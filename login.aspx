<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="SportsWebApp.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="height: 273px">
            Please Login.<br />
            <br />
            Username:<br />
            <asp:TextBox ID="username" runat="server"></asp:TextBox>
            <br />
            Password:<br />
            <asp:TextBox ID="password" TextMode="Password" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button1" runat="server" Text="Login" Width="166px" OnClick="Button1_Click" />
        </div>
    </form>
</body>
</html>
