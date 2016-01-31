using System.Collections.Generic;
using System.Web;

namespace Ext.Net.Examples.Examples.Loader.Component.Http_Handler
{
    /// <summary>
    /// Сводное описание для ComponentHandler
    /// </summary>
    public class ComponentHandler : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "application/json";
            
            switch (context.Request["mode"])
            {
                case "uc":
                    ComponentLoader.Render("~/Examples/Loaders/_Shared/Items.ascx");
                    break;

                case "items":
                default:
                    ComponentLoader.Render(new List<AbstractComponent>()
                        { 
                            new Panel { Title="Item 1", Icon = Icon.UserBrown },
                            new Panel { Title="Item 2", Icon = Icon.UserGray },
                            new Panel { Title="Item 3", Icon = Icon.UserGreen }
                        }
                    );
                    break;
            }            
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}