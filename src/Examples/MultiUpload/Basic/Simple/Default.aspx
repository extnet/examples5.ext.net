<%@ Page Language="C#" %>

<script runat="server">
    protected void MultiUpload1_FileUpload(object sender, FileUploadEventArgs e)
    {
        System.Threading.Thread.Sleep(3000); // Just for testing
        X.Msg.Notify("File is uploaded", "Name: " + e.FileName).Show();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Simple MultiUpload - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var uploadError = function (item, file, errorCode, message) {
            alert("Error Code: " + errorCode + ", File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
        };

        var fileSelectionError = function (item, file, errorCode, message) {
            alert("Error Code: " + errorCode + ", File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Simple MultiUpload</h1>

        <ext:MultiUpload
            ID="MultiUpload1"
            runat="server"
            OnFileUpload="MultiUpload1_FileUpload"
            AutoStartUpload="true"
            FileDropAnywhere="true"
            FileSizeLimit="15 MB"
            FileTypes="*.*"
            FileTypesDescription="All Files"
            FileUploadLimit="100"
            FileQueueLimit="0">
            <Listeners>
                <UploadStart Handler="Ext.Msg.wait('Uploading...');" />
                <UploadError Fn="uploadError" />
                <FileSelectionError Fn="fileSelectionError" />
                <UploadComplete Handler="Ext.Msg.hide();" />
            </Listeners>
        </ext:MultiUpload>
    </form>
</body>
</html>
