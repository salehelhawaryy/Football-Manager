<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CRreg.aspx.cs" Inherits="SportsWebApp.CRreg" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="height: 604px">

            Club Representative Registration:<br />
            <br />
            Name:<br />
            <asp:TextBox ID="rep_name" runat="server" ></asp:TextBox>
            <br />
            Username:<br />
            <asp:TextBox ID="username" runat="server"></asp:TextBox>
            <br />
            Password:<br />
            <asp:TextBox ID="password" TextMode="Password" runat="server" ></asp:TextBox>
            <br />
            Represented Club:<br />
            <asp:TextBox ID="rep_club" runat="server" ></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Register" style="height: 29px" />
            <br />

            <br />
            Clubs Without A Representative: 
            <br />
            <br />
            <asp:Panel ID="Panel1" runat="server" Height="170px">
            </asp:Panel>

        </div>
    </form>
</body>
</html>