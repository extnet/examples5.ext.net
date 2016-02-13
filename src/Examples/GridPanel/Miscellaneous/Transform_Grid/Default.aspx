<%@ Page Language="C#" %>

<html>
<head runat="server">
    <title>Converting an HTML table into a GridPanel - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        #data {
            width: 400px;
            border: 1px solid #bbb;
            border-collapse: collapse;
        }

        #data td, #data th {
            border: 1px solid #ccc;
            border-collapse: collapse;
            padding: 5px;
        }
    </style>
</head>
<body>
    <h1>Convert an HTML &lt;table> into a GridPanel</h1>

    <ext:ResourceManager runat="server" />

    <ext:TransformGrid runat="server" Table="data" />

    <table style="visibility:hidden;" id="data">
        <thead>
            <tr>
                <th>Name</th>
                <th>Age</th>
                <th>Gender</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Barney Rubble</td>
                <td>32</td>
                <td>Male</td>
            </tr>
            <tr>
                <td>Fred Flintstone</td>
                <td>33</td>
                <td>Male</td>
            </tr>
            <tr>
                <td>Betty Rubble</td>
                <td>32</td>
                <td>Female</td>
            </tr>
            <tr>
                <td>Pebbles</td>
                <td>1</td>
                <td>Female</td>
            </tr>
            <tr>
                <td>Bamm Bamm</td>
                <td>2</td>
                <td>Male</td>
            </tr>
        </tbody>
    </table>
</body>
</html>