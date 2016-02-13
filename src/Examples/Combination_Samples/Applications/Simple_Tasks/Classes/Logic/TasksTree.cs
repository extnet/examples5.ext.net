using System;
using System.Collections.Generic;
using System.Linq;

using Ext.Net.Utilities;

namespace Ext.Net.Examples.SimpleTasks
{
    [DirectMethodProxyID(IDMode = DirectMethodProxyIDMode.None)]
    public partial class TasksTree
    {
        public const string SCOPE = "SimpleTasks.TasksTree";

        private void InitLogic()
        {
            //Remote tree actions
            this.RemoteAppend += TasksTree_RemoteAppend;
            this.RemoteRemove += TasksTree_RemoteRemove;
            this.RemoteEdit += TasksTree_RemoteRename;
            this.RemoteMove += TasksTree_RemoteMove;

            this.Listeners.BeforeRemoteAppend.Fn = TasksTree.SCOPE + ".beforeRemoteAppend";
            this.Listeners.RemoteActionRefusal.Fn = TasksTree.SCOPE + ".remoteActionRefusal";
            this.Listeners.RemoteActionException.Fn = TasksTree.SCOPE + ".remoteActionRefusal";
            this.Listeners.RemoteActionSuccess.Fn = TasksTree.SCOPE + ".remoteActionSuccess";
            this.Listeners.RemoteActionSuccess.Scope = TasksTree.SCOPE;

            this.Listeners.Render.Fn = TasksTree.SCOPE + ".init";
            this.Listeners.Render.Scope = TasksTree.SCOPE;

            this.Listeners.ItemRemove.Handler = "{0}.tree.selModel.select({0}.tree.getRootNode());".FormatWith(TasksTree.SCOPE);

            this.Listeners.ItemContextMenu.Fn = TasksTree.SCOPE + ".onContextMenu";
            this.Listeners.ItemContextMenu.Scope = TasksTree.SCOPE;

            this.CategoryContextMenu.Listeners.Hide.Fn = TasksTree.SCOPE + ".onContextHide";
            this.CategoryContextMenu.Listeners.Hide.Scope = TasksTree.SCOPE;

            this.FolderContextMenu.Listeners.Hide.Fn = TasksTree.SCOPE + ".onContextHide";
            this.FolderContextMenu.Listeners.Hide.Scope = TasksTree.SCOPE;

            // New Category
            MenuItem mItem = (MenuItem)this.FolderContextMenu.Items[0];
            mItem.Listeners.Click.Handler = TasksTree.SCOPE + ".insertCategory();";
            mItem.Listeners.Click.Scope = TasksTree.SCOPE;

            // New Folder
            mItem = (MenuItem)this.FolderContextMenu.Items[1];
            mItem.Listeners.Click.Handler = TasksTree.SCOPE + ".insertFolder();";
            mItem.Listeners.Click.Scope = TasksTree.SCOPE;

            // Delete from Folder Menu
            mItem = (MenuItem)this.FolderContextMenu.Items[3];
            mItem.Listeners.Click.Handler = TasksTree.SCOPE + ".deleteCategory();";
            mItem.Listeners.Click.Scope = TasksTree.SCOPE;

            // New Task from Category Menu
            mItem = (MenuItem)this.CategoryContextMenu.Items[0];
            mItem.Listeners.Click.Handler = TasksGrid.SCOPE + ".focusTaskField();";
            mItem.Listeners.Click.Scope = TasksGrid.SCOPE;

            // Delete from Category Menu
            mItem = (MenuItem)this.CategoryContextMenu.Items[2];
            mItem.Listeners.Click.Handler = TasksTree.SCOPE + ".deleteCategory();";
            mItem.Listeners.Click.Scope = TasksTree.SCOPE;

            this.Store.Primary.ReadData += TasksTree_NodeLoad;

            TreeSelectionModel sm = (TreeSelectionModel)this.SelectionModel.Primary;
            sm.Listeners.SelectionChange.Fn = TasksTree.SCOPE + ".selectionChange";
            sm.Listeners.SelectionChange.Scope = TasksTree.SCOPE;

            TreeView view = this.View[0];
            view.Listeners.BeforeDrop.Fn = TasksTree.SCOPE + ".beforeNodeDrop";
            view.Listeners.BeforeDrop.Scope = TasksTree.SCOPE;

            Button button = (Button)this.bBar.Items[0];
            button.Listeners.Click.Handler = TasksTree.SCOPE + ".insertCategory();";
            button.Listeners.Click.Scope = TasksTree.SCOPE;

            button = (Button)this.bBar.Items[1];
            button.Listeners.Click.Handler = TasksTree.SCOPE + ".deleteCategory();";
            button.Listeners.Click.Scope = TasksTree.SCOPE;

            button = (Button)this.bBar.Items[3];
            button.Listeners.Click.Handler = TasksTree.SCOPE + ".insertFolder();";
            button.Listeners.Click.Scope = TasksTree.SCOPE;

            button = (Button)this.bBar.Items[4];
            button.Listeners.Click.Handler = TasksTree.SCOPE + ".deleteCategory();";
            button.Listeners.Click.Scope = TasksTree.SCOPE;
        }

        protected override void OnLoad(EventArgs e)
        {
            if (!Ext.Net.X.IsAjaxRequest)
            {
                this.ResourceManager.AddDirectMethodControl(this);
            }
        }

        private SimpleTasksDataContext DBContext
        {
            get
            {
                SimpleTasksDataContext ctx = new SimpleTasksDataContext();
                ctx.DeferredLoadingEnabled = true;

                return ctx;
            }
        }

        void TasksTree_RemoteMove(object sender, RemoteMoveEventArgs e)
        {
            try
            {
                int nodeId = int.Parse(e.NodeID);
                int targetNodeId = int.Parse(e.TargetNodeID);

                SimpleTasksDataContext ctx = this.DBContext;

                Category category = (from tl in ctx.Categories
                                 where tl.ID == nodeId
                                 select tl).First();

                Category parentlist = (from tl in ctx.Categories
                                        where tl.ID == targetNodeId
                                        select tl).First();

                category.ParentCategory = parentlist;
                ctx.SubmitChanges();
                e.Accept = true;
            }
            catch (Exception exception)
            {
                e.Accept = false;
                e.RefusalMessage = exception.Message;
            }
        }

        void TasksTree_RemoteRename(object sender, RemoteEditEventArgs e)
        {
            try
            {
                int nodeId = int.Parse(e.NodeID);

                SimpleTasksDataContext ctx = this.DBContext;

                Category category = (from tl in ctx.Categories
                                  where tl.ID == nodeId
                                  select tl).First();

                IEnumerable<Category> query = from tl in ctx.Categories
                                              where (tl.IsFolder == category.IsFolder && tl.ParentID == category.ParentID && tl.ID != category.ID && tl.Name == e.Value<string>())
                                              select tl;

                if (query.Count() > 0)
                {
                    e.Accept = false;
                    e.RefusalMessage = "Such {0} is existing in the parent folder".FormatWith(category.IsFolder ? "folder" : "category");
                    return;
                }

                category.Name = e.Value<string>();
                ctx.SubmitChanges();
                e.Accept = true;
            }
            catch (Exception exception)
            {
                e.Accept = false;
                e.RefusalMessage = exception.Message;
            }
        }

        void TasksTree_RemoteRemove(object sender, RemoteActionEventArgs e)
        {
            try
            {
                if (e.NodeID.IsEmpty())
                {
                    e.Accept = true;
                    return;
                }

                int nodeId = int.Parse(e.NodeID);

                //root
                if (nodeId == 1)
                {
                    e.Accept = false;
                    e.RefusalMessage = "The root node can't be deleted";
                }

                SimpleTasksDataContext ctx = this.DBContext;

                Category category = (from tl in ctx.Categories
                                  where tl.ID == nodeId
                                  select tl).First();

                // remove children lists
                foreach (Category childrenList in category.Categories)
                {
                    ctx.Categories.DeleteOnSubmit(childrenList);
                }

                // remove category
                ctx.Categories.DeleteOnSubmit(category);

                ctx.SubmitChanges();
                e.Accept = true;
            }
            catch (Exception exception)
            {
                e.Accept = false;
                e.RefusalMessage = exception.Message;
            }
        }

        void TasksTree_RemoteAppend(object sender, RemoteAppendEventArgs e)
        {
            try
            {
                bool isFolder = bool.Parse(e.ExtraParams["isFolder"]);
                int folderId = int.Parse(e.ParentNodeID);

                SimpleTasksDataContext ctx = this.DBContext;

                IEnumerable<Category> query = from tl in ctx.Categories
                            where (tl.IsFolder == isFolder && tl.ParentID == folderId && tl.Name == e.Text)
                            select tl;

                if (query.Count() > 0)
                {
                    e.Accept = false;
                    e.RefusalMessage = "Such {0} is existing in the parent folder".FormatWith(isFolder ? "folder" : "category");
                    return;
                }

                Category category = new Category
                {
                    Name = e.Text,
                    IsFolder = isFolder,
                    ParentID = folderId
                };

                ctx.Categories.InsertOnSubmit(category);
                ctx.SubmitChanges();

                e.NodeID = category.ID.ToString();

                e.Accept = true;
            }
            catch (Exception exception)
            {
                e.Accept = false;
                e.RefusalMessage = exception.Message;
            }
        }

        void TasksTree_NodeLoad(object sender, NodeLoadEventArgs e)
        {
            int folderID = int.Parse(e.NodeID);

            SimpleTasksDataContext ctx = this.DBContext;

            IEnumerable<Category> query = from tl in ctx.Categories
                        where tl.ParentID == folderID
                        select tl;

            this.ListToNode(query.ToList(), e.Nodes);
        }

        private void ListToNode(IEnumerable<Category> lists, NodeCollection nodes)
        {
            foreach (Category tasksList in lists)
            {
                Node node = new Node();
                node.NodeID = tasksList.ID.ToString();
                node.Text = tasksList.Name;
                node.Leaf = !tasksList.IsFolder;
                node.IconCls = tasksList.IsFolder ? "icon-folder" : "icon-category";
                node.CustomAttributes.Add(new ConfigItem("isFolder", JSON.Serialize(tasksList.IsFolder), ParameterMode.Raw));
                if (!tasksList.IsFolder)
                {
                    node.AllowDrop = false;
                }
                node.Expanded = tasksList.IsFolder;

                if (tasksList.Categories.Count > 0)
                {
                    this.ListToNode(tasksList.Categories, node.Children);
                }
                else if(!node.Leaf)
                {
                    node.EmptyChildren = true;
                }

                nodes.Add(node);
            }
        }

        [DirectMethod]
        public void MoveTasks(int[] ids, int categoryID)
        {
            SimpleTasksDataContext ctx = this.DBContext;

            IEnumerable<Task> tasks = from t in ctx.Tasks
                        where ids.Contains(t.ID)
                        select t;

            Category category = (from categories in ctx.Categories where categories.ID == categoryID select categories).First();

            foreach (Task task in tasks)
            {
                task.Category = category;
            }

            ctx.SubmitChanges();
        }
    }
}
