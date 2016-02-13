<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>MultiUpload Overview - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <p>MultiUpload is flash based uploader, it is based on <a href="http://sourceforge.net/projects/swfupload.mirror" target="_blank">SwfUpload</a> flash</p>

        <h3>Features: </h3>

        <ul>
            <li>Multiple File Selection</li>
            <li>File Upload Progress</li>
            <li>Custom Limits for File Size and Number of Uploads</li>
            <li>Filter by File Type ie. *.jpg</li>
            <li>File Queue</li>
            <li>Drag and Drop (it is supported in browsers that support the HTML5 File API and the Drag and Drop API only: FireFox 4.0+, Chrome, Safari 5.0+, IE 10)</li>
        </ul>

        <h3>Web.config settings to change max upload size and timeout value</h3>
        <pre class="code">
&lt;httpRuntime maxRequestLength="2151" executionTimeout="300" />
&lt;!--
        maxRequestLength is in KB units.  2151 KB is just over 2 MB, this ensures that
        a 2 MB plus some other POST overhead will be accepted. The default is 4 MB. The
        maximum value is 2097151 for .Net 2.0 and 1048576 for .Net 1.x.

        executionTimeout is in seconds.  It should be long enough for the entire to be uploaded
        and for page execution to complete.
-->
         </pre>

        <h3>Such Global.cs.asax can be required for correct handling Session and Authentication for MultiUpload requests</h3>

        <pre class="code">
void Application_BeginRequest(object sender, EventArgs e)
{
    /* Fix for the Flash Player Cookie bug in Non-IE browsers.
     * Since Flash Player always sends the IE cookies even in FireFox
     * we have to bypass the cookies by sending the values as part of the POST or GET
     * and overwrite the cookies with the passed in values.
     *
     * The theory is that at this point (BeginRequest) the cookies have not been read by
     * the Session and Authentication logic and if we update the cookies here we'll get our
     * Session and Authentication restored correctly
     */

    try
    {
        string session_param_name = "ASPSESSID";
        string session_cookie_name = "ASP.NET_SESSIONID";

        if (HttpContext.Current.Request.Form[session_param_name] != null)
        {
            UpdateCookie(session_cookie_name, HttpContext.Current.Request.Form[session_param_name]);
        }
        else if (HttpContext.Current.Request.QueryString[session_param_name] != null)
        {
            UpdateCookie(session_cookie_name, HttpContext.Current.Request.QueryString[session_param_name]);
        }
    }
    catch (Exception)
    {
        Response.StatusCode = 500;
        Response.Write("Error Initializing Session");
    }

    try
    {
        string auth_param_name = "AUTHID";
        string auth_cookie_name = FormsAuthentication.FormsCookieName;

        if (HttpContext.Current.Request.Form[auth_param_name] != null)
        {
            UpdateCookie(auth_cookie_name, HttpContext.Current.Request.Form[auth_param_name]);
        }
        else if (HttpContext.Current.Request.QueryString[auth_param_name] != null)
        {
            UpdateCookie(auth_cookie_name, HttpContext.Current.Request.QueryString[auth_param_name]);
        }

    }
    catch (Exception)
    {
        Response.StatusCode = 500;
        Response.Write("Error Initializing Forms Authentication");
    }
}

void UpdateCookie(string cookie_name, string cookie_value)
{
    HttpCookie cookie = HttpContext.Current.Request.Cookies.Get(cookie_name);
    if (cookie == null)
    {
        cookie = new HttpCookie(cookie_name);
        HttpContext.Current.Request.Cookies.Add(cookie);
    }
    cookie.Value = cookie_value;
    HttpContext.Current.Request.Cookies.Set(cookie);
}
         </pre>
    </form>
</body>
</html>
