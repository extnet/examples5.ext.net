using System;

namespace Ext.Net.Examples.Restful
{
    public abstract class Controller
    {
        private RestRequest request;

        public RestRequest Request
        {
            get
            {
                return this.request;
            }
            protected set
            {
                this.request = value;
            }
        }

        public Response Dispatch(RestRequest request)
        {
            this.request = request;
            switch(this.request.Method)
            {
                case "GET":
                    return this.View();
                case "POST":
                    return this.Create();
                case "PUT":
                    return this.Update();
                case "DELETE":
                    return this.Destroy();
                default:
                    throw new InvalidOperationException("Incorrect Http verb");
            }
        }

        public abstract Response View();
        public abstract Response Create();
        public abstract Response Update();
        public abstract Response Destroy();
    }
}
