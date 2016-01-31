using System.Collections.Generic;

namespace Ext.Net.Examples.Restful
{
    public abstract class Model
    {
        public int Id
        {
            get;
            set;
        }

        private static int curId = 7;

        private static int PK
        {
            get
            {
                return System.Threading.Interlocked.Increment(ref curId);
            }
        }

        public T Destroy<T>() where T:Model
        {
            return Session_DB.Destroy<T>(this.Id);
        }

        public T Update<T>() where T : Model
        {
            
            return Session_DB.Update<T>((T)this);
        }

        public T Insert<T>() where T : Model
        {
            this.Id = Model.PK;
            return Session_DB.Create<T>((T)this);
        }

        public static List<T> GetAll<T>() where T : Model
        {
            return Session_DB.GetAll<T>();
        }

        public static T Read<T>(int id) where T : Model
        {
            return Session_DB.Read<T>(id);
        }
    }
}
