using System;
using System.Collections.Generic;
using System.Web;

namespace Ext.Net.Examples.Restful
{
    public static class Session_DB
    {
        private static readonly object lockObj = new object();
        public static T Destroy<T>(int id) where T : Model
        {
            lock (lockObj)
            {
                List<T> all = GetAll<T>();
                if (all == null)
                {
                    return null;
                }

                T t = Read<T>(id);
                if (t == null)
                {
                    return null;
                }

                all.Remove(t);
                Submit(all);

                return t;
            }
        }

        public static T Update<T>(T update) where T : Model
        {
            lock (lockObj)
            {
                List<T> all = GetAll<T>();
                if (all == null)
                {
                    return null;
                }

                T t = Read<T>(update.Id);
                if (t == null)
                {
                    return null;
                }

                all[all.IndexOf(t)] = update;
                Submit(all);

                return update;
            }
        }

        public static T Create<T>(T create) where T : Model
        {
            lock (lockObj)
            {
                List<T> all = GetAll<T>();
                if (all == null)
                {
                    return null;
                }

                T t = Read<T>(create.Id);
                if (t != null)
                {
                    throw new Exception("The entity with such id exists already");
                }

                all.Add(create);
                Submit(all);

                return create;
            }
        }

        public static T Read<T>(int id) where T : Model
        {
            lock (lockObj)
            {
                List<T> all = GetAll<T>();
                if (all == null)
                {
                    return null;
                }

                foreach (T t in all)
                {
                    if (t.Id == id)
                    {
                        return t;
                    }
                }

                return null;
            }
        }

        public static List<T> GetAll<T>() where T : Model
        {
            return HttpContext.Current.Session["DB_" + typeof (T).Name] as List<T>;
        }

        public static void Submit<T>(List<T> data) where T : Model
        {
            HttpContext.Current.Session["DB_" + typeof(T).Name] = data;
        }
    }
}
