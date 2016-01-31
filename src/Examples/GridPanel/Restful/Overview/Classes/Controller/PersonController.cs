using System;
using Newtonsoft.Json;

namespace Ext.Net.Examples.Restful
{
    public class PersonController : Controller
    {
        public override Response View()
        {
            Response r = new Response(true, "Loaded data");
            r.Data = JSON.Serialize(Model.GetAll<PersonModel>());
            return r;
        }

        public override Response Create()
        {
            JsonSerializerSettings settings = new JsonSerializerSettings();
            settings.Converters = JSON.Converters;
            settings.NullValueHandling = NullValueHandling.Ignore;

            PersonModel added = (PersonModel)JsonConvert.DeserializeObject(this.Request.Data, typeof(PersonModel), settings);            
            added.Insert<PersonModel>();

            Response r = new Response(added != null, added != null ? "Created new Person" : "Failed to create Person");
            r.Data = added != null ? JSON.Serialize(added) : null;
            return r;
        }

        public override Response Update()
        {
            PersonModel updated = JSON.Deserialize<PersonModel>(this.Request.Data);
            updated.Id = this.Request.Id;
            updated = updated.Update<PersonModel>();

            Response r = new Response(updated != null, updated != null ? "Updated Person" : "Failed to find that Person");
            r.Data = updated != null ? JSON.Serialize(updated) : null;
            return r;
        }

        public override Response Destroy()
        {
            PersonModel destroyed = PersonModel.Read<PersonModel>(this.Request.Id);
            destroyed = destroyed.Destroy<PersonModel>();

            Response r = new Response(destroyed != null, destroyed != null ? "Destroyed Person" : "Failed to destroy Person");
            return r;
        }
    }
}
