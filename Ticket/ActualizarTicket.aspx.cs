using System;
using Modelo;
using System.Web.UI.WebControls;

namespace peces.Ticket
{
    public partial class ActualizarTicket : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Verificar si hay un ID en la URL
                if (!string.IsNullOrEmpty(Request.QueryString["id"]))
                {
                    string ticketId = Request.QueryString["id"];
                    hfTicketId.Value = ticketId;
                    CargarTicket(ticketId);
                }
                else
                {
                    // Mostrar mensaje de error
                    litMensaje.Text = "No se proporcionó un ID válido para el ticket";
                    pnlMensaje.Visible = true;
                    pnlFormulario.Visible = false;
                }
            }
        }

        private void CargarTicket(string ticketId)
        {
            // Obtener el ticket
            Modelo.Ticket ticket = TicketController.Read(ticketId);

            if (ticket != null)
            {
                // Mostrar los datos del ticket
                lblId.Text = ticket.Id;
                txtProducto.Text = ticket.Producto;
                txtDescripcion.Text = ticket.Descripcion;
                ddlEstado.SelectedValue = ticket.Estado;
                lblFechaCreacion.Text = ticket.GetCreatedAt().ToString("dd/MM/yyyy HH:mm:ss");

                // Mostrar los datos del cliente
                lblNombre.Text = ticket.Cliente.Nombre;
                lblRut.Text = ticket.Cliente.Rut;
                txtTelefono.Text = ticket.Cliente.Telefono;
                txtEmail.Text = ticket.Cliente.Email;

                // Verificar el tipo de cliente
                if (ticket.Cliente is Empresa)
                {
                    Empresa empresa = ticket.Cliente as Empresa;
                    lblTipoCliente.Text = "Empresa";
                    lblRazonSocial.Text = empresa.RazonSocial;
                    trRazonSocial.Visible = true;
                }
                else
                {
                    lblTipoCliente.Text = "Persona Natural";
                    trRazonSocial.Visible = false;
                }
            }
            else
            {
                // Mostrar mensaje de error
                litMensaje.Text = "No se encontró el ticket con el ID proporcionado";
                pnlMensaje.Visible = true;
                pnlFormulario.Visible = false;
            }
        }

        // Validación personalizada para longitud del producto
        protected void cvProductoLength_ServerValidate(object source, ServerValidateEventArgs args)
        {
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
            if (args.Value.Length < 10)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Ticket/DetalleTicket.aspx?id=" + hfTicketId.Value);
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // Verificar que todas las validaciones se cumplan
            if (Page.IsValid)
            {
                try
                {
                    // Actualizar el ticket
                    string resultado = TicketController.Update(
                        hfTicketId.Value,
                        txtProducto.Text.Trim(),
                        txtDescripcion.Text.Trim(),
                        ddlEstado.SelectedValue,
                        txtTelefono.Text.Trim(),
                        txtEmail.Text.Trim()
                    );

                    // Redireccionar a la página de detalle con el mensaje de resultado
                    Response.Redirect("~/Ticket/DetalleTicket.aspx?id=" + hfTicketId.Value + "&mensaje=" + Server.UrlEncode(resultado));
                }
                catch (Exception ex)
                {
                    // Mostrar mensaje de error
                    litMensaje.Text = "Error al actualizar el ticket: " + ex.Message;
                    pnlMensaje.Visible = true;
                }
            }
        }
    }
}