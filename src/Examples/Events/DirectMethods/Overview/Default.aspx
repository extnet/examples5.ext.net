<%@ Page Language="C#" %>

<%@ Import Namespace="System.Threading" %>
<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Label1.DataBind();
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>DirectMethod Overview - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>DirectMethod Overview</h1>

        <p>A DirectMethod provides the ability to call server-side .NET Methods from client-side JavaScript code.</p>

        <p>Decorating a server-side <code>public</code> or <code>public static</code> Method with the [DirectMethod] Attribute will expose the server-side Method
        to your client-side JavaScript.</p>

        <h3>Syntax Example</h3>

        <pre class="code">[DirectMethod]
public void SetTimeStamp(string text)
{
    this.Label1.Text = DateTime.Now.ToLongTimeString();
}
</pre>


        <!--  1  ----------------------------------------------------------------------------------------------->

        <h2>1. Basic DirectMethod</h2>

        <p>The following demonstrates a simple [DirectMethod] which updates an &lt;ext:Label> control.</p>

        <h3>Example</h3>

        <script runat="server">
            [DirectMethod]
            public void SetTimeStamp()
            {
                this.Label1.Text = DateTime.Now.ToLongTimeString();
                this.Label1.Element.Highlight();
            }
        </script>

        <ext:Button ID="Button1" runat="server" Text="Click Me" Icon="Lightning">
            <Listeners>
                <Click Handler="App.direct.SetTimeStamp();" />
            </Listeners>
        </ext:Button>

        <br />

        <ext:Label ID="Label1" runat="server" Format="Server Time: {0}" Text='<%# DateTime.Now.ToLongTimeString() %>' />

        <h3>Code</h3>

        <pre class="code">&lt;script runat="server">
    [DirectMethod]
    public void SetTimeStamp()
    {
        this.Label1.Text = string.Concat("Server Time: ", DateTime.Now.ToLongTimeString());
    }
&lt;/script>

&lt;ext:Button ID="Button5" runat="server" Text="Click Me" Icon="Lightning">
    &lt;Listeners>
        &lt;Click Handler="App.direct.SetTimeStamp();" />
    &lt;/Listeners>
&lt;/ext:Button>
</pre>


        <!--  2 ----------------------------------------------------------------------------------------------->

        <h2>2. Return a string from an DirectMethod</h2>

        <p>Any type object can be returned from an DirectMethod. The object is serialized into JSON. The serialized object is
            sent as the 'result' parameter to the 'success' function as configured in the DirectMethod configuration.</p>

        <h3>Example</h3>

        <script runat="server">
            [DirectMethod]
            public string GetTimeStamp()
            {
                return DateTime.Now.ToLongTimeString();
            }
        </script>

        <ext:Button ID="Button2" runat="server" Text="Click Me" Icon="Lightning">
            <Listeners>
                <Click Handler="
                    App.direct.GetTimeStamp({
                        success: function (result) {
                            Ext.Msg.alert('Server Time', result);
                        }
                    });" />
            </Listeners>
        </ext:Button>

        <h3>Code</h3>

        <pre class="code">&lt;script runat="server">
    [DirectMethod]
    public string GetTimeStamp()
    {
        return DateTime.Now.ToLongTimeString();
    }
&lt;/script>

&lt;ext:Button runat="server" Text="Click Me" Icon="Lightning">
    &lt;Listeners>
        &lt;Click Handler="
            App.direct.GetTimeStamp({
                success: function (result) {
                    Ext.Msg.alert('Server Time', result);
                }
            });" />
    &lt;/Listeners>
&lt;/ext:Button>
</pre>


        <!--  3  ----------------------------------------------------------------------------------------------->

        <h2>3. Pass multiple arguments to an DirectMethod</h2>

        <p>If the server-side DirectMethod requires parameters, the client-side DirectMethod will also be created and expect to be passed values for the two arguments.</p>
        <p>For example, if the server-side Method requires a <code>string</code> and <code>int</code> argument, both a valid <code>string</code> and <code>number</code> must be passed to the client-side function.</p>

        <h3>Example</h3>

        <script runat="server">
            [DirectMethod]
            public void LogCompanyInfo(string name, int count)
            {
                string template = string.Concat("<b>{0}</b> has approximately <b>{1}</b> employees.");
                string[] employees = new string[4] { "1-5", "6-25", "26-100", "100+" };

                this.Label3.Html = string.Format(template, name, employees[count]);
            }
        </script>

        <ext:FormPanel
            runat="server"
            Title="Company Information"
            Width="350"
            BodyPadding="5"
            Frame="true">
            <Items>
                <ext:TextField
                    ID="TextField3"
                    runat="server"
                    FieldLabel="Company Name"
                    AllowBlank="false"
                    AnchorHorizontal="100%"
                    />
                <ext:ComboBox
                    ID="ComboBox3"
                    runat="server"
                    FieldLabel="# of Employees"
                    AnchorHorizontal="100%"
                    AllowBlank="false"
                    Editable="false">
                    <Items>
                        <ext:ListItem Text="1-5" Value="0" />
                        <ext:ListItem Text="6-25" Value="1" />
                        <ext:ListItem Text="26-100" Value="2" />
                        <ext:ListItem Text="101+" Value="3" />
                    </Items>
                </ext:ComboBox>
            </Items>
            <Buttons>
                <ext:Button runat="server" Text="Submit" Icon="Lightning" FormBind="true">
                    <Listeners>
                        <Click Handler="App.direct.LogCompanyInfo(#{TextField3}.getValue(), #{ComboBox3}.getValue());" />
                    </Listeners>
                </ext:Button>
            </Buttons>
        </ext:FormPanel>

        <br />

        <ext:Label ID="Label3" runat="server" Text="Write Company Information Here" />

        <h3>Code</h3>

        <pre class="code">&lt;script runat="server">
    [DirectMethod]
    public void LogCompanyInfo(string name, int count)
    {
        string template = string.Concat("{0} has approximately {1} employees.");
        string[] employees = new string[4] { "1-5", "6-25", "26-100", "100+" };

        this.Label3.Text = string.Format(template, name, employees[count]);
    }
&lt;/script>

&lt;ext:Button runat="server" Text="Submit">
    &lt;Listeners>
        &lt;Click Handler="App.direct.LogCompanyInfo('Ext.NET, Inc.', 0);" />
    &lt;/Listeners>
&lt;/ext:Button></pre>


        <!--  4  ----------------------------------------------------------------------------------------------->

        <h2>4. Calling static Method DirectMethod and return a string (Super Fast + Best Performance)</h2>

        <p>When calling a public server-side Method, but default the complete Page lifecycle is executed
            and the Method has access to all web controls on the Page.</p>
        <p>With a 'static' [DirectMethod] the Page lifecycle is not executed and access to the Page WebControls
            are not possible. This reduces the processing overhead and optimizes performance.</p>

        <h3>Example</h3>

        <script runat="server">
            [DirectMethod]
            public static string GetTimeStamp4()
            {
                return DateTime.Now.ToLongTimeString();
            }
        </script>

        <ext:Button runat="server" Text="Click Me" Icon="Lightning">
            <Listeners>
                <Click Handler="
                    App.direct.GetTimeStamp4({
                        success: function (result) {
                            Ext.Msg.alert('Server Time', result);
                        }
                    });" />
            </Listeners>
        </ext:Button>

        <h3>Code</h3>

        <pre class="code">&lt;script runat="server">
    [DirectMethod]
    public static string GetTimeStamp4()
    {
        return DateTime.Now.ToLongTimeString();
    }
&lt;/script>

&lt;ext:Button xrunat="server" Text="Click Me" Icon="Lightning">
    &lt;Listeners>
        &lt;Click Handler="
            App.direct.GetTimeStamp4({
                success: function (result) {
                    Ext.Msg.alert('Server Time', result);
                }
            });" />
    &lt;/Listeners>
&lt;/ext:Button>
</pre>


        <!--  5  ----------------------------------------------------------------------------------------------->

        <h2>5. Return a Customer object from a static DirectMethod</h2>

        <p>Any type of object can be returned from a DirectMethod. The following example creates and returns a 'Customer' object.</p>

        <p>The Customer object is serialized into JSON and returned to the client (browser). Within the DirectMethod configuration object,
        the 'result' parameter is the return object.</p>

        <h3>Example</h3>

        <script runat="server">
            // Define Customer Class
            public class Customer
            {
                public int ID { get; set; }
                public string FirstName { get; set; }
                public string LastName { get; set; }
                public string Company { get; set; }
                public Country Country { get; set; }
                public bool Premium { get; set; }
            }

            // Define Country Class
            public class Country
            {
                public string Name { get; set; }
            }

            [DirectMethod]
            public static Customer GetCustomer()
            {
                // Get your Customer data from somewhere...

                return new Customer()
                {
                    ID = 99,
                    FirstName = "Peter",
                    LastName = "Smith",
                    Company = "CompanyX, LLC.",
                    Premium = true,
                    Country = new Country { Name = "Canada" }
                };
            }
        </script>

        <ext:Button runat="server" Text="Click Me" Icon="Lightning">
            <Listeners>
                <Click Handler="
                    App.direct.GetCustomer({
                        success : function (customer) {
                            var template = 'ID : {0}{6} Name : {1} {2}{6} Company : {3}{6} Country : {4}{6} Premium Member : {5}',
                                msg = Ext.String.format(template,
                                        customer.ID,
                                        customer.FirstName,
                                        customer.LastName,
                                        customer.Company,
                                        customer.Country.Name,
                                        customer.Premium,
                                        '&lt;br /&gt;&lt;br /&gt;');

                            Ext.Msg.alert('Customer', msg);
                        }
                    });" />
            </Listeners>
        </ext:Button>

        <h3>Code</h3>

        <pre class="code">&lt;script runat="server">
    // Define Customer Class
    public class Customer
    {
        public int ID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Company { get; set; }
        public Country Country { get; set; }
        public bool Premium { get; set; }
    }

    // Define Country Class
    public class Country
    {
        public string Name { get; set; }
    }

    [DirectMethod]
    public static Customer GetCustomer()
    {
        // Get your Customer data from somewhere...

        return new Customer() {
            ID = 99,
            FirstName = "Peter",
            LastName = "Smith",
            Company = "CompanyX, LLC.",
            Premium = true,
            Country = new Country { Name = "Canada" }
        };
    }
&lt;/script>

&lt;ext:Button runat="server" Text="Click Me" Icon="Lightning">
    &lt;Listeners>
        &lt;Click Handler="
            App.direct.GetCustomer({
                success : function (customer) {
                    var template = 'ID : {0}{6} Name : {1} {2}{6} Company : {3}{6} Country : {4}{6} Premium Member : {5}',
                        msg = Ext.String.format(template,
                                customer.ID,
                                customer.FirstName,
                                customer.LastName,
                                customer.Company,
                                customer.Country.Name,
                                customer.Premium,
                                '&lt;br /&gt;&lt;br /&gt;');

                    Ext.Msg.alert('Customer', msg);
                }
            });" />
    &lt;/Listeners>
&lt;/ext:Button>
</pre>


        <!--  6  ----------------------------------------------------------------------------------------------->

        <h2>6. Disable the DirectMethod ClientProxy Creation</h2>

        <p>When the [DirectMethod] Attribute is added to a server-side Method, by default, a JavaScript function of the same name, and accepting the same
            parameters will be created in the client-side App.direct arry.</p>

        <p>For example, if we create a server-side Method called "GetTimeStamp", on the client, the App.direct.GetTimeStamp JavaScript function will also be created.</p>

        <p>There may be scenarios where developers may decide to create an DirectMethod, but not expose the corresponding JavaScript function on the client.
            You can configure the DirectMethod to ignore creating the corresponding client-side JavaScript function by setting the <code>ClientProxy.Ignore</code> property on that particular DirectMethod.</p>

        <h3>Code</h3>

        <pre class="code">[DirectMethod(ClientProxy = ClientProxy.Ignore)]
public string GetTimeStamp()
{
    return DateTime.Now.ToLongTimeString();
}</pre>

        <p>If the DirectMethod is set with ClientProxy.Ignore, the corresponding client-side proxy function will not be created, but the DirectMethod can still be called.
            The DirectMethod proxy functions are conveinience wrappers around the underlying Ext.net.DirectMethod.request() function.</p>
        <p>Any server-side DirectMethod can be called directly (without a client-side proxy function), by configuring the Ext.net.DirectMethod.request() function.</p>

        <div class="doc-item">
            <span class="doc-member">request</span> ( <code>string methodName</code> , <span class="doc-optional" title="Optional">[Object options]</span> ) : void
            <div class="doc-desc">Calls the server-side [DirectMethod] as specified in the methodName parameter.</div>
            <div class="doc-params">
                <strong>Parameters:</strong>
                <ul>
                    <li>
                        <span class="doc-member">methodName</span> : String
                        <div class="doc-subdesc">
                            The server-side Method name to call.
                        </div>
                    </li>
                    <li>
                        <span class="doc-member">options</span> : Object
                        <div class="doc-subdesc">
                            (optional) An object containing configuration properties. This options object may contain any of the following properties
                            as well as options of <a href="http://docs.sencha.com/extjs/7.2.0/classic/Ext.data.Connection.html#method-request" target="_blank">Ext.data.Connection.request</a>.
                            <ul>
                                <li>
                                    <span class="doc-prop">success</span> : Function
                                    <div class="doc-subdesc">
                                        The JavaScript function to invoke on successful response from the DirectMethod.<br />
                                        The "<code>result</code>" parameter is passed to the success function.
                                    </div>
                                </li>
                               <li>
                                    <span class="doc-prop">failure</span> : Function
                                    <div class="doc-subdesc">
                                        The JavaScript function to invoke if a failure response is returned from the DirectMethod.<br />
                                        The "<code>errorMessage</code>" parameter is passed to the success function.
                                    </div>
                                </li>
                                <li>
                                    <span class="doc-prop">complete</span> : Function
                                    <div class="doc-subdesc">
                                        The JavaScript function to invoke when a DirectMethod completes (successfully or not),<br/>
                                        and the response is parsed on the client side.
                                        <br />
                                        The "<code>success</code>", "<code>result</code>", "<code>response</code>", "<code>extraParams</code>", "<code>directMethodConfig</code>" parameters are passed to the complete function.
                                    </div>
                                </li>
                                <li>
                                    <span class="doc-member">specifier</span> : String
                                    <div class="doc-subdesc">
                                        The server-side Method access specifier, options inlcude (<code>"public"</code>, <code>"static"</code>).<br />
                                        The specifier of "public" is the default value and does not need to be explicitly set.<br />
                                        If the server-side Method is a static Method, the specifier options must be set to "static".
                                    </div>
                                </li>
                                <li>
                                    <span class="doc-member">method</span> : String
                                    <div class="doc-subdesc">
                                        The type of http request to make, options include (<code>"POST"</code>, <code>"GET"</code>).<br />
                                        The method of "POST" is the default value.
                                    </div>
                                </li>
                                <li>
                                    <span class="doc-member">url</span> : String
                                    <div class="doc-subdesc">
                                        A custom url to call the DirectMethod from. The DirectMethod does not need to be configured on the "Parent Page".<br />
                                        If no url is provided, the request options will use the &lt;form>'s action attribute. If the action attribute is empty,
                                        the request options will use the window.location.href value. If the window.location.href value ends with a forward-slash ("/"),
                                        the IIS web server may not be able to process the "POST" request. Under this scenario, you must set the "method" options property to "GET".
                                    </div>
                                </li>
                                <li>
                                    <span class="doc-member">control</span> : String
                                    <div class="doc-subdesc">
                                        The ID of the UserControl which contains the DirectMethod.
                                        An DirectMethod can be configured within a .ascx file and called from a Parent .aspx Page.
                                    </div>
                                </li>
                                <li>
                                    <span class="doc-member">timeout</span> : Number
                                    <div class="doc-subdesc">
                                        The timeout in milliseconds to be used for requests. (defaults to 30000)
                                    </div>
                                </li>
                                <li>
                                    <span class="doc-member">eventMask</span> : Object
                                    <div class="doc-subdesc">
                                        (optional) An EventMask options object. This options object may contain any of the following properties:
                                        <ul>
                                            <li>
                                                <span class="doc-member">showMask</span> : Boolean
                                                <div class="doc-subdesc">
                                                    <code>true</code> to show mask (defaults to <code>false</code>).
                                                </div>
                                            </li>
                                            <li>
                                                <span class="doc-member">msg</span> : String
                                                <div class="doc-subdesc">
                                                    The text to display in a centered loading message box (defaults to 'Working...').
                                                </div>
                                            </li>
                                            <li>
                                                <span class="doc-member">msgCls</span> : String
                                                <div class="doc-subdesc">
                                                    The CSS class to apply to the loading message element (defaults to "x-mask-loading")
                                                </div>
                                            </li>
                                            <li>
                                                <span class="doc-member">target</span> : String
                                                <div class="doc-subdesc">
                                                    The target element to apply the mask to, options include (<code>"page"</code>, <code>"customtarget"</code>).<br />
                                                    If <code>"customtarget"</code>, the <code>customTarget</code> configuration option should be set.
                                                </div>
                                            </li>
                                            <li>
                                                <span class="doc-member">customTarget</span> : String
                                                <div class="doc-subdesc">
                                                    The id of the target element, or a instance of the target element.
                                                </div>
                                            </li>
                                            <li>
                                                <span class="doc-member">minDelay</span> : Number
                                                <div class="doc-subdesc">
                                                    The minimum amount of time to display the mask (defaults to 0).<br />
                                                    Setting the minDelay provides and minimum amount of time to display a message to the user before removing mask
                                                    and executing success, failure and/or callback functions.
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                                <li>
                                    <span class="doc-member">encode</span> : Boolean
                                    <div class="doc-subdesc">
                                        True to encode parameters using <code>Ext.decode</code>, false to use <code>Ext.Object.toQueryString</code>. Defaults to true.
                                    </div>
                                </li>
                                <li>
                                    <span class="doc-member">recursive</span> : Boolean
                                    <div class="doc-subdesc">
                                        True to a recursive call of <code>Ext.Object.toQueryString</code> on preparation of request's parameters. Defaults to false. Applicable only if <code>encode</code> is false.
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </li>
                </ul>
                <strong>Returns:</strong>
                <ul>
                    <li><code>void</code></li>
                </ul>
            </div>
        </div>

        <h3>Example</h3>

        <script runat="server">
            [DirectMethod(ClientProxy = ClientProxy.Ignore)]
            public string GetTimeStamp6()
            {
                return DateTime.Now.ToLongTimeString();
            }
        </script>

        <ext:Button runat="server" Text="Click Me" Icon="Lightning">
            <Listeners>
                <Click Handler="Ext.net.DirectMethod.request(
                    'GetTimeStamp6',
                    {
                        success: function (result) {
                            Ext.Msg.alert('Message', result);
                        }
                    });" />
            </Listeners>
        </ext:Button>

        <h3>Code</h3>

        <pre class="code">&lt;script runat="server">
    [DirectMethod(ClientProxy = ClientProxy.Ignore)]
    public string GetTimeStamp6()
    {
        return DateTime.Now.ToLongTimeString();
    }
&lt;/script>

&lt;ext:Button runat="server" Text="Click Me" Icon="Lightning">
    &lt;Listeners>
        &lt;Click Handler="Ext.net.DirectMethod.request(
            'GetTimeStamp6',
            {
                success: function (result) {
                    Ext.Msg.alert('Message', result);
                }
            });" />
    &lt;/Listeners>
&lt;/ext:Button>
</pre>


        <!--  7  ----------------------------------------------------------------------------------------------->

        <h2>7. Pass DirectMethod configuration object to proxy function</h2>

        <p>An DirectMethod configuration object can always be passed as the last parameter on any DirectMethod proxy function.</p>

        <h3>Example</h3>

        <script runat="server">
            [DirectMethod]
            public string LogMessage(string msg)
            {
                // Log the message somewhere...
                return msg;
            }
        </script>

        <ext:Button ID="Button3" runat="server" Text="Click Me" Icon="Lightning">
            <Listeners>
                <Click Handler="App.direct.LogMessage('Hello World', {
                            success: function (result) {
                                Ext.Msg.alert('Message', result);
                            },
                            eventMask: {
                                showMask: true,
                                minDelay: 500
                            }
                        });" />
            </Listeners>
        </ext:Button>

        <h3>Code</h3>

        <pre class="code">&lt;script runat="server">
    [DirectMethod]
    public string LogMessage(string msg)
    {
        // Log the message somewhere...
        return msg;
    }
&lt;/script>

&lt;ext:Button ID="Button4" runat="server" Text="Click Me" Icon="Lightning">
    &lt;Listeners>
        &lt;Click Handler="App.direct.LogMessage('Hello World', {
                    success: function (result) {
                        Ext.Msg.alert('Message', result);
                    },
                    eventMask: {
                        showMask: true,
                        minDelay: 500
                    }
                });" />
    &lt;/Listeners>
&lt;/ext:Button></pre>

    </form>
</body>
</html>