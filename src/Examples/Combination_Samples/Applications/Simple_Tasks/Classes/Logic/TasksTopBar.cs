using System.Linq;

namespace Ext.Net.Examples.SimpleTasks
{
    public partial class TasksTopBar
    {
        public const string SCOPE = "SimpleTasks.TasksTopBar";

        private void InitLogic()
        {
            this.Listeners.Render.Fn = TasksTopBar.SCOPE + ".init";
            this.Listeners.Render.Scope = TasksTopBar.SCOPE;
            
            SplitButton sBut = (SplitButton)this.tBar.Items[0];
            sBut.Listeners.Click.Fn = TasksGrid.SCOPE + ".focusTaskField";
            sBut.Listeners.Click.Scope = TasksGrid.SCOPE;

            //New Task
            MenuItem mItem = (MenuItem)sBut.Menu[0].Items[0];
            mItem.Listeners.Click.Fn = TasksGrid.SCOPE + ".focusTaskField";
            mItem.Listeners.Click.Scope = TasksGrid.SCOPE;

            //New Category
            mItem = (MenuItem)sBut.Menu[0].Items[1];
            mItem.Listeners.Click.Handler = TasksTree.SCOPE + ".insertCategory();";
            mItem.Listeners.Click.Scope = TasksTree.SCOPE;

            //New Folder
            mItem = (MenuItem)sBut.Menu[0].Items[2];
            mItem.Listeners.Click.Handler = TasksTree.SCOPE + ".insertFolder();";
            mItem.Listeners.Click.Scope = TasksTree.SCOPE;

            Button button = (Button)this.tBar.Items[2];

            ComponentDirectEvent click = button.DirectEvents.Click;
            click.Event += DelClick_Event;
            click.Confirmation.ConfirmRequest = true;
            click.Confirmation.Message = "Are you sure you want to delete the selected task(s)?";
            click.ExtraParams.Add(new Parameter("ids", TasksGrid.SCOPE + ".getSelectedIds()", ParameterMode.Raw));
            click.Before = TasksGrid.SCOPE + ".setIndicator(true);";
            click.Complete = TasksGrid.SCOPE + ".setIndicator(false);";

            button = (Button)this.tBar.Items[3];
            click = button.DirectEvents.Click;
            click.Event += MarkClick_Event;
            click.ExtraParams.Add(new Parameter("ids", TasksGrid.SCOPE + ".getSelectedIds()", ParameterMode.Raw));
            click.ExtraParams.Add(new Parameter("filter", TasksGrid.SCOPE + ".getFilterValue()", ParameterMode.Raw));
            click.ExtraParams.Add(new Parameter("categoryID", TasksGrid.SCOPE + ".getActiveNodeCategory().getId()", ParameterMode.Raw));
            click.Before = TasksGrid.SCOPE + ".setIndicator(true);";
            click.Complete = TasksGrid.SCOPE + ".setIndicator(false);";

            button = (Button)this.tBar.Items[4];
            click = button.DirectEvents.Click;
            click.Event += UnMarkClick_Event;
            click.ExtraParams.Add(new Parameter("ids", TasksGrid.SCOPE + ".getSelectedIds()", ParameterMode.Raw));
            click.ExtraParams.Add(new Parameter("filter", TasksGrid.SCOPE + ".getFilterValue()", ParameterMode.Raw));
            click.ExtraParams.Add(new Parameter("categoryID", TasksGrid.SCOPE + ".getActiveNodeCategory().getId()", ParameterMode.Raw));
            click.Before = TasksGrid.SCOPE + ".setIndicator(true);";
            click.Complete = TasksGrid.SCOPE + ".setIndicator(false);";

            for (int i = 6; i < 9; i++)
            {
                button = (Button)this.tBar.Items[i];
                button.Listeners.Click.Fn = TasksGrid.SCOPE + ".applyFilter";
                button.Listeners.Click.Scope = TasksGrid.SCOPE;
            }
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

        protected void UnMarkClick_Event(object sender, DirectEventArgs e)
        {
            TasksGrid grid = Ext.Net.Utilities.ControlUtils.FindControls<TasksGrid>(this.Page)[0];
            int[] ids = JSON.Deserialize<int[]>(e.ExtraParams["ids"]);
            int categoryID = int.Parse(e.ExtraParams["categoryID"]);
            grid.ToggleStatus(ids, false, categoryID, e.ExtraParams["filter"]);
        }
    }
}
