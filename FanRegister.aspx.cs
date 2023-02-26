using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SportsWebApp
{
    public partial class FanRegister : System.Web.UI.Page
    {

        public int A()
        {
            string stmt = "SELECT COUNT(*) FROM dbo.Users";
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


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string user = username.Text;
            string password = pass.Text;
            string ism = name.Text;
            string ID = NatID.Text;
            string bod = BD.Text;
            string add= AD.Text;

            bool number = true;
            string run = Phone.Text;
            for(int i=0;i<run.Length;i++)
                if (run[i]<'0' || run[i]>'9')
                {
                    number = false;
                    break;
                }




            // System.Diagnostics.Debug.WriteLine(ism);
            if (number && user.Length<21 && password.Length<21 && ism.Length<21 && ID.Length<21 && bod.Length<21 && add.Length<21)
            {
                int phoneN = int.Parse(Phone.Text);
                string connStr = WebConfigurationManager.ConnectionStrings["SportsDatabase"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                int currSize = A();



                SqlCommand AddFanProc = new SqlCommand("addFan", conn);
                AddFanProc.CommandType = CommandType.StoredProcedure;


                AddFanProc.Parameters.Add(new SqlParameter("@name", ism));
                AddFanProc.Parameters.Add(new SqlParameter("@username", user));
                AddFanProc.Parameters.Add(new SqlParameter("@password", password));
                AddFanProc.Parameters.Add(new SqlParameter("@NatID", ID));
                AddFanProc.Parameters.Add(new SqlParameter("@BOD", bod));
                AddFanProc.Parameters.Add(new SqlParameter("@address", add));
                AddFanProc.Parameters.Add(new SqlParameter("@phone", phoneN));

                conn.Open();
                AddFanProc.ExecuteNonQuery();
                conn.Close();

                int newSize = A();

                if (currSize == newSize)
                    Response.Write("Username is Taken");
                else Response.Redirect("login.aspx");
            }
            else Response.Write("Enter Valid Data");
        }
    }
}