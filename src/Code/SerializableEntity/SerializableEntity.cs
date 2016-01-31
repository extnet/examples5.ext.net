using System;
using System.ComponentModel;
using System.Data.Linq.Mapping;
using System.IO;
using System.Reflection;
using System.Runtime.Serialization;
using System.Text;
using System.Xml;
using System.Xml.Schema;
using System.Xml.Serialization;

/// <summary>
/// Summary description for SerializableEntity
/// </summary>
[Serializable]
[XmlSchemaProvider("MySchema")]
public class SerializableEntity<T> : IXmlSerializable, ISerializable where T : class, new()
{
    private const string ns = "http://tempuri.org/";
    private T _entity;

    public SerializableEntity()
    {
    }

    public SerializableEntity(T entity)
    {
        Entity = entity;
    }

    public SerializableEntity(SerializationInfo info, StreamingContext context)
    {
        _entity = new T();
        PropertyInfo[] properties = _entity.GetType().GetProperties();

        SerializationInfoEnumerator enumerator = info.GetEnumerator();

        while (enumerator.MoveNext())
        {
            SerializationEntry se = enumerator.Current;
            foreach (PropertyInfo pi in properties)
            {
                if (pi.Name == se.Name)
                {
                    pi.SetValue(_entity, info.GetValue(se.Name, pi.PropertyType), null);
                }
            }
        }
    }

    public T Entity
    {
        get { return _entity; }
        set { _entity = value; }
    }

    #region ISerializable Members

    public void GetObjectData(SerializationInfo info, StreamingContext context)
    {
        PropertyInfo[] infos = _entity.GetType().GetProperties();

        foreach (PropertyInfo pi in infos)
        {
            bool isAssociation = false;
            foreach (object obj in pi.GetCustomAttributes(true))
            {
                if (obj.GetType() == typeof (AssociationAttribute))
                {
                    isAssociation = true;
                    break;
                }
            }
            if (!isAssociation)
            {
                if (pi.GetValue(_entity, null) != null)
                {
                    info.AddValue(pi.Name, pi.GetValue(_entity, null));
                }
            }
        }
    }

    #endregion

    #region IXmlSerializable Members

    public XmlSchema GetSchema()
    {
        return null;
    }

    // This is the method named by the XmlSchemaProviderAttribute applied to the type.

    public void ReadXml(XmlReader reader)
    {
        _entity = new T();
        PropertyInfo[] pinfos = _entity.GetType().GetProperties();

        if (reader.LocalName == typeof (T).Name)
        {
            reader.MoveToContent();
            string inn = reader.ReadOuterXml();
            StringReader sr = new StringReader(inn);
            XmlTextReader tr = new XmlTextReader(sr);
            tr.Read();
            while (tr.Read())
            {
                string elementName = tr.LocalName;
                string value = tr.ReadString();
                //tr.Read();
                foreach (PropertyInfo pi in pinfos)
                {
                    if (pi.Name == elementName)
                    {
                        TypeConverter tc = TypeDescriptor.GetConverter(pi.PropertyType);
                        pi.SetValue(_entity, tc.ConvertFromString(value), null);
                    }
                }
            }
        }
    }

    public void WriteXml(XmlWriter writer)
    {
        PropertyInfo[] pinfos = _entity.GetType().GetProperties();

        foreach (PropertyInfo pi in pinfos)
        {
            bool isAssociation = false;
            foreach (object obj in pi.GetCustomAttributes(true))
            {
                if (obj.GetType() == typeof (AssociationAttribute))
                {
                    isAssociation = true;
                    break;
                }
            }
            if (!isAssociation)
            {
                if (pi.GetValue(_entity, null) != null)
                {
                    writer.WriteStartElement(pi.Name);
                    writer.WriteValue(pi.GetValue(_entity, null));
                    writer.WriteEndElement();
                }
            }
        }
    }

    #endregion

    public static XmlQualifiedName MySchema(XmlSchemaSet xs)
    {
        // This method is called by the framework to get the schema for this type.
        StringBuilder sb = new StringBuilder();
        StringWriter sw = new StringWriter(sb);
        XmlTextWriter xw = new XmlTextWriter(sw);

        // generate the schema for type T
        xw.WriteStartDocument();
        xw.WriteStartElement("schema");
        xw.WriteAttributeString("targetNamespace", "http://tempuri.org/");
        xw.WriteAttributeString("xmlns", "http://www.w3.org/2001/XMLSchema");
        xw.WriteStartElement("complexType");
        xw.WriteAttributeString("name", typeof (T).Name);
        xw.WriteStartElement("sequence");

        PropertyInfo[] infos = typeof (T).GetProperties();

        foreach (PropertyInfo pi in infos)
        {
            bool isAssociation = false;
            foreach (object a in pi.GetCustomAttributes(true))
            {
                //check whether the property is an Association
                if (a.GetType() == typeof (AssociationAttribute))
                {
                    isAssociation = true;
                    break;
                }
            }
            //only use the property which is not an Association
            if (!isAssociation)
            {
                xw.WriteStartElement("element");
                xw.WriteAttributeString("name", pi.Name);
                if (pi.PropertyType.IsGenericType)
                {
                    Type[] types = pi.PropertyType.GetGenericArguments();
                    xw.WriteAttributeString("type", "" + GetXsdType(types[0].FullName));
                }
                else
                {
                    xw.WriteAttributeString("type", "" + GetXsdType(pi.PropertyType.FullName));
                }
                xw.WriteEndElement();
            }
        }
        xw.WriteEndElement();
        xw.WriteEndElement();
        xw.WriteEndElement();
        xw.WriteEndDocument();
        xw.Close();

        XmlSerializer schemaSerializer = new XmlSerializer(typeof(XmlSchema));
        StringReader sr = new StringReader(sb.ToString());
        XmlSchema s = (XmlSchema)schemaSerializer.Deserialize(sr);
        xs.XmlResolver = new XmlUrlResolver();
        xs.Add(s);

        return new XmlQualifiedName(typeof (T).Name, ns);
    }

    private static string GetXsdType(string nativeType)
    {
        string[] xsdTypes = new[]
                           {
                               "boolean",
                               "unsignedByte",
                               "dateTime",
                               "decimal",
                               "Double",
                               "short",
                               "int",
                               "long",
                               "Byte",
                               "Float",
                               "string",
                               "unsignedShort",
                               "unsignedInt",
                               "unsignedLong",
                               "anyURI"
                           };
        string[] nativeTypes = new[]
                              {
                                  "System.Boolean",
                                  "System.Byte",
                                  "System.DateTime",
                                  "System.Decimal",
                                  "System.Double",
                                  "System.Int16",
                                  "System.Int32",
                                  "System.Int64",
                                  "System.SByte",
                                  "System.Single",
                                  "System.String",
                                  "System.UInt16",
                                  "System.UInt32",
                                  "System.UInt64",
                                  "System.Uri"
                              };

        for (int i = 0; i < nativeTypes.Length; i++)
        {
            if (nativeType == nativeTypes[i])
            {
                return xsdTypes[i];
            }
        }
        return "";
    }
}