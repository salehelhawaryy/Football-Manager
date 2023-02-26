using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

namespace SportsWebApp
{
    public partial class FanPage : System.Web.UI.Page
    {

        public int A()
        {
            string stmt = "SELECT COUNT(*) FROM dbo.ticket_buying_transaction";
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
            if (!TextBox1.Text.Equals(""))
            {
                string connStr = WebConfigurationManager.ConnectionStrings["SportsDatabase"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                string DateTime = TextBox1.Text;
                string use = "";
                for (int i = 0; i < DateTime.Length; i++)
                    if (DateTime[i] != 'T') use += DateTime[i];
                    else use += ' ';
                use += ":00";



                SqlCommand cmd = new SqlCommand("select m1.*,m.Match_ID AS Match_ID from availableMatchesToAttend(@date) m1 INNER JOIN club c1 ON c1.Name=m1.Host INNER JOIN club c2 ON c2.Name=m1.Guest INNER JOIN Match m ON c1.C_ID=m.host AND c2.C_ID =m.guest AND m1.Start=m.Start_time", conn);
                cmd.Parameters.AddWithValue("@date", use);


                conn.Open();
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
                conn.Close();
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            if (!TicketID.Text.Equals(""))
            {
                string connStr = WebConfigurationManager.ConnectionStrings["SportsDatabase"].ToString();
                SqlConnection conn = new SqlConnection(connStr);

                int OGsize = A();
                int TickID = int.Parse(TicketID.Text);
                string user = Session["user"].ToString();
                SqlCommand buyTicketProc = new SqlCommand("purchaseTicket2", conn);
                buyTicketProc.CommandType = CommandType.StoredProcedure;


                buyTicketProc.Parameters.Add(new SqlParameter("@NatID", user));
                buyTicketProc.Parameters.Add(new SqlParameter("@Match_ID", TickID));

                conn.Open();
                buyTicketProc.ExecuteNonQuery();
                conn.Close();
                if (OGsize == A()) Response.Write("You Are Blocked!/No More Tickets!");
                else Response.Write("Ticket Purchased!");
            }
        }
    }
}