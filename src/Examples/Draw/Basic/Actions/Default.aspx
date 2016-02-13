<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Draw Actions - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script runat="server">
        protected void CreateSprite(object sender, DirectEventArgs e)
        {
            RectSprite sprite = new RectSprite
            {
                SpriteID = "Sprite1",
                Width = 100,
                Height = 100,
                X = 150,
                Y = 150,
                FillStyle = "green"
            };

            Draw1.Add(sprite);
            Draw1.RenderFrame();
            this.EnableButton(sender);
        }

        protected void ChangeColor(object sender, DirectEventArgs e)
        {
            Draw1.GetSprite("Sprite1").SetAttributes(new Sprite { FillStyle = "red" });
            Draw1.RenderFrame();
            this.EnableButton(sender);
        }

        protected void RotateLeft(object sender, DirectEventArgs e)
        {
            Draw1.GetSprite("Sprite1").SetAttributes(new Sprite { RotationDegrees = -45 });
            Draw1.RenderFrame();
            this.EnableButton(sender);
        }

        protected void RotateRight(object sender, DirectEventArgs e)
        {
            Draw1.GetSprite("Sprite1").SetAttributes(new Sprite { RotationDegrees = 0, Duration = 1000, Easing = Easing.ElasticIn });
            Draw1.RenderFrame();
            this.EnableButton(sender);
        }

        protected void Scaling(object sender, DirectEventArgs e)
        {
            Draw1.GetSprite("Sprite1").SetAttributes(new Sprite { ScalingX = 2, ScalingY = 2, Duration = 0 });
            Draw1.RenderFrame();
            this.EnableButton(sender);
        }

        protected void Translation(object sender, DirectEventArgs e)
        {
            Draw1.GetSprite("Sprite1").SetAttributes(new Sprite { TranslationX = -100, TranslationY = -100 });
            Draw1.RenderFrame();
            this.EnableButton(sender);
        }

        private void EnableButton(object sender)
        {
            Ext.Net.Button button = (Ext.Net.Button)sender;
            ItemsCollection<AbstractComponent> items = ((AbstractContainer)button.Parent).Items;
            int index = items.IndexOf(button) + 1;
            button.Disabled = true;

            if (index < items.Count)
            {
                items[index].Disabled = false;
            }
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        <h1>Draw Actions</h1>

        <ext:Window runat="server" Title="Draw Actions" Width="640" Height="480" Layout="BorderLayout">
            <Items>
                <ext:Panel runat="server" Frame="true" Width="200" Region="West" Layout="VBoxLayout" Margin="5">
                    <LayoutConfig>
                        <ext:VBoxLayoutConfig Align="Stretch" Pack="Center" />
                    </LayoutConfig>
                    <Defaults>
                        <ext:Parameter Name="margin" Value="5" Mode="Raw" />
                    </Defaults>
                    <Items>
                        <ext:Button runat="server" Text="Create Sprite" OnDirectClick="CreateSprite" />
                        <ext:Button runat="server" Text="Change Color" OnDirectClick="ChangeColor" Disabled="true" />
                        <ext:Button runat="server" Text="Rotate -45" OnDirectClick="RotateLeft" Disabled="true" />
                        <ext:Button runat="server" Text="Rotate back (animaton)" OnDirectClick="RotateRight" Disabled="true" />
                        <ext:Button runat="server" Text="Scaling" OnDirectClick="Scaling" Disabled="true" />
                        <ext:Button runat="server" Text="Translation" OnDirectClick="Translation" Disabled="true" />
                    </Items>
                </ext:Panel>
                <ext:DrawContainer ID="Draw1" runat="server" Region="Center" />
            </Items>
        </ext:Window>
    </form>
</body>
</html>