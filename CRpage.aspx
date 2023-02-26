<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CRpage.aspx.cs" Inherits="SportsWebApp.CRpage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #form1 {
            height: 371px;
            width: 1951px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Club Representive Page<br />
        Your Club Info:<asp:Panel ID="Panel1" runat="server" Height="20px" Width="1699px">
        </asp:Panel>
        <br />
        <br />
        <br />
        <br />
        Send a request to Host Match in a Stadium:<br />
        Start time of Match:
        <asp:TextBox ID="StartR" TextMode="DateTimeLocal" runat="server" Width="172px"></asp:TextBox>
&nbsp;&nbsp; Stadium Name:
        <asp:TextBox ID="StadR" runat="server" Width="132px"></asp:TextBox>
&nbsp;
        <asp:Button ID="Button3" runat="server" Text="Request" OnClick="Button3_Click" />
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" Text="View Club's upcoming matches" Width="243px" OnClick="Button1_Click" />
&nbsp;&nbsp;
        <asp:Button ID="Button2" runat="server" Text="View available stadiums On -> " Width="232px" OnClick="Button2_Click" />
        <asp:TextBox ID="StadOn" runat="server" style="margin-left: 0px" Width="167px"  textMode="DateTimeLocal" ></asp:TextBox>
    &nbsp;&nbsp;
        <br />
        <br />
        Tables:<br />
        <asp:Panel ID="Panel2" runat="server">
        </asp:Panel>
    </form>
</body>
</html>
