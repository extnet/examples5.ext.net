<%@ Page Title="MessageBus - Ext.NET Examples" Language="C#" MasterPageFile="~/Examples/MessageBus/Basic/Complex/MasterPage.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ext:Panel runat="server" Title="Container In Content Page">
        <LayoutConfig>
            <ext:VBoxLayoutConfig Align="Stretch" />
        </LayoutConfig>

        <Items>
            <ext:Panel runat="server" PreventHeader="true" Height="200" Layout="FitLayout">
                <MessageBusListeners>
                    <ext:MessageBusListener 
                        Name="FromUserControl.*" 
                        Handler="this.body.createChild({html: 'Name: ' + name, tag:'p'});" 
                        />
                </MessageBusListeners>
            </ext:Panel>

            <ext:Container runat="server" Flex="1" Layout="HBoxLayout">
                <LayoutConfig>
                    <ext:HBoxLayoutConfig Align="Stretch"/>
                </LayoutConfig>
                <Items>
                    <ext:UserControlLoader runat="server" Path="UserControl1.ascx" />
                    <ext:UserControlLoader runat="server" Path="UserControl2.ascx" />
                </Items>
            </ext:Container>            
        </Items>
    </ext:Panel>
</asp:Content>