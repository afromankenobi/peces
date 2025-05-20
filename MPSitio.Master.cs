using System;
using System.Web.UI;

namespace peces
{
    public partial class MPSitio : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            // Obtener el criterio de búsqueda
            string criterio = txtBusqueda.Text.Trim();

            // Redireccionar a la página de listado de tickets con el criterio de búsqueda
            Response.Redirect("~/Ticket/ListarTickets.aspx?criterio=" + Server.UrlEncode(criterio));
        }
    }
}