using System;
using System.Web.UI.WebControls;
using Modelo;

namespace peces.Ticket
{
    // En Rails: tickets_controller.rb con def edit y def update... dos métodos simples
    // En Phoenix: def edit y def update con changesets automáticos
    public partial class ActualizarTicket : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // En Rails: before_action :set_ticket, only: [:edit, :update]
            // En Phoenix: action_fallback para manejar errores automáticamente
            if (!IsPostBack)
            {
                string ticketId = Request.QueryString["id"];
                
                if (string.IsNullOrEmpty(ticketId))
                {
                    // En Rails: redirect_to tickets_path, alert: "Ticket no especificado"
                    MostrarError("No se especificó un ticket para actualizar");
                    pnlFormulario.Visible = false;
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
                    MostrarError("No se encontró el ticket con el ID proporcionado");
                    pnlFormulario.Visible = false;
                }
                else
                {
                    // Guardar el ID en un campo oculto para usarlo al actualizar
                    // En Rails esto viene automático con el form_for @ticket
                    hfTicketId.Value = ticket.Id;
                    
                    // Llenar los campos del ticket (editables)
                    lblId.Text = ticket.Id;
                    txtProducto.Text = ticket.Producto;
                    txtDescripcion.Text = ticket.Descripcion;
                    ddlEstado.SelectedValue = ticket.Estado;
                    
                    // En Rails/Phoenix el created_at viene gratis con timestamps
                    lblFechaCreacion.Text = ticket.GetCreatedAt().ToString("dd/MM/yyyy HH:mm:ss");
                    
                    // Llenar los campos del cliente (solo email y teléfono son editables)
                    lblNombre.Text = ticket.Cliente.Nombre;
                    lblRut.Text = ticket.Cliente.Rut;
                    txtTelefono.Text = ticket.Cliente.Telefono;
                    txtEmail.Text = ticket.Cliente.Email;
                    
                    // Determinar el tipo de cliente
                    // En Elixir: pattern matching elegante
                    // En Ruby: duck typing con respond_to?(:razon_social)
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
                    
                    pnlFormulario.Visible = true;
                }
            }
            catch (Exception ex)
            {
                // En Rails/Phoenix: rescue_from o error handlers centralizados
                MostrarError("Error al cargar el ticket: " + ex.Message);
                pnlFormulario.Visible = false;
            }
        }

        private void MostrarError(string mensaje)
        {
            litMensaje.Text = mensaje;
            pnlMensaje.Visible = true;
        }

        // Validación personalizada para longitud del producto
        protected void cvProductoLength_ServerValidate(object source, ServerValidateEventArgs args)
        {
            // En Rails esto sería: validates :producto, length: { minimum: 10 }
            // Una línea vs todo este método... suspiro
            if (args.Value.Length < 10)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        // Validación personalizada para longitud de la descripción
        protected void cvDescripcionLength_ServerValidate(object source, ServerValidateEventArgs args)
        {
            // En Rails: validates :descripcion, length: { minimum: 10 }
            // En Phoenix: validate_length(:descripcion, min: 10)
            if (args.Value.Length < 10)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // En Rails: if @ticket.update(ticket_params)
            // En Phoenix: case Tickets.update_ticket(ticket, ticket_params) do
            if (Page.IsValid)
            {
                try
                {
                    string ticketId = hfTicketId.Value;
                    
                    // Llamar al método Update del controlador
                    // En Rails sería: @ticket.update(ticket_params) y listo!
                    string resultado = TicketController.Update(
                        ticketId,
                        txtProducto.Text.Trim(),
                        txtDescripcion.Text.Trim(),
                        ddlEstado.SelectedValue,
                        txtTelefono.Text.Trim(),
                        txtEmail.Text.Trim()
                    );
                    
                    // Redireccionar con el mensaje de resultado
                    // En Rails: redirect_to @ticket, notice: 'Ticket actualizado exitosamente'
                    Response.Redirect("~/Ticket/ListarTickets.aspx?mensaje=" + Server.UrlEncode(resultado));
                }
                catch (Exception ex)
                {
                    // En Rails/Phoenix esto se maneja con rescue_from o error_handler
                    MostrarError("Error al actualizar el ticket: " + ex.Message);
                }
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            // En Rails: redirect_back(fallback_location: tickets_path)
            // En Phoenix: redirect(conn, to: Routes.ticket_path(conn, :index))
            string ticketId = hfTicketId.Value;
            
            if (!string.IsNullOrEmpty(ticketId))
            {
                // Volver al detalle del ticket
                Response.Redirect("~/Ticket/DetalleTicket.aspx?id=" + ticketId);
            }
            else
            {
                // Volver al listado
                Response.Redirect("~/Ticket/ListarTickets.aspx");
            }
        }
    }
}