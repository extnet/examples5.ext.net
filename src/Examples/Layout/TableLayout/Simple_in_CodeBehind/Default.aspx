<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        // Build all the Panels which will fill the Table Cells.
        Ext.Net.Panel panel1 = new Ext.Net.Panel();
        panel1.Title = "Lots of Spanning";
        panel1.BodyPadding = 15;
        panel1.Height = 320;
        panel1.Html = "<p>Row spanning.</p><br /><p>Row spanning.</p><br /><p>Row spanning.</p><br /><p>Row spanning.</p><br /><p>Row spanning.</p><br /><p>Row spanning.</p>";

        Ext.Net.Panel panel2 = new Ext.Net.Panel();
        panel2.Title = "Basic Table Cell";
        panel2.BodyStyle = "padding:15px;";
        panel2.Height = 105;
        panel2.Html = "<p>Basic panel in a table cell.</p>";

        Ext.Net.Panel panel3 = new Ext.Net.Panel();
        panel3.Header = false;
        panel3.BodyStyle = "padding:15px;";
        panel3.Height = 105;
        panel3.Html = "<p>Plain panel</p>";

        Ext.Net.Panel panel4 = new Ext.Net.Panel();
        panel4.Title = "Another Cell";
        panel4.Width = Unit.Pixel(300);
        panel4.Height = 220;
        panel4.BodyStyle = "padding:15px;";
        panel4.Html = "<p>Row spanning.</p><br /><p>Row spanning.</p><br /><p>Row spanning.</p><br /><p>Row spanning.</p>";

        Ext.Net.Panel panel5 = new Ext.Net.Panel();
        panel5.BodyStyle = "padding:15px;";
        panel5.Height = 100;
        panel5.Html = "Plain cell spanning two columns";

        Ext.Net.Panel panel6 = new Ext.Net.Panel();
        panel6.Title = "More Column Spanning";
        panel6.BodyStyle = "padding:15px;";
        panel6.Height = 85;
        panel6.Html = "<p>Spanning three columns.</p>";

        Ext.Net.Panel panel7 = new Ext.Net.Panel();
        panel7.Title = "Spanning All Columns";
        panel7.BodyStyle = "padding:15px;";
        panel7.Html = "<p>Spanning all columns.</p>";

        panel1.RowSpan = 3;
        panel4.RowSpan = 2;
        panel5.ColSpan = 2;
        panel6.ColSpan = 3;
        panel7.ColSpan = 4;

        Ext.Net.Panel pnlTableLayout = new Ext.Net.Panel();
        pnlTableLayout.ID = "pnlTableLayout";
        pnlTableLayout.Region = Region.Center;
        pnlTableLayout.Title = "Table Layout";
        pnlTableLayout.BodyPadding = 15;
        pnlTableLayout.Border = false;
        pnlTableLayout.Layout = LayoutType.Table.ToString();

        TableLayoutConfig tlc = new TableLayoutConfig()
        {
            Columns = 4
        };
        pnlTableLayout.LayoutConfig.Add(tlc);

        pnlTableLayout.Items.Add(panel1);
        pnlTableLayout.Items.Add(panel2);
        pnlTableLayout.Items.Add(panel3);
        pnlTableLayout.Items.Add(panel4);
        pnlTableLayout.Items.Add(panel5);
        pnlTableLayout.Items.Add(panel6);
        pnlTableLayout.Items.Add(panel7);

        Viewport viewPort1 = new Viewport();
        viewPort1.Layout = "BorderLayout";
        viewPort1.Items.Add(pnlTableLayout);

        this.PlaceHolder1.Controls.Add(viewPort1);
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Simple TableLayout - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <style>
        #pnlTableLayout .x-table-layout {
            padding : 5px;
        }

        #pnlTableLayout .x-table-layout td {
            font-size : 11px;
            padding   : 5px;
            vertical-align : top;
        }
    </style>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <asp:PlaceHolder ID="PlaceHolder1" runat="server" />
</body>
</html>