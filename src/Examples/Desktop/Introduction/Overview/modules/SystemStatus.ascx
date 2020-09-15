<%@ Control Language="C#" %>

<script runat="server">
    public static string[] MemoryColors = new string[]{ "rgb(244, 16, 0)", "rgb(248, 130, 1)", "rgb(0, 7, 255)", "rgb(84, 254, 0)" };

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.LastCore1 = 0;
            this.LastCore2 = 0;
            this.Pass = 99;
            this.UpdateCharts();
        }
    }

    protected void UpdateTask(object sender, DirectEventArgs e)
    {
        this.UpdateCharts();
    }

    private object GenerateData(string[] names)
    {
        List<object> data = new List<object>();
        double rest = names.Length;
        Random random = new Random();
        
        for (int i = 0; i < names.Length; i++)
        {
            double consume = Math.Floor(random.NextDouble() * rest * 100) / 100 + 2;
            rest = rest - (consume - 5);
            data.Add(new 
            { 
                Name = names[i],
                Memory = consume
            });
        }

        return data;
    }

    public int Pass
    {
        get
        {
            object obj = this.Session["pass"];
            return obj != null ? (int)obj : 99;
        }
        set
        {
            this.Session["pass"] = value;
        }
    }

    private double GenerateCPUValue(double factor, Random random)
    {
        double value = factor + ((Math.Floor(random.NextDouble() * 2) % 2) > 0 ? -1 : 1) * Math.Floor(random.NextDouble() * 9);

        if (value < 0 || value > 100)
        {
            value = 50;
        }

        return value;
    }

    private double LastCore1
    {
        get
        {
            object obj = this.Session["core1"];
            return obj != null ? (double)obj : 0d;
        }
        set
        {
            this.Session["core1"] = value;
        }
    }

    private double LastCore2
    {
        get
        {
            object obj = this.Session["core2"];
            return obj != null ? (double)obj : 0d;
        }
        set
        {
            this.Session["core2"] = value;
        }
    }

    private void GenerateCPULoad()
    {
        double core1 = this.LastCore1;
        double core2 = this.LastCore2;
        int pass = 99;
        Random random = new Random();
        
        if (X.IsAjaxRequest)
        {
            CPULoadStore.RemoveAt(0);

            CPULoadStore.Each(new JFunction 
            {  
                Args = new string[]{"item", "key"},
                Handler = "item.data.Time = key;" // update time
            });
            
            core1 = this.GenerateCPUValue(core1, random);
            core2 = this.GenerateCPUValue(core2, random);

            CPULoadStore.LoadData(new []{new { Core1 = core1, Core2 = core2, Time = pass }}, true);
        }
        else
        {
            List<object> data = new List<object>();
            data.Add(new { Core1 = 0, Core2 = 0, Time = 0 });            
            
            for (int i = 1; i < 100; i++) {
                core1 = this.GenerateCPUValue(core1, random);
                core2 = this.GenerateCPUValue(core2, random);
                
                data.Add(new 
                {
                    Core1 = core1,
                    Core2 = core2,
                    Time = i
                });
            }

            CPULoadStore.DataSource = data;
            CPULoadStore.DataBind();            
            this.Pass = 99;
        }

        this.LastCore1 = core1;
        this.LastCore2 = core2;
    }
    
    private void UpdateCharts()
    {
        int pass = this.Pass;
        
        if (pass % 3 == 0 || !X.IsAjaxRequest)
        {
            MemoryStore.DataSource = this.GenerateData(new string[]{"Wired", "Active", "Inactive", "Free"});
            MemoryStore.DataBind();
            if (X.IsAjaxRequest)
            {
                this.MemoryChart.Redraw();
            }
        }

        if (pass % 2 == 0 || !X.IsAjaxRequest)
        {
           ProcessStore.DataSource = this.GenerateData(new string[] { "Explorer", "Monitor", "Charts", "Desktop", "Ext3", "Ext4" });
           ProcessStore.DataBind();
        }

        this.GenerateCPULoad();
        
        this.Pass++;
    }
</script>

<script>
    var processRenderer = function (sprite, config, rendererData, index) {
        var lowColor = Ext.draw.Color.fromString('#b1da5a'),
            record = rendererData.store.getAt(index),
            value = record.get('Memory'),
            color;

        if (value > 5) {
            color = lowColor.createDarker((value - 5) / 15).toString();
        } else {
            color = lowColor.createLighter(((5 - value) / 20)).toString();
        }

        if (value >= 8) {
            color = '#CD0000';
        }

        return {
            fillStyle: color
        };
    };
</script>

<ext:DesktopModuleProxy runat="server">
    <Module ModuleID="systemstatus">
        <Shortcut Name="System Status" IconCls="x-status-shortcut" SortIndex="2" />
        <Window>
            <ext:Window ID="SystemStatusWnd" runat="server"
                Width="800" 
                Height="600" 
                Border="false"      
                CloseAction="Destroy" 
                Layout="Fit"
                Title="System Status">
                <Bin>                    
                    <ext:Store ID="CPULoadStore" runat="server">
                        <Model>
                            <ext:Model runat="server">
                                <Fields>
                                    <ext:ModelField Name="Core1" />
                                    <ext:ModelField Name="Core2" />
                                    <ext:ModelField Name="Time" />
                                </Fields>
                            </ext:Model>
                        </Model>
                    </ext:Store>

                    <ext:Store ID="MemoryStore" runat="server">
                        <Model>
                            <ext:Model runat="server">
                                <Fields>
                                    <ext:ModelField Name="Name" />
                                    <ext:ModelField Name="Memory" />
                                </Fields>
                            </ext:Model>
                        </Model>
                    </ext:Store>

                    <ext:Store ID="ProcessStore" runat="server">
                        <Model>
                            <ext:Model runat="server">
                                <Fields>
                                    <ext:ModelField Name="Name" />
                                    <ext:ModelField Name="Memory" />
                                </Fields>
                            </ext:Model>
                        </Model>
                    </ext:Store>

                    <ext:TaskManager ID="TaskManager1" runat="server">
                        <Tasks>
                            <ext:Task TaskID="updateCharts" WaitPreviousRequest="true" AutoRun="false" Interval="2000">
                                <DirectEvents>
                                    <Update OnEvent="UpdateTask" />
                                </DirectEvents>
                            </ext:Task>
                        </Tasks>
                    </ext:TaskManager>

                    <ext:ChartTheme runat="server"  ThemeName="Memory" 
                        Colors="<%# MemoryColors %>"
                        AutoDataBind="true"
                        />
                </Bin>
                <Items>
                    <ext:Panel runat="server">
                        <LayoutConfig>
                            <ext:HBoxLayoutConfig Align="Stretch" />
                        </LayoutConfig>
                        <Items>
                            <ext:Container
                                runat="server"
                                Flex="1">
                                <LayoutConfig>
                                    <ext:VBoxLayoutConfig Align="Stretch" />
                                </LayoutConfig>
                                <Items>
                                    <ext:CartesianChart ID="CPUChart1" runat="server"
                                        Flex="1"
                                        StandardTheme="Category1"
                                        Animation="false" 
                                        Legend="true"
                                        StoreID="CPULoadStore">
                                        <Axes>
                                            <ext:NumericAxis 
                                                Position="Left"
                                                Minimum="0"
                                                Maximum="100"
                                                Fields="Core1"
                                                Title="CPU Load"
                                                Grid="true">
                                                <TitleConfig Font="13px Arial" />
                                                <Label Font="11px Arial" />
                                            </ext:NumericAxis>
                                        </Axes>
                                        <Series>
                                            <ext:LineSeries
                                                Title="Core 1 (3.4GHz)"
                                                ShowMarkers="false"
                                                Fill="true"
                                                XField="Time"
                                                YField="Core1">
                                                <StyleSpec>
                                                    <ext:Sprite LineWidth="1" />
                                                </StyleSpec>
                                            </ext:LineSeries>
                                        </Series>
                                    </ext:CartesianChart>

                                    <ext:CartesianChart  ID="CPUChart2" runat="server"
                                        Flex="1"
                                        StandardTheme="Category2"
                                        Animation="false"
                                        Legend="true"
                                        StoreID="CPULoadStore">
                                        <Axes>
                                            <ext:NumericAxis 
                                                Position="Left"
                                                Minimum="0"
                                                Maximum="100"
                                                Fields="Core2"
                                                Title="CPU Load"
                                                Grid="true">
                                                <TitleConfig Font="13px Arial" />
                                                <Label Font="11px Arial" />
                                            </ext:NumericAxis>
                                        </Axes>
                                        <Series>
                                            <ext:LineSeries
                                                Title="Core 2 (3.4GHz)"
                                                Fill="true"
                                                XField="Time"
                                                YField="Core2">
                                                <StyleSpec>
                                                    <ext:Sprite LineWidth="1" />
                                                </StyleSpec>
                                            </ext:LineSeries>
                                        </Series>
                                    </ext:CartesianChart>
                                </Items>
                            </ext:Container>

                            <ext:Container
                                runat="server"
                                Flex="1">
                                <LayoutConfig>
                                    <ext:VBoxLayoutConfig Align="Stretch" />
                                </LayoutConfig>
                                <Items>
                                    <ext:PolarChart ID="MemoryChart" runat="server"
                                        Flex="1"
                                        StoreID="MemoryStore"
                                        InnerPadding="20"
                                        Shadow="true"
                                        Animation="true"
                                        Theme="Memory">
                                        <LegendConfig runat="server" Dock="Right" />
                                        <Series>
                                            <ext:PieSeries
                                                Donut="30"
                                                AngleField="Memory"
                                                ShowInLegend="true"
                                                Highlight="true"
                                                HighlightMargin="20">
                                                <ToolTip 
                                                    runat="server"
                                                    TrackMouse="true"
                                                    Width="140"
                                                    Height="28">
                                                    <Renderer Handler="toolTip.setTitle(record.get('Name') + ': ' + Math.round(record.get('Memory') / #{MemoryStore}.sum('Memory') * 100) + '%');" />
                                                </ToolTip>                    
                                                <Label Field="Name" Display="Rotate" Font="12px Arial" />
                                            </ext:PieSeries>
                                        </Series>
                                    </ext:PolarChart>

                                    <ext:CartesianChart
                                        runat="server"
                                        Flex="1"
                                        StandardTheme="Category1"
                                        StoreID="ProcessStore">
                                        <AnimationConfig Easing="EaseInOut" Duration="750" />
                                        <Axes>
                                            <ext:NumericAxis
                                                Position="Left"
                                                Minimum="0"
                                                Maximum="10"
                                                Fields="Memory"
                                                Title="Memory">
                                                <TitleConfig Font="13px Arial" />
                                                <Label Font="11px Arial" />
                                            </ext:NumericAxis>

                                            <ext:CategoryAxis
                                                Position="Bottom"
                                                Fields="Name"
                                                Title="System Processes">
                                                <TitleConfig Font="bold 14px Arial" />
                                                <Label RotationDegrees="45" />
                                            </ext:CategoryAxis>
                                        </Axes>
                                        <Series>
                                            <ext:BarSeries
                                                Title="Processes"
                                                XField="Name"
                                                YField="Memory">
                                                <Renderer Fn="processRenderer" />
                                                <StyleSpec>
                                                    <ext:Sprite LineWidth="1" />
                                                </StyleSpec>
                                            </ext:BarSeries>
                                        </Series>
                                    </ext:CartesianChart>
                                </Items>
                            </ext:Container>
                        </Items>
                    </ext:Panel>
                </Items>   
                <Listeners>
                    <AfterRender Handler="#{TaskManager1}.startTask('updateCharts');" />
                </Listeners>             
            </ext:Window>
        </Window>
    </Module>
</ext:DesktopModuleProxy>