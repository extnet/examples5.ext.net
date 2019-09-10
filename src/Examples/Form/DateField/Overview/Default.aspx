<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest && !IsPostBack)
        {
            var curTheme = Ext.Net.ResourceManager.GetInstance(HttpContext.Current);

            switch (curTheme.Theme)
            {
                case Ext.Net.Theme.Triton:
                    Container1.Width = 640;
                    break;
                case Ext.Net.Theme.CrispTouch:
                case Ext.Net.Theme.NeptuneTouch:
                    Container1.Width = 584;
                    break;
                case Ext.Net.Theme.Aria:
                case Ext.Net.Theme.Crisp:
                case Ext.Net.Theme.Classic:
                case Ext.Net.Theme.Gray:
                case Ext.Net.Theme.Neptune:
                    Container1.Width = 580;
                    break;
            }
        }
    }
</script>

<html>
<head runat="server">
    <title>Overview of Date and Month Fields - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <!-- The following fixes an issue with zooming out and years views in the pickers (github issue #14). -->
    <style type="text/css">
        .x-monthpicker-months,
        .x-monthpicker-months .x-monthpicker-item,
        .x-monthpicker-years,
        .x-monthpicker-years .x-monthpicker-item,
        .x-monthpicker-yearnav-button-ct {
            width: 50% !important;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Overview of Date and Month Fields</h1>

        <ext:Container ID="Container1" runat="server">
            <LayoutConfig>
                <ext:VBoxLayoutConfig Align="Center" />
            </LayoutConfig>
            <Items>
                <ext:Container runat="server" Layout="HBoxLayout" MarginSpec="0 0 20 0">
                    <Items>
                        <ext:Panel runat="server" Title="Date Field" MarginSpec="0 20 0 0">
                            <Items>
                                <ext:DateField runat="server" />
                            </Items>
                        </ext:Panel>
                        <ext:Panel runat="server" Title="Month Field">
                            <Items>
                                <ext:DateField runat="server" Type="Month" />
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Container>

                <ext:Container runat="server" Layout="HBoxLayout" MarginSpec="0 0 20 0">
                    <Items>
                        <ext:Panel runat="server" Title="Date Picker" MarginSpec="0 20 0 0">
                            <Items>
                                <ext:DatePicker runat="server" />
                            </Items>
                        </ext:Panel>
                        <ext:Panel runat="server" Title="Month Picker">
                            <Items>
                                <ext:MonthPicker runat="server" />
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Container>

                <ext:Container runat="server" Layout="HBoxLayout">
                    <Items>
                        <ext:Panel runat="server" Title="Date Picker (no today)" MarginSpec="0 20 0 0">
                            <Items>
                                <ext:DatePicker runat="server" ShowToday="false" />
                            </Items>
                        </ext:Panel>
                        <ext:Panel runat="server" Title="Month Picker (no buttons)">
                            <Items>
                                <ext:MonthPicker runat="server" ShowButtons="false" />
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Container>
            </Items>
        </ext:Container>
    </form>
</body>
</html>
