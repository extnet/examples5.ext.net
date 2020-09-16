<%@ Page Language="C#" %>

<script runat="server">
    public const string Template = "Curabitur pretium tincidunt lacus. Nulla gravida orci a odio.";
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Callout - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        h3.x-callout-header {
            /* to deactivate h3 rule from resources/css/examples.css */
            font-family:inherit;
        }
    </style>


    <style>
        /* Custom1 */
        .x-callout-custom1 {
            background-color: black;
            border: 1px solid #fff;
        }

        .x-callout-custom1 .x-callout-header {
            background-color: black;
            color:white;
            font-weight:bold;
        }

        .x-callout-custom1 .x-callout-body {
            color:white;
        }

        .x-callout-custom1.x-callout-top .x-callout-arrow,
        .x-callout-custom1.x-callout-topleft .x-callout-arrow,
        .x-callout-custom1.x-callout-topright .x-callout-arrow {
            border-top-color: #fff;
        }

        .x-callout-custom1.x-callout-top .x-callout-arrow:after,
        .x-callout-custom1.x-callout-topleft .x-callout-arrow:after,
        .x-callout-custom1.x-callout-topright .x-callout-arrow:after {
            border-top-color: black;
        }

        .x-callout-custom1.x-callout-right .x-callout-arrow,
        .x-callout-custom1.x-callout-righttop .x-callout-arrow,
        .x-callout-custom1.x-callout-rightbottom .x-callout-arrow {
            border-right-color: #fff;
        }

        .x-callout-custom1.x-callout-right .x-callout-arrow:after,
        .x-callout-custom1.x-callout-righttop .x-callout-arrow:after,
        .x-callout-custom1.x-callout-rightbottom .x-callout-arrow:after {
            border-right-color: black;
        }

        .x-callout-custom1.x-callout-bottom .x-callout-arrow,
        .x-callout-custom1.x-callout-bottomleft .x-callout-arrow,
        .x-callout-custom1.x-callout-bottomright .x-callout-arrow {
            border-bottom-color: #fff;
        }

        .x-callout-custom1.x-callout-bottom .x-callout-arrow:after,
        .x-callout-custom1.x-callout-bottomleft .x-callout-arrow:after,
        .x-callout-custom1.x-callout-bottomright .x-callout-arrow:after {
            border-bottom-color: black;
        }

        .x-callout-custom1.x-callout-left .x-callout-arrow,
        .x-callout-custom1.x-callout-lefttop .x-callout-arrow,
        .x-callout-custom1.x-callout-leftbottom .x-callout-arrow {
            border-left-color: #fff;
        }

        .x-callout-custom1.x-callout-left .x-callout-arrow:after,
        .x-callout-custom1.x-callout-lefttop .x-callout-arrow:after,
        .x-callout-custom1.x-callout-leftbottom .x-callout-arrow:after {
            border-left-color: black;
        }
    </style>

    <style>
        /* Custom2 */
        .x-callout-custom2 {
            background-color: #1e90ff;
            border: 5px solid rgb(17, 100, 151);
            padding: 0px;
        }

        .x-callout-custom2 .x-callout-header {
            background-color: #0d7cd0;
            color: white;
            font-weight: bold;
            border-radius: 0px;
            border: none;
        }

        .x-callout-custom2 .x-callout-body {
            color: white;
        }

        .x-callout-custom2.x-callout-top .x-callout-arrow,
        .x-callout-custom2.x-callout-topleft .x-callout-arrow,
        .x-callout-custom2.x-callout-topright .x-callout-arrow {
            border-top-color: rgb(17, 100, 151);
            bottom: -16px;
        }

        .x-callout-custom2.x-callout-top .x-callout-arrow:after,
        .x-callout-custom2.x-callout-topleft .x-callout-arrow:after,
        .x-callout-custom2.x-callout-topright .x-callout-arrow:after {
            border-top-color: rgb(17, 100, 151);
        }

        .x-callout-custom2.x-callout-right .x-callout-arrow,
        .x-callout-custom2.x-callout-righttop .x-callout-arrow,
        .x-callout-custom2.x-callout-rightbottom .x-callout-arrow {
            border-right-color: rgb(17, 100, 151);
            left: -16px;
        }

        .x-callout-custom2.x-callout-right .x-callout-arrow:after,
        .x-callout-custom2.x-callout-righttop .x-callout-arrow:after,
        .x-callout-custom2.x-callout-rightbottom .x-callout-arrow:after {
            border-right-color: rgb(17, 100, 151);
        }

        .x-callout-custom2.x-callout-bottom .x-callout-arrow,
        .x-callout-custom2.x-callout-bottomleft .x-callout-arrow,
        .x-callout-custom2.x-callout-bottomright .x-callout-arrow {
            border-bottom-color: rgb(17, 100, 151);
            top: -16px;
        }

        .x-callout-custom2.x-callout-bottom .x-callout-arrow:after,
        .x-callout-custom2.x-callout-bottomleft .x-callout-arrow:after,
        .x-callout-custom2.x-callout-bottomright .x-callout-arrow:after {
            border-bottom-color: rgb(17, 100, 151);
        }

        .x-callout-custom2.x-callout-left .x-callout-arrow,
        .x-callout-custom2.x-callout-lefttop .x-callout-arrow,
        .x-callout-custom2.x-callout-leftbottom .x-callout-arrow {
            border-left-color: rgb(17, 100, 151);
            right: -16px;
        }

        .x-callout-custom2.x-callout-left .x-callout-arrow:after,
        .x-callout-custom2.x-callout-lefttop .x-callout-arrow:after,
        .x-callout-custom2.x-callout-leftbottom .x-callout-arrow:after {
            border-left-color: rgb(17, 100, 151);
        }
    </style>

    <style>
        /* Custom3 */
        .x-callout-custom3 {
            background: #deefff; /* Old browsers */
            background: -moz-linear-gradient(top, #deefff 0%, #98bede 100%); /* FF3.6+ */
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#deefff), color-stop(100%,#98bede)); /* Chrome,Safari4+ */
            background: -webkit-linear-gradient(top, #deefff 0%,#98bede 100%); /* Chrome10+,Safari5.1+ */
            background: -o-linear-gradient(top, #deefff 0%,#98bede 100%); /* Opera 11.10+ */
            background: -ms-linear-gradient(top, #deefff 0%,#98bede 100%); /* IE10+ */
            background: linear-gradient(to bottom, #deefff 0%,#98bede 100%); /* W3C */
            filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#deefff', endColorstr='#98bede',GradientType=0 ); /* IE6-9 */
            padding: 0px;
        }

        .x-callout-custom3 .x-callout-header {
            background-color: transparent;
            color: black;
            font-weight: bold;
            border: none;
            padding-top: 10px;
        }

        .x-callout-custom3 .x-callout-body {
            color: black;
        }
    </style>

    <style>
        /* Custom4 */
        .x-callout-custom4 {
            font-size: 11px;
            font-family: Arial, sans-serif;
            background: rgb(251, 251, 251); /* Old browsers */
            background: -moz-linear-gradient(top, rgba(251, 251, 251, 1) 0%, rgba(248, 248, 248, 1) 11%, rgba(240, 240, 240, 1) 100%); /* FF3.6+ */
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, rgba(251, 251, 251, 1)), color-stop(11%, rgba(248, 248, 248, 1)), color-stop(100%, rgba(240, 240, 240, 1))); /* Chrome,Safari4+ */
            background: -webkit-linear-gradient(top, rgba(251, 251, 251, 1) 0%, rgba(248, 248, 248, 1) 11%, rgba(240, 240, 240, 1) 100%); /* Chrome10+,Safari5.1+ */
            background: -o-linear-gradient(top, rgba(251, 251, 251, 1) 0%, rgba(248, 248, 248, 1) 11%, rgba(240, 240, 240, 1) 100%); /* Opera11.10+ */
            background: -ms-linear-gradient(top, rgba(251, 251, 251, 1) 0%, rgba(248, 248, 248, 1) 11%, rgba(240, 240, 240, 1) 100%); /* IE10+ */
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr = '#fbfbfb', endColorstr = '#f0f0f0', GradientType = 0); /* IE6-9 */
            background: linear-gradient(top, rgba(251, 251, 251, 1) 0%, rgba(248, 248, 248, 1) 11%, rgba(240, 240, 240, 1) 100%); /* W3C */
            border: 1px solid #d9d9d9;
            border-radius: 4px;
            -moz-border-radius: 4px;
            -webkit-border-radius: 4px;
            padding: 0px;
        }

        .x-callout-custom4 .x-callout-header {
            background-color: transparent;
            color: #666;
            font-weight: bold;
            border: none;
            padding-top: 10px;
        }

        .x-callout-custom4 .x-callout-body {
            color: #666;
        }

        .x-callout-custom4.x-callout-top .x-callout-arrow,
        .x-callout-custom4.x-callout-topleft .x-callout-arrow,
        .x-callout-custom4.x-callout-topright .x-callout-arrow {
            border-top-color: #d9d9d9;
        }

        .x-callout-custom4.x-callout-top .x-callout-arrow:after,
        .x-callout-custom4.x-callout-topleft .x-callout-arrow:after,
        .x-callout-custom4.x-callout-topright .x-callout-arrow:after {
            border-top-color: rgb(243, 238, 238);
        }
    </style>

    <style>
        /* Custom5 */
        .x-callout-custom5 {
            border-radius:0px;
            padding:0px;
        }

        .x-callout-custom5 .x-callout-header {
            background-color: rgb(109, 188, 219);
            color: rgb(255, 255, 255);
            font-size: 18px;
            font-weight: bold;
            border-radius:0px;
            height:40px;
            line-height:40px;
            text-align:center;
            padding: 0px;
        }

        .x-callout-custom5 .x-callout-body {
            color: #666;
        }
    </style>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>Custom Appearance</h1>

    <ext:Container runat="server" BodyPadding="18" >
        <Defaults>
            <ext:Parameter Name="Margin" Value="20" />
            <ext:Parameter Name="Width" Value="150" />
            <ext:Parameter Name="Html" Value="<%# Template %>" AutoDataBind="true" />
        </Defaults>
        <Items>
            <ext:Callout runat="server" Title="Custom 1" UIName="custom1" />
            <ext:Callout runat="server" Title="Custom 2" UIName="custom2" />
            <ext:Callout
                runat="server"
                Title="Custom 3"
                UIName="custom3"
                NoArrow="true"
                />
            <ext:Callout
                runat="server"
                Title="Custom 4"
                UIName="custom4"
                Alignment="Top"
                />
            <ext:Callout
                runat="server"
                Title="Custom 5"
                UIName="custom5"
                NoArrow="true"
                Width="360"
                Height="180">
                <Content>
                    <div style="position:absolute;top:0px; left:0px;color:white;font-size:40px;width:40px;line-height:40px;text-align:center;">&#x2709;</div>
                    <div class="close-glyph" style="position:absolute;top:5px; right:5px;color:#bdddfa;font-size:25px;cursor:pointer;">&#x2716;</div>
                </Content>
                <Listeners>
                    <AfterRender Handler="this.el.down('.close-glyph').on('click', this.destroy, this);" />
                </Listeners>
            </ext:Callout>
        </Items>
    </ext:Container>
</body>
</html>
