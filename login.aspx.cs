using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SportsWebApp
{
    public partial class login : System.Web.UI.Page
    {
        public string type(string user)
        {
            string Fan = "SELECT count(*) FROM dbo.fan f INNER JOIN dbo.USERS u ON u.username=f.username where f.username= '"+user+"'";
            string SAM = "SELECT count(*) FROM dbo.SportsAssosManager f INNER JOIN dbo.USERS u ON u.username=f.username where f.username= '" + user + "'";
            string SM = "SELECT count(*) FROM dbo.Stadium_Manager f INNER JOIN dbo.USERS u ON u.username=f.username where f.username= '" + user + "'";

            string connStr = WebConfigurationManager.ConnectionStrings["SportsDatabase"].ToString();
            int res = 0;

            using (SqlConnection thisConnection = new SqlConnection(connStr))
            {
                thisConnection.Open();
                using (SqlCommand cmd = new SqlCommand(Fan,thisConnection))
                {
                    res = (int)cmd.ExecuteScalar();
                    if (res!=0)
                    { thisConnection.Close(); return "Fan";}
                }

                using (SqlCommand cmd = new SqlCommand(SAM, thisConnection))
                {
                    res = (int)cmd.ExecuteScalar();

                    if (res != 0)
                    { thisConnection.Close(); return "SAM";  }
                }

                using (SqlCommand cmd = new SqlCommand(SM, thisConnection))
                {
                    res = (int)cmd.ExecuteScalar();

                    if (res != 0)
                    { thisConnection.Close(); return "SM"; }
                }

                return null;

            }
        }

        public int FanBlock(string user)
        {
            string stmt = "SELECT COUNT(*) FROM dbo.fan where username='"+user+"' AND status=1" ;
            string connStr = WebConfigurationManager.ConnectionStrings["SportsDatabase"].ToString();
            int count = 0;

            using (SqlConnection thisConnection = new SqlConnection(connStr))
            {
                using (SqlCommand cmdCount = new SqlCommand(stmt, thisConnection))
                {
                    thisConnection.Open();
                    count = (int)cmdCount.ExecuteScalar();
                    thisConnection.Close();
                }
            }
            return count;
        }



        public bool exists(string user,string pass)
        {
            string check = "SELECT count(*) FROM USERS WHERE username='" + user + "' AND password='" + pass+"'";
            string connStr = WebConfigurationManager.ConnectionStrings["SportsDatabase"].ToString();
            int res = 0;
            using (SqlConnection thisConnection = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand(check,thisConnection))
                {
                    thisConnection.Open();
                    res = (int)cmd.ExecuteScalar();
                    thisConnection.Close();
                    if (res==0) return false;
                    return true;
                }
            }
        }

        public string GetID_Fan(string user)
        {
           
             string check = "SELECT NationalID FROM Fan WHERE username='" + user + "'";
            string connStr = WebConfigurationManager.ConnectionStrings["SportsDatabase"].ToString();
            string res = "";
            using (SqlConnection thisConnection = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand(check, thisConnection))
                {
                    thisConnection.Open();
                    res = cmd.ExecuteScalar().ToString();
                    thisConnection.Close();
                    return res;
                }
            }
        }

        public int GetID(string user,string type)
        {
            string check = "";
            if(type=="SAM") check= "SELECT SAM_Id FROM dbo.SportsAssosManager WHERE username='" + user + "'";
            else if(type=="SM") check = "SELECT SM_ID FROM dbo.Stadium_Manager WHERE username='" + user + "'";
            else check = "SELECT CR_ID FROM dbo.Club_representative WHERE username='" + user + "'";
            string connStr = WebConfigurationManager.ConnectionStrings["SportsDatabase"].ToString();
            int res = 0;
            using (SqlConnection thisConnection = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand(check, thisConnection))
                {
                    thisConnection.Open();
                    res = int.Parse(cmd.ExecuteScalar().ToString());
                    thisConnection.Close();
                    return res;
                }
            }

        }




        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string user = username.Text;
            string pass = password.Text;
            if (exists(user, pass))
            {
                if (user == "admin" && pass == "admin") Response.Redirect("sysAdmin.aspx");
                if (type(user) == "Fan")
                {
                    if (FanBlock(user) == 1)
                    {
                        Session["user"] = GetID_Fan(user);
                        Response.Redirect("FanPage.aspx");
                    }
                    else Response.Write("This Fan is blocked");
                }  
                else if(type(user)=="SAM")
                {
                    Session["user"] = GetID(user,"SAM");
                    Response.Redirect("samPage.aspx");
                }
                else if(type(user)=="SM")
                {
                    Session["user"] = GetID(user, "SM");
                    Response.Redirect("SMpage.aspx");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("A7a");
                    Session["user"] = GetID(user, "CR");
                    Response.Redirect("CRpage.aspx");
                }
            }
            else Response.Write("Incorrect Username or password");
        }
    }
}