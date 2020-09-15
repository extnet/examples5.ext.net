<%@ Page Language="C#" %>

<script runat="server">
    public class MyModel
    {
        /// <summary>
        /// Ensures the ToConfig() string does not have line breaks, which would break the code.
        /// </summary>
        /// <returns>The single-line store representation object.</returns>
        private static string makeInline(Store val)
        {
            return val.ToConfig().Replace("\r\n", "");
        }

        public static object Model = new
        {
            //A declaration of Ext.data.Store configurations that are first processed as binds to produce an effective store configuration.
            stores = new
            {
                everyone = JRawValue.From(makeInline(new Store
                {
                    Model =
                    {
                        new Model
                        {
                            Name = "Person",
                            Fields =
                            {
                                new ModelField("firstName"),
                                new ModelField("lastName"),
                                new ModelField("age"),
                                new ModelField("favoriteColor")
                            }
                        }
                    },

                    Data = GenerateData(15, 10)
                })),

                adults = JRawValue.From(makeInline(new Store
                {
                    Source = "{everyone}",
                    Filters =
                    {
                        new DataFilter
                        {
                            Property = "age",
                            RawValue = 18,
                            Op = ">="
                        }
                    },
                    Sorters =
                    {
                        new DataSorter
                        {
                            Property = "age",
                            Direction = Ext.Net.SortDirection.ASC
                        }
                    }
                }))
            }
        };

        private static string GetRandom(Random r, string[] array)
        {
            var index = r.Next(0, array.Length);
            return array[index];
        }

        private static object GenerateData(int? total, int? adults = null, int? children = null)
        {
            var lasts = new string[]{"Jones", "Smith", "Lee", "Wilson", "Black", "Williams", "Lewis", "Johnson", "Foot", "Little", "Vee", "Train", "Hot", "Mutt"};
            var firsts = new string[]{"Fred", "Julie", "Bill", "Ted", "Jack", "John", "Mark", "Mike", "Chris", "Bob", "Travis", "Kelly", "Sara"};
            var colors = new string[]{"Red", "Green", "Blue"};


            var result = new List<object>();
            var hasAdult = adults.HasValue;
            var hasChildren = children.HasValue;
            string name;
            var r = new Random();

            if (hasAdult && hasChildren)
            {
                total = adults + children;
            }
            else {
                // We rely on total now
                total = total.HasValue ? total : 15;

                if (!hasAdult && !hasChildren)
                {
                    adults = r.Next(Convert.ToInt32(Math.Floor(total.Value * 0.25)), Convert.ToInt32(Math.Floor(total.Value * 0.75)));
                    children = total - adults;
                }
                else if (!hasAdult) {
                    adults = total - children;
                }
                else {
                    children = total - adults;
                }
            }


            for (int i = 0; i < total; ++i)
            {
                result.Add(new
                {
                    firstName = GetRandom(r, firsts),
                    lastName = GetRandom(r, lasts),
                    age = i >= adults ? r.Next(0, 18) : r.Next(18, 100),
                    favoriteColor = GetRandom(r, colors)
                });
            }

            return result;
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Chaining Stores - Ext.Net Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var onEditComplete = function (editor, context) {
            var rec = context.record,
                ct = this.grid.up(),
                model = ct.getViewModel(),
                store = model.getStore('adults');

            if (store.contains(rec)) {
                ct.refs.adultsGrid.getView().focusRow(rec);
            }
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Chaining Stores</h1>

        <p>This example demonstrates a chained store, a store that is backed by the data of another <br />
           store. Sorting and filtering of the stores are independent. Removing a value in the source <br />
           store removes it from the chained store. Model instances are shared, so editing the data <br />
           in one store will be reflected in the other.
        </p>

       <ext:Container
           runat="server"
           Width="680"
           Height="600"
           ViewModel="<%# MyModel.Model %>"
           ReferenceHolder="true"
           AutoDataBind="true">
           <LayoutConfig>
               <ext:VBoxLayoutConfig Align="Stretch" />
           </LayoutConfig>
           <Items>
               <ext:GridPanel
                   runat="server"
                   BindString="{everyone}"
                   Title="All People"
                   Flex="1">
                   <ColumnModel>
                       <Columns>
                           <ext:Column runat="server" Text="First Name" DataIndex="firstName" Flex="1">
                               <Editor>
                                   <ext:TextField runat="server" />
                               </Editor>
                           </ext:Column>

                           <ext:Column runat="server" Text="Last Name" DataIndex="lastName" Flex="1">
                               <Editor>
                                   <ext:TextField runat="server" />
                               </Editor>
                           </ext:Column>

                           <ext:Column runat="server" Text="Age" DataIndex="age" Width="120">
                               <Editor>
                                   <ext:NumberField runat="server" />
                               </Editor>
                           </ext:Column>

                           <ext:Column runat="server" Text="Fav. Color" DataIndex="favoriteColor" Flex="1">
                               <Renderer Handler="return Ext.String.format('<span style=\'color: {0};\'>{1}</span>', value.toLowerCase(), value);" />
                               <Editor>
                                   <ext:TextField runat="server" />
                               </Editor>
                           </ext:Column>

                           <ext:CommandColumn runat="server">
                               <Commands>
                                   <ext:GridCommand CommandName="remove" Text="Remove" />
                               </Commands>
                               <Listeners>
                                   <Command Handler="this.up('grid').up().getViewModel().getStore('everyone').remove(record);" />
                               </Listeners>
                           </ext:CommandColumn>
                       </Columns>
                   </ColumnModel>
                   <Plugins>
                       <ext:CellEditing runat="server">
                           <Listeners>
                               <Edit Fn="onEditComplete" />
                           </Listeners>
                       </ext:CellEditing>
                   </Plugins>
               </ext:GridPanel>

               <ext:GridPanel
                   runat="server"
                   BindString="{adults}"
                   Title="The Adults"
                   Reference="adultsGrid"
                   MarginSpec="10 0 0 0"
                   Flex="1">
                   <ColumnModel>
                       <Columns>
                           <ext:Column runat="server" Text="First Name" DataIndex="firstName" Flex="1" />
                           <ext:Column runat="server" Text="Last Name" DataIndex="lastName" Flex="1" />
                           <ext:Column runat="server" Text="Age" DataIndex="age" Width="120" />

                           <ext:Column runat="server" Text="Fav. Color" DataIndex="favoriteColor" Flex="1">
                               <Renderer Handler="return Ext.String.format('<span style=\'color: {0};\'>{1}</span>', value.toLowerCase(), value);" />
                           </ext:Column>
                       </Columns>
                   </ColumnModel>
               </ext:GridPanel>
           </Items>
       </ext:Container>
    </form>
</body>
</html>