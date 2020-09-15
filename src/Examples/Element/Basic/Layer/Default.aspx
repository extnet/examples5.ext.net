<%@ Page Language="C#" %>

<%@ Import Namespace="Panel=Ext.Net.Panel" %>

<script runat="server">
    protected void ShowRight(object sender, DirectEventArgs e)
    {
        Layer layer = new Layer(new LayerConfig
        {
            ID = "Layer1",
            DH =
            {
                Cls = "layer",
                Children = {
                    new DomObject {
                        Children = {
                            new DomObject {
                                Tag = HtmlTextWriterTag.H3,
                                Html = "Hello"
                            },
                            new DomObject {
                                Tag = HtmlTextWriterTag.Hr
                            },
                            new DomObject {
                                Tag = HtmlTextWriterTag.A,
                                Html = "Close",
                                CustomConfig = {
                                    new ConfigItem("href", "#", ParameterMode.Value),
                                    new ConfigItem("onClick", "CompanyX.Close('Layer1'); return false;", ParameterMode.Value)
                                }
                            }
                        }
                    }
                }
            }
        });

        layer.SetVisible(false, false).AlignTo(Panel1.Element, "tl-tr", new int[] { 5, 0 }).SlideIn("l");

        ((Ext.Net.Button)sender).Disabled = true;
    }

    [DirectMethod]
    public void Close(string id)
    {
        X.Get(id).SlideOut("l", new FxConfig
        {
            Callback = new JFunction(X.Get(id).ChainOn().Remove().ToScript(), 200)
        });

        this.Button1.Disabled = false;
    }

    protected void ShowBottom(object sender, DirectEventArgs e)
    {
        Panel p = new Panel
        {
            ID = "Panel2",
            Floating = true,
            Title = "Panel in Layer",
            Html = "Ext.Net Panel",
            BodyPadding = 18,
            Width = 300,
            Height = 100,
            Shadow = false,
            Tools = {
                new Tool {
                    Type = ToolType.Close,
                    Handler = "CompanyX.Close2();"
                }
            }
        };

        p.Render(X.Body().Descriptor, RenderMode.RenderTo);

        Layer layer = new Layer(new LayerConfig
        {
            ID = "Layer2",
            ExistingElement = p.Element
        });

        layer.SetVisible(false, false).AlignTo(Panel1.Element, "tl-bl", new int[] { 0, 5 }).SlideIn("t");

        ((Ext.Net.Button)sender).Disabled = true;
    }

    [DirectMethod]
    public void Close2()
    {
        Element l2 = X.Get("Layer2").ChainOn();
        l2.SlideOut("t", new FxConfig { Callback = new JFunction(l2.Remove().ToScript(), 200) }).Render();
        Button2.Disabled = false;
    }

</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Layer Overview - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .layer {
            position: absolute;
            width: 100px;
            height: 270px;
            padding: 5px;
            border: solid 1px silver;
        }

            .layer div {
                height: 258px;
                background-color: silver;
                padding: 5px;
            }
    </style>
</head>
<body>
    <ext:ResourceManager runat="server" Namespace="" DirectMethodNamespace="CompanyX" />

    <ext:Panel
        ID="Panel1"
        runat="server"
        Title="Panel"
        Width="480"
        Height="480">
        <Buttons>
            <ext:Button ID="Button1" runat="server" Text="Show Right">
                <DirectEvents>
                    <Click OnEvent="ShowRight">
                        <EventMask MinDelay="250" ShowMask="true" CustomTarget="={#{Panel1}.getBody()}" />
                    </Click>
                </DirectEvents>
            </ext:Button>

            <ext:Button ID="Button2" runat="server" Text="Show Bottom">
                <DirectEvents>
                    <Click OnEvent="ShowBottom">
                        <EventMask MinDelay="250" ShowMask="true" CustomTarget="={#{Panel1}.getBody()}" />
                    </Click>
                </DirectEvents>
            </ext:Button>
        </Buttons>
    </ext:Panel>
</body>
</html>
