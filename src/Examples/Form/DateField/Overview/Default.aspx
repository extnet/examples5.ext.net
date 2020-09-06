<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Overview of Date and Month Fields - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Overview of Date and Month Fields</h1>

        <ext:Container runat="server" Layout="hbox" MarginSpec="0 0 20 0">
            <Items>
                <ext:Panel
                    runat="server"
                    Title="DateField"
                    BodyPadding="18"
                    MarginSpec="0 20 0 0">
                    <Items>
                        <ext:DateField runat="server" />
                    </Items>
                </ext:Panel>
                <ext:Panel runat="server" Title="Month & Year" BodyPadding="18" >
                    <Items>
                        <ext:DateField runat="server" Type="Month" />
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Container>

        <ext:Container runat="server" Layout="hbox" MarginSpec="0 0 20 0">
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

        <ext:Container runat="server" Layout="hbox">
            <Items>
                <ext:Panel runat="server" Title="Date Picker" MarginSpec="0 20 0 0">
                    <Items>
                        <ext:DatePicker runat="server" ShowToday="false" />
                    </Items>
                </ext:Panel>
                <ext:Panel runat="server" Title="Month Picker">
                    <Items>
                        <ext:MonthPicker runat="server" ShowButtons="false" />
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Container>
    </Items>
    </form>
</body>
</html>
