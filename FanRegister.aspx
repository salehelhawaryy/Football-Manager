<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FanRegister.aspx.cs" Inherits="SportsWebApp.FanRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="height: 589px">
            Fan Register<br />
            <br />
            Name:<br />
            <asp:TextBox ID="name" runat="server"></asp:TextBox>
            <br />
            Username:<br />
            <asp:TextBox ID="username" runat="server"></asp:TextBox>
            <br />
            Password:<br />
            <asp:TextBox ID="pass" TextMode="Password" runat="server"></asp:TextBox>
            <br />
            National ID:<br />
            <asp:TextBox ID="NatID" runat="server"></asp:TextBox>
            <br />
            Phone Number:<br />
            <asp:TextBox ID="Phone" runat="server"></asp:TextBox>
            <br />
            Birth Date:<br />
            <asp:TextBox ID="BD" TextMode="Date" runat="server"></asp:TextBox>
            <br />
            Address:<br />
            <asp:TextBox ID="AD" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button1" runat="server" Text="Register" Width="169px" OnClick="Button1_Click" />
        </div>
    </form>
</body>
</html>
