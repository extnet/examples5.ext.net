<%@ Page Language="C#" %>

<script runat="server">        
    protected void SubmitModel(object sender, DirectEventArgs e)
    {
        var model = e.ExtraParams["model"];
        X.Msg.Alert("Data", model).Show();
    }
    
    public class MyModel
    {
        public static object Model = new
        {
            //data : Object
            //This object holds the arbitrary data that populates the ViewModel and is then available for binding.
            data = new
            {
                birthDate = JRawValue.From("new Date(1971, 4, 3)"),
                firstName = "John",
                lastName = "Doe"
            },

            // formulas : Object
            // An object that defines named values whose value is managed by function calls. The names of the properties of this object are assigned as values in the ViewModel.
            // More information at http://docs-origin.sencha.com/extjs/5.0.1/#!/api/Ext.app.bind.Formula
            formulas = new
            {
                age = new 
                {
                    get = new JFunction("TwoWayFormulasModel.formulas.age.get"),
                    set = new JFunction("TwoWayFormulasModel.formulas.age.set")
                },
                fullName = new
                {
                    get = new JFunction("TwoWayFormulasModel.formulas.fullName.get"),
                    set = new JFunction("TwoWayFormulasModel.formulas.fullName.set")
                }
            },

            getAge = new JFunction("TwoWayFormulasModel.getAge"),
        };
    }
</script>


<!DOCTYPE html>

<html>
<head runat="server">
    <title>Formulas - Ext.Net Examples</title>        
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var TwoWayFormulasModel = {
            formulas: {
                age: {
                    get: function (get) {
                        return this.getAge(get('birthDate'));
                    },

                    set: function (age) {
                        var date = this.getData().birthDate,
                            now = new Date();

                        if (!date) {
                            date = Ext.Date.add(now, Ext.Date.YEAR, -age);
                        } else {
                            date = new Date(now.getFullYear() - age, date.getMonth(), date.getDate());
                            if (this.getAge(date) !== age) {
                                date = new Date(now.getFullYear() - age - 1, date.getMonth(), date.getDate());
                            }
                        }

                        this.set('birthDate', date);
                    }
                },

                fullName: {
                    get: function (get) {
                        var ret = get('firstName') || '',
                            last = get('lastName');

                        if (last) {
                            ret += ' ' + last;
                        }

                        return ret;
                    },

                    // By providing the set method "fullName" is two-way bindable.
                    set: function (value) {
                        var space = value.indexOf(' '),
                            split = (space < 0) ? value.length : space;

                        this.set({
                            firstName: value.substring(0, split),
                            lastName: value.substring(split + 1)
                        });
                    }
                }
            },

            getAge: function (date) {
                var now = new Date(),
                    age, birth;

                if (date) {
                    age = now.getFullYear() - date.getFullYear();
                    now = now.getMonth() * 100 + now.getDate();
                    birth = date.getMonth() * 100 + date.getDate();

                    if (now < birth) {
                        --age;
                    }
                }

                return age || 0;
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Formulas</h1>

        <p>This example shows data binding using formulas that can be edited. That is, "virtual properties"!</p>
        
        <ext:Panel 
            runat="server" 
            Width="450" 
            AutoScroll="true"
            BodyPadding="10" 
            Frame="true"
            Resizable="true"
            Layout="FormLayout"
            Title="Two-Way Formulas"
            ViewModel="<%# MyModel.Model %>" 
            AutoDataBind="true">
            <Items>
                <ext:TextField runat="server" FieldLabel="First Name" BindString="{firstName}" />
                <ext:TextField runat="server" FieldLabel="Last Name" BindString="{lastName}" />
                <ext:TextField runat="server" FieldLabel="Full Name (virtual)" BindString="{fullName}" />
                
                <ext:FieldContainer runat="server" FieldLabel="Age">
                    <LayoutConfig>
                        <ext:HBoxLayoutConfig Align="Middle" />
                    </LayoutConfig>
                    <Items>
                        <ext:NumberField runat="server" Width="100" BindString="{age}" MinValue="0" />
                        <ext:Slider runat="server" Width="80" MarginSpec="0 0 0 8" BindString="{age}" Single="true" />
                        <ext:Slider runat="server" Width="80" PublishOnComplete="false" MarginSpec="0 0 0 8" BindString="{age}" Single="true" />
                    </Items>
                </ext:FieldContainer>

                <ext:DateField 
                    runat="server" 
                    Format="MM/dd/yyyy" 
                    FieldLabel="Birth Date" 
                    BindString="{birthDate}" 
                    MaxDate="<%# DateTime.Now %>" 
                    AutoDataBind="true" 
                    />
            </Items>
            <Buttons>
                <ext:Button runat="server" Text="Submit Model">
                    <DirectEvents>
                        <Click OnEvent="SubmitModel">
                            <ExtraParams>
                                <ext:Parameter Name="model" Value="this.up('panel').getViewModel().getData()" Encode="true" Mode="Raw" />
                            </ExtraParams>
                        </Click>
                    </DirectEvents>
                </ext:Button>
            </Buttons>
        </ext:Panel>
    </form>
</body>
</html>