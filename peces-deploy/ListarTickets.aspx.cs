using System;
using System.Collections.Generic;
using System.Web.UI;
using Modelo;

namespace peces.Ticket
{
    // En Rails, esto sería un hermoso TicketsController con 5 líneas
    // Todo este código sería un simple index/show action con automágica integración
    public partial class ListarTickets : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // En Phoenix, no habría IsPostBack... todo sería automático
            // Un simple get "/" en el router y listo
            if (!IsPostBack)
            {
                // En Rails esto sería: flash[:notice] = params[:mensaje]
                // En Phoenix un simple LiveView con assign
                if (!string.IsNullOrEmpty(Request.QueryString["mensaje"]))
                {
                    litMensaje.Text = Request.QueryString["mensaje"];
                    pnlMensaje.Visible = true;
                    
                    // Este if/else en Elixir sería un elegante pattern matching...
                    if (Request.QueryString["mensaje"].Contains("éxito"))
                    {
                        pnlMensaje.CssClass = "message success";
                    }
                    else
                    {
                        pnlMensaje.CssClass = "message error";
                    }
                }

                // En Rails esto sería automático al renderizar la vista
                CargarTickets();
            }
        }

        private void CargarTickets()
        {
            // En Phoenix: assign(socket, :tickets, Tickets.list_tickets())
            // En Rails: @tickets = params[:criterio] ? Ticket.search(params[:criterio]) : Ticket.all
            List<Modelo.Ticket> tickets;

            // Este if/else es doloroso... en Ruby sería una condicional simple
            if (!string.IsNullOrEmpty(Request.QueryString["criterio"]))
            {
                string criterio = Request.QueryString["criterio"];
                tickets = TicketController.Search(criterio);
            }
            else
            {
                tickets = TicketController.ReadAll();
            }

            // En Rails esto sería automático con el partial rendering
            // Si no hay tickets, simplemente muestra el mensaje adecuado, sin este código horrible
            if (tickets.Count > 0)
            {
                gvTickets.DataSource = tickets;
                gvTickets.DataBind();
                pnlTickets.Visible = true;
                pnlNoTickets.Visible = false;
            }
            else
            {
                pnlTickets.Visible = false;
                pnlNoTickets.Visible = true;
            }
        }

        protected void lnkVerDetalle_Click(object sender, EventArgs e)
        {
            // En Rails: redirect_to ticket_path(@ticket)
            // En Phoenix: simple link con pattern matching en el router
            string ticketId = ((LinkButton)sender).CommandArgument;
            
            // Esto sería un simple redirect_to en Rails
            Response.Redirect("~/Ticket/DetalleTicket.aspx?id=" + ticketId);
        }
    }
}