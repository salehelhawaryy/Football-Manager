using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.NetworkInformation;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SportsWebApp
{
    public partial class sysAdmin : System.Web.UI.Page
    {

        public int AStad()
        {
            string stmt = "SELECT COUNT(*) FROM dbo.Stadium";
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

        public int AClub()
        {
            string stmt = "SELECT COUNT(*) FROM dbo.Club";
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


        public void loadFan()
        {
            Panel1.Controls.Clear();
            string connStr = WebConfigurationManager.ConnectionStrings["SportsDatabase"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd2 = new SqlCommand("select * from allFans", conn);

            conn.Open();

            SqlDataAdapter sda2 = new SqlDataAdapter(cmd2);
            DataTable dt2 = new DataTable();
            sda2.Fill(dt2);
            StringBuilder sb2 = new StringBuilder();
            sb2.Append("<table border=1>");
            sb2.Append("<tr>");
            foreach (DataColumn dc in dt2.Columns)
            {
                sb2.Append("<th>");
                sb2.Append(dc.ColumnName);
                sb2.Append("</th>");
            }
            sb2.Append("</tr>");

            foreach (DataRow dr in dt2.Rows)
            {
                sb2.Append("<tr>");
                foreach (DataColumn dc in dt2.Columns)
                {
                    sb2.Append("<th>");
                    sb2.Append(dr[dc.ColumnName].ToString());
                    sb2.Append("</th>");

                }
                sb2.Append("</tr>");
            }
            sb2.Append("</table>");
            Panel1.Controls.Clear();
            Panel1.Controls.Add(new Label { Text = sb2.ToString() });

            conn.Close();
        }



        public void loadClub()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["SportsDatabase"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd2 = new SqlCommand("select * from allClubs", conn);

            conn.Open();

            SqlDataAdapter sda2 = new SqlDataAdapter(cmd2);
            DataTable dt2 = new DataTable();
            sda2.Fill(dt2);
            StringBuilder sb2 = new StringBuilder();
            sb2.Append("<table border=1>");
            sb2.Append("<tr>");
            foreach (DataColumn dc in dt2.Columns)
            {
                sb2.Append("<th>");
                sb2.Append(dc.ColumnName);
                sb2.Append("</th>");
            }
            sb2.Append("</tr>");

            foreach (DataRow dr in dt2.Rows)
            {
                sb2.Append("<tr>");
                foreach (DataColumn dc in dt2.Columns)
                {
                    sb2.Append("<th>");
                    sb2.Append(dr[dc.ColumnName].ToString());
                    sb2.Append("</th>");

                }
                sb2.Append("</tr>");
            }
            sb2.Append("</table>");
            Panel1.Controls.Clear();
            Panel1.Controls.Add(new Label { Text = sb2.ToString() });

            conn.Close();


        }


        public void loadStad()
        {

            string connStr = WebConfigurationManager.ConnectionStrings["SportsDatabase"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            Panel1.Controls.Clear();
            SqlCommand cmd = new SqlCommand("select * from allStadiums", conn);


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



        protected void Button3_Click(object sender, EventArgs e)
        {
            string name = Std_name.Text;
            string location=Std_loc.Text;
            string temp =Std_Cap.Text;
            int cap = 0;
            bool number = true;
            for (int i = 0; i < temp.Length; i++) if (temp[i] < '0' || temp[i] > '9') number = false;  
            if (temp != "" && number ) cap = int.Parse(temp);
            if (name != "" && location != "" && cap > 0 && name.Length<21 && location.Length<21)
            {
                string connStr = WebConfigurationManager.ConnectionStrings["SportsDatabase"].ToString();
                SqlConnection conn = new SqlConnection(connStr);
                int currsize = AStad();

                SqlCommand AddStadProc = new SqlCommand("addStadium", conn);
                AddStadProc.CommandType = CommandType.StoredProcedure;

                AddStadProc.Parameters.Add(new SqlParameter("@name", name));
                AddStadProc.Parameters.Add(new SqlParameter("@location", location));
                AddStadProc.Parameters.Add(new SqlParameter("@capacity", cap));
                conn.Open();
                AddStadProc.ExecuteNonQuery();
                conn.Close();
                loadStad();
                if (currsize == AStad()) Response.Write("Enter Another Name");
                else Response.Write("Stadium Added");

                


            }
            else Response.Write("Enter Valid Data");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["SportsDatabase"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            string name = Club_name.Text;
            string location = Club_loc.Text;
            int currsize = AClub();
            if (name != "" && location != "" && name.Length<21 && location.Length<21)
            {
                SqlCommand AddClubProc = new SqlCommand("addClub", conn);
                AddClubProc.CommandType = CommandType.StoredProcedure;

                AddClubProc.Parameters.Add(new SqlParameter("@name", name));
                AddClubProc.Parameters.Add(new SqlParameter("@location", location));

                conn.Open();
                AddClubProc.ExecuteNonQuery();
                conn.Close();

                if (currsize == AClub()) Response.Write("Enter A new Name");
                else
                {
                    Response.Write("Club " + name + " Added");
                    loadClub();
                }

            }
            else Response.Write("Enter Valid Data");


        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            string delname = delStad.Text;
            if(delname!="")
            {
                string connStr = WebConfigurationManager.ConnectionStrings["SportsDatabase"].ToString();
                SqlConnection conn = new SqlConnection(connStr);
                int currsize = AStad();

                SqlCommand delStadProc = new SqlCommand("deleteStadium", conn);
                delStadProc.CommandType = CommandType.StoredProcedure;

                delStadProc.Parameters.Add(new SqlParameter("@name", delname));

                conn.Open();
                delStadProc.ExecuteNonQuery();
                conn.Close();

                if (currsize == AStad()) Response.Write("Enter Valid Data");
                else
                {
                    Response.Write("Stadium Deleted");
                    loadStad();
                }


            }
        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            string delC = delClub.Text;
            if (delC == "") Response.Write("Enter valid Data");
            else
            {
                string connStr = WebConfigurationManager.ConnectionStrings["SportsDatabase"].ToString();
                SqlConnection conn = new SqlConnection(connStr);
                int currsize = AClub();

                SqlCommand delClubProc = new SqlCommand("deleteClub", conn);
                delClubProc.CommandType = CommandType.StoredProcedure;
                delClubProc.Parameters.Add(new SqlParameter("@ClubName", delC));    

                conn.Open();
                delClubProc.ExecuteNonQuery();
                conn.Close();

                if (currsize == AClub()) Response.Write("No Club with that name");
                else
                {
                    Response.Write("Club " + delC + " Deleted");
                    loadClub();
                }

            }
        }

        protected void Button6_Click(object sender, EventArgs e)
        {
            string ID = TextBox1.Text;
            if (ID == "") Response.Write("Enter an ID");
            else
            {
                string connStr = WebConfigurationManager.ConnectionStrings["SportsDatabase"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                SqlCommand BlockFan = new SqlCommand("blockFan", conn);
                BlockFan.CommandType = CommandType.StoredProcedure;
                BlockFan.Parameters.Add(new SqlParameter("@NatID",ID));

                conn.Open();
                BlockFan.ExecuteNonQuery();
                conn.Close();
                Response.Write("Fan with ID " + ID + " Blocked");
                loadFan();

            }
        }

        protected void Button7_Click(object sender, EventArgs e)
        {
            string ID = TextBox1.Text;
            if (ID == "") Response.Write("Enter an ID");
            else
            {
                string connStr = WebConfigurationManager.ConnectionStrings["SportsDatabase"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                SqlCommand BlockFan = new SqlCommand("unblockFan", conn);
                BlockFan.CommandType = CommandType.StoredProcedure;
                BlockFan.Parameters.Add(new SqlParameter("@NatID", ID));

                conn.Open();
                BlockFan.ExecuteNonQuery();
                conn.Close();
                Response.Write("Fan with ID " + ID + " unblocked");
                loadFan();
            }
        }

        protected void Button8_Click(object sender, EventArgs e)
        {
            loadClub();
        }

        protected void Button9_Click(object sender, EventArgs e)
        {
            loadStad();
        }

        protected void Button10_Click(object sender, EventArgs e)
        {
            loadFan();
        }
    }
}