namespace Ext.Net.Examples.SimpleTasks
{
    public partial class TasksTopBar : Panel
    {
        private Toolbar tBar;

        public TasksTopBar()
        {
            this.BodyCls = "x-hidden";
            this.BuildTopBar();

            this.InitLogic();
        }

        private void BuildTopBar()
        {
            this.tBar = new Toolbar
            {
                Items =
                {
                    new SplitButton
                    {
                        Text = "New",
                        IconCls = "icon-edit",
                        Menu =
                        {
                            new Menu
                            {
                                Items =
                                {
                                    new MenuItem
                                    {
                                        Text = "New Task",
                                        IconCls = "icon-active"
                                    },
                                    new MenuItem
                                    {
                                        Text = "New Category",
                                        Icon = Icon.New
                                    },
                                    new MenuItem
                                    {
                                        Text = "New Folder",
                                        IconCls = "icon-folder-new",
                                    }
                                }
                            }
                        }
                    },
                    new ToolbarSeparator(),
                    new Button
                    {
                        IconCls = "icon-delete-task",
                        ToolTip = "Delete Task",
                        Disabled = true
                    },
                    new Button
                    {
                        IconCls = "icon-mark-complete",
                        ToolTip = "Mark Complete",
                        Disabled = true
                    },
                     new Button
                    {
                        IconCls = "icon-mark-active",
                        ToolTip = "Mark Active",
                        Disabled = true
                    },
                    new ToolbarFill(),
                    new Button
                    {
                        ID = "filterAll",
                        IDMode = IDMode.Static,
                        ToolTip = "All Tasks",
                        IconCls = "icon-all",
                        Pressed = true,
                        EnableToggle = true,
                        ToggleGroup = "tasksfilter"
                    },
                    new Button
                    {
                        ID = "filterActive",
                        IDMode = IDMode.Static,
                        ToolTip = "Active Tasks",
                        IconCls = "icon-active",
                        EnableToggle = true,
                        ToggleGroup = "tasksfilter"
                    },
                    new Button
                    {
                        ID = "filterCompleted",
                        IDMode = IDMode.Static,
                        ToolTip = "Completed Tasks",
                        IconCls = "icon-complete",
                        EnableToggle = true,
                        ToggleGroup = "tasksfilter"
                    }
                }
            };

            this.TopBar.Add(this.tBar);
        }
    }
}
