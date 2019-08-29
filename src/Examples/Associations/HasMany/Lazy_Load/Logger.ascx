<%@ Control Language="C#" %>

<ext:Panel runat="server"
    Title="Loader log"
    TplWriteMode="Append"
    BodyPadding="5"
    Scrollable="Both"
    Flex="1">
    <Tpl runat="server">
        <Html>
            <div class="{cls}">[{now:date("H:i:s")}] - {msg}</div>
        </Html>
    </Tpl>
    <MessageBusListeners>
        <ext:MessageBusListener Name="App.Log" Fn="addLogMessage" />
    </MessageBusListeners>
    <HtmlBin>
        <style>
            .beforeload {
                color: blue;
            }

            .afterload {
                color: green;
            }
        </style>

        <script>
            var addLogMessage = function (name, data) {
                this.update({
                    now: new Date(),
                    cls: data.isStart ? 'beforeload' : 'afterload',
                    msg: data.msg
                });
                this.body.scroll('b', 100000, true);
            };
        </script>
    </HtmlBin>
</ext:Panel>
