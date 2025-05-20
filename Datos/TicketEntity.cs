using System;

namespace Datos
{
    public class TicketEntity
    {
        public string Id { get; set; } = Guid.NewGuid().ToString();
        public ClienteEntity Cliente { get; set; }
        public string Producto { get; set; }
        public string Descripcion { get; set; }
        public string Estado { get; set; }
        private DateTime _createdAt { get; set; } = DateTime.Now;

        public DateTime GetCreatedAt()
        {
            return _createdAt;
        }
    }
}