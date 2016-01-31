<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    protected void ApplyClick(object sender, DirectEventArgs e)
    {
        XTemplate tpl = new XTemplate { ID = "Template1" };
        
        tpl.Html = @"<p>Name: {Name}</p>
                   <p>Company: {Company}</p>
                   <p>Location: {City}, {State}</p>
                   <p>Kids:
                       <tpl if=""Name=='George Baker'"">
                           <tpl for=""Kids"">
                               <tpl if=""Age &gt; 1""><p>{#}. {parent.Name}'s kid - {Name}</p>
                           </tpl>
                       </tpl>
                   </tpl></p>";

        tpl.Overwrite(this.Panel1, new {
            Name = "George Baker",
            Company = "Ext JS, LLC",
            Address = "4 Red Bulls Drive",
            City = "Cleveland",
            State = "Ohio",
            Zip = "44102",
            Kids = new object[] {
                new { Name = "Sara Grace", Age = 3 },
                new { Name = "Zachary", Age = 2 },
                new { Name = "John James", Age = 0 }              
            }
        });
        
        tpl.Render();

        this.Panel1.UpdateLayout();
    }
</script>

<!DOCTYPE html>
   
<html>
<head runat="server">
    <title>Dynamic Template - Ext.NET Examples</title>    
    <link href="/resources/css/examples.css" rel="stylesheet" />    
    
    <style>
        .x-panel {
            margin : 15px;
        }
        
        .x-panel-body p {
            margin    : 5px;
            font-size : 11px;
            padding   : 0px;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Panel 
            ID="Panel1" 
            runat="server"
            Title="Panel"
            Width="300"
            BodyPadding="10"
            Html="<p><i>Apply the template to see results here</i></p>">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" Text="Apply Template">
                            <DirectEvents>
                                <Click OnEvent="ApplyClick">
                                    <EventMask ShowMask="true" CustomTarget="={#{Panel1}.body}" />
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:Panel>
    </form>
</body>
</html>
