using System;
using Modelo;
using System.Web.UI.WebControls;

namespace peces.Ticket
{
    public partial class AgregarTicket : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void ddlTipoCliente_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Mostrar/ocultar campo de Razón Social según el tipo de cliente
            if (ddlTipoCliente.SelectedValue == "Empresa")
            {
                trRazonSocial.Visible = true;
                rfvRazonSocial.Enabled = true;
            }
            else
            {
                trRazonSocial.Visible = false;
                rfvRazonSocial.Enabled = false;
            }
        }

        // Validación personalizada para longitud del nombre
        protected void cvNombreLength_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (args.Value.Length < 5)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
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

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // Verificar que todas las validaciones se cumplan
            if (Page.IsValid)
            {
                try
                {
                    // Crear el cliente según el tipo seleccionado
                    Cliente cliente;
                    
                    if (ddlTipoCliente.SelectedValue == "Empresa")
                    {
                        Empresa empresa = new Empresa
                        {
                            Nombre = txtNombre.Text.Trim(),
                            Rut = txtRut.Text.Trim(),
                            Telefono = txtTelefono.Text.Trim(),
                            Email = txtEmail.Text.Trim(),
                            RazonSocial = txtRazonSocial.Text.Trim()
                        };
                        cliente = empresa;
                    }
                    else
                    {
                        PersonaNatural personaNatural = new PersonaNatural
                        {
                            Nombre = txtNombre.Text.Trim(),
                            Rut = txtRut.Text.Trim(),
                            Telefono = txtTelefono.Text.Trim(),
                            Email = txtEmail.Text.Trim()
                        };
                        cliente = personaNatural;
                    }

                    // Crear el ticket
                    Modelo.Ticket ticket = new Modelo.Ticket
                    {
                        Cliente = cliente,
                        Producto = txtProducto.Text.Trim(),
                        Descripcion = txtDescripcion.Text.Trim(),
                        Estado = ddlEstado.SelectedValue
                    };

                    // Guardar el ticket
                    string resultado = TicketController.Create(ticket);

                    // Redireccionar a la página de listado con el mensaje de resultado
                    Response.Redirect("~/Ticket/ListarTickets.aspx?mensaje=" + Server.UrlEncode(resultado));
                }
                catch (Exception ex)
                {
                    // Mostrar mensaje de error
                    Response.Redirect("~/Ticket/ListarTickets.aspx?mensaje=" + Server.UrlEncode("Error al agregar el ticket: " + ex.Message));
                }
            }
        }
    }
}