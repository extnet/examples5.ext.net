Ext.ns("SimpleTasks");

//-------------------TasksTopBar
SimpleTasks.TasksTopBar = {
    init : function (panel) {
        this.bar = panel.dockedItems.items[0];
    }
};

// ------------------TasksTree----------------------------------
SimpleTasks.TasksTree = {
    init : function (tree) {
        this.tree = tree;

        Ext.Function.defer(this.tree.getSelectionModel().select, 100, this.tree.getSelectionModel(), [this.tree.getRootNode()]);
    },

    onContextMenu : function (view, record, item, index, e) {
        if (this.ctxNode) {
            Ext.fly(this.tree.view.getNodeByRecord(this.ctxNode)).removeCls("x-node-ctx");
            this.ctxNode = null;
        }

        this.ctxNode = record;
        Ext.fly(this.tree.view.getNodeByRecord(this.ctxNode)).addCls("x-node-ctx");

        this.tree[this.ctxNode.data.isFolder ? "ctxFolder" : "ctxCategory"].showAt(e.getXY());

        e.preventDefault();
    },

    onContextHide : function () {
        if (this.ctxNode) {
            Ext.fly(this.tree.view.getNodeByRecord(this.ctxNode)).removeCls("x-node-ctx");
            this.ctxNode = null;
        }
    },

    insertCategory : function (parentNode) {
        parentNode = parentNode || this.ctxNode || this.tree.getSelectionModel().getSelection()[0] || this.tree.getRootNode();

        if (!parentNode.data.isFolder) {
            parentNode = parentNode.parentNode;
        }

        this.tree.appendChild(parentNode, {text: "New Category", isFolder: false, iconCls: "icon-category"});
    },

    insertFolder : function (parentNode) {
        parentNode = parentNode || this.ctxNode || this.tree.getSelectionModel().getSelection()[0] || this.tree.getRootNode();

        if (!parentNode.data.isFolder) {
            parentNode = parentNode.parentNode;
        }

        this.tree.appendChild(parentNode, {
            text     : "New Folder",
            isFolder : true,
            iconCls  : "icon-folder"
        });
    },

    deleteCategory : function (node) {
        node = node || this.ctxNode || this.tree.getSelectionModel().getSelection()[0] || this.tree.getRootNode();

        Ext.Msg.confirm("Confirm", 'Are you sure you want to delete "' + node.data.text + '"?', function (btn) {
            if (btn == "yes") {
                this.tree.removeNode(node);
            }
        }, this);
    },

    beforeRemoteAppend : function (tree, node, params) {
        params["isFolder"] = node.data.isFolder;
    },

    remoteActionRefusal : function (tree, response, e, o) {
        Ext.Msg.show({
           title   :"Action failure",
           msg     : e.message,
           buttons : Ext.Msg.OK,
           icon    : Ext.MessageBox.ERROR
        });
    },

    selectionChange : function (sm, nodes) {
        var bar = this.tree.dockedItems.items[2],
            isCategory = Ext.isEmpty(nodes) || nodes.length == 0 || !nodes[0].data.isFolder;

        bar.items.get(0).setDisabled(isCategory);
        bar.items.get(1).setDisabled(!isCategory);
        bar.items.get(3).setDisabled(isCategory);
        bar.items.get(4).setDisabled(isCategory);

        SimpleTasks.TasksGrid.loadTasks(nodes[0]);
    },

    remoteActionSuccess : function (tree, node, action) {
        var node = this.tree.getSelectionModel().getSelection()[0];

        if (!Ext.isEmpty(node)) {
            if (action == "raAppend") {
               SimpleTasks.TasksGrid.loadTasks(node);
            } else {
                SimpleTasks.TasksGrid.updateTitle(node);
            }
        }
    },

    moveTasks : function (ids, categoryID) {
        SimpleTasks.TasksGrid.setIndicator(true);

        Ext.net.DirectMethods.MoveTasks(Ext.encode(ids), categoryID, {
            success : function () {
                SimpleTasks.TasksGrid.applyFilter();
            },

            failure : function (error, response) {
                Ext.Msg.alert("Tasks moving failure", response.responseText)
            },

            complete : function () {
                SimpleTasks.TasksGrid.setIndicator(false);
            }
        });
    },

    beforeNodeDrop : function (node, data, overModel, pos, handler) {
        if(data.records && data.records.length > 0 && data.records[0].isNode) {
            return true;
        }

        if (Ext.isArray(data.records)) {
            var ids=[];

            for (var i = 0; i < data.records.length; i++) {
                ids.push(data.records[i].getId());
            }

            this.moveTasks(ids, overModel.getId());
            data.records = [];
            handler.cancel = true;

            return false;
        }
    }
};

// ------------------TasksGrid----------------------------------
SimpleTasks.TasksGrid = {
    init : function (grid) {
        this.grid = grid;
    },

    ctxMoveTasks : function (view, record, item, index, e) {
        var ids=[],
            records = this.grid.selModel.getSelection();

        for (var i = 0; i < records.length; i++) {
            ids.push(records[i].getId());
        }

        SimpleTasks.TasksTree.moveTasks(ids, record.getId());
        this.grid.ctxMenu.hide();
    },

    onRowContext : function (view, record, item, index, e) {
        if (!this.grid.selModel.isSelected(record)) {
            this.grid.selModel.select(record);
        }

        e.stopEvent();

        var root = Ext.getCmp("ctxTreeCategory").getRootNode();
        root.removeAll();
        root.appendChild(SimpleTasks.TasksTree.tree.getRootNode().copy(false, true));
        this.grid.ctxMenu.showAt(e.getXY());
    },

    afterRender : function () {
        this.headerHandlers.scope = this;
        ntTitle.on(this.headerHandlers);
        ntCategory.on(this.headerHandlers);
        ntDue.on(this.headerHandlers);
    },

    loadTasks : function (node) {
        if (Ext.isEmpty(node)) {
            return;
        }

        this.updateTitle(node);

        if (Ext.isNumber(parseInt(node.getId()))) {
            this.setIndicator(true);

            this.grid.store.reload({
                params : {
                    categoryID : node.getId(),
                    filter: this.getFilterValue()
                },
                callback : Ext.bind(function () {
                    this.setIndicator(false);
                }, this)
            });
        }
    },

    updateTitle : function (node) {
        this.grid.setTitle(node.data.text);
        this.grid.setIconCls(node.data.iconCls);
    },

    getRowClass : function (r) {
        var d = r.data;

        if (d.Completed) {
            return "task-completed";
        }

        if (d.DueDate && d.DueDate.getTime() < Ext.Date.clearTime(new Date()).getTime()) {
            return "task-overdue";
        }
        return "";
    },

    focusTaskField : function () {
        if (SimpleTasks.TasksTree.ctxNode) {
           SimpleTasks.TasksTree.tree.getSelectionModel().select(SimpleTasks.TasksTree.ctxNode);
        }

        ntTitle.focus();
    },

    onFocusNewTask : function () {
        this.hFocused = true;

        if (!this.hEditing) {
            ntCategory.enable();
            ntDue.enable();
            this.hEditing = true;
        }
    },

    onFocusLeave : function () {
        if (this.hEditing && !this.hFocused && !ntCategory.isExpanded) {
            var title = ntTitle.getValue();

            if (!Ext.isEmpty(title)) {
                if (this.hUserTriggered) {
                   this.onAddTask();
                } else {
                    ntTitle.setValue("");
                    ntCategory.setValue("");
                    delete ntCategory.categoryID;
                }
            } else {
                ntCategory.setValue("");
                delete ntCategory.categoryID;
            }

            ntCategory.disable();
            ntDue.disable();
            this.hEditing = false;
        }
    },

    onAddTask : function () {
        var me = this;
        if (!Ext.isEmpty(ntTitle.getValue(), false) && !Ext.isEmpty(ntCategory.getValue(), false) && !Ext.isEmpty(ntDue.getValue(), false)) {
            this.setIndicator(true);

            Ext.net.DirectMethods.AddTask(ntTitle.getValue(), ntCategory.getValue(), Ext.encode(ntDue.getValue()), {
                complete: function () {
                    me.setIndicator(false);
                }
            });
            ntTitle.setValue("");
        } else {
            if (Ext.isEmpty(ntTitle.getValue(), false)) {
                 Ext.net.Notification.show({
                                        html  : "Please specify the task subject",
                                        title : "Warning"
                                     });
            } else if (Ext.isEmpty(ntCategory.getValue(), false)) {
                 Ext.net.Notification.show({
                                        html  : "Please specify the task category",
                                        title : "Warning"
                                     });
            } else if (Ext.isEmpty(ntDue.getValue(), false)) {
                 Ext.net.Notification.show({
                                        html  : "Please specify the due date",
                                        title : "Warning"
                                     });
            }
        }

        this.hUserTriggered = false;
        Ext.Function.defer(ntTitle.focus, 100, ntTitle);
    },

    categoryCheckChange : function (view, record, item, index, e) {
        var ddf = view.panel.dropDownField;
        ddf.setValue(record.getId(), record.data.text);
    },

    headerHandlers : {
        focus : function () {
            Ext.Function.defer(function () {
                this.hFocused = true;
            }, 20, this);
        },
        focusleave : function () {
            this.hFocused = false;
            Ext.Function.defer(this.onFocusLeave, 250, this);
        },
        specialkey : function (f, e) {
            if (e.getKey()==e.ENTER) {
                this.hUserTriggered = true;
                e.stopEvent();
                f.inputEl.blur();
                if (f.triggerBlur) {
                    f.triggerBlur();
                }
            }
        }
    },

    setIndicator : function (loading) {
        var indicator = Ext.fly("icnIndicator");

        if (indicator) {
            indicator[loading ? "addCls" : "removeCls"]("loading-indicator");
        }
    },

    prepareStatusButton : function (grid, toolbar, rowIndex, record) {
        toolbar.items.items[0].setIconCls(record.get("Completed") ? "icon-complete" : "icon-active");
    },

    selectionChange : function (sm) {
        var bar = SimpleTasks.TasksTopBar.bar;
        bar.items.get(2).setDisabled(!sm.hasSelection());
        bar.items.get(3).setDisabled(!sm.hasSelection());
        bar.items.get(4).setDisabled(!sm.hasSelection());
    },

    getSelectedIds : function () {
        var selectedIds = [];
        Ext.each(SimpleTasks.TasksGrid.grid.getSelectionModel().getSelection(), function (taskRecord) {
            selectedIds.push(taskRecord.getId());
        });

        return Ext.encode(selectedIds);
    },

    getFilterValue : function () {
        var filter = "";

        if (filterAll.pressed) {
            filter = "all";
        }  else if (filterActive.pressed) {
            filter = "active";
        } else if (filterCompleted.pressed) {
            filter = "completed";
        }

        return filter;
    },

    getActiveNodeCategory : function () {
        return SimpleTasks.TasksTree.tree.getSelectionModel().getSelection()[0];
    },

    applyFilter : function () {
        this.loadTasks(this.getActiveNodeCategory());
    },

    categoryExpand : function () {
        var tree = SimpleTasks.TasksTree.tree,
            node = this.getActiveNodeCategory(),
            root = ntTreeCategory.getRootNode();

        root.removeAll();
        root.appendChild(node.copy(false, true));
    }
};

SimpleTasks.TaskWindow = {
    openTask : function (taskId) {
        var w = Ext.getCmp("TaskWindow_" + taskId);

        if (w) {
            w.toFront();
            return false;
        }

        SimpleTasks.TasksGrid.setIndicator(true);

        return true;
    },

    initWindow : function (w) {
        var tree = SimpleTasks.TasksTree.tree,
            taskCategory = w.down("#taskCategory"),
            picker = taskCategory.getPicker(),
            root = picker.getRootNode();

        root.removeAll();
        root.appendChild(tree.getRootNode().copy(false, true));
        picker.getSelectionModel().select(picker.store.getNodeById(parseInt(taskCategory.getValue())));
    },

    save : function (w) {
        var taskForm = w.down("#taskForm");

        if (!taskForm.isValid()) {
            return;
        }

        var values = Ext.encode(taskForm.getForm().getFieldValues());

        Ext.Msg.wait({
            msg: "The task is saving..."
        });

        Ext.net.DirectMethods.SaveTask(w.taskId, values, {
            success : function () {
                Ext.Msg.hide();
                w.close();
                SimpleTasks.TasksGrid.applyFilter();
            },
            failure : function (error, response) {
                Ext.Msg.alert("Task saving failure", response.responseText)
            }
        });
    },

    deleteTask : function (w) {
        Ext.Msg.wait({
            msg: "The task is deleting..."
        });

        Ext.net.DirectMethods.DeleteTasks(Ext.encode([w.taskId]), {
            success : function () {
                Ext.Msg.hide();
                w.close();
            },
            failure : function (error, response) {
                Ext.Msg.alert("Task deleting failure", response.responseText)
            }
        });
    },

    markTask : function (w, complete) {
        Ext.Msg.wait({
            msg: "Please wait, working..."
        });

        Ext.net.DirectMethods.MarkTask(
            w.taskId,
            complete,
            SimpleTasks.TasksGrid.getActiveNodeCategory().getId(),
            SimpleTasks.TasksGrid.getFilterValue(), {
                success : function () {
                    Ext.Msg.hide();
                    if (complete) {
                        w.close();
                    }
                },
                failure : function (error, response) {
                    Ext.Msg.alert("Task marking failure", response.responseText)
                }
            }
        );
    }
};