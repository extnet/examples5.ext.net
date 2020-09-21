<%@ Control Language="C#" %>

<ext:CartesianChart
    runat="server"
    X="300"
    Y="700"
    Width="350"
    Height="360"
    Animation="false">
    <Axes>
        <ext:NumericAxis
            Position="Left"
            TitleMargin="16"
            Minimum="-3"
            Maximum="6">
            <TitleConfig Text="percent" FontSize="16" FontFamily="Charter" />
        </ext:NumericAxis>

        <ext:CategoryAxis Position="Bottom">
            <FloatingConfig ValueInt="0" AlongAxisIndex="0" />
        </ext:CategoryAxis>
    </Axes>
    <Series>
        <ext:BarSeries XField="year" YField="percent">
            <StyleSpec>
                <ext:SeriesSprite StrokeStyle="none" MaxBarWidth="34" />
            </StyleSpec>
            <Renderer Handler="var percent = rendererData.store.getAt(index).get('percent'); return { fillStyle: getStateColor(percent) };" />
        </ext:BarSeries>
    </Series>
</ext:CartesianChart>