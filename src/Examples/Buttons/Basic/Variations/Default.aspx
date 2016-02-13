<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            List<ButtonConfig> configs = new List<ButtonConfig> {
                new ButtonConfig{
                    Name = "Text Only"
                },

                new ButtonConfig{
                    Name = "Disabled",
                    Config = new Ext.Net.Button.Config {
                        Disabled = true
                    }
                },

                new ButtonConfig{
                    Name = "Icon Only",
                    Config = new Ext.Net.Button.Config {
                        IconCls = "add"
                    }
                },

                new ButtonConfig{
                    Name = "Icon (left) and Text",
                    Config = new Ext.Net.Button.Config {
                        IconCls = "add",
                        IconAlign = IconAlign.Left
                    }
                },

                new ButtonConfig{
                    Name = "Icon (top) and Text",
                    Config = new Ext.Net.Button.Config {
                        IconCls = "add",
                        IconAlign = IconAlign.Top
                    }
                },

                new ButtonConfig{
                    Name = "Icon (right) and Text",
                    Config = new Ext.Net.Button.Config {
                        IconCls = "add",
                        IconAlign = IconAlign.Right
                    }
                },

                new ButtonConfig{
                    Name = "Icon (bottom) and Text",
                    Config = new Ext.Net.Button.Config {
                        IconCls = "add",
                        IconAlign = IconAlign.Bottom
                    }
                }
            };

            this.RenderButtons("Normal Buttons", configs, new Ext.Net.Button.Config { CtCls = "floater" });

            this.RenderButtons("Toggle Buttons", configs, new Ext.Net.Button.Config { Cls = "floater", EnableToggle = true });

            this.RenderButtons("Menu Buttons", configs, new Ext.Net.Button.Config { Cls = "floater" }, typeof(Ext.Net.Button), true);

            this.RenderButtons("Split Buttons", configs, new Ext.Net.Button.Config { Cls = "floater" }, typeof(Ext.Net.SplitButton), true);

            this.RenderButtons("Menu Buttons (Arrow on bottom)", configs, new Ext.Net.Button.Config { Cls = "floater", ArrowAlign = ArrowAlign.Bottom }, typeof(Ext.Net.Button), true);

            this.RenderButtons("Split Buttons (Arrow on bottom)", configs, new Ext.Net.Button.Config { Cls = "floater", ArrowAlign = ArrowAlign.Bottom }, typeof(Ext.Net.SplitButton), true);

            this.RenderButtons("Text align: left", configs, new Ext.Net.Button.Config { Cls = "floater", TextAlign = Ext.Net.ButtonTextAlign.Left, Width = 200 });

            this.RenderButtons("Text align: right", configs, new Ext.Net.Button.Config { Cls = "floater", TextAlign = Ext.Net.ButtonTextAlign.Right, Width = 200 });

            this.RenderButtons("Href Buttons", configs, new Ext.Net.Button.Config { Cls = "floater", Href = "http://ext.net/" });
        }
    }

    private MenuBase GetMenu()
    {
        return new Ext.Net.Menu
        {
            Items = {
                new Ext.Net.MenuItem("Menu Item 1"),
                new Ext.Net.MenuItem("Menu Item 2"),
                new Ext.Net.MenuItem("Menu Item 3")
            }
        };
    }

    private void RenderButtons(string title, List<ButtonConfig> configs, Ext.Net.Button.Config defaultConfig, Type buttonType = null, bool menu = false)
    {
        this.Buttons.Controls.Add(new HtmlGenericControl {
            TagName = "h2",
            InnerText = title
        });

        foreach (ButtonConfig config in configs)
        {
            this.Buttons.Controls.Add(new HtmlGenericControl
            {
                TagName = "h3",
                InnerText = config.Name
            });

            HtmlGenericControl div = new HtmlGenericControl
            {
                TagName = "div"
            };

            this.Buttons.Controls.Add(div);

            foreach (ButtonScale scale in new ButtonScale[] { ButtonScale.Large, ButtonScale.Medium, ButtonScale.Small })
            {
                ButtonBase button = (ButtonBase)Activator.CreateInstance(buttonType ?? typeof(Ext.Net.Button));

                if (config.Name != "Icon Only")
                {
                    button.Text = scale.ToString();
                }

                button.Scale = scale;

                if (config.Config != null)
                {
                    Ext.Net.Utilities.ObjectUtils.Apply(button, config.Config);
                }

                if (defaultConfig != null)
                {
                    Ext.Net.Utilities.ObjectUtils.Apply(button, defaultConfig);
                }

                if (menu)
                {
                    button.Menu.Add(this.GetMenu());
                }

                div.Controls.Add(button);
            }

            div.Controls.Add(new HtmlGenericControl
            {
                TagName = "div",
                Style = {
                    Value = "clear: both;"
                }
            });
        }
    }

    public class ButtonConfig
    {
        public string Name
        {
            get;
            set;
        }

        public Ext.Net.Button.Config Config
        {
            get;
            set;
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Button Variations - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .x-btn-default-large .add {
            background-image: url(images/add32.gif) !important;
        }
        .x-btn-default-small .add {
            background-image: url(images/add16.gif) !important;
        }
        .x-btn-default-medium .add {
            background-image: url(images/add24.gif) !important;
        }

        h2 {
            color:#083772 !important;
            margin: 20px 0 0 !important;
            padding: 5px;
            background:#eee;
            width:400px;
        }

        h3 {
            font-weight:normal !important;
            margin:10px;
        }

        .x-btn {
            margin-left:10px;
        }

        .floater{
            float:left;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Ext Buttons</h1>

        <asp:PlaceHolder ID="Buttons" runat="server" />
    </form>
</body>
</html>