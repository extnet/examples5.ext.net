using System.Linq;

using Ext.Net.Utilities;

namespace Ext.Net.Examples.SimpleTasks
{
    public partial class TaskWindow
    {
        public const string SCOPE = "SimpleTasks.TaskWindow";
        private int taskId;

        public TaskWindow(int taskId) : this()
        {
            this.ID = "TaskWindow_" + taskId;
            this.taskId = taskId;

            SimpleTasksDataContext ctx = this.DBContext;
            Task task = (from t in ctx.Tasks where t.ID == taskId select t).First();
            this.Title = "Task - " + task.Title.Ellipsis(40);

            if (task.Completed)
            {
                Component msg = (Component)this.formPanel.Items[0];
                msg.Hidden = false;
                msg.AutoEl.Html = "This task was completed on " + task.CompletedDate.Value.ToString("dddd, MMMM dd, yyyy");
            }
           
            this.toolbar.Items[0].Hidden = task.Completed;
            this.toolbar.Items[1].Hidden = !task.Completed;

            this.cbxReminder.Disabled = task.Completed;
            this.dfReminder.Disabled = task.Completed;

            if (!task.Completed)
            {
                this.cbxReminder.Checked = task.Reminder.HasValue;

                if (task.Reminder.HasValue)
                {
                    this.dfReminder.SelectedDate = task.Reminder.Value;
                }
            }

            this.taskSubject.Text = task.Title;
            this.dueDate.SelectedDate = task.DueDate;
            this.taskCategory.Text = task.Category.Name;
            this.taskCategory.UnderlyingValue = task.Category.ID.ToString();
            this.description.Text = task.Description;

            this.CustomConfig.Add(new ConfigItem("taskId", taskId.ToString(), ParameterMode.Raw));

            this.InitLogic();
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

        private void InitLogic()
        {
            this.Listeners.AfterRender.Fn = TaskWindow.SCOPE + ".initWindow";

            this.Buttons[0].Handler = new JFunction(TaskWindow.SCOPE.ConcatWith(".save(", this.ID, ");")).ToScript();
            this.Buttons[1].Handler = new JFunction(this.ID + ".close();").ToScript();

            TreePanel tree = (TreePanel)(taskCategory.Component[0]);
            tree.Listeners.ItemClick.Fn = TasksGrid.SCOPE + ".categoryCheckChange";

            ((Button)this.toolbar.Items[0]).Handler = new JFunction(TaskWindow.SCOPE.ConcatWith(".markTask(", this.ID, ", true);")).ToScript();
            ((Button)this.toolbar.Items[1]).Handler = new JFunction(TaskWindow.SCOPE.ConcatWith(".markTask(", this.ID, ", false);")).ToScript();
            ((Button)this.toolbar.Items[3]).Handler = new JFunction(TaskWindow.SCOPE.ConcatWith(".deleteTask(", this.ID, ");")).ToScript();
        }
    }
}