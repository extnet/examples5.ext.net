using System.Collections.Generic;

namespace Ext.Net.Examples.Restful
{
    public class PersonModel : Model
    {
        public string Email
        {
            get;
            set;
        }

        public string First
        {
            get;
            set;
        }

        public string Last
        {
            get;
            set;
        }

        public static void InitDB()
        {
            if (Session_DB.GetAll<PersonModel>() == null)
            {
                Session_DB.Submit<PersonModel>(PersonModel.TestPersons);
            }
        }

        private static List<PersonModel> TestPersons
        {
            get
            {
               return new List<PersonModel>
               {
                   new PersonModel{Id=1, Email="fred@flintstone.com", First="Fred", Last="Flintstone"},
                   new PersonModel{Id=2, Email="wilma@flintstone.com", First="Wilma", Last="Flintstone"},
                   new PersonModel{Id=3, Email="pebbles@flintstone.com", First="Pebbles", Last="Flintstone"},
                   new PersonModel{Id=4, Email="barney@rubble.com", First="Barney", Last="Rubble"},
                   new PersonModel{Id=5, Email="betty@rubble.com", First="Betty", Last="Rubble"},
                   new PersonModel{Id=6, Email="bambam@rubble.com", First="BamBam", Last="Rubble"}
               };
            }
        }
    }
}
