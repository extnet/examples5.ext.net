<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Color Palette - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .my-color-pallete {
            width: 310px;
            height: 360px;
        }

        .my-color-pallete a {
            border: 1px solid #FFFFFF;
            cursor: pointer;
            float: left;
            outline: 0 none;
            padding: 2px;
            text-decoration: none;
        }

        .my-color-pallete em {
            border: 1px solid #ACA899;
            display: block;
        }

        .my-color-pallete em span {
            cursor: pointer;
            display: block;
        }

        .my-color-pallete a:hover, .my-color-pallete a.x-color-picker-selected {
            background-color: #DEECFD;
            border-color: #8BB8F3;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:ColorPicker runat="server" Cls="my-color-pallete">
            <Template runat="server">
                <Html>
                    <tpl for="colors">
                        <a href="#" class="color-{.}" hidefocus="on">
                            <em style="padding:2px;">
                                <span style="background:#{.}; width:50px; height:20px; border:1px solid black;" unselectable="on">
                                    &#160;
                                </span>
                                <div style="font-size:10px;text-align:center;">#{.}</div>
                            </em>
                        </a>
                    </tpl>
                </html>            </Template>
        </ext:ColorPicker>
    </form>
</body>
</html>