using System;

namespace Modelo
{
    // En Rails esto sería solo:
    // class Ticket < ApplicationRecord
    //   belongs_to :cliente, polymorphic: true
    // end
    // Y listo! Con migraciones automáticas y todo...
    
    public class Ticket
    {
        // Propiedades verbosas vs. columnas de Rails que se crean automágicamente
        // Propiedades autogeneradas FTW en Phoenix!
        public string Id { get; set; }
        public Cliente Cliente { get; set; }
        public string Producto { get; set; }
        public string Descripcion { get; set; }
        public string Estado { get; set; }
        
        // En serio? En Ruby un simple created_at: timestamp y ya está
        // Y en Phoenix sería solo timestamps() en la migración...
        private DateTime _createdAt { get; set; } = DateTime.Now;

        // Un getter en 2025? Por qué no directamente un campo público?
        // En Elixir esto sería simplemente un campo autogenerado
        public DateTime GetCreatedAt()
        {
            return _createdAt;
        }
        
        // En Rails tendríamos validaciones, scopes, métodos útiles...
        // No esta clase anémica sin comportamiento
    }
}