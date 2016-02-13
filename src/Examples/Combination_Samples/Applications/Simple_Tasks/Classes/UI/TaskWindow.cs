namespace Ext.Net.Examples.SimpleTasks
{
    public partial class TaskWindow : Window
    {
        private Toolbar toolbar;
        private FormPanel formPanel;
        private Checkbox cbxReminder;
        private DateField dfReminder;
        private TextField taskSubject;
        private DateField dueDate;
        private DropDownField taskCategory;
        private HtmlEditor description;

        public TaskWindow()
        {
            this.Width = 480;
            this.Height = 365;
            this.Resizable = false;
            this.Layout = "Border";
            this.CloseAction = CloseAction.Destroy;

            this.BuildToolbar();
            this.BuildFormPanel();
        }

        private void BuildToolbar()
        {
            this.toolbar = new Toolbar
               {
                   ItemID ="buttonsBar",
                   Region = Ext.Net.Region.North,
                   Height = 26,
                   Items =
                   {
                       new Button
                       {
                           ItemID ="markComplete",
                           IconCls = "icon-mark-complete",
                           Text = "Mark Complete"
                       },
                       new Button
                       {
                           ItemID ="markActive",
                           Hidden = true,
                           IconCls = "icon-mark-active",
                           Text = "Mark Active"
                       },
                       new ToolbarSeparator(),
                       new Button
                       {
                           IconCls = "icon-delete-task",
                           Text = "Delete"
                       }
                   }
               };

            this.Items.Add(this.toolbar);
        }

        private void BuildFormPanel()
        {
            this.cbxReminder = new Checkbox  {
                ItemID ="hasReminder",
                BoxLabel = "Reminder:",
                Name = "HasReminder",
                Checked = false
            };

            this.dfReminder = new DateField
            {
                ItemID ="reminder",
                Disabled = true,
                Name = "Reminder",
                Width = 135
            };

            this.taskSubject = new TextField
            {
                AllowBlank = false,
                FieldLabel = "Task&nbsp;Subject",
                Name = "Title",
                Anchor = "100%"
            };

            this.dueDate = new DateField
            {
                AllowBlank = false,
                FieldLabel = "Due Date",
                Name = "DueDate",
                Width = 135
            };

            this.taskCategory = new DropDownField
              {
                  AllowBlank = false,
                  FieldLabel = "Task List",
                  Name = "Name",
                  Editable = false,
                  Mode = DropDownMode.ValueText,
                  ItemID ="taskCategory",
                  Component =
                  {
                      new TreePanel
                      {
                          Height = 150,
                          Shadow = false,
                          UseArrows = true,
                          AutoScroll = true,
                          Animate = true,
                          Cls = "tasks-tree",
                          RootVisible = false,
                          Root =
                          {
                              new Node{NodeID="root", EmptyChildren = true}
                          },
                          SelectionModel =
                          {
                              new TreeSelectionModel()
                          }
                      }
                  }
              };

            this.description = new HtmlEditor
            {
                HideLabel = true,
                Name = "Description",
                Anchor = "100% -150",
                EnableSourceEdit = false,
                EnableFont = false
            };

            this.formPanel = new FormPanel
             {
                 Region = Ext.Net.Region.Center,
                 ButtonAlign = Alignment.Right,
                 MinButtonWidth = 80,
                 BaseCls = "x-plain",
                 ItemID ="taskForm",
                 Cls = "task-window",

                 FieldDefaults =
                 {
                     LabelWidth = 75
                 },

                 CustomConfig =
                 {
                     new ConfigItem("margin", "10 10 5 10", ParameterMode.Value)
                 },

                 Items =
                 {
                     new Component
                     {
                         Hidden = true,
                         ItemID ="taskMessage",
                         AutoEl =
                         {
                             Cls = "taskMessage"
                         }
                     },
                     taskSubject,
                     new Container
                     {
                         Cls = "x-plain",
                         Layout = "Hbox",
                         Anchor = "100%",
                         Height = 30,
                         Items =
                         {
                             new Container
                             {
                                 Width = 250,
                                 Layout = "Form",
                                 Cls = "x-pain",
                                 Items =
                                 {
                                     dueDate
                                 }
                             },
                             new Container
                             {
                                 Flex = 1,
                                 Layout = "Form",
                                 Cls = "x-plain",
                                 Items =
                                 {
                                     taskCategory
                                 },
                                 Defaults =
                                 {
                                     new Parameter()
                                     {
                                        Name = "LabelWidth",
                                        Value = "55",
                                        Mode = ParameterMode.Raw
                                     }
                                 }
                             }
                         }
                     },
                     new Component
                     {
                         AutoEl =
                         {
                             Cls = "divider"
                         }
                     },
                     new Container
                     {
                         Layout = "HBox",
                         Anchor = "100%",
                         Cls = "x-plain",
                         Height = 30,
                         Items =
                         {
                             new Container
                             {
                                 Width = 80,
                                 Layout = "Form",
                                 Cls = "x-plain",
                                 Items =
                                 {
                                     cbxReminder
                                 },
                                 Defaults =
                                 {
                                     new Parameter()
                                     {
                                        Name = "HideLabel",
                                        Value = "true",
                                        Mode = ParameterMode.Raw
                                     }
                                 }
                             },
                             new Container
                             {
                                 Flex = 1,
                                 Layout = "Form",
                                 Cls = "x-plain",
                                 Items =
                                 {
                                     dfReminder
                                 },
                                 Defaults =
                                 {
                                     new Parameter()
                                     {
                                        Name = "HideLabel",
                                        Value = "true",
                                        Mode = ParameterMode.Raw
                                     }
                                 }
                             }
                         }
                     },
                     description
                 }
             };

            this.Buttons.Add(new Button ("OK"));
            this.Buttons.Add(new Button ("Cancel"));

            this.Items.Add(this.formPanel);
        }
    }
}