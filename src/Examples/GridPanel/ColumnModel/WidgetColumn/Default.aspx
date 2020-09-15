<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            var data = new List<object>();
            var random = new Random();

            for (int i = 0; i < 8; i++) {
                data.Add(new object[]
                {
                    "Record " + (i + 1),
                    random.Next(0, 100) / 100d,
                    GenerateSequence(random),
                    GenerateSequence(random),
                    GenerateSequence(random),
                    GenerateSequence(random, 20, 1, 10),
                    GenerateSequence(random, 4, 10, 20),
                    GenerateSequence(random),
                    GenerateSequence(random, 20, -1, 1)
                });
            }

            this.Store1.DataSource = data;
        }
    }

    private object GenerateSequence(Random random, int? count = null, int? min = null, int? max = null)
    {
        var sequence = new List<int>();

        if (!count.HasValue)
        {
            count = 20;
        }

        if (!min.HasValue)
        {
            min = -10;
        }

        if (!max.HasValue)
        {
            max = 10;
        }

        for (int j = 0; j < count; j++)
        {
            sequence.Add(random.Next(min.Value, max.Value + 1));
        }
        return sequence;
     }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Widget Column - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Widget Column</h1>

        <p>This example shows how to create Widgets in grid columns. Widgets are lightweight components with a simpler lifecycle.</p>

        <p>The <b>Progress</b> and <b>Slider</b> widget columns uses the widget's <a href="http://docs.sencha.com/extjs/7.2.0/classic/Ext.Widget.html#cfg-ripple">Ripple</a> feature to highlight clicks on them.</p>

        <ext:GridPanel
            runat="server"
            Collapsible="true"
            Title="Widget Grid"
            Width="1050"
            Height="480"
            DisableSelection="true">
            <Store>
                <ext:Store ID="Store1" runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="name" />
                                <ext:ModelField Name="progress" Type="Float" />
                                <ext:ModelField Name="sequence1" />
                                <ext:ModelField Name="sequence2" />
                                <ext:ModelField Name="sequence3" />
                                <ext:ModelField Name="sequence4" />
                                <ext:ModelField Name="sequence5" />
                                <ext:ModelField Name="sequence6" />
                                <ext:ModelField Name="sequence7" />
                            </Fields>
                        </ext:Model>
                    </Model>
                    <Reader>
                        <ext:ArrayReader />
                    </Reader>
                </ext:Store>
            </Store>

            <ViewConfig
                StripeRows="true"
                EnableTextSelection="false"
                MarkDirty="false"
                TrackOver="false"
                />

            <ColumnModel runat="server">
                <Columns>
                     <ext:WidgetColumn runat="server" Width="105" DataIndex="progress" Text="Button">
                         <Widget>
                             <ext:SplitButton
                                runat="server"
                                Width="90"
                                IconCls="x-md md-icon-add-circle-outline"
                                Handler="Ext.Msg.alert('Button clicked', 'Hey! ' + this.getWidgetRecord().get('name'));"
                                />
                         </Widget>
                     </ext:WidgetColumn>

                    <ext:WidgetColumn runat="server" Width="120" DataIndex="progress" Text="Progress">
                        <Widget>
                            <ext:ProgressBarWidget runat="server" TextTplString="{percent:number('0')}% done" RippleString="blue" />
                        </Widget>
                    </ext:WidgetColumn>

                    <ext:WidgetColumn runat="server" Width="150" Text="Run Mode">
                         <Widget>
                             <ext:ComboBox runat="server">
                                 <Items>
                                     <ext:ListItem Text="Local" />
                                     <ext:ListItem Text="Remote" />
                                 </Items>
                                 <Listeners>
                                     <Select Handler="Ext.MessageBox.notify({html:this.getValue() + ' selected'});" />
                                 </Listeners>
                             </ext:ComboBox>
                         </Widget>
                     </ext:WidgetColumn>

                    <ext:WidgetColumn runat="server" Width="120" DataIndex="progress" Text="Slider">
                        <Widget>
                            <ext:SliderWidget
                                runat="server"
                                MinValue="0"
                                MaxValue="1"
                                DecimalPrecision="2"
                                Ripple="true">
                                <Listeners>
                                    <Change Handler="if (this.getWidgetRecord) {var rec = this.getWidgetRecord(); if (rec) { rec.set('progress', newValue);}}" />
                                </Listeners>
                            </ext:SliderWidget>
                        </Widget>
                    </ext:WidgetColumn>

                    <ext:WidgetColumn runat="server" Width="100" DataIndex="sequence1" Text="Line">
                        <Widget>
                            <ext:LineSparkLine runat="server" TipTplString='Value: {y:number("0.00")}' />
                        </Widget>
                    </ext:WidgetColumn>

                    <ext:WidgetColumn runat="server" Width="100" DataIndex="sequence2" Text="Bar">
                        <Widget>
                            <ext:BarSparkLine runat="server" />
                        </Widget>
                    </ext:WidgetColumn>

                    <ext:WidgetColumn runat="server" Width="100" DataIndex="sequence3" Text="Discrete">
                        <Widget>
                            <ext:DiscreteSparkLine runat="server" />
                        </Widget>
                    </ext:WidgetColumn>

                    <ext:WidgetColumn runat="server" Width="100" DataIndex="sequence4" Text="Bullet">
                        <Widget>
                            <ext:BulletSparkLine runat="server" />
                        </Widget>
                    </ext:WidgetColumn>

                    <ext:WidgetColumn runat="server" Width="60" DataIndex="sequence5" Text="Pie">
                        <Widget>
                            <ext:PieSparkLine runat="server" />
                        </Widget>
                    </ext:WidgetColumn>

                    <ext:WidgetColumn runat="server" Width="100" DataIndex="sequence6" Text="Box">
                        <Widget>
                            <ext:BoxSparkLine runat="server" />
                        </Widget>
                    </ext:WidgetColumn>

                    <ext:WidgetColumn runat="server" Width="100" DataIndex="sequence7" Text="TriState">
                        <Widget>
                            <ext:TriStateSparkLine runat="server" />
                        </Widget>
                    </ext:WidgetColumn>
                </Columns>
            </ColumnModel>
        </ext:GridPanel>
    </form>
</body>
</html>