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

namespace SportsWebApp
{
    public partial class CRpage : System.Web.UI.Page
    {

        public int A()
        {
            string stmt = "SELECT COUNT(*) FROM Host_request";
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
            string connStr = WebConfigurationManager.ConnectionStrings["SportsDatabase"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            Panel1.Controls.Clear();
            SqlCommand cmd = new SqlCommand("select * from club where representative=" + Session["user"], conn);


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



        protected void Button1_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["SportsDatabase"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            Panel2.Controls.Clear();
            SqlCommand cmd = new SqlCommand("select * from upcomingMatchesOfClub2(@CRID)" , conn);
            cmd.Parameters.AddWithValue("@CRID", int.Parse(Session["user"].ToString()));



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
            Panel2.Controls.Add(new Label { Text = sb.ToString() });
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string temp = StadOn.Text;
            string connStr = WebConfigurationManager.ConnectionStrings["SportsDatabase"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            if (temp != "")
            {
                string use = "";
                for (int i = 0; i < temp.Length; i++)
                    if (temp[i] != 'T') use += temp[i];
                    else use += ' ';
                use += ":00";


                SqlCommand cmd = new SqlCommand("select * from viewAvailableStadiumsOn(@date)", conn);
                cmd.Parameters.AddWithValue("@date", use);

                Panel2.Controls.Clear();

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
                Panel2.Controls.Add(new Label { Text = sb.ToString() });


            }
            else Response.Write("Enter Valid Data");


        }


        protected void Button3_Click(object sender, EventArgs e)
        {
            string temp = StartR.Text;
            string Stad = StadR.Text;
            if (temp != "" && Stad != "")
            {
                string use = "";
                for (int i = 0; i < temp.Length; i++)
                    if (temp[i] != 'T') use += temp[i];
                    else use += ' ';
                use += ":00";


                string connStr = WebConfigurationManager.ConnectionStrings["SportsDatabase"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                SqlCommand cmd = new SqlCommand("addHostRequest2", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@CRID", int.Parse(Session["user"].ToString())));
                cmd.Parameters.Add(new SqlParameter("@StadName", Stad));
                cmd.Parameters.Add(new SqlParameter("@Start", use));

                int currsize = A();

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                if (currsize == A()) Response.Write("Cannot Add Request");
                else Response.Write("Request Submitted!");

            }
            else Response.Write("Enter Valid Data");
        }
    }
}