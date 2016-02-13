using Newtonsoft.Json;
using System.ComponentModel;
using System.Web.UI;
using System.Xml.Serialization;

namespace Ext.Net.Examples
{
    [Meta]
    public partial class ArcTextSprite : AbstractSprite
    {
        public ArcTextSprite()
        {
        }

        [ConfigOption]
        [DefaultValue("")]
        public override string Type
        {
            get
            {
                return "arctext";
            }
        }

        /// <summary>
        ///
        /// </summary>
        [Meta]
        [ConfigOption]
        [DefaultValue(null)]
        public virtual string Text
        {
            get
            {
                return this.State.Get<string>("Text", null);
            }
            set
            {
                this.State.Set("Text", value);
            }
        }

        /// <summary>
        ///
        /// </summary>
        [Meta]
        [ConfigOption]
        [DefaultValue(null)]
        public virtual int? CenterX
        {
            get
            {
                return this.State.Get<int?>("CenterX", null);
            }
            set
            {
                this.State.Set("CenterX", value);
            }
        }

        /// <summary>
        ///
        /// </summary>
        [Meta]
        [ConfigOption]
        [DefaultValue(null)]
        public virtual int? CenterY
        {
            get
            {
                return this.State.Get<int?>("CenterY", null);
            }
            set
            {
                this.State.Set("CenterY", value);
            }
        }

        /// <summary>
        ///
        /// </summary>
        [Meta]
        [ConfigOption]
        [DefaultValue(null)]
        public virtual double? Radius
        {
            get
            {
                return this.State.Get<double?>("Radius", null);
            }
            set
            {
                this.State.Set("Radius", value);
            }
        }

        /// <summary>
        ///
        /// </summary>
        [Meta]
        [ConfigOption]
        [DefaultValue(null)]
        public virtual double? Angle
        {
            get
            {
                return this.State.Get<double?>("Angle", null);
            }
            set
            {
                this.State.Set("Angle", value);
            }
        }

        /// <summary>
        /// The minimum value of the axis data.
        /// </summary>
        [Meta]
        [ConfigOption]
        [DefaultValue(false)]
        public virtual int? Spacing
        {
            get
            {
                return this.State.Get<int?>("Spacing", null);
            }
            set
            {
                this.State.Set("Spacing", null);
            }
        }

        /// <summary>
        ///
        /// </summary>
        [Meta]
        [ConfigOption]
        [DefaultValue(TextSpriteAlign.Center)]
        public virtual TextSpriteAlign TextAlign
        {
            get
            {
                return this.State.Get<TextSpriteAlign>("TextAlign", TextSpriteAlign.Center);
            }
            set
            {
                this.State.Set("TextAlign", value);
            }
        }

        private Sprite template;

        /// <summary>
        ///
        /// </summary>
        [Meta]
        [ConfigOption(JsonMode.Object)]
        [DefaultValue(null)]
        [PersistenceMode(PersistenceMode.InnerProperty)]
        public Sprite Template
        {
            get
            {
                return this.template;
            }
            set
            {
                this.template = value;
            }
        }

        /// <summary>
        ///
        /// </summary>
        [Browsable(false)]
        [EditorBrowsable(EditorBrowsableState.Never)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        [XmlIgnore]
        [JsonIgnore]
        public override ConfigOptionsCollection ConfigOptions
        {
            get
            {
                ConfigOptionsCollection list = base.ConfigOptions;

                list.Add("text", new ConfigOption("text", null, null, this.Text));
                list.Add("centerX", new ConfigOption("centerX", null, null, this.CenterX));
                list.Add("centerY", new ConfigOption("centerY", null, null, this.CenterY));
                list.Add("radius", new ConfigOption("radius", null, null, this.Radius));
                list.Add("angle", new ConfigOption("angle", null, null, this.Angle));
                list.Add("spacing", new ConfigOption("spacing", null, false, this.Spacing));
                list.Add("textAlign", new ConfigOption("textAlign", null, TextSpriteAlign.Center, this.TextAlign));
                list.Add("template", new ConfigOption("template", new SerializationOptions(JsonMode.Object), null, this.Template));

                return list;
            }
        }
    }
}