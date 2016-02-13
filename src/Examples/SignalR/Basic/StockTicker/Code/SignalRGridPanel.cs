using System;
using Ext.Net;

namespace Ext.Net.Examples
{
    public class SignalRGridPanel : GridPanel
    {
        public override string XType
        {
            get { return "signalrgridpanel"; }
        }

        public override string InstanceOf
        {
            get { return "ExtNetSignalRDemo.SignalRGridPanel"; }
        }

        protected override void OnInit(EventArgs e)
        {
            BuildTopBar();
            BuildStore();
            BuildColumns();
            BuildView();

            base.OnInit(e);
        }

        private void BuildTopBar()
        {
            TopBar.Add(new Toolbar
            {
                Items =
                {
                    BuildButton("Open", "Open Market", Icon.PlayGreen),
                    BuildButton("Close", "Close Market", Icon.StopRed, false),
                    BuildButton("Reset", "Reset", Icon.PlayGreen)
                }
            });
        }

        private Button BuildButton(string action, string text, Icon icon, bool enabled = true)
        {
            return new Button
            {
                ItemID    = "btn" + action,
                Enabled   = enabled,
                Text      = text,
                Icon      = icon,
                Listeners =
                {
                    Click =
                    {
                        Handler = "this.up('signalrgridpanel')." + action.ToLower() + "();"
                    }
                }
            };
        }

        private void BuildStore()
        {
            Store.Add(new Store
            {
                Model =
                {
                    new Model
                    {
                        IDProperty = "Symbol",
                        Fields =
                        {
                            new ModelField("Symbol"),
                            new ModelField("Price", ModelFieldType.Float)
                            {
                                Convert = { Handler="return #{" + ID + "}.convertPrice.apply(this, arguments);" }
                            },
                            new ModelField("DayOpen", ModelFieldType.Float),
                            new ModelField("DayHigh", ModelFieldType.Float),
                            new ModelField("DayLow", ModelFieldType.Float),
                            new ModelField("Direction"),
                            new ModelField("LastChange", ModelFieldType.Float),
                            new ModelField("Change", ModelFieldType.Float),
                            new ModelField("PercentChange", ModelFieldType.Float)
                            {
                                Convert = { Handler="return #{" + ID + "}.convertPercentChange.apply(this, arguments);" }
                            }
                        }
                    }
                }
            });
        }

        private void BuildColumns()
        {
            ColumnModel.Columns.AddRange(new []
            {
                new Column { Flex=1, DataIndex="Symbol", Text="Symbol" },
                new Column { Width=70, DataIndex="Price", Text="Price", Align=Alignment.Right },
                new Column { Width=70, DataIndex="DayOpen", Text="Open", Align=Alignment.Right },
                new Column { Width=70, DataIndex="DayHigh", Text="High", Align=Alignment.Right },
                new Column { Width=70, DataIndex="DayLow", Text="Low", Align=Alignment.Right },
                new Column
                {
                    Width=90, DataIndex="Symbol", Text="Direction", Align=Alignment.Center,
                    Renderer = { Handler = "return #{" + ID + "}.renderDirection.apply(#{" + ID + "}, arguments);" }
                },
                new Column { Width=80, DataIndex="LastChange", Text="Change", Align=Alignment.Right },
                new Column { Width=80, DataIndex="Change", Text="Change", Align=Alignment.Right },
                new Column { Width=70, DataIndex="PercentChange", Text="%", Align=Alignment.Right }
            });
        }

        private void BuildView()
        {
            View.Add(new GridView { MarkDirty = false });
        }
    }
}