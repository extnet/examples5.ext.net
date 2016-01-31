<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>ClickRepeater - Ext.NET Examples</title>    
    <link href="/resources/css/examples.css" rel="stylesheet" />
    
    <style>
        .pressedTd {
            background-color : Silver;
        }    
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>ClickRepeater</h1>
        
        <h2>Simple Spinner</h2>
        
        <p>"Click" or "Click and Hold"</p>
        
        <table border="1">
            <tr>
                <td id="minusTd" style="width:50px;height:50px;text-align:center;cursor:pointer;">
                    <ext:Label runat="server" Icon="Delete" />
                </td>
                <td style="width:100px;text-align:center;">
                    <ext:Label ID="ValueLabel" runat="server" Text="0" />
                </td>
                <td id="plusTd" style="width:50px;height:50px;text-align:center;cursor:pointer;">
                    <ext:Label runat="server" Icon="Add" />
                </td>
            </tr>
        </table>
        
        <ext:ClickRepeater runat="server" Target="minusTd" PressClass="pressedTd">     
            <Listeners>
                <Click Handler="#{ValueLabel}.setText((parseInt(#{ValueLabel}.getText(), 10) - 1).toString());" />
            </Listeners>
        </ext:ClickRepeater>
        
        <ext:ClickRepeater runat="server" Target="plusTd" PressClass="pressedTd">     
            <Listeners>
                <Click Handler="#{ValueLabel}.setText((parseInt(#{ValueLabel}.getText(), 10) + 1).toString());" />
            </Listeners>
        </ext:ClickRepeater>
        
        <br />
        
        <h2>LeftClick and RightClick Listeners</h2>
        
        <div id="clickDiv" style="border: solid 1px black; cursor:pointer;text-align:center;width:210px;">
            <ext:Label ID="ValueLabel1" runat="server" Text="0" />
            <br />
            <p>Right Click : Increase Value</p>
            <p>Left Click  : Decrease Value</p>            
        </div>
        
        <ext:ClickRepeater 
            runat="server" 
            Target="clickDiv" 
            PreventDefault="true"
            StopDefault="true">
            <Listeners>
                <LeftClick Handler="#{ValueLabel1}.setText((parseInt(#{ValueLabel1}.getText(), 10) - 1).toString());" />
                <RightClick Handler="#{ValueLabel1}.setText((parseInt(#{ValueLabel1}.getText(), 10) + 1).toString());" />
            </Listeners>
        </ext:ClickRepeater>
    </form>    
</body>
</html>