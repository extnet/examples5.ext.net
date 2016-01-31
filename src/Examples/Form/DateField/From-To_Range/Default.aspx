<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Multiple DateFields with DateRange Validation - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Multiple DateFields with DateRange Validation</h1>

        <p>This example demonstrates two date fields acting as a date range. Selecting an initial date sets the minimum value for the end field. Selecting an ending date sets a maximum value for the start field.</p>

        <p>If a value is specified / selected in the 'DateField1 field', the 'DateField2 field' doesn't allow any date prior to the 'DateField1' entry to be specified / selected and vice versa.</p>

        <ext:Window
            runat="server"
            Width="350"
            Title="DateRange"
            Icon="Date"
            Closable="false"
            BodyPadding="5"
            Layout="Anchor"
            DefaultAnchor="100%">
            <Items>
                <ext:DateField
                    ID="DateField1"
                    runat="server"
                    Vtype="daterange"
                    FieldLabel="From">
                    <CustomConfig>
                        <ext:ConfigItem Name="endDateField" Value="DateField2" Mode="Value" />
                    </CustomConfig>
                </ext:DateField>

                <%--// Alternative syntax using custom config property attributes. --%>

                <%--<ext:DateField 
                    ID="DateField1" 
                    runat="server" 
                    FieldLabel="From"
                    Vtype="daterange"
                    EndDateField="DateField2" />--%>

                <ext:DateField
                    ID="DateField2"
                    runat="server"
                    Vtype="daterange"
                    FieldLabel="To">
                    <CustomConfig>
                        <ext:ConfigItem Name="startDateField" Value="DateField1" Mode="Value" />
                    </CustomConfig>
                </ext:DateField>

                <%--// Alternative syntax using custom config property attributes. --%>

                <%--<ext:DateField 
                    ID="DateField2" 
                    runat="server" 
                    Vtype="daterange"
                    FieldLabel="To"
                    StartDateField="DateField1" />--%>
            </Items>
        </ext:Window>
    </form>
</body>
</html>
