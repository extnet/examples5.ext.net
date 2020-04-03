<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title> - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <link href="Book.css" rel="stylesheet" />

    <script>
        var stars = function (values) {
            var res = [],
                extension = Ext.isIE6 ? 'gif' : 'png',
                i = 0;

            //print out the stars for each of the ratings
            for (; i < values.rating; i++) {
                res.push('<img src="images/star.', extension, '" />');
            }

            //print out transparent stars for the rest (up to 5)
            while (i < 5) {
                res.push('<img src="images/star_no.', extension, '" />');
                i++;
            }

            return res.join('');
        };
    </script>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:Model runat="server" Name="Books.Review">
        <Fields>
            <ext:ModelField Name="author" />
            <ext:ModelField Name="rating" />
            <ext:ModelField Name="date" />
            <ext:ModelField Name="title" />
            <ext:ModelField Name="comment" />
        </Fields>
    </ext:Model>

    <ext:Model runat="server" Name="Books.Book">
        <Fields>
            <ext:ModelField Name="id" />
            <ext:ModelField Name="name" />
            <ext:ModelField Name="author" />
            <ext:ModelField Name="detail" />
            <ext:ModelField Name="price" />
            <ext:ModelField Name="image" />
        </Fields>
        <Associations>
            <ext:HasManyAssociation Model="Books.Review" Name="reviews" ForeignKey="book_id" />
        </Associations>
    </ext:Model>

    <ext:Viewport runat="server" Layout="Fit">
        <Items>
            <ext:Panel runat="server" Border="false">
                <LayoutConfig>
                    <ext:VBoxLayoutConfig Align="Stretch" />
                </LayoutConfig>

                <DockedItems>
                    <ext:Component
                        runat="server"
                        Dock="Top"
                        BaseCls="app-header"
                        Html="Loading Nested Data Example"
                        />

                    <ext:DataView
                        runat="server"
                        Dock="Left"
                        Width="180"
                        Border="false"
                        Cls="sidebar-list"
                        ItemSelector=".product">
                        <Tpl>
                            <Html>
                                <div class="sidebar-title">Books</div>
                                <tpl for=".">
                                    <div class="product">{name}</div>
                                </tpl>
                            </html>
                        </Tpl>
                        <Store>
                            <ext:Store ID="BooksStore" runat="server" ModelName="Books.Book">
                                <Proxy>
                                    <ext:AjaxProxy runat="server" Url="Products.json" />
                                </Proxy>
                                <Listeners>
                                    <Load BroadcastOnBus="App.BooksLoad" />
                                </Listeners>
                            </ext:Store>
                        </Store>
                        <Listeners>
                            <SelectionChange BroadcastOnBus="App.SelectionChange" />
                        </Listeners>
                        <MessageBusListeners>
                            <ext:MessageBusListener
                                Name="App.BooksLoad"
                                Handler="data.records.length && this.getSelectionModel().select(data.records[0]);"
                                Delay="500"
                                />
                        </MessageBusListeners>
                    </ext:DataView>
                </DockedItems>

                <Items>
                    <ext:Panel
                        runat="server"
                        Cls="item-ct"
                        Flex="2"
                        Border="false"
                        Scrollable="Both">
                        <LayoutConfig>
                            <ext:HBoxLayoutConfig Align="Middle" Pack="Center" />
                        </LayoutConfig>
                        <Items>
                            <ext:Image
                                runat="server"
                                MarginSpec="0 20 0 0"
                                Width="250"
                                Height="308"
                                ImageUrl="={Ext.BLANK_IMAGE_URL}">
                                <LoadMask ShowMask="true" />
                                <MessageBusListeners>
                                    <ext:MessageBusListener
                                        Name="App.SelectionChange"
                                        Handler="data.selected && this.setImageUrl(data.selected[0].get('image'))"
                                        />
                                </MessageBusListeners>
                            </ext:Image>
                            <ext:Component runat="server" Width="500" Border="false">
                                <Tpl runat="server">
                                    <Html>
                                        <div class="name">{name} <span>${price}</span></div>
                                        <div class="author">By {author}</div>
                                        <div class="detail">{detail}</div>
                                    </html>                                </Tpl>
                                <MessageBusListeners>
                                    <ext:MessageBusListener
                                        Name="App.SelectionChange"
                                        Handler="data.selected.length && this.update(data.selected[0].getData())"
                                        />
                                </MessageBusListeners>
                            </ext:Component>
                        </Items>
                    </ext:Panel>

                    <ext:Panel
                        runat="server"
                        Border="false"
                        Flex="1"
                        Layout="Card">
                        <DockedItems>
                            <ext:Component
                                runat="server"
                                Dock="Top"
                                BaseCls="app-header"
                                Html="Reviews"
                                />
                        </DockedItems>

                        <Items>
                            <ext:DataView
                                runat="server"
                                Border="false"
                                Cls="review-list"
                                Scrollable="Both"
                                ItemSelector=".review">
                                <Tpl>
                                    <Html>
                                        <tpl for=".">
                                            <div class="review {[xindex === 1 ? "first-review" : ""]}">
                                                <div class="title">{title} {[this.stars(values)]}</div>
                                                <div class="author">By <span>{author}</span> - {date}</div>
                                                <div class="comment">{comment}</div>
                                            </div>
                                        </tpl>
                                    </html>                                    <Functions>
                                        <ext:JFunction Name="stars" Fn="stars" />
                                    </Functions>
                                </Tpl>
                                <Store>
                                    <ext:Store ID="ReviewsStore" runat="server" ModelName="Books.Review" />
                                </Store>
                                <MessageBusListeners>
                                    <ext:MessageBusListener
                                        Name="App.SelectionChange"
                                        Handler="data.selected.length && this.bindStore(data.selected[0].reviews())"
                                        />
                                </MessageBusListeners>
                            </ext:DataView>
                        </Items>
                    </ext:Panel>
                </Items>
            </ext:Panel>
        </Items>
    </ext:Viewport>
</body>
</html>