<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            WidgetsCombo.Items.AddRange(this.GetTypes());
        }
    }

    private List<Ext.Net.ListItem> GetTypes()
    {
        List<Ext.Net.ListItem> data = new List<Ext.Net.ListItem>();
        System.Reflection.Assembly extnetlib = typeof(Ext.Net.ResourceManager).Assembly;
        foreach (Type type in extnetlib.GetTypes())
        {
            if (type.IsSubclassOf(typeof(Ext.Net.BaseControl)) && !type.IsAbstract)
            {
                data.Add(new Ext.Net.ListItem(type.Name, type.FullName));
            }
        }
        data.Sort((a, b) => string.Compare(a.Text, b.Text));
        return data;
    }

    protected void GetEvents(object sender, DirectEventArgs e)
    {
        System.Reflection.PropertyInfo listeners = this.GetListenersProperty(WidgetsCombo.SelectedItem.Value);
        if (listeners != null && listeners.PropertyType.IsSubclassOf(typeof(ComponentListeners)))
        {
            System.Reflection.BindingFlags flags = System.Reflection.BindingFlags.Instance |
            System.Reflection.BindingFlags.Public;
            if (!InheritedCheck.Checked)
            {
                flags = System.Reflection.BindingFlags.DeclaredOnly | flags;
            }
            foreach (System.Reflection.PropertyInfo listener in listeners.PropertyType.GetProperties(flags))
            {
                if (listener.PropertyType.IsAssignableFrom(typeof(ComponentListener)))
                {
                    EventsCombo.Items.Add(new Ext.Net.ListItem(listener.Name));
                }
            }
            EventsCombo.Items.Sort((a, b) => string.Compare(a.Text, b.Text));
        }

        if (EventsCombo.Items.Count == 0)
        {
            EventsCombo.Items.Add(new Ext.Net.ListItem("-- No events --", "-1"));
        }

        EventsCombo.Reset();
        EventsCombo.GetStore().DataBind();
        FunctionLabel.Text = "";
    }
    private System.Reflection.PropertyInfo GetListenersProperty(string widget)
    {
        return typeof(Ext.Net.ResourceManager).Assembly.GetType(widget).GetProperty("Listeners");
    }
    protected void GetFunctionSignature(object sender, DirectEventArgs e)
    {
        if (EventsCombo.SelectedItem.Value == "-1")
        {
            return;
        }
        System.Reflection.PropertyInfo listeners = this.GetListenersProperty(WidgetsCombo.SelectedItem.Value);
        System.Reflection.PropertyInfo listener = listeners.PropertyType.GetProperty(EventsCombo.SelectedItem.Value);
        if (listener != null)
        {
            List<ListenerArgumentAttribute> attrs = new List<ListenerArgumentAttribute>();
            foreach (ListenerArgumentAttribute a in
            listener.GetCustomAttributes(typeof(ListenerArgumentAttribute), false))
            {
                attrs.Add(a);
            }
            attrs.Sort(new Ext.Net.BaseListener.ListenerArgumentAttributeComparer());
            StringBuilder sb = new StringBuilder();
            sb.Append("function ( ");
            for (int i = 0; i < attrs.Count; i++)
            {
                sb.Append(attrs[i].Name);
                if (i != (attrs.Count - 1))
                {
                    sb.Append(", ");
                }
            }
            sb.Append(" )");
            FunctionLabel.Text = sb.ToString();
        }
        else
        {
            FunctionLabel.Text = "";
        }
    }
</script>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        body
        {
            padding: 20px;
        }
        .func-label
        {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:FormPanel
            runat="server"
            Title="Listener Arguments"
            Width="400"
            BodyPadding="18"
            DefaultAnchor="100%">
            <FieldDefaults LabelWidth="60" />
            <Items>
                <ext:ComboBox ID="WidgetsCombo" runat="server"
                    FieldLabel="Ext.Net"
                    EmptyText="Select a widget"
                    LabelSeparator="."
                    ForceSelection="true"
                    TypeAhead="true"
                    Width="360">
                    <DirectEvents>
                        <Select OnEvent="GetEvents">
                            <EventMask ShowMask="true" />
                        </Select>
                    </DirectEvents>
                </ext:ComboBox>

                <ext:ComboBox ID="EventsCombo" runat="server"
                    FieldLabel="Events"
                    EmptyText="Select an event"
                    ForceSelection="true"
                    TypeAhead="true"
                    Width="360">
                    <DirectEvents>
                        <Select OnEvent="GetFunctionSignature">
                            <EventMask ShowMask="true" />
                        </Select>
                    </DirectEvents>
                </ext:ComboBox>

                <ext:Checkbox ID="InheritedCheck" runat="server"
                    BoxLabel="Show inherited events"
                    Checked="true"
                    FieldLabel="&nbsp;"
                    LabelSeparator=" ">
                    <DirectEvents>
                        <Change OnEvent="GetEvents">
                            <EventMask ShowMask="true" />
                        </Change>
                    </DirectEvents>
                </ext:Checkbox>

                <ext:DisplayField ID="FunctionLabel" runat="server"
                    FieldLabel="Signature"
                    FieldCls="func-label"
                    />
            </Items>
        </ext:FormPanel>


    </form>
</body>
</html>