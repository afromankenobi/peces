using System;
using Modelo;

namespace peces.Ticket
{
    public partial class DetalleTicket : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Verificar si hay un ID en la URL
                if (!string.IsNullOrEmpty(Request.QueryString["id"]))
                {
                    string ticketId = Request.QueryString["id"];
                    CargarTicket(ticketId);
                }
                else
                {
                    // Mostrar mensaje de error
                    litMensaje.Text = "No se proporcionó un ID válido para el ticket";
                    pnlMensaje.Visible = true;
                    pnlDetalle.Visible = false;
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
                lblProducto.Text = ticket.Producto;
                lblDescripcion.Text = ticket.Descripcion;
                lblEstado.Text = ticket.Estado;
                lblFechaCreacion.Text = ticket.GetCreatedAt().ToString("dd/MM/yyyy HH:mm:ss");

                // Mostrar los datos del cliente
                lblNombre.Text = ticket.Cliente.Nombre;
                lblRut.Text = ticket.Cliente.Rut;
                lblTelefono.Text = ticket.Cliente.Telefono;
                lblEmail.Text = ticket.Cliente.Email;

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
                pnlDetalle.Visible = false;
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Ticket/ListarTickets.aspx");
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            string ticketId = Request.QueryString["id"];
            Response.Redirect("~/Ticket/ActualizarTicket.aspx?id=" + ticketId);
        }
    }
}