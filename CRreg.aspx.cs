using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace SportsWebApp
{
    public partial class CRreg : System.Web.UI.Page
    {

        public int A()
        {
            string stmt = "SELECT COUNT(*) FROM dbo.users";
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

        public void loadClubs()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["SportsDatabase"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            Panel1.Controls.Clear();
      
            var sql = String.Format("select name,location from Club where representative is null");
            SqlCommand cmd = new SqlCommand(sql, conn);


            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            StringBuilder sb = new StringBuilder();
            sb.Append("<table border=1>");
            sb.Append("<tr>");
            foreach (DataColumn dc in dt.Columns)
            {
                sb.Append("<th>");
                sb.Append(dc.ColumnName);
                sb.Append("</th>");
            }
            sb.Append("</tr>");

            foreach (DataRow dr in dt.Rows)
            {
                sb.Append("<tr>");
                foreach (DataColumn dc in dt.Columns)
                {
                    sb.Append("<th>");
                    sb.Append(dr[dc.ColumnName].ToString());
                    sb.Append("</th>");

                }
                sb.Append("</tr>");
            }
            sb.Append("</table>");
            Panel1.Controls.Add(new Label { Text = sb.ToString() });
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            loadClubs();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["SportsDatabase"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
  
            string name = rep_name.Text;
            string user = username.Text;
            string pass = password.Text;
            string club = rep_club.Text;
            if (user != "" && name != "" && pass != "" && club != "" && user.Length<21 && name.Length<21 && pass.Length<21 && club.Length<21)
            {

                SqlCommand AddCr = new SqlCommand("addRepresentative", conn);
                AddCr.CommandType = CommandType.StoredProcedure;

                AddCr.Parameters.Add(new SqlParameter("@name", name));
                AddCr.Parameters.Add(new SqlParameter("@ClubName", club));
                AddCr.Parameters.Add(new SqlParameter("@User", user));
                AddCr.Parameters.Add(new SqlParameter("@pass", pass));

                int currSize = A();

                conn.Open();
                AddCr.ExecuteNonQuery();
                conn.Close();

                if (currSize == A()) Response.Write("Enter Valid Data");
                else Response.Redirect("login.aspx");
            }
            else Response.Write("Enter Valid Data");
        }
    }
}