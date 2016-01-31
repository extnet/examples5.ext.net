<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Pickers overview - Ext.NET Examples</title>    
    <link href="/resources/css/examples.css" rel="stylesheet" />        
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Pickers overview</h1>

        <h3>Date picker</h3>
        <ext:DatePicker runat="server" SelectedDate="01.04.2010" />

        <h3>Color picker</h3>
        <ext:ColorPicker runat="server" Value="008000" />        

        <h3>Month picker</h3>
        <ext:MonthPicker runat="server" SelectedMonth="1" SelectedYear="2010" />        

        <h3>Time picker</h3>
        <ext:TimePicker runat="server" Height="200" Width="200" SelectedTime="0:15" />                
    </form>
</body>
</html>
