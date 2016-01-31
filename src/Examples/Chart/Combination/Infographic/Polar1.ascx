<%@ Control Language="C#" %>
<%@ Register Namespace="Ext.Net.Examples" Assembly="Ext.Net.Examples" TagPrefix="ee" %>

<ext:PolarChart runat="server"
    AnchorHorizontal="100%"
    Height="1375"
    Animation="false"
    InsetPaddingSpec="400 0 125 0"
    StoreID="Store1">
    <HtmlBin>
        <script>
            function onSliceRender2012(sprite, config, data, index) {
                // Please see the comments in the KitchenSink.store.Unemployment class
                // for more info on the meaning of the record fields.
                var record = data.store.getAt(index),
                    label = record.get('label'),
                    unemployment = record.get('y2012'),
                    spriteSurface = sprite.getSurface(),
                    chart = spriteSurface.ownerCt,
                    style = {};

                if (label === '') { // a separating sector
                    style.fillStyle = 'none';
                    style.strokeStyle = 'none';
                } else if (label === 'year') { // a sector that shows a year
                    style.fillStyle = 'rgba(70, 70, 69, 1.0)';
                } else { // a sector that shows the change in unemployment with a color
                    if (!spriteSurface.getStateColor) {
                        // Add the 'getStateColor' method of the view to the 'series' surface
                        // of the pie chart for the ease of access inside a series renderer.
                        spriteSurface.getStateColor = getStateColor;
                    }
                    style.fillStyle = spriteSurface.getStateColor(unemployment);
                }
                return style;
            }

            function onSliceRenderOther(year) {
                return function (sprite, config, data, index) {
                    var record = data.store.getAt(index),
                        label = record.get('label'),
                        style = {};
                    if (label === '') {
                        style.fillStyle = 'none';
                        style.strokeStyle = 'none';
                    } else if (label === 'year') {
                        style.fillStyle = 'rgba(70, 70, 69, 1.0)';
                    } else {
                        style.fillStyle = sprite.getSurface().getStateColor(record.get(year));
                    }
                    return style;
                };
            }

            function onLabelRender2012(text, sprite, config, data, index) {
                if (text === 'year') {
                    return {
                        text: '2012',
                        font: 'bold 16px sans-serif'
                    };
                }
            }

            function onLabelRenderOther(year) {
                return function(text, sprite, config, data, index) {
                    if (text === 'year') {
                        return {
                            text: year
                        };
                    } else {
                        return {
                            hidden: true
                        };
                    }
                }
            }
        </script>
    </HtmlBin>
    <Items>
        <ext:RectSprite
            X="50"
            Y="40"
            Width="890"
            Height="100"
            FillStyle="rgba(76, 76, 77, 1.0)" />

        <ext:TextSprite
            Text="Changes in U.S. Unemployment"
            Font="bold 54px Charter"
            FillStyle="white"
            X="70"
            Y="120" />

        <ext:TextSprite
            Text="2007-2012"
            Font="24px Verdana"
            FillStyle="white"
            X="730"
            Y="76" />

        <%--The stripe containing the "SENCHA INFOGRAPHIC" text--%>
        <ext:PathSprite
            Path="M0,0 L294,0 L302,8 L302,29.14 C302,29.14 0,29.5 0,29 C0,28.5 0,0 0,0 z"
            TranslationX="34"
            TranslationY="20"
            FillStyle="#DDDCD4" />

        <%--The edge twist of the stripe above.--%>
        <ext:PathSprite
            Path="M0,29.265 L13.5,29.265 L13.5,41.265 z"
            TranslationX="34"
            TranslationY="20"
            FillStyle="#9D9D9D" />

        <ext:TextSprite
            Text="SENCHA"
            Font="12px Verdana"
            FillStyle="rgba(148, 51, 57, 1.0)"
            X="60"
            Y="42" />

        <ext:TextSprite
            Text="INFOGRAPHIC"
            Font="bold 12px Verdana"
            FillStyle="rgba(148, 51, 57, 1.0)"
            X="116"
            Y="42" />

        <ext:ImageSprite
            Src="sencha.png"
            X="24"
            Y="10" />

        <ext:TextSprite
            Text="={'Forty-three states and the District of Columbia added\njobs in the past 12 months, but the US has 4.8\nmillion fewer jobs than it did in 2008. North Dakota\nled the pack with a 7.2 percent increase, but the\nnational growth rate was only 1.1 percent. Seven\nstates lost jobs.'}"
            Font="20px Charter"
            TextBaseline="Top"
            X="75"
            Y="165" />

        <ext:TextSprite
            Text="Unemployment"
            Font="bold 36px Charter"
            FillStyle="rgba(76, 76, 77, 1.0)"
            TextBaseline="Top"
            X="632"
            Y="165" />

        <%--The legend"s up arrow.--%>
        <ext:PathSprite
            Path="M0,6.5 L12.5,0 L25,6.5 L25,21.5 L0,21.5 z"
            TranslationX="748"
            TranslationY="214.5"
            FillStyle="rgba(146, 50, 51, 1.0)" />

        <ext:RectSprite
            X="748"
            Y="238"
            Width="25"
            Height="20"
            FillStyle="rgba(179, 113, 114, 1.0)" />

        <ext:RectSprite
            X="748"
            Y="260"
            Width="25"
            Height="20"
            FillStyle="rgba(126, 135, 142, 1.0)" />

        <ext:RectSprite
            X="748"
            Y="282"
            Width="25"
            Height="20"
            FillStyle="rgba(194, 212, 221, 1.0)" />

        <%--The legend"s down arrow.--%>
        <ext:PathSprite
            Path="M0,15 L12.5,21.5 L25,15 L25,0 L0,0 z"
            TranslationX="748"
            TranslationY="304"
            FillStyle="rgba(114, 166, 185, 1.0)" />

        <ext:TextSprite
            Text="rose by more than 1.5%"
            TextAlign="Right"
            Font="13px Charter"
            FillStyle="rgba(56, 54, 54, 1.0)"
            X="742"
            Y="233" />

        <ext:TextSprite
            Text="rose by 0.5% to 1.5%"
            TextAlign="Right"
            Font="13px Charter"
            FillStyle="rgba(56, 54, 54, 1.0)"
            X="742"
            Y="255" />

        <ext:TextSprite
            Text="rose by less than 0.5%"
            TextAlign="Right"
            Font="13px Charter"
            FillStyle="rgba(56, 54, 54, 1.0)"
            X="742"
            Y="277" />

        <ext:TextSprite
            Text="fell by less than 0.5%"
            TextAlign="Left"
            Font="13px Charter"
            FillStyle="rgba(56, 54, 54, 1.0)"
            X="778"
            Y="277" />

        <ext:TextSprite
            Text="fell by 0.5% to 1.5%"
            TextAlign="Left"
            Font="13px Charter"
            FillStyle="rgba(56, 54, 54, 1.0)"
            X="778"
            Y="298" />

        <ext:TextSprite
            Text="fell by more than 1.5%"
            TextAlign="Left"
            Font="13px Charter"
            FillStyle="rgba(56, 54, 54, 1.0)"
            X="778"
            Y="318" />

        <ext:TextSprite
            Text="Roll over a state to learn more."
            TextAlign="Center"
            Font="bold 17px Charter"
            FillStyle="rgba(77, 77, 78, 1.0)"
            X="495"
            Y="370" />

        <ext:TextSprite
            Text="={'Percent change\nin unemployment'}"
            TextAlign="center"
            Font="bold 21px Charter"
            FillStyle="rgba(56, 54, 54, 1.0)"
            X="495"
            Y="1020" />

        <%--The footer rectangle--%>
        <ext:RectSprite
            X="50"
            Y="1300"
            Width="890"
            Height="50"
            FillStyle="rgba(76, 76, 77, 1.0)" />

        <ext:TextSprite
            Text="Source=Bureau of Labor Statistics"
            TextBaseline="Top"
            Font="12px Tahoma"
            FillStyle="white"
            X="60"
            Y="1310" />

        <ext:TextSprite
            Text="={'Sencha infographic by Vitaly Kravchenko\nupdated June 4, 2014'}"
            TextBaseline="Top"
            TextAlign="Right"
            Font="12px Tahoma"
            FillStyle="white"
            X="910"
            Y="1310" />

        <ee:ArcTextSprite
            Text="Recession December 2007"
            TranslationX="495"
            TranslationY="829"
            Radius="276"
            Angle="-90"
            Spacing="3">
            <Template FontSize="13" FillStyle="rgba(146, 50, 51, 1.0)" />
        </ee:ArcTextSprite>
    </Items>

    <Series>
        <ext:PieSeries
            AngleField="span"
            Donut="93"
            Rotation="<%# -Math.PI/60 %>"
            AutoDataBind="true">
            <SubStyle>
                <ext:Sprite StrokeStyle="white" LineWidth="1" />
            </SubStyle>
            <Label
                Orientation="None"
                Field="label"
                Display="Inside"
                FillStyle="white"
                FontWeight="bold"
                FontSize="13"
                FontFamily="Tahoma">
                <Renderer Fn="onLabelRender2012" />
            </Label>
            <Renderer Fn="onSliceRender2012" />
        </ext:PieSeries>

        <ext:PieSeries
            AngleField="span"
            Donut="86"
            RadiusFactor="93"
            Rotation="<%# -Math.PI/60 %>"
            AutoDataBind="true">
            <SubStyle>
                <ext:Sprite StrokeStyle="white" LineWidth="1" />
            </SubStyle>
            <Label
                Orientation="None"
                Field="label"
                Display="Inside"
                FillStyle="white"
                FontWeight="bold"
                FontSize="15">
                <Renderer Fn="onLabelRenderOther('2011')" />
            </Label>
            <Renderer Fn="onSliceRenderOther('y2011')" />
        </ext:PieSeries>

        <ext:PieSeries
            AngleField="span"
            Donut="79"
            RadiusFactor="86"
            Rotation="<%# -Math.PI/60 %>"
            AutoDataBind="true">
            <SubStyle>
                <ext:Sprite StrokeStyle="white" LineWidth="1" />
            </SubStyle>
            <Label
                Orientation="None"
                Field="label"
                Display="Inside"
                FillStyle="white"
                FontWeight="bold"
                FontSize="14">
                <Renderer Fn="onLabelRenderOther('2010')" />
            </Label>
            <Renderer Fn="onSliceRenderOther('y2010')" />
        </ext:PieSeries>

        <ext:PieSeries
            AngleField="span"
            Donut="73"
            RadiusFactor="79"
            Rotation="<%# -Math.PI/60 %>"
            AutoDataBind="true">
            <SubStyle>
                <ext:Sprite StrokeStyle="white" LineWidth="1" />
            </SubStyle>
            <Label
                Orientation="None"
                Field="label"
                Display="Inside"
                FillStyle="white"
                FontWeight="bold"
                FontSize="13">
                <Renderer Fn="onLabelRenderOther('2009')" />
            </Label>
            <Renderer Fn="onSliceRenderOther('y2009')" />
        </ext:PieSeries>

        <ext:PieSeries
            AngleField="span"
            Donut="67"
            RadiusFactor="73"
            Rotation="<%# -Math.PI/60 %>"
            AutoDataBind="true">
            <SubStyle>
                <ext:Sprite StrokeStyle="white" LineWidth="1" />
            </SubStyle>
            <Label
                Orientation="None"
                Field="label"
                Display="Inside"
                FillStyle="white"
                FontWeight="bold"
                FontSize="12">
                <Renderer Fn="onLabelRenderOther('2008')" />
            </Label>
            <Renderer Fn="onSliceRenderOther('y2008')" />
        </ext:PieSeries>

        <ext:PieSeries
            AngleField="span"
            Donut="57"
            RadiusFactor="63"
            Rotation="<%# -Math.PI/60 %>"
            AutoDataBind="true">
            <SubStyle>
                <ext:Sprite StrokeStyle="white" LineWidth="1" />
            </SubStyle>
            <Label
                Orientation="None"
                Field="label"
                Display="Inside"
                FillStyle="white"
                FontWeight="bold"
                FontSize="11">
                <Renderer Fn="onLabelRenderOther('2007')" />
            </Label>
            <Renderer Fn="onSliceRenderOther('y2007')" />
        </ext:PieSeries>
    </Series>
</ext:PolarChart>