<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Store1.Data = this.Users;
    }

    public List<User> Users
    {
        get
        {
            return new List<User>
            {
                new User(1, "User1", new List<Product>
                {
                    new Product(1, "Product1 of User1"),
                    new Product(2, "Product2 of User1"),
                    new Product(3, "Product3 of User1")
                }),

                new User(2, "User2", new List<Product>
                {
                    new Product(4, "Product1 of User2"),
                    new Product(5, "Product2 of User2"),
                    new Product(6, "Product3 of User2")
                }),

                new User(3, "User3", new List<Product>
                {
                    new Product(7, "Product1 of User3"),
                    new Product(8, "Product2 of User3"),
                    new Product(9, "Product3 of User3")
                })
            };
        }
    }

    public class Product
    {
        public Product(int id, string name)
        {
            this.Id = id;
            this.Name = name;
        }

        public int Id
        {
            get;
            private set;
        }

        public string Name
        {
            get;
            private set;
        }
    }

    public class User
    {
        public User(int id, string name, List<Product> products)
        {
            this.Id = id;
            this.Name = name;
            this.Products = products;
        }

        public int Id
        {
            get;
            private set;
        }

        public string Name
        {
            get;
            private set;
        }

        public List<Product> Products
        {
            get;
            private set;
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Callout Delegation - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        h3.x-callout-header {
            /* to deactivate h3 rule from resources/css/examples.css */
            font-family: inherit;
        }

        .list ul {
            list-style: none outside none;
            padding: 0;
            padding-right: 3px;
            margin: 0;
        }

        .list li {
            white-space: nowrap;
            width: 100%;
            display: block;
            height: 44px;
            padding: 7px 15px 7px 10px;
            background: #D7EECE;
            border-radius: 5px;
            margin: 2px;
        }

            .list li div {
                color: green;
                font-size: 14px;
                line-height: 16px;
            }

                .list li div.pId {
                    font-weight: bold;
                }
    </style>

    <script type="text/javascript">
        Ext.net.Callout.override({
            onTargetClick: function (e) {
                // Do not show a Callout if it is clicked on a node's expander
                if (e.getTarget(".x-tree-expander")) {
                    return;
                }

                this.callParent(arguments);
            }
        });

        var setCalloutContent = function (callout) {
            var grid = callout.calloutOwner,
                record = grid.view.getRecord(callout.triggerElement.dom.parentNode);

            callout.bodyWidget.store.loadData(record.data.Products);
        };

        var setTreeCalloutContent = function (callout) {
            var tree = callout.calloutOwner,
                record = tree.view.getRecord(callout.triggerElement);

            callout.setTitle(record.data.task);
            callout.setHtml([
                "<b>User:</b> " + record.data.user,
                "<b>Duration:</b> " + formatHours(record.data.duration),
                "<b>Complete:</b> " + record.data.done
            ].join("<br/>"));
        };

        var setFieldErrors = function (callout) {
            var field = Ext.getCmp(callout.triggerElement.id),
                valid = field.isValid();

            if (!valid) {
                callout.setHtml(field.getActiveError());
            }

            return !valid;
        };

        var formatHours = function (v) {
            if (v < 1) {
                return Math.round(v * 60) + " mins";
            } else if (Math.floor(v) !== v) {
                var min = v - Math.floor(v);
                return Math.floor(v) + "h " + Math.round(min * 60) + "m";
            } else {
                return v + " hour" + (v === 1 ? "" : "s");
            }
        };
    </script>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>Callout Delegation</h1>

    <ext:GridPanel
        runat="server"
        Title="Users"
        Width="550">
        <ColumnModel>
            <Columns>
                <ext:Column runat="server" Text="Name" DataIndex="Name" Flex="1" />
                <ext:Column
                    runat="server"
                    ItemID="Products"
                    Text="Products"
                    DataIndex="Products"
                    Width="150">
                    <Renderer Handler="return '[Hover to see details]';" />
                </ext:Column>
            </Columns>
        </ColumnModel>
        <Store>
            <ext:Store ID="Store1" runat="server">
                <Model>
                    <ext:Model runat="server" Name="User" IDProperty="Id">
                        <Fields>
                            <ext:ModelField Name="Id" Type="Int" />
                            <ext:ModelField Name="Name" Type="String" />
                            <ext:ModelField Name="Products" Type="Object" />
                        </Fields>
                    </ext:Model>
                </Model>
            </ext:Store>
        </Store>
        <Callouts>
            <ext:Callout
                runat="server"
                Trigger="Hover"
                Alignment="Left"
                Delegate=".x-grid-cell-Products"
                BodyStyle="padding:0px;">
                <BodyWidget>
                    <ext:DataView runat="server" Width="250" Cls="list" ItemSelector="li">
                        <Store>
                            <ext:Store runat="server">
                                <Fields>
                                    <ext:ModelField Name="Id" />
                                    <ext:ModelField Name="Name" />
                                </Fields>
                            </ext:Store>
                        </Store>
                        <Tpl runat="server">
                            <Html>
                                <ul>
                                    <tpl for=".">
                                        <li>
                                            <div class="pId">#{Id}</div>
                                            <div class="pName">{Name}</div>
                                        </li>
                                    </tpl>
                                </ul>
                            </Html>
                        </Tpl>
                    </ext:DataView>
                </BodyWidget>
                <Listeners>
                    <BeforeShow Fn="setCalloutContent" />
                </Listeners>
            </ext:Callout>
        </Callouts>
    </ext:GridPanel>

    <br />
    <br />

    <ext:TreePanel
        runat="server"
        Title="Core Team Projects (click on a node to see the details)"
        Width="500"
        Height="480"
        Collapsible="true"
        UseArrows="true"
        RootVisible="false"
        FolderSort="true">
        <Fields>
            <ext:ModelField Name="task" />
            <ext:ModelField Name="user" />
            <ext:ModelField Name="duration" />
            <ext:ModelField Name="done" Type="Boolean" />
        </Fields>
        <ColumnModel>
            <Columns>
                <ext:TreeColumn
                    runat="server"
                    Text="Task"
                    Flex="1"
                    Sortable="true"
                    DataIndex="task"
                    />
            </Columns>
        </ColumnModel>

        <Root>
            <ext:Node Text="Tasks">
                <Children>
                    <ext:Node IconCls="x-md md-icon-folder">
                        <CustomAttributes>
                            <ext:ConfigItem Name="task" Value="Project: Testing" Mode="Value" />
                            <ext:ConfigItem Name="duration" Value="2" />
                            <ext:ConfigItem Name="user" Value="Core Team" Mode="Value" />
                        </CustomAttributes>
                        <Children>
                            <ext:Node IconCls="x-md md-icon-folder">
                                <CustomAttributes>
                                    <ext:ConfigItem Name="task" Value="Mac OSX" Mode="Value" />
                                    <ext:ConfigItem Name="duration" Value="0.75" />
                                    <ext:ConfigItem Name="user" Value="Clark Lewis" Mode="Value" />
                                </CustomAttributes>
                                <Children>
                                    <ext:Node Leaf="true">
                                        <CustomAttributes>
                                            <ext:ConfigItem Name="task" Value="FireFox" Mode="Value" />
                                            <ext:ConfigItem Name="duration" Value="0.25" />
                                            <ext:ConfigItem Name="user" Value="Clark Lewis" Mode="Value" />
                                        </CustomAttributes>
                                    </ext:Node>
                                    <ext:Node Leaf="true">
                                        <CustomAttributes>
                                            <ext:ConfigItem Name="task" Value="Safari" Mode="Value" />
                                            <ext:ConfigItem Name="duration" Value="0.25" />
                                            <ext:ConfigItem Name="user" Value="Clark Lewis" Mode="Value" />
                                        </CustomAttributes>
                                    </ext:Node>
                                    <ext:Node Leaf="true">
                                        <CustomAttributes>
                                            <ext:ConfigItem Name="task" Value="Chrome" Mode="Value" />
                                            <ext:ConfigItem Name="duration" Value="0.25" />
                                            <ext:ConfigItem Name="user" Value="Clark Lewis" Mode="Value" />
                                        </CustomAttributes>
                                    </ext:Node>
                                </Children>
                            </ext:Node>
                            <ext:Node IconCls="x-md md-icon-folder">
                                <CustomAttributes>
                                    <ext:ConfigItem Name="task" Value="Windows" Mode="Value" />
                                    <ext:ConfigItem Name="duration" Value="3.75" />
                                    <ext:ConfigItem Name="user" Value="Darrell Meyer" Mode="Value" />
                                </CustomAttributes>
                                <Children>
                                    <ext:Node Leaf="true">
                                        <CustomAttributes>
                                            <ext:ConfigItem Name="task" Value="FireFox" Mode="Value" />
                                            <ext:ConfigItem Name="duration" Value="0.25" />
                                            <ext:ConfigItem Name="user" Value="Darrell Meyer" Mode="Value" />
                                        </CustomAttributes>
                                    </ext:Node>
                                    <ext:Node Leaf="true">
                                        <CustomAttributes>
                                            <ext:ConfigItem Name="task" Value="Safari" Mode="Value" />
                                            <ext:ConfigItem Name="duration" Value="0.25" />
                                            <ext:ConfigItem Name="user" Value="Darrell Meyer" Mode="Value" />
                                        </CustomAttributes>
                                    </ext:Node>
                                    <ext:Node Leaf="true">
                                        <CustomAttributes>
                                            <ext:ConfigItem Name="task" Value="Chrome" Mode="Value" />
                                            <ext:ConfigItem Name="duration" Value="0.25" />
                                            <ext:ConfigItem Name="user" Value="Darrell Meyer" Mode="Value" />
                                        </CustomAttributes>
                                    </ext:Node>
                                    <ext:Node Leaf="true">
                                        <CustomAttributes>
                                            <ext:ConfigItem Name="task" Value="Internet Explorer" Mode="Value" />
                                            <ext:ConfigItem Name="duration" Value="3" />
                                            <ext:ConfigItem Name="user" Value="Darrell Meyer" Mode="Value" />
                                        </CustomAttributes>
                                    </ext:Node>
                                </Children>
                            </ext:Node>
                            <ext:Node IconCls="x-md md-icon-folder">
                                <CustomAttributes>
                                    <ext:ConfigItem Name="task" Value="Linux" Mode="Value" />
                                    <ext:ConfigItem Name="duration" Value="0.5" />
                                    <ext:ConfigItem Name="user" Value="Steve Scott" Mode="Value" />
                                </CustomAttributes>
                                <Children>
                                    <ext:Node Leaf="true">
                                        <CustomAttributes>
                                            <ext:ConfigItem Name="task" Value="FireFox" Mode="Value" />
                                            <ext:ConfigItem Name="duration" Value="0.25" />
                                            <ext:ConfigItem Name="user" Value="Steve Scott" Mode="Value" />
                                        </CustomAttributes>
                                    </ext:Node>
                                    <ext:Node Leaf="true">
                                        <CustomAttributes>
                                            <ext:ConfigItem Name="task" Value="Chrome" Mode="Value" />
                                            <ext:ConfigItem Name="duration" Value="0.25" />
                                            <ext:ConfigItem Name="user" Value="Steve Scott" Mode="Value" />
                                        </CustomAttributes>
                                    </ext:Node>
                                </Children>
                            </ext:Node>
                        </Children>
                    </ext:Node>
                </Children>
            </ext:Node>
        </Root>

        <Callouts>
            <ext:Callout runat="server" Delegate=".x-grid-row" CloseOnOutsideClick="true">
                <Listeners>
                    <BeforeShow Fn="setTreeCalloutContent" />
                </Listeners>
            </ext:Callout>
        </Callouts>

        <Listeners>
            <ItemExpand Handler="this.callouts[0].hide();" Buffer="1" />
            <ItemCollapse Handler="this.callouts[0].hide();" Buffer="1" />
        </Listeners>
    </ext:TreePanel>

    <br />
    <br />

    <ext:FormPanel
        runat="server"
        Title="Form panel (click a field to see validation result)"
        BodyPadding="18"
        Width="500">
        <Defaults>
            <ext:Parameter Name="MsgTarget" Value="none" />
        </Defaults>

        <Items>
            <ext:TextField
                runat="server"
                FieldLabel="Username"
                AllowBlank="false"
                MinLength="6">
            </ext:TextField>

            <ext:TextField
                ID="PasswordField"
                runat="server"
                FieldLabel="Password"
                InputType="Password"
                AllowBlank="false">
                <Listeners>
                    <ValidityChange Handler="this.next().validate();" />
                    <Blur Handler="this.next().validate();" />
                </Listeners>
            </ext:TextField>

            <ext:TextField
                runat="server"
                Vtype="password"
                FieldLabel="Confirm Password"
                AllowBlank="false"
                InputType="Password">
                <CustomConfig>
                    <ext:ConfigItem Name="initialPassField" Value="PasswordField" Mode="Value" />
                </CustomConfig>
            </ext:TextField>

            <ext:DateField
                ID="DateField1"
                runat="server"
                FieldLabel="From"
                Editable="false">
            </ext:DateField>

            <ext:DateField
                ID="DateField2"
                runat="server"
                FieldLabel="To"
                Editable="false">
                <Validator Handler="var date1 = this.prev().getValue(), date2 = this.getValue(); return !date1 || date1 && date2 && date1.getTime() <= date2.getTime();" />
            </ext:DateField>
        </Items>
        <Listeners>
            <FieldErrorChange Handler="if (field.hasFocus && (!this._e || this._e.field != field || this._e.error != error)) {this._e = {field: field, error: error}; var c = this.callouts[0]; c.triggerElement = field.el; error ? (c.hidden ? c.show() : c.setHtml(field.getActiveError())) : c.hide();}" />
        </Listeners>
        <Callouts>
            <ext:Callout runat="server" Delegate=".x-field" Trigger="Click" Title="Errors" IconCls="x-md md-icon-cancel">
                <Listeners>
                    <BeforeShow Fn="setFieldErrors" />
                </Listeners>
            </ext:Callout>
        </Callouts>
    </ext:FormPanel>
</body>
</html>
