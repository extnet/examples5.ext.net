<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Items - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .title {
            margin-top: 10px;
        }

        .title .x-form-display-field {
            font-size: 16px;
            color: #871414;
        }
    </style>

    <script>
        var add = function () {
            Ext.Msg.info({
                autoHide: false,
                ui: 'danger',
                renderTo:'host',
                floating: false,

                items: [
                    {
                        xtype: 'displayfield',
                        cls: 'title',
                        value: 'Danger Notification'
                    },
                    {
                        xtype: 'displayfield',
                        cls: 'message',
                        value: 'You can insert message here'
                    }
                ],

                buttons: [{
                    text: 'Close',
                    handler: function () {
                        this.up('infopanel').destroy();
                    }
                }]
            });
        };
    </script>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:Button runat="server" Text="Add Info into a div" Handler="add" />

    <br />

    <div id="host" style="border-radius:5px; border: 1px solid navy; width:300px; height:500px;">
        <ext:InfoPanel
            ID="InfoPanel1"
            runat="server"
            Title="Init Info"
            Html="Message"
            Pinned="true"
            ShowPin="true"
            />
    </div>
</body>
</html>