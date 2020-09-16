<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Isolated Child Sessions - Ext.Net Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script runat="server">
        [DirectMethod]
        public object GetOrders(string action, Dictionary<string, object> extraParams)
        {
            StoreRequestParameters prms = new StoreRequestParameters(extraParams);

            var data = JSON.Deserialize<Dictionary<string, object>[]>(System.IO.File.ReadAllText(Server.MapPath("orders.json")));

            if (prms.Filter.Length > 0)
            {
                var key = prms.Filter[0].Property;
                int cId;

                if (!Int32.TryParse(prms.Filter[0].Value, out cId))
                {
                    return new { data = (object)null };
                }

                var searchValue = cId;

                return new
                {
                    data = data.Where(item =>
                        {
                            var value = item[key];
                            if (value != null)
                            {
                                return Convert.ToInt32(value) == searchValue;
                            }

                            return false;
                        })
                };
            }

            return new { data };
        }

        public class MyModel
        {
            public static object Model = new
            {
                stores = new
                {
                    customers = new
                    {
                        model = "Customer",
                        autoLoad = true,
                        session = true
                    }
                }
            };
        }
    </script>

    <script>
        function onSessionChangeClick() {
            var changes = App.View1.getSession().getChanges();
            if (changes !== null) {
                new Ext.window.Window({
                    autoShow: true,
                    title: 'Session Changes',
                    modal: true,
                    width: 600,
                    height: 400,
                    layout: 'fit',
                    items: {
                        xtype: 'textarea',
                        value: JSON.stringify(changes, null, 4)
                    }
                });
            } else {
                Ext.Msg.alert('No Changes', 'There are no changes to the session.');
            }
        }

        function createDialog(record) {
            var view = App.View1;

            var dialog = view.add(App.getChildSessionForm({
                viewModel: {
                    data: {
                        title: record ? 'Edit: ' + record.get('name') : 'Add Customer'
                    },
                    // If we are passed a record, a copy of it will be created in the newly spawned session.
                    // Otherwise, create a new phantom customer in the child.
                    links: {
                        theCustomer: record || {
                            type: 'Customer',
                            create: true
                        }
                    }
                },

                // Creates a child session that will spawn from the current session
                // of this view.
                session: true
            }));

            dialog.isEdit = !!record;
            dialog.show();
        }

        function onRemoveCustomerClick(button) {
            var customerGrid = App.View1.lookupReference("customerGrid"),
                selection = customerGrid.getSelectionModel().getSelection()[0];

            selection.drop();
        }

        function onAddOrderClick() {
            var orders = App.View1.lookupReference("orders").getStore();
            orders.insert(0, {
                date: new Date(),
                shipped: false
            })
        }

        function onRemoveOrderClick(item, command, record) {
            var orders =  App.View1.lookupReference("orders").getStore();
            orders.remove(record);
        }

        function onSaveClick() {
            // Save the changes pending in the dialog's child session back to the
            // parent session.
            var dialog = this.up("window"),
                form = App.View1.lookupReference("form"),
                isEdit = dialog.isEdit,
                id;

            if (form.isValid()) {
                if (!isEdit) {
                    // Since we're not editing, we have a newly inserted record. Grab the id of
                    // that record that exists in the child session
                    id = dialog.getViewModel().get('theCustomer').id;
                }
                dialog.getSession().save();
                if (!isEdit) {
                    // Use the id of that child record to find the phantom in the parent session,
                    // we can then use it to insert the record into our store
                    App.View1.getViewModel().getStore('customers').add(App.View1.getSession().getRecord('Customer', id));
                }
                Ext.destroy(dialog);
            }
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Isolated Child Sessions</h1>

        <p>This form is a popup window used by the ChildSession view. This view is
           added as a contained window so we use the same ViewController instance.
        </p>

        <ext:Model runat="server" Name="Customer">
            <Fields>
                <ext:ModelField Name="name" />
                <ext:ModelField Name="phone" />
            </Fields>
            <Validators>
                <ext:PresenceValidator Field="name" />
                <ext:FormatValidator Field="phone" Matcher="^\d{3}-?\d{3}-?\d{4}$" Message="Must be in the format xxx-xxx-xxxx" />
            </Validators>
            <Proxy>
                <ext:AjaxProxy Url="customers.json" />
            </Proxy>
        </ext:Model>

        <ext:Model runat="server" Name="Order">
            <Fields>
                <ext:ModelField Name="date" Type="Date" DateFormat="yyyy-MM-dd" />
                <ext:ModelField Name="shipped" />
                <ext:ModelField Name="customerId">
                    <Reference Parent="Customer" />
                </ext:ModelField>
            </Fields>
            <Proxy>
                <ext:PageProxy DirectFn="App.direct.GetOrders" />
            </Proxy>
        </ext:Model>

        <ext:Window
            runat="server"
            LazyMode="Config"
            Layout="Fit"
            Modal="true"
            Width="500"
            Height="430"
            Closable="true"
            CloseAction="Destroy"
            TemplateWidget="true"
            TemplateWidgetFnName="getChildSessionForm">
            <Bind>
                <ext:Parameter Name="title" Value="{title}" />
            </Bind>

            <Items>
                <ext:FormPanel
                    runat="server"
                    Reference="form"
                    BodyPadding="18"
                    Border="false"
                    ModelValidation="true">
                    <LayoutConfig>
                        <ext:VBoxLayoutConfig Align="Stretch" />
                    </LayoutConfig>
                    <Items>
                        <ext:TextField
                            runat="server"
                            FieldLabel="Name"
                            Reference="name"
                            MsgTarget="Side"
                            BindString="{theCustomer.name}"
                            />

                        <ext:TextField
                            runat="server"
                            FieldLabel="Phone"
                            Reference="phone"
                            MsgTarget="Side"
                            BindString="{theCustomer.phone}"
                            />

                        <ext:GridPanel
                            runat="server"
                            Flex="1"
                            Reference="orders"
                            MarginSpec="10 0 0 0"
                            Title="Orders"
                            BindString="{theCustomer.orders}">
                            <TopBar>
                                <ext:Toolbar runat="server">
                                    <Items>
                                        <ext:Button runat="server" Text="Add Order" Handler="onAddOrderClick" />
                                    </Items>
                                </ext:Toolbar>
                            </TopBar>
                            <ColumnModel>
                                <Columns>
                                    <ext:Column runat="server" Text="Id" DataIndex="id">
                                        <Renderer Handler=" if (String(value).indexOf('O') > -1) {value = value.replace('Order-', 'O');} return value;" />
                                    </ext:Column>

                                    <ext:DateColumn
                                        runat="server"
                                        Text="Date"
                                        DataIndex="date"
                                        Format="yyyy-MM-dd"
                                        Flex="1"
                                        />

                                    <ext:CheckColumn runat="server" Text="Shipped" DataIndex="shipped" />

                                     <ext:CommandColumn runat="server">
                                       <Commands>
                                           <ext:GridCommand CommandName="remove" Text="Remove" Disabled="true" />
                                       </Commands>
                                       <Listeners>
                                           <Command Fn="onRemoveOrderClick" />
                                       </Listeners>
                                   </ext:CommandColumn>
                                </Columns>
                            </ColumnModel>
                        </ext:GridPanel>
                    </Items>
                </ext:FormPanel>
            </Items>
            <Buttons>
                <ext:Button runat="server" Text="Save" Handler="onSaveClick" />
                <ext:Button runat="server" Text="Cancel" Handler="Ext.destroy(this.up('window'))" />
            </Buttons>
        </ext:Window>

        <ext:Panel ID="View1" runat="server"
            Title="All Customers"
            ReferenceHolder="true"
            Frame="true"
            Width="420"
            Height="320"
            Session="true"
            ViewModel="<%# MyModel.Model %>"
            AutoDataBind="true">
            <LayoutConfig>
                <ext:VBoxLayoutConfig Align="Stretch" />
            </LayoutConfig>
           <Items>
               <ext:GridPanel
                   runat="server"
                   BindString="{customers}"
                   Reference="customerGrid"
                   Flex="1">
                   <ColumnModel>
                       <Columns>
                           <ext:Column
                               runat="server"
                               Text="Name"
                               DataIndex="name"
                               Flex="1"
                               />
                           <ext:Column
                               runat="server"
                               Text="Phone"
                               DataIndex="phone"
                               Width="115"
                               />

                           <ext:CommandColumn runat="server" Width="50">
                                <Commands>
                                    <ext:GridCommand CommandName="edit" Text="Edit" />
                                </Commands>
                                <Listeners>
                                    <Command Handler="createDialog(record);" />
                                </Listeners>
                            </ext:CommandColumn>
                       </Columns>
                   </ColumnModel>
               </ext:GridPanel>
           </Items>

            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" Text="Add Customer" Handler="createDialog(null);" />
                        <ext:Button runat="server" Text="Remove Customer" Handler="onRemoveCustomerClick">
                            <Bind>
                                <ext:Parameter Name="disabled" Value="{!customerGrid.selection}" />
                            </Bind>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>

            <Buttons>
                <ext:Button runat="server" Text="Show Changes" Handler="onSessionChangeClick" />
            </Buttons>
        </ext:Panel>
    </form>
</body>
</html>