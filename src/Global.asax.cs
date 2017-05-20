using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Threading;
using System.Globalization;

namespace Ext.Net.Examples
{
    public class ExtNetVersion
    {
        public static Version Version = typeof(Ext.Net.Examples.Global).Assembly.GetName().Version;

        private static string rev = (Version.Revision == 0) ? "" : ("." + Version.Revision);
        private static string bld = (Version.Build == 0) ? "" : ("." + Version.Build + rev);

        public static string Major = Version.Major + "." + Version.Minor + bld;
        public static string Full = Version.ToString();
    }

    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            if (!Ext.Net.ResourceManager.HasFactory("mybutton"))
            {
                Ext.Net.ResourceManager.AddFactory(delegate
                {
                    var b = new Ext.Net.Button
                    {
                        Text = "Factory button",
                        Handler = "Ext.Msg.alert('Factory button', 'The button is clicked');",
                        Plugins =
                    {
                        new Badge
                        {
                            Text = "20"
                        }
                    },

                        Factory = new FactoryConfig
                        {
                            Alias = "mybutton",
                            Instance = "My.Button"
                        }
                    };

                    return b;
                }, "mybutton", "My.Button");
            }

            if (!Ext.Net.ResourceManager.HasFactory("mywindow"))
            {
                Ext.Net.ResourceManager.AddFactory("~/Examples/Miscellaneous/Factory/Basic/MyWindow.ascx", "mywindow", "My.Window");
            }
        }

        protected void Session_Start(object sender, EventArgs e)
        {
#if DEBUG
            // Enables debugging code output by default if the project is built in debug configuration.
            if (Session["Ext.Net.ScriptMode"] == null)
            {
                Session["Ext.Net.ScriptMode"] = ScriptMode.Debug;
            }

            if (Session["Ext.Net.SourceFormatting"] == null)
            {
                Session["Ext.Net.SourceFormatting"] = true;
            }
#endif // DEBUG
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AcquireRequestState(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}