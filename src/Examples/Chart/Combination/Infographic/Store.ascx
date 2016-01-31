 <%@ Control Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Store1.Data = new List<object> 
        { 
            new {label = "year", span = "100"}, // Corresponds to the sectors of the chart that display a year.

            // Note that most of the records have the span of '100', so that the pie chart sectors that represent them
            // have equal angular span.
            // There are also records with the span of '20' that are represented by the smaller blank sectors
            // that separate one country region from another.

            // The 'label' field stores a short state name that is displayed inside the sectors of the outer ring of the chart.
            // The 'state' field stores a full state name that is displayed by the 'stateName' text sprite
            // on top of the cartesian chart when the user hovers/taps a pie chart sector.

            // Finally, the 'y2007' - 'y2012' fields store the percentage change in unemployment from year to year.
            // These are used to determine the color of the pie chart sectors, and also the color and the length
            // of the cartesian chart bars.

            new {label = "CT", span = "100", y2007 = 0.2,  y2008 = 1.0, y2009 = 2.6, y2010 = 1.1,  y2011 = -0.4, y2012 = -0.6, state = "Connecticut"},
            new {label = "DE", span = "100", y2007 = 0.0,  y2008 = 1.4, y2009 = 3.0, y2010 = 0.1,  y2011 = -0.6, y2012 = -0.3, state = "Delaware"},
            new {label = "ME", span = "100", y2007 = 0.0,  y2008 = 0.7, y2009 = 2.7, y2010 = 0.1,  y2011 = -0.5, y2012 = -0.5, state = "Maine"},
            new {label = "MD", span = "100", y2007 = -0.4, y2008 = 0.9, y2009 = 3.1, y2010 = 0.5,  y2011 = -0.6, y2012 = -0.4, state = "Maryland"},
            new {label = "MA", span = "100", y2007 = -0.3, y2008 = 0.8, y2009 = 2.9, y2010 = 0.1,  y2011 = -1.0, y2012 = -0.5, state = "Massachusetts"},
            new {label = "NH", span = "100", y2007 = 0.0,  y2008 = 0.4, y2009 = 2.3, y2010 = 0.0,  y2011 = -0.7, y2012 = 0.0,  state = "New Hampshire"},
            new {label = "NJ", span = "100", y2007 = -0.3, y2008 = 1.2, y2009 = 3.5, y2010 = 0.6,  y2011 = -0.3, y2012 = 0.0,  state = "New Jersey"},
            new {label = "NY", span = "100", y2007 = 0.0,  y2008 = 0.8, y2009 = 2.9, y2010 = 0.3,  y2011 = -0.4, y2012 = 0.3,  state = "New York"},
            new {label = "PA", span = "100", y2007 = -0.1, y2008 = 0.9, y2009 = 2.6, y2010 = 0.6,  y2011 = -0.5, y2012 = -0.1, state = "Pennsylvania"},
            new {label = "RI", span = "100", y2007 = 0.1,  y2008 = 2.5, y2009 = 3.2, y2010 = 0.8,  y2011 = -0.5, y2012 = -0.9, state = "Rhode Island"},
            new {label = "VT", span = "100", y2007 = 0.2,  y2008 = 0.6, y2009 = 2.4, y2010 = -0.5, y2011 = -0.8, y2012 = -0.7, state = "Vermont"},
            
            new {label = "", span = "20"}, // Corresponds to the empty sectors that divide the chart into regions.
            
            new {label = "AL", span = "100", y2007 = -0.1, y2008 = 1.6, y2009 = 4.7, y2010 = -0.5, y2011 = -0.7, y2012 = -1.4, state = "Alabama"},
            new {label = "DC", span = "100", y2007 = -0.2, y2008 = 1.1, y2009 = 3.1, y2010 = 0.4,  y2011 = 0.1,  y2012 = -1.1, state = "District of Columbia"},
            new {label = "FL", span = "100", y2007 = 0.7,  y2008 = 2.3, y2009 = 4.1, y2010 = 0.9,  y2011 = -1.0, y2012 = -1.5, state = "Florida"},
            new {label = "GA", span = "100", y2007 = -0.1, y2008 = 1.7, y2009 = 3.4, y2010 = 0.5,  y2011 = -0.3, y2012 = -0.9, state = "Georgia"},
            new {label = "LA", span = "100", y2007 = -0.1, y2008 = 0.6, y2009 = 2.2, y2010 = 0.8,  y2011 = -0.2, y2012 = -0.7, state = "Louisiana"},
            new {label = "MS", span = "100", y2007 = -0.5, y2008 = 0.5, y2009 = 2.7, y2010 = 1.1,  y2011 = 0.0,  y2012 = -0.9, state = "Mississippi"},
            new {label = "NC", span = "100", y2007 = 0.0,  y2008 = 1.5, y2009 = 4.1, y2010 = 0.4,  y2011 = -0.6, y2012 = -1.0, state = "North Carolina"},
            new {label = "SC", span = "100", y2007 = -0.8, y2008 = 1.2, y2009 = 4.6, y2010 = -0.3, y2011 = -0.8, y2012 = -1.3, state = "South Carolina"},
            new {label = "TN", span = "100", y2007 = -0.4, y2008 = 1.8, y2009 = 4.0, y2010 = -0.7, y2011 = -0.6, y2012 = -1.1, state = "Tennessee"},
            new {label = "VA", span = "100", y2007 = 0.1,  y2008 = 0.9, y2009 = 3.0, y2010 = 0.1,  y2011 = -0.7, y2012 = -0.5, state = "Virginia"},
            
            new {label = "", span = "20"},
            
            new {label = "WI", span = "100", y2007 = 0.1,  y2008 = 0.0, y2009 = 3.9, y2010 = -0.2, y2011 = -1.0, y2012 = -0.6, state = "Wisconsin"},
            new {label = "WV", span = "100", y2007 = -0.3, y2008 = 0.0, y2009 = 3.4, y2010 = 0.9,  y2011 = -0.7, y2012 = -0.6, state = "West Virginia"},
            new {label = "SD", span = "100", y2007 = -0.2, y2008 = 0.1, y2009 = 2.2, y2010 = -0.1, y2011 = -0.4, y2012 = -0.5, state = "South Dakota"},
            new {label = "OH", span = "100", y2007 = 0.2,  y2008 = 1.0, y2009 = 3.6, y2010 = -0.2, y2011 = -1.3, y2012 = -1.3, state = "Ohio"},
            new {label = "ND", span = "100", y2007 = -0.1, y2008 = 0.0, y2009 = 1.0, y2010 = -0.3, y2011 = -0.4, y2012 = -0.4, state = "North Dakota"},
            new {label = "NE", span = "100", y2007 = 0.0,  y2008 = 0.3, y2009 = 1.4, y2010 = 0.0,  y2011 = -0.2, y2012 = -0.5, state = "Nebraska"},
            new {label = "MO", span = "100", y2007 = 0.2,  y2008 = 0.9, y2009 = 3.5, y2010 = -0.1, y2011 = -0.8, y2012 = -1.5, state = "Missouri"},
            new {label = "MN", span = "100", y2007 = 0.6,  y2008 = 0.7, y2009 = 2.6, y2010 = -0.6, y2011 = -0.9, y2012 = -0.9, state = "Minnesota"},
            new {label = "MI", span = "100", y2007 = 0.2,  y2008 = 1.2, y2009 = 5.2, y2010 = -0.8, y2011 = -2.3, y2012 = -1.3, state = "Michigan"},
            new {label = "KY", span = "100", y2007 = -0.3, y2008 = 1.0, y2009 = 3.7, y2010 = -0.1, y2011 = -0.7, y2012 = -1.2, state = "Kentucky"},
            new {label = "KS", span = "100", y2007 = -0.3, y2008 = 0.3, y2009 = 2.7, y2010 = 0.0,  y2011 = -0.6, y2012 = -0.7, state = "Kansas"},
            new {label = "IA", span = "100", y2007 = 0.1,  y2008 = 0.2, y2009 = 2.3, y2010 = 0.0,  y2011 = -0.5, y2012 = -0.6, state = "Iowa"},
            new {label = "IN", span = "100", y2007 = -0.4, y2008 = 1.2, y2009 = 4.5, y2010 = -0.3, y2011 = -1.2, y2012 = -0.7, state = "Indiana"},
            new {label = "IL", span = "100", y2007 = 0.5,  y2008 = 1.3, y2009 = 3.6, y2010 = 0.5,  y2011 = -0.8, y2012 = -0.8, state = "Illinois"},
            new {label = "AR", span = "100", y2007 = 0.0,  y2008 = 0.1, y2009 = 2.1, y2010 = 0.4,  y2011 = 0.1,  y2012 = -0.5, state = "Arkansas"},
            
            new {label = "", span = "20"},
            
            new {label = "AZ", span = "100", y2007 = -0.4, y2008 = 2.3,  y2009 = 3.8, y2010 = 0.6,  y2011 = -1.0, y2012 = -1.1, state = "Arizona"},
            new {label = "CA", span = "100", y2007 = 0.5,  y2008 = 1.8,  y2009 = 4.1, y2010 = 1.1,  y2011 = -0.6, y2012 = -1.4, state = "California"},
            new {label = "CO", span = "100", y2007 = -0.5, y2008 = 1.0,  y2009 = 3.3, y2010 = 0.9,  y2011 = -0.5, y2012 = -0.7, state = "Colorado"},
            new {label = "HI", span = "100", y2007 = 0.2,  y2008 = 1.4,  y2009 = 2.7, y2010 = -0.1, y2011 = -0.2, y2012 = -0.8, state = "Hawaii"},
            new {label = "NV", span = "100", y2007 = 0.5,  y2008 = 2.4,  y2009 = 4.6, y2010 = 2.1,  y2011 = -0.6, y2012 = -1.7, state = "Nevada"},
            new {label = "NM", span = "100", y2007 = -0.6, y2008 = 1.0,  y2009 = 2.4, y2010 = 1.1,  y2011 = -0.4, y2012 = -0.5, state = "New Mexico"},
            new {label = "OK", span = "100", y2007 = 0.0,  y2008 = -0.4, y2009 = 3.0, y2010 = 0.2,  y2011 = -1.0, y2012 = -0.5, state = "Oklahoma"},
            new {label = "TX", span = "100", y2007 = -0.5, y2008 = 0.5,  y2009 = 2.6, y2010 = 0.7,  y2011 = -0.3, y2012 = -1.1, state = "Texas"},
            new {label = "UT", span = "100", y2007 = -0.3, y2008 = 0.7,  y2009 = 4.5, y2010 = 0.3,  y2011 = -1.3, y2012 = -1.4, state = "Utah"},
            
            new {label = "", span = "20"},
            
            new {label = "AK", span = "100", y2007 = -0.4, y2008 = 0.3, y2009 = 1.3, y2010 = 0.3,  y2011 = -0.4, y2012 = -0.7, state = "Alaska"},
            new {label = "ID", span = "100", y2007 = 0.0,  y2008 = 1.8, y2009 = 2.6, y2010 = 1.3,  y2011 = -0.3, y2012 = -1.1, state = "Idaho"},
            new {label = "MT", span = "100", y2007 = 0.2,  y2008 = 1.1, y2009 = 1.5, y2010 = 0.7,  y2011 = -0.2, y2012 = -0.5, state = "Montana"},
            new {label = "OR", span = "100", y2007 = -0.1, y2008 = 1.3, y2009 = 4.6, y2010 = -0.3, y2011 = -1.1, y2012 = -0.9, state = "Oregon"},
            new {label = "WA", span = "100", y2007 = -0.3, y2008 = 0.8, y2009 = 3.9, y2010 = 0.6,  y2011 = -0.7, y2012 = -1.1, state = "Washington"},
            new {label = "WY", span = "100", y2007 = -0.4, y2008 = 0.3, y2009 = 3.2, y2010 = 0.7,  y2011 = -0.9, y2012 = -0.7, state = "Wyoming"}
        };
    }
</script>

<ext:Store ID="Store1" runat="server" IDMode="Static">
    <Model>
        <ext:Model runat="server">
            <Fields>
                <ext:ModelField Name="label" />
                <ext:ModelField Name="span" />
                <ext:ModelField Name="y2007" />
                <ext:ModelField Name="y2008" />
                <ext:ModelField Name="y2009" />
                <ext:ModelField Name="y2010" />
                <ext:ModelField Name="y2011" />
                <ext:ModelField Name="y2012" />
                <ext:ModelField Name="state" />
            </Fields>
        </ext:Model>
    </Model>
</ext:Store>