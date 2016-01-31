<%@ Page Title="" Language="C#" MasterPageFile="NoneID.Master" %>

<%@ Register src="Alias.ascx" tagname="Alias" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Body" runat="server">
    <h1>Example</h1>
    
    <uc1:Alias ID="Alias1" runat="server" />
    
    <ext:Button runat="server" Text="UserControl">
        <Listeners>
            <Click Handler="App.direct.UC.HelloUserControl();" />
        </Listeners>
    </ext:Button>
    
    <br />
    
    <ext:Button ID="Button1" runat="server" Text="MasterPage">
        <Listeners>
            <Click Handler="App.direct.HelloMasterPage();" />
        </Listeners>
    </ext:Button>
</asp:Content>
