<%@ Page Language="C#" %>

<script runat="server">
    [DirectMethod]
    public static void ShowTerms()
    {
        Window w = new Window
        {
            Title = "Terms of Use",
            Modal = true,
            Width = 700,
            Height = 400,
            BodyStyle = "padding: 10px 20px;",
            AutoScroll = true,
            CloseAction = Ext.Net.CloseAction.Destroy,
            Buttons = 
            {
                new Ext.Net.Button
                {
                    Text = "Decline",
                    Handler = "function () { this.up('window').close(); Ext.ComponentQuery.query('[name=acceptTerms]')[0].setValue(false); }"
                },
                
                new Ext.Net.Button
                {
                    Text = "Accept",
                    Handler = "function () { this.up('window').close(); Ext.ComponentQuery.query('[name=acceptTerms]')[0].setValue(true); }"
                }
            }            
        };

        w.ContentControls.Add(new UserControlLoader { Path = "LicenseTerms.ascx" });

        w.Render();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Registration Form - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />       

     <style>
        /* Styling of global error indicator */
        .form-error-state {
            font-size: 11px;
            padding-left: 20px;
            height: 16px;
            line-height: 18px;
            background: no-repeat 0 0;
            cursor: default;
        }
        .form-error-state-invalid {
            color: #C30;
            background-image: url(../../../../icons/exclamation-png/ext.axd);            
        }
        .form-error-state-valid {
            color: #090;
            background-image: url(../../../../icons/accept-png/ext.axd);
        }

        /* Error details tooltip */
        .errors-tip .error {
            font-style: italic;
        }
    </style>

    <script>
        function updateErrorState (form) {
            var me = form,
                errorCmp, fields, errors;

            if (me.hasBeenDirty || me.getForm().isDirty()) { //prevents showing global error when form first loads
                errorCmp = me.down('#formErrorState');
                fields = me.getForm().getFields();
                errors = [];
                fields.each(function (field) {
                    Ext.Array.forEach(field.getErrors(), function (error) {
                        errors.push({name: field.getFieldLabel(), error: error});
                    });
                });
                setErrors(errorCmp, errors);
                me.hasBeenDirty = true;
            }
        }

        function boxLabelClick (e) {
            var target = e.getTarget('.terms'),
                win;
                        
            e.preventDefault();
                        
            if (target) {
                App.direct.ShowTerms();
            }
        }

        function setErrors (cmp, errors) {
            var me = cmp,
                baseCls = me.baseCls,
                tip = me.tooltips[0];

            errors = Ext.Array.from(errors);                       

            // Update CSS class and tooltip content
            if (errors.length) {
                me.addCls(baseCls + '-invalid');
                me.removeCls(baseCls + '-valid');
                me.update("Form has errors");
                tip.setDisabled(false);
                if (!tip.rendered) {
                    tip.show();
                }
                tip.update(me.bin[0].apply(errors));
            } else {
                me.addCls(baseCls + '-valid');
                me.removeCls(baseCls + '-invalid');
                me.update("Form is valid");
                tip.setDisabled(true);
                tip.hide();
            }            
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Registration Form</h1>

        <p>This example shows a common site registration form. The form appears simple but it shows a few special things: </p>
        <ul class="feature-list">
            <li>The display of field errors has been customized. Fields have <code>msgTarget:'none'</code> so
                the errors are not displayed with the individual fields; instead event listeners are attached
                to the FormPanel to group up all error messages into a custom global error indicator, with a
                persistent tooltip showing the error details.</li>
            <li>The "Terms of Use" link has an event handler attached so it opens the page in a modal Ext window.</li>
            <li>The password fields have custom validation attached to verify the user enters the same value in both.</li>
            <li>The submit button has <code>formBind:true</code> so it is only enabled when the form becomes valid.</li>
        </ul>

        <br />

        <ext:FormPanel 
            ID="FormPanel1"
            runat="server"
            Frame="true"
            Width="350"
            BodyPadding="10"
            BodyBorder="1"
            Title="Account Registration"
            DefaultAnchor="100%">
            
            <FieldDefaults LabelAlign="Left" MsgTarget="None" InvalidCls="" />

            <Listeners>
                <FieldValidityChange Fn="updateErrorState" />
                <FieldErrorChange Fn="updateErrorState" />
            </Listeners>

            <Items>
                <ext:TextField 
                    runat="server" 
                    Name="username" 
                    FieldLabel="User Name"
                    AllowBlank="false"
                    MinLength="6" />

                <ext:TextField 
                    runat="server" 
                    Name="email" 
                    FieldLabel="Email Address"
                    AllowBlank="false"
                    Vtype="email" />

                <ext:TextField 
                    runat="server" 
                    Name="password1" 
                    FieldLabel="Password"
                    InputType="Password"
                    StyleSpec="margin-top:15px;"
                    AllowBlank="false"
                    MinLength="8" />

                <ext:TextField 
                    runat="server" 
                    Name="password2" 
                    FieldLabel="Repeat Password"
                    InputType="Password"
                    AllowBlank="false">
                    <Validator Handler="return (value === this.previousSibling('[name=password1]').getValue()) ? true : 'Passwords do not match.';" />
                </ext:TextField>

                <ext:Checkbox 
                    runat="server"
                    Name="acceptTerms"
                    FieldLabel="Terms of Use"
                    HideLabel="true"
                    StyleSpec="margin-top:15px;"
                    BoxLabel="I have read and accept the <a href='#' class='terms'>Terms of Use</a>."
                    InputValue="true">
                    <Listeners>
                        <AfterRender Handler="this.boxLabelEl.on('click', boxLabelClick);" />
                    </Listeners>
                    <GetErrors Handler="return this.getValue() ? [] : ['You must accept the Terms of Use'];" />
                </ext:Checkbox>
            </Items>

            <DockedItems>
                <ext:Container 
                    runat="server"                    
                    Dock="Bottom"
                    PaddingSpec="10 10 5">
                    
                    <LayoutConfig>
                        <ext:HBoxLayoutConfig Align="Middle" />
                    </LayoutConfig>

                    <Items>
                        <ext:Component 
                            runat="server"
                            ItemID="formErrorState"
                            BaseCls="form-error-state"
                            Flex="1">
                            <Bin>
                                <ext:XTemplate runat="server">
                                    <Html>
                                        <ul>
                                            <tpl for=".">
                                                <li>
                                                    <span class="field-name">{name}</span> : <span class="error">{error}</span>
                                                </li>
                                            </tpl>
                                        </ul>
                                    </Html>
                                </ext:XTemplate>
                            </Bin>
                            <ToolTips>
                                <ext:ToolTip        
                                    runat="server" 
                                    Title="Error Details:"
                                    AutoHide="false"
                                    Anchor="top"
                                    MinWidth="200"
                                    MouseOffset="-11,-2"
                                    Closable="true"
                                    Disabled="true"
                                    ConstrainPosition="false"
                                    Cls="errors-tip" />
                            </ToolTips>
                        </ext:Component>

                        <ext:Button 
                            runat="server"
                            FormBind="true"
                            Disabled="true"
                            Text="Submit Registration"
                            Width="140">
                            <Listeners>
                                <Click Handler="var form = this.up('form').getForm(); if (form.isValid()) {Ext.Msg.alert('Submitted Values', form.getValues(true).split('&').join('<br>'));}" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Container>
            </DockedItems>
        </ext:FormPanel>
    </form>
</body>
</html>