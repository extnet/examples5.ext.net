<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        var panel1 = new Panel("Users");
        var panel2 = new Panel("Settings");
        var panel3 = new Panel("Security");
        var panel4 = new Panel("Documents");

        var toolbar = new Toolbar();

        var button1 = new Button
        {
            IconCls = "x-md md-icon-add-circle-outline"
        };

        var tooltip = new ToolTip
        {
            Title = "Rich ToolTips",
            Html = "Let your users know what they can do!"
        }

        button1.ToolTips.Add(tooltip);

        var button2 = new Button
        {
            IconCls = "x-md md-icon-person"
        };

        var button3 = new Button
        {
            IconCls = "x-md md-icon-person"
        };

        toolbar.Items.Add(button1);
        toolbar.Items.Add(button2);
        toolbar.Items.Add(button3);

        var window = new Window
        {
            Title = "Accordion Window",
            Width = Unit.Pixel(360),
            Height = Unit.Pixel(600),
            Maximizable = true,
            BodyBorder = 0,
            Layout = "Accordion"
        }

        window.TopBar.Add(toolbar);

        window.Items.Add(panel1);
        window.Items.Add(panel2);
        window.Items.Add(panel3);
        window.Items.Add(panel4);

        this.PlaceHolder1.Controls.Add(window);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>AccordionLayout in Code-Behind - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>Accordion Layout in Code-Behind</h1>

    <asp:PlaceHolder ID="PlaceHolder1" runat="server" />
</body>
</html>