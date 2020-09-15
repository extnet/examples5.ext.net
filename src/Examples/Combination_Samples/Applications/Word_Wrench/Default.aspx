<%@ Page Language="C#" ValidateRequest="false" %>

<%@ Import Namespace="Ext.Net.Utilities" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>

<script runat="server">
    [DirectMethod]
    public void UpdateData()
    {
        string pattern = this.BuildRegexPattern();

        this.txtPattern.Text = pattern;

        MatchCollection matches;

        try
        {
            matches = Regex.Matches(this.TextArea1.Text, pattern, RegexOptions.IgnoreCase);
        }
        catch
        {
            return;
        }

        List<Word> words = new List<Word>();

        string word = "";

        foreach (Match match in matches)
        {
            word = this.chkIgnoreCase.Checked ? match.Value.Trim().ToLower() : match.Value.Trim();

            if (word.IsEmpty())
            {
                continue;
            }

            if (words.Contains(new Word { Text = word }))
            {
                words.Find(item => item.Text == word).Increment();
            }
            else
            {
                words.Add(new Word { Text = word, Count = 1 });
            }
        }

        // Order the List Alphabetically
        IOrderedEnumerable<Word> sortedByAlpha = words.OrderBy(item => item.Text);

        // Order the List by Text Count
        IOrderedEnumerable<Word> sortedByCount = sortedByAlpha.OrderByDescending(item => item.Count);

        int max = Convert.ToInt32(this.intRecordLimit.Number);

        this.Store1.Data = sortedByCount.Take(max > 0 ? max : 99);
        this.Store1.DataBind();
    }

    private string BuildRegexPattern()
    {
        string pattern = @"\b{0}{1}{2}{3}{4}{5}{6}\b"; // @"\b(?!and|not)(?![0-9])[a-z0-9]{3,}\b";

        string exclusionWords = Regex.Matches(this.txtExclusionWords.Text.Trim(), @"\b[a-zA-Z0-9]+\b").Join("|");

        int maxMinTotalLength = this.txtPrefixPattern.Text.Trim().Length + this.txtSuffixPattern.Text.Length;

        string exclusionWordsPattern = exclusionWords.Length > 0 ? "(?!" + exclusionWords + ")" : ""; //0
        string allowIntegersPrefixPattern = chkAllowIntegerPrefix.Checked ? "" : @"(?![0-9])"; //1
        string prefixPattern = string.Format("{0}", this.txtPrefixPattern.Text.Length > 0 ? "(" + this.txtPrefixPattern.Text + ")" : ""); //2
        string alphaCharPattern = @"[" + this.txtWordPattern.Text; //3
        string allowIntegersPattern = this.chkAllowIntegers.Checked ? "0-9]" : "]"; //4
        string maxMinWordLengthPattern = string.Format("{{{0},{1}}}", this.intMinWordLength.Number - maxMinTotalLength, intMaxWordLength.Number - maxMinTotalLength); //5
        string suffixPattern = string.Format("{0}", this.txtSuffixPattern.Text.Length > 0 ? "(" + this.txtSuffixPattern.Text + ")" : ""); //6

        return string.Format(pattern, exclusionWordsPattern, allowIntegersPrefixPattern, prefixPattern, alphaCharPattern, allowIntegersPattern, maxMinWordLengthPattern, suffixPattern);
    }

    public class Word : IEquatable<Word>
    {
        public string Text { get; set; }

        private int count = 0;

        public int Count
        {
            get
            {
                return this.count;
            }
            set
            {
                this.count = value;
            }
        }

        public void Increment()
        {
            this.Count++;
        }

        public bool Equals(Word other)
        {
            return this.Text == other.Text;
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Text Wrench - Ext.NET Examples</title>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server">
            <Listeners>
                <DocumentReady Handler="
                    var fields = Ext.ComponentQuery.query('field[autoUpdateData=true], button[autoUpdateData=true]'),
                        i = 0;

                    for (; i &lt; fields.length; i += 1) {
                        fields[i].on('change', function (item) {
                            App.direct.UpdateData();
                        }, fields[i], { buffer : 500 });
                    }" />
            </Listeners>
        </ext:ResourceManager>

        <ext:Viewport runat="server" Layout="Border">
            <Items>
                <ext:FormPanel runat="server" Region="Center" Layout="HBox">
                    <LayoutConfig>
                        <ext:HBoxLayoutConfig Align="Stretch" />
                    </LayoutConfig>
                    <Items>
                        <ext:Panel
                            runat="server"
                            Title="Word Wrench"
                            Rounded="false"
                            IconCls="x-md md-icon-build"
                            Flex="8"
                            Layout="Fit"
                            BodyPadding="18">
                            <TopBar>
                                <ext:Toolbar runat="server">
                                    <Items>
                                        <ext:Button runat="server" Text="Clear" IconCls="x-md md-icon-clear">
                                            <Listeners>
                                                <Click Handler="App.TextArea1.clear()" />
                                            </Listeners>
                                        </ext:Button>
                                    </Items>
                                </ext:Toolbar>
                            </TopBar>
                            <Items>
                                <ext:TextArea
                                    ID="TextArea1"
                                    runat="server"
                                    EmptyText="[Paste Text Here] and Text Wrench will find words."
                                    AutoUpdateData="true"
                                    />
                            </Items>
                        </ext:Panel>
                        <ext:FormPanel
                            ID="frmSettings"
                            runat="server"
                            Title="Settings"
                            Rounded="false"
                            Flex="4"
                            IconCls="x-md md-icon-settings"
                            BodyPadding="18"
                            DefaultAnchor="100%"
                            Layout="VBox">
                            <LayoutConfig>
                                <ext:VBoxLayoutConfig Align="Stretch" />
                            </LayoutConfig>
                            <TopBar>
                                <ext:Toolbar runat="server">
                                    <Items>
                                        <ext:ToolbarFill runat="server" />
                                        <ext:Button
                                            ID="btnForm"
                                            runat="server"
                                            Text="Reset"
                                            IconCls="x-md md-icon-undo"
                                            OnClientClick="App.btnForm.up('form').reset();"
                                            />
                                    </Items>
                                </ext:Toolbar>
                            </TopBar>
                            <Items>
                                <ext:Container runat="server" Flex="1" Layout="HBox">
                                    <LayoutConfig>
                                        <ext:HBoxLayoutConfig Align="Stretch" />
                                    </LayoutConfig>
                                    <Items>
                                        <ext:Container
                                            runat="server"
                                            Flex="1"
                                            Layout="Anchor"
                                            DefaultAnchor="100%"
                                            DefaultLabelWidth="85">
                                            <Items>
                                                <ext:TextField
                                                    ID="txtWordPattern"
                                                    runat="server"
                                                    FieldLabel="Text Pattern"
                                                    Text="a-zA-Z"
                                                    AllowBlank="false"
                                                    AutoUpdateData="true"
                                                    />
                                                <ext:NumberField
                                                    ID="intRecordLimit"
                                                    runat="server"
                                                    FieldLabel="Unique Words"
                                                    Number="20"
                                                    MinValue="1"
                                                    MaxValue="999"
                                                    AllowDecimals="false"
                                                    AutoUpdateData="true"
                                                    />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container
                                            runat="server"
                                            Flex="1"
                                            Layout="Anchor"
                                            DefaultAnchor="100%"
                                            DefaultLabelAlign="right"
                                            DefaultLabelWidth="85">
                                            <Items>
                                                <ext:TextField
                                                    ID="txtPrefixPattern"
                                                    runat="server"
                                                    FieldLabel="Prefix"
                                                    AutoUpdateData="true"
                                                    />
                                                <ext:TextField
                                                    ID="txtSuffixPattern"
                                                    runat="server"
                                                    FieldLabel="Suffix"
                                                    AutoUpdateData="true"
                                                    />
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:Container>
                                <ext:FieldContainer
                                    runat="server"
                                    FieldLabel="Text Length"
                                    Layout="HBox"
                                    LabelWidth="85"
                                    Anchor="100%">
                                    <Defaults>
                                        <ext:Parameter Name="margin" Value="0 5 0 0" Mode="Value" />
                                    </Defaults>
                                    <Items>
                                        <ext:NumberField
                                            ID="intMinWordLength"
                                            runat="server"
                                            Width="80"
                                            Number="3"
                                            MinValue="1"
                                            MaxValue="99"
                                            AllowDecimals="false"
                                            AllowBlank="false"
                                            AutoUpdateData="true"
                                            />
                                        <ext:DisplayField runat="server" Text="Min" Width="60" />
                                        <ext:NumberField
                                            ID="intMaxWordLength"
                                            runat="server"
                                            Width="80"
                                            Number="20"
                                            MinValue="1"
                                            MaxValue="99"
                                            AllowDecimals="false"
                                            AllowBlank="false"
                                            AutoUpdateData="true"
                                            />
                                        <ext:DisplayField runat="server" Text="Max" Width="60" />
                                    </Items>
                                </ext:FieldContainer>
                                <ext:Container runat="server" Layout="HBox">
                                    <Items>
                                        <ext:Checkbox
                                            ID="chkAllowIntegerPrefix"
                                            runat="server"
                                            BoxLabel="Allow Integer Prefix"
                                            AutoUpdateData="true"
                                            Flex="1"
                                            />
                                        <ext:Checkbox
                                            ID="chkAllowIntegers"
                                            runat="server"
                                            Checked="true"
                                            BoxLabel="Allow Integers"
                                            AutoUpdateData="true"
                                            Flex="1"
                                            />
                                        <ext:Checkbox
                                            ID="chkIgnoreCase"
                                            runat="server"
                                            Checked="true"
                                            BoxLabel="Ignore Case"
                                            AutoUpdateData="true"
                                            Flex="1"
                                            />
                                    </Items>
                                </ext:Container>
                                <ext:TextArea
                                    ID="txtExclusionWords"
                                    runat="server"
                                    Flex="1"
                                    FieldLabel="Exclusion Words"
                                    LabelAlign="Top"
                                    Text="and the were with was are for that this"
                                    AutoUpdateData="true"
                                    />
                                <ext:TextArea
                                    ID="txtPattern"
                                    runat="server"
                                    Flex="1"
                                    FieldLabel="Regex Pattern (Auto Generated)"
                                    LabelAlign="Top"
                                    ReadOnly="true"
                                    />
                            </Items>
                        </ext:FormPanel>
                    </Items>
                </ext:FormPanel>
                <ext:Container
                    ID="Container1"
                    runat="server"
                    Region="South"
                    Height="480"
                    Layout="HBox">
                    <LayoutConfig>
                        <ext:HBoxLayoutConfig Align="Stretch" />
                    </LayoutConfig>
                    <Bin>
                        <ext:Store ID="Store1" runat="server" AutoLoad="true" SortOnLoad="true">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Text" />
                                        <ext:ModelField Name="Count" Type="Int" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                            <Sorters>
                                <ext:DataSorter Property="Count" Direction="DESC" />
                            </Sorters>
                            <Listeners>
                                <DataChanged Handler="if (App.GridPanel1) { App.GridPanel1.setTitle('Words (' + this.getCount() + ' unique)'); }" />
                            </Listeners>
                        </ext:Store>
                    </Bin>
                    <Items>
                        <ext:CartesianChart
                            ID="Chart1"
                            runat="server"
                            Shadow="true"
                            Flex="8"
                            StoreID="Store1">
                            <Axes>
                                <ext:NumericAxis
                                    Position="Left"
                                    Fields="Count"
                                    Grid="true"
                                    Title="Count"
                                    Minimum="0"
                                    MajorTickSteps="1"
                                    />
                                <ext:CategoryAxis
                                    Position="Bottom"
                                    Fields="Text">
                                    <Label RotationDegrees="315" />
                                </ext:CategoryAxis>
                            </Axes>
                            <Series>
                                <ext:BarSeries
                                    Highlight="true"
                                    XField="Text"
                                    YField="Count">
                                    <Tooltip
                                        runat="server"
                                        TrackMouse="true"
                                        Width="140"
                                        Height="28">
                                        <Renderer Handler="toolTip.setTitle(record.get('Text') + ' (' + record.get('Count') + ')');" />
                                    </Tooltip>
                                    <Label
                                        Display="InsideEnd"
                                        Field="Count"
                                        Orientation="Horizontal"
                                        Color="#333"
                                        TextAlign="Center"
                                        />
                                </ext:BarSeries>
                            </Series>
                        </ext:CartesianChart>
                        <ext:GridPanel
                            ID="GridPanel1"
                            runat="server"
                            Title="Words"
                            Rounded="false"
                            Flex="2"
                            StoreID="Store1">
                            <ColumnModel>
                                <Columns>
                                    <ext:Column runat="server" Text="Text" DataIndex="Text" Flex="1" />
                                    <ext:Column runat="server" Text="Count" DataIndex="Count" />
                                </Columns>
                            </ColumnModel>
                        </ext:GridPanel>
                        <ext:Panel
                            runat="server"
                            Title="Raw Data"
                            Rounded="false"
                            Layout="Fit"
                            BodyPadding="18"
                            Flex="2">
                            <TopBar>
                                <ext:Toolbar runat="server">
                                    <Items>
                                        <ext:Checkbox
                                            ID="Checkbox1"
                                            runat="server"
                                            BoxLabel="Include Count"
                                            Checked="true">
                                            <Listeners>
                                                <Change Handler="App.DataView1.refresh();" />
                                            </Listeners>
                                        </ext:Checkbox>
                                    </Items>
                                </ext:Toolbar>
                            </TopBar>
                            <Items>
                                <ext:DataView
                                    ID="DataView1"
                                    runat="server"
                                    StoreID="Store1"
                                    Scrollable="Both"
                                    Flex="1"
                                    ItemSelector="div">
                                    <Tpl runat="server">
                                        <Html>
                                            <tpl for=".">
                                                <tpl if="App.Checkbox1.getValue()">
                                                    <div>{Text} ({Count})</div>
                                                </tpl>
                                                <tpl if="!App.Checkbox1.getValue()">
                                                    <div>{Text}</div>
                                                </tpl>

                                            </tpl>
                                        </Html>
                                    </Tpl>
                                </ext:DataView>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Container>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
