using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Web.Script.Services;
using System.Web.Services;

namespace Ext.Net.Calendar.Demo
{
    /// <summary>
    /// Summary description for RemoteService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [ToolboxItem(false)]
    [ScriptService]
    public class RemoteService : WebService
    {
        [WebMethod]
        public EventModelCollection GetEvents(DateTime? start, DateTime? end)
        {
            return Data.Events;
        }

        [WebMethod]
        public string SaveAll(List<EventModel> events)
        {
            EventsViewer uc = ((EventsViewer)UserControlRenderer.LoadControl("/Examples/Calendar/Overview/Shared/Common/EventsViewer.ascx"));
            return uc.ToScript(events);
        }
    }
}
