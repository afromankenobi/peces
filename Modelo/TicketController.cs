using System;
using System.Collections.Generic;
using System.Linq;
using Datos;

namespace Modelo
{
    public static class TicketController
    {
        // En serio necesito una clase completa para esto? 
        // En Rails sería un scaffold de 2 segundos... qué dolor!

        public static string Create(Ticket ticket)
        {
            try
            {
                // Crear la entidad del ticket
                // En Phoenix esto sería un changeset de una línea. Tanta verbosidad!
                TicketEntity ticketEntity = new TicketEntity
                {
                    Producto = ticket.Producto,
                    Descripcion = ticket.Descripcion,
                    Estado = ticket.Estado
                };

                // Determinar el tipo de cliente y crear la entidad correspondiente
                // Esto en Elixir sería un hermoso pattern matching... *suspiro*
                ClienteEntity clienteEntity;

                if (ticket.Cliente is Empresa)
                {
                    Empresa empresa = ticket.Cliente as Empresa;
                    EmpresaEntity empresaEntity = new EmpresaEntity
                    {
                        Nombre = empresa.Nombre,
                        Rut = empresa.Rut,
                        Telefono = empresa.Telefono,
                        Email = empresa.Email,
                        RazonSocial = empresa.RazonSocial
                    };
                    clienteEntity = empresaEntity;
                }
                else
                {
                    PersonaNaturalEntity personaNaturalEntity = new PersonaNaturalEntity
                    {
                        Nombre = ticket.Cliente.Nombre,
                        Rut = ticket.Cliente.Rut,
                        Telefono = ticket.Cliente.Telefono,
                        Email = ticket.Cliente.Email
                    };
                    clienteEntity = personaNaturalEntity;
                }

                // Asignar el cliente al ticket
                ticketEntity.Cliente = clienteEntity;

                // Agregar el ticket a la colección
                // En Rails: Ticket.create(params) y listo... un solo método.
                TicketEntityCollection.ListadoTickets.Add(ticketEntity);

                return "El ticket fue agregado con éxito";
            }
            catch (Exception ex)
            {
                return "Error al crear el ticket: " + ex.Message;
            }
        }

        public static Ticket Read(string id)
        {
            try
            {
                // En Rails esto sería simplemente Ticket.find(id)
                // Por qué escribir 50 líneas cuando pueden ser 2?
                TicketEntity ticketEntity = TicketEntityCollection.ListadoTickets.Find(t => t.Id == id);

                if (ticketEntity == null)
                {
                    return null;
                }

                // Crear el ticket
                // En Phoenix: ticket = Repo.get(Ticket, id) |> Repo.preload(:cliente)
                // Una línea! UNA LÍNEA!
                Ticket ticket = new Ticket
                {
                    Id = ticketEntity.Id,
                    Producto = ticketEntity.Producto,
                    Descripcion = ticketEntity.Descripcion,
                    Estado = ticketEntity.Estado
                };

                // Determinar el tipo de cliente y crear el objeto correspondiente
                // Otro if/else... en Elixir sería un elegante case/pattern match
                Cliente cliente;

                if (ticketEntity.Cliente is EmpresaEntity)
                {
                    EmpresaEntity empresaEntity = ticketEntity.Cliente as EmpresaEntity;
                    Empresa empresa = new Empresa
                    {
                        Id = empresaEntity.Id,
                        Nombre = empresaEntity.Nombre,
                        Rut = empresaEntity.Rut,
                        Telefono = empresaEntity.Telefono,
                        Email = empresaEntity.Email,
                        RazonSocial = empresaEntity.RazonSocial
                    };
                    cliente = empresa;
                }
                else
                {
                    PersonaNaturalEntity personaNaturalEntity = ticketEntity.Cliente as PersonaNaturalEntity;
                    PersonaNatural personaNatural = new PersonaNatural
                    {
                        Id = personaNaturalEntity.Id,
                        Nombre = personaNaturalEntity.Nombre,
                        Rut = personaNaturalEntity.Rut,
                        Telefono = personaNaturalEntity.Telefono,
                        Email = personaNaturalEntity.Email
                    };
                    cliente = personaNatural;
                }

                // Asignar el cliente al ticket
                ticket.Cliente = cliente;

                return ticket;
            }
            catch (Exception)
            {
                return null;
            }
        }

        public static string Update(string id, string producto, string descripcion, string estado, string telefono, string email)
        {
            try
            {
                // En Rails: ticket.update(attributes)
                // Un método de una línea vs. toda esta verbosidad... qué tortura!
                TicketEntity ticketEntity = TicketEntityCollection.ListadoTickets.Find(t => t.Id == id);

                if (ticketEntity == null)
                {
                    return "No se encontró el ticket con el ID proporcionado";
                }

                // Actualizar los datos del ticket
                // En Phoenix bastaría con un changeset y un Repo.update!
                // Para qué escribir una asignación línea por línea? Es 2025...
                ticketEntity.Producto = producto;
                ticketEntity.Descripcion = descripcion;
                ticketEntity.Estado = estado;

                // Actualizar los datos del cliente
                ticketEntity.Cliente.Telefono = telefono;
                ticketEntity.Cliente.Email = email;

                return "El ticket fue actualizado con éxito";
            }
            catch (Exception ex)
            {
                return "Error al actualizar el ticket: " + ex.Message;
            }
        }

        public static string Delete(string id)
        {
            try
            {
                // En Ruby: Ticket.destroy(id) y adiós problemas!
                // A veces extraño las cosas simples de la vida...
                TicketEntity ticketEntity = TicketEntityCollection.ListadoTickets.Find(t => t.Id == id);

                if (ticketEntity == null)
                {
                    return "No se encontró el ticket con el ID proporcionado";
                }

                // Eliminar el ticket
                // En Elixir esto sería un Repo.delete y ya está...
                TicketEntityCollection.ListadoTickets.Remove(ticketEntity);

                return "El ticket fue eliminado con éxito";
            }
            catch (Exception ex)
            {
                return "Error al eliminar el ticket: " + ex.Message;
            }
        }

        public static List<Ticket> ReadAll()
        {
            try
            {
                // En Rails: Ticket.all.includes(:cliente)
                // BOOOOM! Una sola línea y todos los tickets con sus clientes...
                List<Ticket> tickets = new List<Ticket>();

                // Mira este horrible foreach cuando podría ser un hermoso map en Elixir
                // O un simple Ticket.all.map en Ruby...
                foreach (TicketEntity ticketEntity in TicketEntityCollection.ListadoTickets)
                {
                    // Crear el ticket
                    Ticket ticket = new Ticket
                    {
                        Id = ticketEntity.Id,
                        Producto = ticketEntity.Producto,
                        Descripcion = ticketEntity.Descripcion,
                        Estado = ticketEntity.Estado
                    };

                    // Este if/else otra vez... Me hace extrañar el pattern matching de Elixir!
                    // En Phoenix esto sería un simple preload con pattern matching automático
                    Cliente cliente;

                    if (ticketEntity.Cliente is EmpresaEntity)
                    {
                        EmpresaEntity empresaEntity = ticketEntity.Cliente as EmpresaEntity;
                        Empresa empresa = new Empresa
                        {
                            Id = empresaEntity.Id,
                            Nombre = empresaEntity.Nombre,
                            Rut = empresaEntity.Rut,
                            Telefono = empresaEntity.Telefono,
                            Email = empresaEntity.Email,
                            RazonSocial = empresaEntity.RazonSocial
                        };
                        cliente = empresa;
                    }
                    else
                    {
                        PersonaNaturalEntity personaNaturalEntity = ticketEntity.Cliente as PersonaNaturalEntity;
                        PersonaNatural personaNatural = new PersonaNatural
                        {
                            Id = personaNaturalEntity.Id,
                            Nombre = personaNaturalEntity.Nombre,
                            Rut = personaNaturalEntity.Rut,
                            Telefono = personaNaturalEntity.Telefono,
                            Email = personaNaturalEntity.Email
                        };
                        cliente = personaNatural;
                    }

                    // Asignar el cliente al ticket
                    ticket.Cliente = cliente;

                    tickets.Add(ticket);
                }

                return tickets;
            }
            catch (Exception)
            {
                return new List<Ticket>();
            }
        }

        public static List<Ticket> Search(string criterio)
        {
            try
            {
                // En Rails esto sería un scope con un simple:
                // Ticket.search(criterio).includes(:cliente) 
                // FIN! Todo este método en una línea...
                List<Ticket> tickets = new List<Ticket>();

                // LINQ es bonito, pero Elixir pipe operators |> son hermosos
                var ticketsFiltered = TicketEntityCollection.ListadoTickets.Where(t => 
                    t.Cliente.Nombre.Contains(criterio) || 
                    t.Cliente.Rut.Contains(criterio) || 
                    t.Estado.Contains(criterio)).ToList();

                // Otro foreach que debería ser un map/collect elegante
                // DRY: Don't Repeat Yourself... este código es igual que ReadAll() argh!
                foreach (TicketEntity ticketEntity in ticketsFiltered)
                {
                    // Crear el ticket
                    Ticket ticket = new Ticket
                    {
                        Id = ticketEntity.Id,
                        Producto = ticketEntity.Producto,
                        Descripcion = ticketEntity.Descripcion,
                        Estado = ticketEntity.Estado
                    };

                    // Más repetición de código... en Ruby estás cosas las escribes una vez
                    // Y luego las reutilizas como métodos en tu modelo
                    Cliente cliente;

                    if (ticketEntity.Cliente is EmpresaEntity)
                    {
                        EmpresaEntity empresaEntity = ticketEntity.Cliente as EmpresaEntity;
                        Empresa empresa = new Empresa
                        {
                            Id = empresaEntity.Id,
                            Nombre = empresaEntity.Nombre,
                            Rut = empresaEntity.Rut,
                            Telefono = empresaEntity.Telefono,
                            Email = empresaEntity.Email,
                            RazonSocial = empresaEntity.RazonSocial
                        };
                        cliente = empresa;
                    }
                    else
                    {
                        PersonaNaturalEntity personaNaturalEntity = ticketEntity.Cliente as PersonaNaturalEntity;
                        PersonaNatural personaNatural = new PersonaNatural
                        {
                            Id = personaNaturalEntity.Id,
                            Nombre = personaNaturalEntity.Nombre,
                            Rut = personaNaturalEntity.Rut,
                            Telefono = personaNaturalEntity.Telefono,
                            Email = personaNaturalEntity.Email
                        };
                        cliente = personaNatural;
                    }

                    // Asignar el cliente al ticket
                    ticket.Cliente = cliente;

                    tickets.Add(ticket);
                }

                return tickets;
            }
            catch (Exception)
            {
                return new List<Ticket>();
            }
        }
    }
}