# DOCUMENTACIÓN FINAL - SISTEMA PECES
**Examen Final Programación I - 2025**

## RESUMEN EJECUTIVO

El Sistema de Tickets PeCe's ha sido desarrollado completamente según las especificaciones del examen final. Todas las validaciones ASP.NET están implementadas, el despliegue en Windows Server 2022 está documentado, y los entregables están listos para evaluación.

---

## VALIDACIONES IMPLEMENTADAS

### Formulario de Creación (AgregarTicket.aspx)
- **Grupo de Validación**: vgCrearTicket
- **Nombre**: Obligatorio, mínimo 5 caracteres
- **RUT**: Obligatorio, regex `^(\d{8,9}-[\dkK])$`
- **Teléfono**: Obligatorio
- **Email**: Obligatorio, regex `^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$`
- **Tipo Cliente**: No puede ser "Seleccionar"
- **Producto**: Obligatorio, mínimo 10 caracteres
- **Descripción**: Obligatorio, mínimo 10 caracteres

### Formulario de Actualización (ActualizarTicket.aspx)
- **Grupo de Validación**: vgActualizarTicket
- **Teléfono**: Obligatorio
- **Email**: Obligatorio, regex validado
- **Producto**: Obligatorio, mínimo 10 caracteres
- **Descripción**: Obligatorio, mínimo 10 caracteres

### Configuraciones Técnicas
- Web.config con UnobtrusiveValidationMode = None
- ValidationSummary en ambos formularios
- Page.IsValid verificado antes de operaciones
- Controles ocultos cuando no hay registro

---

## PROCESO DE DESPLIEGUE REALIZADO

### 1. Configuración de Máquina Virtual
- **Plataforma**: VMware Workstation
- **Sistema**: Windows Server 2022 Standard (Desktop Experience)
- **Hardware**: 3GB RAM, 3 núcleos, 60GB disco
- **Red**: Configuración NAT para acceso a internet

### 2. Instalación de Componentes
- VMware Tools instalado para transferencia de archivos
- IIS instalado con componentes ASP.NET 4.8
- Roles habilitados: Web Server, Application Development, ASP.NET 4.8
- Verificación de funcionamiento con página por defecto

### 3. Publicación de Aplicación
- Perfil de publicación tipo Folder creado
- Directorio de salida: peces-deploy
- Archivos compilados generados en bin/
- Web.config configurado para producción

### 4. Configuración IIS
- Sitio por defecto detenido
- Nuevo sitio "peces-web" creado
- Ruta física: C:\inetpub\wwwroot\peces-deploy
- Puerto 80 configurado
- Documento por defecto: Home.aspx
- Permisos IIS_IUSRS asignados

---

## PRUEBAS FUNCIONALES REALIZADAS

### Validaciones de Formulario
- Formulario vacío: ValidationSummary muestra errores
- RUT inválido (12345): Error de formato mostrado
- Nombre corto (abc): Error de longitud mínima
- Email inválido (test@): Error de formato
- Campos válidos: Ticket creado exitosamente

### Funcionalidad de Actualización
- Edición de ticket existente: Formulario carga datos
- Validaciones aplicadas correctamente
- Cambios guardados sin errores
- Ticket inexistente: Controles ocultos correctamente

### Navegación y Acceso
- Página de inicio carga sin errores
- Navegación entre secciones funcional
- Acceso a listado de tickets operativo
- Enlaces de edición y detalle funcionando

---

## ARQUITECTURA DEL SISTEMA

### Estructura de Capas
- **Presentación**: Archivos .aspx con validaciones del lado servidor
- **Modelo**: Lógica de negocio en clases Entity
- **Datos**: Acceso a datos con patrón Repository

### Tecnologías Utilizadas
- ASP.NET Web Forms 4.7.2
- C# como lenguaje de programación
- Validaciones nativas ASP.NET
- IIS como servidor web
- Windows Server 2022 como plataforma

---

## ENTREGABLES INCLUIDOS

### Código de Aplicación
- Solución completa peces.sln
- Formularios con validaciones implementadas
- Code-behind con eventos personalizados
- Web.config configurado apropiadamente

### Despliegue
- Carpeta peces-deploy lista para IIS
- Perfil de publicación configurado
- Tutorial de despliegue paso a paso
- Documentación de configuración

### Documentación
- Guía de despliegue completa (deploy.org)
- Seguimiento de requisitos (examen_track.org)
- Índice de entregables (README_ENTREGABLES.md)
- Instrucciones de entrega final

---

### Funcionalidades Adicionales
- Ocultación de controles en formularios sin registro
- Manejo apropiado de errores
- Mensajes informativos al usuario
- Validaciones tanto cliente como servidor

---

## CONCLUSIONES

El Sistema de Tickets PeCe's cumple completamente con todos los requisitos del examen final. Las validaciones ASP.NET están correctamente implementadas, el despliegue en Windows Server 2022 con IIS está documentado y verificado, y todos los entregables están listos para evaluación.
