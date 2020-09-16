<%@ Page Language="C#" %>

<%@ Import Namespace="System.Threading" %>
<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    protected void UpdateTimeStamp(object sender, DirectEventArgs e)
    {
        X.Msg.Notify("The Server Time is: ", DateTime.Now.ToLongTimeString()).Show();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>DirectEvents Summary - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .box, .box-wihtout-event {
            width  : 100px;
            height : 50px;
            border : 1px solid #000;
            cursor : pointer;
            text-align       : center;
            margin-bottom    : 4px;
            background-color : white;
        }

        .red  {
            color  : #fff;
            cursor : default;
            background-color : red;
        }

        .blue  {
            color : #fff;
            background-color : blue;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server">
            <CustomDirectEvents>
                <ext:DirectEvent Target="Button2" OnEvent="UpdateTimeStamp" />
                <ext:DirectEvent Target="Button3" OnEvent="UpdateTimeStamp" />
                <ext:DirectEvent Target="Span1" OnEvent="UpdateTimeStamp" />
                <ext:DirectEvent Target="Ext.select('div.box', true)" OnEvent="UpdateTimeStamp" />
            </CustomDirectEvents>
        </ext:ResourceManager>

        <h1>Summary of DirectEvents</h1>

        <p>The action of each of the following samples will trigger a DirectEvent Ajax request to the server and return a Notification Window to the browser.</p>

        <h2>Add a &lt;Click> DirectEvent to &lt;ext:Button></h2>

        <ext:Button
            ID="Button1"
            runat="server"
            Text="Click Me"
            OnDirectClick="UpdateTimeStamp"
            />

        <h2>Add a &lt;Click> DirectEvent with confirmation to &lt;ext:Button></h2>

        <ext:Button ID="Button4" runat="server" Text="Click Me">
            <DirectEvents>
                <Click OnEvent="UpdateTimeStamp">
                    <Confirmation ConfirmRequest="true" Title="Title" Message="Sample Confirmation Message..." />
                </Click>
            </DirectEvents>
        </ext:Button>

        <h2>Add a Click DirectEvent to &lt;asp:Button></h2>

        <asp:Button ID="Button2" runat="server" Text="Click Me" />

        <h2>Add a Click DirectEvent to a standard html &lt;input> button</h2>

        <input id="Button3" type="button" value="Click Me" />

        <h2>Add a Click DirectEvent to html &lt;span> element</h2>

        <span id="Span1" style="cursor: pointer;">*Click Me*</span>

        <h2>Add a Click DirectEvent to several html &lt;div> elements by using a Target Query</h2>

        <p>By using a Target Query we can attach the same DirectEvent (or Listener) to several html elements or Controls and fire a server-side event.</p>
        <p>The target(s) do not require an "id" and do not need a runat="server" attribute. The elements can be any html element available on the Page.</p>
        <p>The following Target Query will select all &lt;div> elements on the Page that contain the css class "box", but do not contain the css class "red".</p>

        <div class="box">Click Me</div>
        <div class="box-wihtout-event red">Not Me</div>
        <div class="box blue">Click Me too!</div>
    </form>
</body>
</html>