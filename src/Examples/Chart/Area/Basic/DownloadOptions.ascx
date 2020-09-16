<%@ Control Language="C#" %>

<ext:FormPanel runat="server" Width="250" BodyPadding="10">
    <FieldDefaults LabelAlign="Top" />
    <Items>
        <ext:ComboBox runat="server" Name="format" FieldLabel="Format">
            <Items>
                <ext:ListItem Text="PNG" Value="png" />
                <ext:ListItem Text="PDF" Value="pdf" />
                <ext:ListItem Text="JPEG" Value="jpeg" />
                <ext:ListItem Text="GIF" Value="gif" />
            </Items>
            <SelectedItems>
                <ext:ListItem Value="png" />
            </SelectedItems>
        </ext:ComboBox>

        <ext:NumberField runat="server" Name="width" FieldLabel="Width" />
        <ext:NumberField runat="server" Name="height" FieldLabel="Height" />
        <ext:TextField runat="server" Name="filename" FieldLabel="Filename" />
        <ext:NumberField runat="server" Name="scale" FieldLabel="Scale" />

        <ext:FieldSet runat="server" Title="PDF">
            <Items>
                <ext:ComboBox runat="server" DataIndex="pdf.format" FieldLabel="Format">
                    <Items>
                        <ext:ListItem Text="A3" />
                        <ext:ListItem Text="A4" />
                        <ext:ListItem Text="A5" />
                        <ext:ListItem Text="Legal" />
                        <ext:ListItem Text="Letter" />
                        <ext:ListItem Text="Tabloid" />
                    </Items>
                </ext:ComboBox>

                <ext:ComboBox runat="server" DataIndex="pdf.orientation" FieldLabel="Orientation">
                    <Items>
                        <ext:ListItem Text="Portrait" Value="portrait" />
                        <ext:ListItem Text="Landscape" Value="landscape" />
                    </Items>
                </ext:ComboBox>

                <ext:TextField runat="server" DataIndex="pdf.border" FieldLabel="Border" />
            </Items>
        </ext:FieldSet>

        <ext:FieldSet runat="server" Title="JPEG">
            <Items>
                <ext:NumberField
                    runat="server"
                    DataIndex="jpeg.quality"
                    FieldLabel="Quality"
                    MinValue="0"
                    MaxValue="100"
                    AllowDecimals="false"
                    />
            </Items>
        </ext:FieldSet>
    </Items>
</ext:FormPanel>