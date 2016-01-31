using System.Collections.Generic;
using System.Web;

// !!! DO NOT REMOVE CODEBEHIND AND DO NOT MOVE CODE TO THE ASPX (REQUIRED FOR THE WEB SERVICE)

namespace Ext.Net.Calendar.Demo
{
    public partial class EventsViewer : System.Web.UI.UserControl
    {
        public void Render(List<EventModel> events)
        {            
            this.SubmittedEventsStore1.DataSource = events;
            this.Window1.Render();
        }

        public string ToScript(List<EventModel> events)
        {
            this.SubmittedEventsStore1.DataSource = events;
            return this.Window1.ToScript();
        }
    }
}