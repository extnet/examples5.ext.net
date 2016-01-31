<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EventsViewer.ascx.cs" Inherits="Ext.Net.Calendar.Demo.EventsViewer" %>

<ext:Window 
    ID="Window1" 
    runat="server"
    Title="Events"
    Modal="true"
    BodyStyle="background:#fff;"
    CloseAction="Destroy"
    Width="600"
    Height="400"
    Layout="Fit">
    <Items>
        <ext:DataView 
            ID="DataView1" 
            runat="server" 
            ItemSelector="div.event" 
            AutoScroll="true">
            <Store>
                <ext:Store ID="SubmittedEventsStore1" runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="EventId" />
                                <ext:ModelField Name="CalendarId" />
                                <ext:ModelField Name="Title" />
                                <ext:ModelField Name="StartDate" Type="Date" />
                                <ext:ModelField Name="EndDate" Type="Date" />
                                <ext:ModelField Name="Location" />
                                <ext:ModelField Name="Notes" />
                                <ext:ModelField Name="Url" />
                                <ext:ModelField Name="IsAllDay" />
                                <ext:ModelField Name="Reminder" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>            
            <Tpl runat="server">
                <Html>
                    <tpl for=".">
                        <div class="event">
                            <table>
                                <caption>{Title} ({CalendarId}-{EventId})</caption>
                                <tr>
                                    <th>Start Date</th>
                                    <td>{StartDate:date("Y-m-d H:i:s")}</td>
                                </tr>
                                <tr>
                                    <th>End Date</th>
                                    <td>{EndDate:date("Y-m-d H:i:s")}</td>
                                </tr>
                                <tr>
                                    <th>Location</th>
                                    <td>{Location}</td>
                                </tr>
                                <tr>
                                    <th>Notes</th>
                                    <td>{Notes}</td>
                                </tr>
                                <tr>
                                    <th>Url</th>
                                    <td>{Url}</td>
                                </tr>
                                <tr>
                                    <th>IsAllDay</th>
                                    <td>{IsAllDay}</td>
                                </tr>
                                <tr>
                                    <th>Reminder</th>
                                    <td>{Reminder}</td>
                                </tr>                                
                            </table>
                        </div>
                    </tpl>
                </html>            </Tpl>
        </ext:DataView>
    </Items>
</ext:Window>
