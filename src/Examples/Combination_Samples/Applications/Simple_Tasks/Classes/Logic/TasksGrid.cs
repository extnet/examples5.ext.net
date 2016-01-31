using System;
using System.Collections.Generic;
using System.Linq;

using Ext.Net.Utilities;

namespace Ext.Net.Examples.SimpleTasks
{
    [DirectMethodProxyID(IDMode = DirectMethodProxyIDMode.None)]
    public partial class TasksGrid
    {
        public const string SCOPE = "SimpleTasks.TasksGrid";

        private void InitLogic()
        {
            this.Listeners.Render.Fn = TasksGrid.SCOPE + ".init";
            this.Listeners.Render.Scope = TasksGrid.SCOPE;

            this.Listeners.AfterRender.Fn = TasksGrid.SCOPE + ".afterRender";
            this.Listeners.AfterRender.Scope = TasksGrid.SCOPE;

            ComponentDirectEvent rowDblClick = this.DirectEvents.ItemDblClick;
            rowDblClick.Event += RowDblClick_Event;
            rowDblClick.Before = "return ".ConcatWith(TaskWindow.SCOPE, ".openTask(record.getId());");
            rowDblClick.Complete = TasksGrid.SCOPE + ".setIndicator(false);";
            rowDblClick.ExtraParams.Add(new Parameter("taskId", "record.getId()", ParameterMode.Raw));

            ComponentDirectEvent command = (this.ColumnModel.Columns[0] as CommandColumn).DirectEvents.Command;
            command.Event += Command_Event;
            command.Type = DirectEventType.Load;
            command.ExtraParams.Add(new Parameter("command", "command", ParameterMode.Raw));
            command.ExtraParams.Add(new Parameter("taskId", "record.getId()", ParameterMode.Raw));
            command.ExtraParams.Add(new Parameter("filter", TasksGrid.SCOPE + ".getFilterValue()", ParameterMode.Raw));
            command.ExtraParams.Add(new Parameter("categoryID", TasksGrid.SCOPE + ".getActiveNodeCategory().getId()", ParameterMode.Raw));
            command.Before = TasksGrid.SCOPE + ".setIndicator(true);";
            command.Complete = TasksGrid.SCOPE + ".setIndicator(false);";

            this.store.ReadData += TasksGrid_RefreshData;
            DropDownField ddf = ((DropDownField) this.ColumnModel.Columns[2].Items[0]);
            TreePanel tree = (TreePanel)(ddf.Component[0]);
            tree.Listeners.ItemClick.Fn = TasksGrid.SCOPE + ".categoryCheckChange";
            tree.Listeners.ItemClick.Scope = TasksGrid.SCOPE;
            ddf.Listeners.Expand.Fn = TasksGrid.SCOPE + ".categoryExpand";
            ddf.Listeners.Expand.Scope = TasksGrid.SCOPE;

            CommandColumn cmdCol = (CommandColumn) this.ColumnModel.Columns[0];
            cmdCol.PrepareToolbar.Fn = TasksGrid.SCOPE + ".prepareStatusButton";

            RowSelectionModel gridsm = (RowSelectionModel)this.SelectionModel[0];
            gridsm.Listeners.SelectionChange.Fn = TasksGrid.SCOPE + ".selectionChange";
            gridsm.Listeners.SelectionChange.Scope = TasksGrid.SCOPE;

            this.Listeners.ItemContextMenu.Fn = TasksGrid.SCOPE + ".onRowContext";
            this.Listeners.ItemContextMenu.Scope = TasksGrid.SCOPE;

            MenuItem mItem = (MenuItem)this.ctxMenu.Items[4];

            ComponentDirectEvent click = mItem.DirectEvents.Click;
            click.Event += DelClick_Event;
            click.Confirmation.ConfirmRequest = true;
            click.Confirmation.Message = "Are you sure you want to delete the selected task(s)?";
            click.ExtraParams.Add(new Parameter("ids", TasksGrid.SCOPE + ".getSelectedIds()", ParameterMode.Raw));
            click.Before = TasksGrid.SCOPE + ".setIndicator(true);";
            click.Complete = TasksGrid.SCOPE + ".setIndicator(false);";

            mItem = (MenuItem)this.ctxMenu.Items[3];
            click = mItem.DirectEvents.Click;
            click.Event += MarkClick_Event;
            click.ExtraParams.Add(new Parameter("ids", TasksGrid.SCOPE + ".getSelectedIds()", ParameterMode.Raw));
            click.ExtraParams.Add(new Parameter("filter", TasksGrid.SCOPE + ".getFilterValue()", ParameterMode.Raw));
            click.ExtraParams.Add(new Parameter("categoryID", TasksGrid.SCOPE + ".getActiveNodeCategory().getId()", ParameterMode.Raw));
            click.Before = TasksGrid.SCOPE + ".setIndicator(true);";
            click.Complete = TasksGrid.SCOPE + ".setIndicator(false);";

            mItem = (MenuItem)this.ctxMenu.Items[0];
            click = mItem.DirectEvents.Click;
            click.Event += OpenClick_Event;
            click.ExtraParams.Add(new Parameter("ids", TasksGrid.SCOPE + ".getSelectedIds()", ParameterMode.Raw));
            click.Before = TasksGrid.SCOPE + ".setIndicator(true);";
            click.Complete = TasksGrid.SCOPE + ".setIndicator(false);";

            ctxTreeCategory.Listeners.ItemClick.Fn = TasksGrid.SCOPE + ".ctxMoveTasks";
            ctxTreeCategory.Listeners.ItemClick.Scope = TasksGrid.SCOPE;
        }

        protected void DelClick_Event(object sender, DirectEventArgs e)
        {
            TasksGrid grid = Ext.Net.Utilities.ControlUtils.FindControls<TasksGrid>(this.Page)[0];
            int[] ids = JSON.Deserialize<int[]>(e.ExtraParams["ids"]);
            grid.DeleteTasks(ids);
        }

        protected void MarkClick_Event(object sender, DirectEventArgs e)
        {
            TasksGrid grid = Ext.Net.Utilities.ControlUtils.FindControls<TasksGrid>(this.Page)[0];
            int[] ids = JSON.Deserialize<int[]>(e.ExtraParams["ids"]);
            int categoryID = int.Parse(e.ExtraParams["categoryID"]);
            grid.ToggleStatus(ids, true, categoryID, e.ExtraParams["filter"]);
        }

        void RowDblClick_Event(object sender, DirectEventArgs e)
        {
            new TaskWindow(int.Parse(e.ExtraParams["taskId"])).Render(this.Page.Form.ClientID, RenderMode.RenderTo);
        }

        void OpenClick_Event(object sender, DirectEventArgs e)
        {
            int[] ids = JSON.Deserialize<int[]>(e.ExtraParams["ids"]);
            foreach (int id in ids)
            {
                new TaskWindow(id).Render(this.Page.Form.ClientID, RenderMode.RenderTo);
            }
        }

        void Command_Event(object sender, DirectEventArgs e)
        {
            string command = e.ExtraParams["command"];

            switch (command)
            {
                case "togglestatus":
                    int taskId = int.Parse(e.ExtraParams["taskId"]);
                    int categoryID = int.Parse(e.ExtraParams["categoryID"]);
                    this.ToggleStatus(new int[] { taskId }, null, categoryID, e.ExtraParams["filter"]);
                    break;
            }
        }

        public bool ToggleStatus(int[] taskIds, bool? status, int categoryID, string filter)
        {
            try
            {
                SimpleTasksDataContext ctx = this.DBContext;
                List<Task> tasks = (from t in ctx.Tasks where taskIds.Contains(t.ID) select t).ToList();

                foreach (Task task in tasks)
                {
                    task.Completed = status != null ? status.Value : !task.Completed;
                    task.CompletedDate = DateTime.Now;
                }

                ctx.SubmitChanges();

                if (filter != "all")
                {
                    this.BindTasks(categoryID, filter);
                }
                else
                {
                    foreach (Task task in tasks)
                    {
                        ModelProxy r = this.store.GetById((object)task.ID);
                        r.Set(new
                            {
                                Completed = task.Completed,
                                CompletedDate = new JRawValue(DateTimeUtils.DateNetToJs(task.CompletedDate.Value))
                            });
                    }
                }

                return true;
            }
            catch (Exception e)
            {
                Ext.Net.X.Msg.Show(new MessageBoxConfig
                {
                    Title = "Toggle status error",
                    Message = e.Message,
                    Icon = MessageBox.Icon.ERROR,
                    Buttons = MessageBox.Button.OK
                });

                return false;
            }
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

        void TasksGrid_RefreshData(object sender, StoreReadDataEventArgs e)
        {
            int categoryID;

            if (!int.TryParse(e.Parameters["categoryID"], out categoryID))
            {
                Ext.Net.X.Msg.Show(new MessageBoxConfig
                {
                    Title = "Tasks retrieving error",
                    Message = "ID is missing",
                    Icon = MessageBox.Icon.ERROR,
                    Buttons = MessageBox.Button.OK
                });

                return;
            }

            string filter = e.Parameters["filter"];
            this.BindTasks(categoryID, filter);
        }

        private void BindTasks(int categoryID, string filter)
        {
            bool? completed = null;
            switch (filter)
            {
                case "active":
                    completed = false;
                    break;
                case "completed":
                    completed = true;
                    break;
            }

            SimpleTasksDataContext ctx = this.DBContext;

            List<Task> allTasks = new List<Task>(16);

            // not so good solution
            // it is better to write stored procedure which returns all children nodes 
            // for particular category (children from all down levels)
            Category category = (from tl in ctx.Categories where tl.ID == categoryID select tl).First();
            this.AddTasks(category, allTasks, completed);

            this.store.DataSource = allTasks;
            this.store.DataBind();
        }

        private void AddTasks(Category category, List<Task> allTasks, bool? filter)
        {
            allTasks.AddRange(category.Tasks.Where(task => !filter.HasValue || (filter.Value == task.Completed) ));

            foreach (Category childrenList in category.Categories)
            {
                this.AddTasks(childrenList, allTasks, filter);
            }
        }

        [DirectMethod]
        public bool AddTask(string title, int categoryID, DateTime due)
        {
            if (title.IsEmpty())
            {
                Ext.Net.X.Msg.Show(new MessageBoxConfig
                {
                    Title = "Add task error",
                    Message = "Title is missing",
                    Icon = MessageBox.Icon.ERROR,
                    Buttons = MessageBox.Button.OK
                });

                return false;
            }

            if (due == DateTime.MinValue)
            {
                Ext.Net.X.Msg.Show(new MessageBoxConfig
                {
                    Title = "Add task error",
                    Message = "Due date is missing",
                    Icon = MessageBox.Icon.ERROR,
                    Buttons = MessageBox.Button.OK
                });

                return false;
            }

            try
            {
                SimpleTasksDataContext ctx = this.DBContext;

                Category category = (from tl in ctx.Categories where tl.ID == categoryID select tl).First();

                Task task = new Task();
                task.Title = title;
                task.Category = category;
                task.DueDate = due;
                ctx.Tasks.InsertOnSubmit(task);

                ctx.SubmitChanges();

                this.store.Add(new
                {
                    task.ID,
                    task.CategoryID,
                    task.Category.Name,
                    task.Title,
                    task.DueDate
                });

                ((RowSelectionModel)this.GetSelectionModel()).Select((object)task.ID);

                return true;
            }
            catch (Exception e)
            {
                Ext.Net.X.Msg.Show(new MessageBoxConfig
                {
                    Title = "Add task error",
                    Message = e.Message,
                    Icon = MessageBox.Icon.ERROR,
                    Buttons = MessageBox.Button.OK
                });

                return false;
            }
        }

        [DirectMethod]
        public bool DeleteTasks(int[] taskIds)
        {
            if (taskIds == null)
            {
                Ext.Net.X.Msg.Show(new MessageBoxConfig
                {
                    Title = "Delete tasks error",
                    Message = "Tasks ids are missing",
                    Icon = MessageBox.Icon.ERROR,
                    Buttons = MessageBox.Button.OK
                });

                return false;
            }

            try
            {
                SimpleTasksDataContext ctx = this.DBContext;
                List<Task> tasks = (from t in ctx.Tasks where taskIds.Contains(t.ID) select t).ToList();

                foreach (Task task in tasks)
                {
                    ctx.Tasks.DeleteOnSubmit(task);
                }

                ctx.SubmitChanges();

                foreach (int id in taskIds)
                {
                    this.Store.Primary.Remove((object)id);
                }
                
                return true;
            }
            catch (Exception e)
            {
                Ext.Net.X.Msg.Show(new MessageBoxConfig
                {
                    Title = "Delete tasks error",
                    Message = e.Message,
                    Icon = MessageBox.Icon.ERROR,
                    Buttons = MessageBox.Button.OK
                });

                return false;
            }
        }

        [DirectMethod]
        public void SaveTask(int taskId, JsonObject values)
        {
            SimpleTasksDataContext ctx = this.DBContext;
            Task task = (from t in ctx.Tasks where t.ID == taskId select t).First();

            task.Title = values.ContainsKey("Title") ? values["Title"].ToString() : "";
            task.DueDate = values.ContainsKey("DueDate") ?  DateTime.Parse(values["DueDate"].ToString()) : DateTime.MinValue;
            task.CategoryID = values.ContainsKey("Name") ?  int.Parse(values["Name"].ToString()) : -1;
            task.Description = values.ContainsKey("Description") ? values["Description"].ToString() : "";

            if (values.ContainsKey("HasReminder") && bool.Parse(values["HasReminder"].ToString()) && values.ContainsKey("Reminder"))
            {
                task.Reminder = DateTime.Parse(values["Reminder"].ToString());
            }
            
            ctx.SubmitChanges();
        }

        [DirectMethod]
        public void MarkTask(int taskId, bool complete, int categoryID, string filter)
        {
            this.ToggleStatus(new int[] { taskId }, complete, categoryID, filter);
            
            if (!complete)
            {
                this.AddScript("TaskWindow_{0}.down('#taskMessage').hide();", taskId);
                this.AddScript("TaskWindow_{0}.down('#markComplete').show();", taskId);
                this.AddScript("TaskWindow_{0}.down('#markActive').hide();", taskId);
                this.AddScript("TaskWindow_{0}.down('#buttonsBar').updateLayout();", taskId);
                this.AddScript("TaskWindow_{0}.down('#hasReminder').enable();", taskId);
                this.AddScript("TaskWindow_{0}.down('#reminder').enable();", taskId);
            }
        }
    }
}
