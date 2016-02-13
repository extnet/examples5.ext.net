using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Xml.Serialization;

using Newtonsoft.Json;

namespace Ext.Net.Examples.SimpleTasks
{
    public partial class TasksGrid : GridPanel
    {
        private Store store;
        private Menu ctxMenu;
        private TreePanel ctxTreeCategory;

        public TasksGrid()
        {
            this.Title = "All Lists";
            this.IconCls = "icon-folder";
            this.EnableColumnHide = false;
            this.EnableColumnMove = false;

            this.SelectionModel.Add(new RowSelectionModel {
            });

            this.View.Add(new GridView
            {
                MarkDirty = false,
                EmptyText = "There are no tasks to show in this category.",
                GetRowClass = { Fn = TasksGrid.SCOPE + ".getRowClass" },
                LoadMask = true,
                LoadingText = "Loading Tasks...",

                Plugins =
                {
                    new GridDragDrop{ DDGroup = "tasktree" }
                }
            });

            Grouping g = new Grouping();

            this.Features.Add(g);

            this.BuildStore();
            this.BuildColumnModel();
            this.BuildHeaderRow();
            this.BuildContextMenu();
            this.InitLogic();
        }

        [Browsable(false)]
        [EditorBrowsable(EditorBrowsableState.Never)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        [XmlIgnore]
        [JsonIgnore]
        public override ConfigOptionsCollection ConfigOptions
        {
            get
            {
                ConfigOptionsCollection category = base.ConfigOptions;
                category.Add("contextMenu", new ConfigOption("contextMenu", new SerializationOptions("ctxMenu", typeof(LazyControlJsonConverter)), null, this.ContextMenu));

                return category;
            }
        }

        [DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        [DefaultValue(null)]
        public Menu ContextMenu
        {
            get
            {
                return this.ctxMenu;
            }
        }


        private void BuildContextMenu()
        {
            ctxTreeCategory = new TreePanel
              {
                  ID = "ctxTreeCategory",
                  Height = 300,
                  Width = 200,
                  Shadow = false,
                  UseArrows = true,
                  AutoScroll = true,
                  Animate = true,
                  RootVisible = false,
                  Cls = "tasks-tree",
                  Root =
                  {
                      new Node{NodeID="root", EmptyChildren = true}
                  },

                  Store = {
                    new TreeStore
                    {
                        ModelName = "CategoryTree"
                    }
                  },

                  SelectionModel =
                  {
                      new TreeSelectionModel()
                  }
              };

            this.ctxMenu = new Menu
            {
                Items =
                   {
                       new MenuItem
                       {
                           ID = "mnuTaskGrid_OpenTask",
                           Text = "Open"
                       },
                       new MenuItem
                       {
                           Text = "Move To...",
                           Icon = Net.Icon.ArrowRight,
                           Menu =
                           {
                               new Menu
                               {
                                   Items =
                                   {
                                       new Panel
                                        {
                                            Width = 200,
                                            BodyStyle = "color: #3764a0;",
                                            BodyPadding = 5,
                                            Html = "You can drag and drop tasks from<br/>the grid to the west tree also"
                                        },
                                       new MenuSeparator(),
                                       this.ctxTreeCategory
                                   }
                               }
                           }
                       },
                       new MenuSeparator(),
                       new MenuItem
                       {
                           ID = "mnuTaskGrid_MarkTask",
                           Text = "Mark Complete",
                           IconCls = "icon-mark-complete"
                       },
                       new MenuItem
                       {
                           ID = "mnuTaskGrid_DeleteTask",
                           Text = "Delete",
                           IconCls = "icon-category-delete"
                       }
                   }
            };

            this.Controls.Add(this.ctxMenu);
            this.LazyItems.Add(this.ctxMenu);
            this.ctxMenu.LazyMode = LazyMode.Instance;
        }

        protected override void OnPreRender(EventArgs e)
        {
            //if (!Ext.Net.X.IsAjaxRequest)
            //{
            //    this.StoreID = this.store.ID;
            //}

            base.OnPreRender(e);
        }

        private void BuildHeaderRow()
        {
            GridHeaderContainer colModel = this.ColumnModel;
            colModel.Columns[0].Items.Add(
                new Container
                {
                    ID = "icnIndicator",

                    AutoEl =
                    {
                        Cls = "new-task-icon"
                    }
                });

            colModel.Columns[1].Items.Add(
                new TextField
                {
                    ID = "ntTitle",
                    IDMode = IDMode.Static,
                    EmptyText = "Add a task...",
                    Listeners =
                    {
                        Focus =
                        {
                            Fn = TasksGrid.SCOPE + ".onFocusNewTask",
                            Scope = TasksGrid.SCOPE
                        }
                    }
                });
            colModel.Columns[2].Items.Add(
                new DropDownField
                {
                    ID = "ntCategory",
                    IDMode = IDMode.Static,
                    Disabled = true,
                    Editable = false,
                    Mode = DropDownMode.ValueText,
                    Component =
                    {
                        new TreePanel
                        {
                            ID = "ntTreeCategory",
                            Height = 300,
                            Shadow = false,
                            UseArrows = true,
                            AutoScroll = true,
                            Animate = true,
                            RootVisible = false,
                            Cls = "tasks-tree",
                            Root =
                            {
                                new Node()
                                {
                                    Text = "root",
                                    EmptyChildren = true
                                }
                            },
                            SelectionModel =
                            {
                                new TreeSelectionModel()
                            }
                        }
                    }
                });
            colModel.Columns[3].Items.Add(
                new DateField
                {
                    ID = "ntDue",
                    IDMode = IDMode.Static,
                    Editable = false,
                    Disabled = true
                });

            colModel.Columns[4].Items.Add(
                new Container
                {
                    Items = {
                        new Button
                        {
                            Icon = Icon.Add,
                            ToolTip = "Add new task",
                            Handler = TasksGrid.SCOPE + ".onAddTask",
                            Scope = TasksGrid.SCOPE
                        }
                    }
                }
            );
        }

        private void BuildColumnModel()
        {
            GridHeaderContainer cm = this.ColumnModel;
            cm.Columns.Add(new CommandColumn
               {
                   Commands =
                   {
                       new GridCommand
                       {
                           IconCls = "icon-active",
                           CommandName = "togglestatus"
                       }
                   },
                   Cls="task-col-hd",
                   Width = 25,
                   Resizable = false,
                   MenuDisabled = true
               });

            cm.Columns.Add(new Column
               {
                   Text = "Task",
                   Flex = 1,
                   Sortable = true,
                   DataIndex = "Title"
               });

            cm.Columns.Add(new Column
               {
                   Text = "Category",
                   Width = 150,
                   Sortable = true,
                   DataIndex = "ID",
                   Renderer = new Renderer("return record.get('Name');")
               });

            cm.Columns.Add(new DateColumn
               {
                   Text = "Due Date",
                   Width = 150,
                   Sortable = true,
                   DataIndex = "DueDate"
               });

            cm.Columns.Add(new Column
               {
                   Resizable = false,
                   MenuDisabled = true,
                   Width = 25,
                   DataIndex = ""
               });
        }

        private void BuildStore()
        {
            this.store = new Store
             {
                 AutoLoad = false,
                 WarningOnDirty = false,
                 Model =
                 {
                     new Model
                     {
                         IDProperty = "ID",
                         Fields =
                         {
                             new ModelField("ID", ModelFieldType.Int),
                             new ModelField
                             {
                                 Name = "Name",
                                 ServerMapping = "Category.Name"
                             },
                             new ModelField("Title"),
                             new ModelField("Description"),
                             new ModelField("DueDate", ModelFieldType.Date),
                             new ModelField
                             {
                                 Name = "Completed",
                                 Type = ModelFieldType.Boolean,
                                 DefaultValue = "={false}"
                             },
                             new ModelField("CompletedDate", ModelFieldType.Date),
                             new ModelField("Reminder", ModelFieldType.Date)
                         }
                     }
                 },
                 Sorters =
                 {
                    new DataSorter()
                    {
                        Property = "DueDate",
                        Direction = SortDirection.ASC
                    }
                 },
                 GroupField = "DueDate",
                 Proxy =
                 {
                     new PageProxy()
                 }
             };

            this.Store.Add(this.store);
        }
    }
}