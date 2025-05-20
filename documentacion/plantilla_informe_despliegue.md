# Informe de Despliegue - Aplicación PeCe's

*[Nombre del Estudiante]*  
*[Fecha]*

## Publicación del Sitio Web

### Paso 1: Creación del Perfil de Publicación

[INSERTAR CAPTURA DE PANTALLA: Visual Studio > Proyecto > Publicar > Crear nuevo perfil]

En esta etapa, se creó un nuevo perfil de publicación tipo Folder con el nombre "peces-deploy".

### Paso 2: Configuración del Perfil

[INSERTAR CAPTURA DE PANTALLA: Configuración del perfil de publicación]

Se configuró el perfil para publicar en una carpeta local con la ruta [especificar ruta] y se establecieron las configuraciones de compilación para Release.

### Paso 3: Publicación

[INSERTAR CAPTURA DE PANTALLA: Proceso de publicación completado]

El proceso de publicación se completó exitosamente, generando los archivos necesarios en la carpeta "peces-deploy".

## Configuración de la Máquina Virtual

### Paso 1: Creación de la VM en VMware Workstation

[INSERTAR CAPTURA DE PANTALLA: Configuración de la VM]

Se creó una máquina virtual con las siguientes especificaciones:
- 3GB de RAM
- 3 núcleos de procesador
- 60GB de disco duro
- Windows Server 2022

### Paso 2: Instalación de Windows Server 2022

[INSERTAR CAPTURA DE PANTALLA: Windows Server instalado]

Se completó la instalación del sistema operativo Windows Server 2022.

### Paso 3: Instalación de VMware Tools

[INSERTAR CAPTURA DE PANTALLA: VMware Tools instaladas]

Las VMware Tools fueron instaladas correctamente para facilitar la transferencia de archivos entre host y VM.

## Instalación y Configuración de IIS

### Paso 1: Instalación de Roles y Características

[INSERTAR CAPTURA DE PANTALLA: Administrador del servidor > Agregar roles y características]

Se agregó el rol de "Servidor Web (IIS)" junto con las características necesarias para ASP.NET.

### Paso 2: Verificación de Instalación

[INSERTAR CAPTURA DE PANTALLA: IIS Manager abierto]

Se verificó que IIS se instaló correctamente y está ejecutándose.

## Despliegue del Sitio Web

### Paso 1: Migración de Archivos

[INSERTAR CAPTURA DE PANTALLA: Copia de archivos a la VM]

Los archivos de la carpeta "peces-deploy" fueron copiados a `C:\inetpub\wwwroot\` en la máquina virtual.

### Paso 2: Configuración de Permisos

[INSERTAR CAPTURA DE PANTALLA: Configuración de permisos para IIS_IUSRS]

Se configuraron los permisos de la carpeta para asegurar que el grupo IIS_IUSRS tenga acceso de lectura y ejecución.

### Paso 3: Detener el Sitio Web por Defecto

[INSERTAR CAPTURA DE PANTALLA: IIS Manager > Default Web Site > Detener]

El sitio web por defecto fue detenido para liberar el puerto 80.

### Paso 4: Crear Nuevo Sitio Web

[INSERTAR CAPTURA DE PANTALLA: IIS Manager > Agregar sitio web]

Se creó un nuevo sitio web con las siguientes configuraciones:
- Nombre: peces-web
- Ruta física: C:\inetpub\wwwroot\peces-deploy
- Puerto: 80

### Paso 5: Configuración del Documento Predeterminado

[INSERTAR CAPTURA DE PANTALLA: Configuración del documento predeterminado]

Se configuró "Home.aspx" como documento predeterminado para el sitio.

## Pruebas del Sitio Web

### Prueba 1: Acceso a la Página de Inicio

[INSERTAR CAPTURA DE PANTALLA: Navegador mostrando la página de inicio]

El sitio web se cargó correctamente y la página de inicio se muestra como se esperaba.

### Prueba 2: Listado de Tickets

[INSERTAR CAPTURA DE PANTALLA: Página de listado de tickets]

La página de listado de tickets funciona correctamente.

### Prueba 3: Creación de Nuevo Ticket

[INSERTAR CAPTURA DE PANTALLA: Formulario de creación de ticket]
[INSERTAR CAPTURA DE PANTALLA: Mensaje de éxito al crear ticket]

El formulario de creación de tickets funciona y aplica las validaciones correctamente.

### Prueba 4: Visualización de Detalles

[INSERTAR CAPTURA DE PANTALLA: Página de detalles de ticket]

La página de detalles muestra correctamente la información del ticket.

### Prueba 5: Actualización de Ticket

[INSERTAR CAPTURA DE PANTALLA: Formulario de actualización]
[INSERTAR CAPTURA DE PANTALLA: Mensaje de éxito al actualizar]

El formulario de actualización funciona y aplica las validaciones correctamente.

## Conclusión

El despliegue de la aplicación PeCe's se completó exitosamente siguiendo todos los requisitos especificados. El sitio web está funcionando correctamente en un servidor Windows Server 2022 con IIS, y todas las funcionalidades de administración de tickets están operativas.

## Anexos

- Registro de errores durante el despliegue y sus soluciones
- Configuraciones adicionales realizadas
- Recomendaciones para mantenimiento futuro