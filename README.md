# Proyecto PeCe's - Sistema de Gestión de Tickets de Soporte

## Descripción del Proyecto

Sistema web desarrollado en ASP.NET Web Forms con C# para la gestión de tickets de soporte técnico de la empresa PeCe's. El proyecto implementa una arquitectura de 3 capas (Presentación, Modelo/Negocio, Datos) según los requerimientos académicos establecidos.

## Tecnologías Utilizadas

- **Framework**: ASP.NET Web Forms
- **Lenguaje**: C# 
- **Arquitectura**: 3 capas (n-tier architecture)
- **Patrón de diseño**: Entity/Controller pattern
- **IDE**: Visual Studio Community 2022

## Estructura del Proyecto

```
peces/
├── Datos/           # Capa de acceso a datos (Class Library)
├── Modelo/          # Capa de lógica de negocio (Class Library) 
├── Ticket/          # Módulo de gestión de tickets
├── MPSitio.Master   # Página maestra
├── Home.aspx        # Página de inicio
└── Web.sitemap      # Configuración del menú
```

## Funcionalidades Implementadas

### ✅ Gestión Completa de Tickets (CRUD)
- **Crear ticket**: Formulario para registrar nuevos tickets de soporte
- **Listar tickets**: Vista general de todos los tickets registrados
- **Ver detalle**: Información completa de cada ticket
- **Actualizar ticket**: Edición de tickets existentes
- **Búsqueda avanzada**: Filtrado por nombre, RUT o estado

### ✅ Gestión de Clientes
- **Personas Naturales**: Clientes individuales
- **Empresas**: Clientes corporativos con razón social
- **Información completa**: Nombre, RUT, teléfono, email

### ✅ Interfaz de Usuario
- **Master Page**: Diseño consistente en todas las páginas
- **Menú de navegación**: Navegación intuitiva entre secciones
- **Responsive**: Formularios organizados con tablas HTML
- **Validaciones**: Control de datos de entrada

## Arquitectura Técnica

### Capa de Datos (`Datos/`)
- `ClienteEntity`, `PersonaNaturalEntity`, `EmpresaEntity`
- `TicketEntity` con gestión de timestamps
- `TicketEntityCollection` para almacenamiento en memoria

### Capa de Modelo/Negocio (`Modelo/`)
- Clases modelo: `Cliente`, `PersonaNatural`, `Empresa`, `Ticket`
- `TicketController` con métodos CRUD estáticos
- Transformaciones entre capas de datos y negocio

### Capa de Presentación
- Formularios Web Forms con código subyacente
- Master Page con logo, menú y búsqueda
- Controles ASP.NET nativos con nomenclatura estándar

## Estado de Cumplimiento de Requerimientos

### Requerimientos Generales ✅
- [x] ASP.NET como Framework Frontend
- [x] C# como lenguaje de programación
- [x] Separación de roles por capas
- [x] Referencias correctas entre proyectos
- [x] Capas de datos y modelo como Class Library

### Capa de Datos ✅
- [x] **ClienteEntity** con propiedades Id, Nombre, Rut, Telefono, Email
- [x] **PersonaNaturalEntity** heredando de ClienteEntity
- [x] **EmpresaEntity** heredando de ClienteEntity + RazonSocial
- [x] **TicketEntity** con Cliente, Producto, Descripcion, Estado, _createdAt
- [x] **TicketEntityCollection** clase estática con List<TicketEntity>

### Capa de Modelo/Negocio ✅
- [x] **Cliente** sin inicialización automática de Guid
- [x] **PersonaNatural** y **Empresa** heredando de Cliente
- [x] **Ticket** con propiedad Cliente de tipo Cliente
- [x] **TicketController** estático con métodos:
  - [x] Create(Ticket) - Creación de tickets
  - [x] Read(string id) - Lectura por ID
  - [x] Update(...) - Actualización de campos específicos
  - [x] Delete(string id) - Eliminación por ID
  - [x] ReadAll() - Listado completo
  - [x] Search(string filtro) - Búsqueda filtrada

### Capa de Presentación ASP.NET ✅
- [x] **Master Page MPSitio** con logo, menú y búsqueda
- [x] **Menú de navegación** con 3 opciones (Home, Agregar, Listar)
- [x] **Formulario Home** con mensaje de bienvenida
- [x] **Formulario AgregarTicket** con validaciones y tipo de cliente
- [x] **Formulario ListarTickets** con GridView y manejo de estados vacíos
- [x] **Formulario DetalleTicket** con navegación y botones de acción
- [x] **Formulario ActualizarTicket** con campos editables/no editables
- [x] **Búsqueda avanzada** integrada en Master Page

### Consideraciones Adicionales ✅
- [x] Controles con nomenclatura estándar
- [x] DropDownLists con opción "Seleccionar" deshabilitada
- [x] Formularios organizados en tablas HTML
- [x] Logo implementado como imagen (logo.png)

## Criterios de Evaluación

| Criterio | Descripción | Puntaje | Estado |
|----------|-------------|---------|--------|
| Arquitectura n-capas | Bibliotecas de clase para datos y modelo/negocio | 10 | ✅ |
| Colecciones de datos | Colección estática para almacenamiento | 10 | ✅ |
| Clases modelo y controladores | Implementación en capa de negocio | 20 | ✅ |
| Master Page | Plantilla general del proyecto | 10 | ✅ |
| Formularios Web Forms | Pantallas de administración | 20 | ✅ |
| Controles ASP.NET | Uso y nomenclatura correcta | 15 | ✅ |
| Propiedades y eventos | Configuración según requerimientos | 15 | ✅ |
| **Total** | | **100** | **✅** |

## Instalación y Uso

1. **Requisitos previos**:
   - Visual Studio Community 2022 o superior
   - .NET Framework 4.7.2 o superior
   - IIS Express (incluido con Visual Studio)

2. **Configuración**:
   ```bash
   # Clonar el repositorio
   git clone [URL_DEL_REPO]
   
   # Abrir solución en Visual Studio
   # Compilar solución (Ctrl+Shift+B)
   # Ejecutar (F5)
   ```

3. **Uso del sistema**:
   - Navegar a Home para comenzar
   - Usar "Agregar Ticket" para crear nuevos registros
   - "Listar todos" para ver tickets existentes
   - Búsqueda avanzada disponible en todas las páginas

## Notas de Desarrollo

- El proyecto utiliza almacenamiento en memoria (no persistente)
- Implementa validaciones del lado del servidor
- Manejo de errores con mensajes informativos
- Redirecciones con parámetros por URL
- Diseño responsive básico con CSS

## Estructura de Archivos Principales

```
├── Datos/
│   ├── ClienteEntity.cs
│   ├── PersonaNaturalEntity.cs
│   ├── EmpresaEntity.cs
│   ├── TicketEntity.cs
│   └── TicketEntityCollection.cs
├── Modelo/
│   ├── Cliente.cs
│   ├── PersonaNatural.cs
│   ├── Empresa.cs
│   ├── Ticket.cs
│   └── TicketController.cs
├── Ticket/
│   ├── AgregarTicket.aspx[.cs]
│   ├── ListarTickets.aspx[.cs]
│   ├── DetalleTicket.aspx[.cs]
│   └── ActualizarTicket.aspx[.cs]
└── MPSitio.Master[.cs]
```

---

**Proyecto desarrollado como parte del Taller 1 - Unidad 2 de Programación I**