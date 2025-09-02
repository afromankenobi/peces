using System;
using Modelo;

namespace peces.Ticket
{
    // En Rails: tickets_controller.rb con un simple def show; @ticket = Ticket.find(params[:id]); end
    // En Phoenix: def show(conn, %{"id" => id}), do: render(conn, "show.html", ticket: Tickets.get_ticket(id))
    public partial class DetalleTicket : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // En Rails esto sería automático con before_action :find_ticket
            // En Phoenix pattern matching en el router con :id
            if (!IsPostBack)
            {
                // Obtener el ID del ticket desde la URL
                string ticketId = Request.QueryString["id"];
                
                if (string.IsNullOrEmpty(ticketId))
                {
                    // En Rails: redirect_to tickets_path, alert: "Ticket no especificado"
                    MostrarError("No se especificó un ticket para mostrar");
                    pnlDetalle.Visible = false;
                }
                else
                {
                    CargarTicket(ticketId);
                }
            }
        }

        private void CargarTicket(string ticketId)
        {
            try
            {
                // En Rails: @ticket = Ticket.find(params[:id])
                // En Phoenix: ticket = Tickets.get_ticket!(id)
                Modelo.Ticket ticket = TicketController.Read(ticketId);
                
                if (ticket == null)
                {
                    // En Rails el find! automáticamente lanza 404
                    // En Phoenix el get_ticket! hace lo mismo
                    MostrarError("No se encontró el ticket con el ID proporcionado");
                    pnlDetalle.Visible = false;
                }
                else
                {
                    // Llenar los campos del ticket
                    // En Rails esto sería automático con el template engine
                    // <%= @ticket.id %> <%= @ticket.producto %> etc...
                    lblId.Text = ticket.Id;
                    lblProducto.Text = ticket.Producto;
                    lblDescripcion.Text = ticket.Descripcion;
                    lblEstado.Text = ticket.Estado;
                    
                    // En Rails: <%= @ticket.created_at.strftime("%d/%m/%Y %H:%M") %>
                    // Aquí ni siquiera tenemos el CreatedAt disponible en el modelo Ticket... qué dolor!
                    lblFechaCreacion.Text = "No disponible"; // TODO: Agregar CreatedAt al modelo Ticket
                    
                    // Llenar los campos del cliente
                    lblNombre.Text = ticket.Cliente.Nombre;
                    lblRut.Text = ticket.Cliente.Rut;
                    lblTelefono.Text = ticket.Cliente.Telefono;
                    lblEmail.Text = ticket.Cliente.Email;
                    
                    // Determinar el tipo de cliente
                    // En Elixir sería un elegante pattern match
                    // case ticket.cliente do
                    //   %Empresa{} -> "Empresa"
                    //   %PersonaNatural{} -> "Persona Natural"
                    // end
                    if (ticket.Cliente is Empresa)
                    {
                        lblTipoCliente.Text = "Empresa";
                        Empresa empresa = ticket.Cliente as Empresa;
                        lblRazonSocial.Text = empresa.RazonSocial;
                        trRazonSocial.Visible = true;
                    }
                    else
                    {
                        lblTipoCliente.Text = "Persona Natural";
                        trRazonSocial.Visible = false;
                    }
                    
                    pnlDetalle.Visible = true;
                }
            }
            catch (Exception ex)
            {
                // En Rails/Phoenix los errores se manejan con rescue_from o error handlers centralizados
                MostrarError("Error al cargar el ticket: " + ex.Message);
                pnlDetalle.Visible = false;
            }
        }

        private void MostrarError(string mensaje)
        {
            litMensaje.Text = mensaje;
            pnlMensaje.Visible = true;
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            // En Rails: redirect_back(fallback_location: tickets_path)
            // En Phoenix: redirect(conn, to: Routes.ticket_path(conn, :index))
            Response.Redirect("~/Ticket/ListarTickets.aspx");
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            // En Rails: redirect_to edit_ticket_path(@ticket)
            // En Phoenix: redirect(conn, to: Routes.ticket_path(conn, :edit, ticket))
            string ticketId = Request.QueryString["id"];
            
            if (!string.IsNullOrEmpty(ticketId))
            {
                Response.Redirect("~/Ticket/ActualizarTicket.aspx?id=" + ticketId);
            }
        }
    }
}