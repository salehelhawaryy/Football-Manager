<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FanPage.aspx.cs" Inherits="SportsWebApp.FanPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #day {
            width: 117px;
        }
        #time {
            width: 117px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="height: 405px">
            Choose a Date and Time
            <br />
            <span style="color: rgb(32, 33, 36); font-family: arial, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">
            <br />
                <label for="Date"  > Date-Time</label>&nbsp;
                <asp:TextBox ID="TextBox1" runat="server" TextMode="DateTimeLocal"  style="margin-top: 0px"></asp:TextBox>
                
            <asp:Button ID="Button1" runat="server" Text="Search" OnClick="Button1_Click" />
            <br />
                
            <br />
                
            <br />
                
            Enter ID Of Match to purchase it&#39;s Ticket
            <asp:TextBox ID="TicketID" runat="server" Width="172px"></asp:TextBox>
            <asp:Button ID="Button2" runat="server" Height="23px" Text="Buy" OnClick="Button2_Click" />
            <br />
            <br />
            <br />
            <br />
            <br />
                
            Available matches :<br />
            <br />
                
            </span>
            <br />
            <asp:Panel ID="Panel1" runat="server" style="margin-top: 0px">
            </asp:Panel>
            <br />
        </div>
    </form>
</body>
</html>
