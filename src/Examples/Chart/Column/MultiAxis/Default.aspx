<%@ Page Language="C#" %>

<script runat="server">
    public class Temperature
    {
        public string Month
        {
            get;
            set;    
        }
        
        public double High
        {
            get;
            set;    
        }    
        
        public double Low
        {
            get;
            set;    
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.BindData();
        }
    }

    private void BindData()
    {
        var data = new List<Temperature> 
        {
            new Temperature { Month = "Jan", High = 14.7, Low = 5.6  },
            new Temperature { Month = "Feb", High = 16.5, Low = 6.6  },
            new Temperature { Month = "Mar", High = 18.6, Low = 7.3  },
            new Temperature { Month = "Apr", High = 20.8, Low = 8.1  },
            new Temperature { Month = "May", High = 23.3, Low = 9.9  },
            new Temperature { Month = "Jun", High = 26.2, Low = 11.9 },
            new Temperature { Month = "Jul", High = 27.7, Low = 13.3 },
            new Temperature { Month = "Aug", High = 27.6, Low = 13.2 },
            new Temperature { Month = "Sep", High = 26.4, Low = 12.1 },
            new Temperature { Month = "Oct", High = 23.6, Low = 9.9  },
            new Temperature { Month = "Nov", High = 17  , Low = 6.8  },
            new Temperature { Month = "Dec", High = 14.7, Low = 5.8  }
        };

        this.Chart1.GetStore().DataSource = data;
        this.Chart1.GetStore().DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Column Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        function rangechange (range) {
            var cAxis = this.getChart().getAxis('celsius-axis');
            if (cAxis) {
                cAxis.setMinimum((range[0] - 32) / 1.8);
                cAxis.setMaximum((range[1] - 32) / 1.8);
            }
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Column Chart Sample</h1>

        <p>This example shows how to define multiple axes in a single direction. It also shows</p>
        <p>how to have slave axes linked to the master axis. Slave axes mirror the data and the</p>
        <p>layout of the master axis, but can be styled and positioned differently. The example</p>
        <p>also shows how to use gradients in charts.</p>
        <br />
        <p>Click and drag to select a region to zoom into. Double-click to undo the last zoom.</p>

        <ext:Panel
            runat="server"
            Width="650"
            Height="500"
            Layout="FitLayout">
            <Items>
                <ext:CartesianChart
                    ID="Chart1"
                    runat="server"
                    InsetPadding="10" 
                    InnerPadding="0 20 0 20">
                    <Store>
                        <ext:Store runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Month" />
                                        <ext:ModelField Name="High" />
                                        <ext:ModelField Name="Low" />
                                        <ext:ModelField Name="HighF">
                                            <Convert Handler="return record.data.High * 1.8 + 32;" />
                                        </ext:ModelField>
                                        <ext:ModelField Name="LowF">
                                            <Convert Handler="return record.data.Low * 1.8 + 32;" />
                                        </ext:ModelField>
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>

                    <Interactions>
                        <ext:CrossZoomInteraction />
                    </Interactions>                    

                    <Axes>
                        <ext:NumericAxis 
                            AxisID="fahrenheit-axis"
                            Position="Left"                                                        
                            AdjustByMajorUnit="true"
                            Minimum="32"
                            TitleMargin="20"
                            Grid="true"
                            Title="Temperature in °F">
                            <Listeners>
                                <RangeChange Fn="rangechange" />
                            </Listeners>
                        </ext:NumericAxis>

                        <ext:NumericAxis 
                            AxisID="celsius-axis"
                            TitleMargin="20"
                            Position="Right"> 
                            <TitleConfig FillStyle="red" Text="Temperature in °C" />
                        </ext:NumericAxis>

                        <ext:CategoryAxis AxisID="months-axis" Position="Bottom" />

                        <ext:CategoryAxis 
                            LinkedToID="months-axis" 
                            Position="Top"
                            TitleMargin="20">
                            <TitleConfig FillStyle="green" Text="Climate data for Redwood City, California" />
                        </ext:CategoryAxis>
                    </Axes>

                    <Series>
                        <ext:BarSeries                            
                            XField="Month"
                            YField="HighF" 
                            YAxisID="fahrenheit-axis">
                            <StyleSpec>
                                <ext:SeriesSprite MinGapWidth="10" />
                            </StyleSpec>

                            <SubStyle>
                                <ext:Sprite FillStyle="url(#rainbow)" />
                            </SubStyle>
                        </ext:BarSeries>

                        <ext:BarSeries                            
                            XField="Month"
                            YField="LowF" 
                            YAxisID="fahrenheit-axis">
                            <StyleSpec>
                                <ext:SeriesSprite MinGapWidth="10" />
                            </StyleSpec>

                            <SubStyle>
                                <ext:Sprite FillStyle="none" />
                            </SubStyle>
                        </ext:BarSeries>
                    </Series>

                    <Gradients>
                        <ext:LinearGradient GradientID="rainbow" Degrees="270">
                            <Stops>
                                <ext:GradientStop Offset="0" Color="#78C5D6" />
                                <ext:GradientStop Offset="0.14" Color="#449AA7" />
                                <ext:GradientStop Offset="0.28" Color="#79C267" />
                                <ext:GradientStop Offset="0.42" Color="#C4D546" />
                                <ext:GradientStop Offset="0.56" Color="#F5D63D" />
                                <ext:GradientStop Offset="0.7" Color="#F18B32" />
                                <ext:GradientStop Offset="0.84" Color="#E767A1" />
                                <ext:GradientStop Offset="1" Color="#BF62A6" />
                            </Stops>
                        </ext:LinearGradient>
                    </Gradients>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
