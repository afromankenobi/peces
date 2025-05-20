using System;

namespace peces
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnIrAgregarTicket_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Ticket/AgregarTicket.aspx");
        }
    }
}