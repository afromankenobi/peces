# Instrucciones de Despliegue - Aplicación PeCe's

Este documento proporciona instrucciones detalladas para desplegar la aplicación web PeCe's en un servidor Windows Server 2022 con IIS.

## Archivos Incluidos

- `deploy_script.ps1`: Script de PowerShell para automatizar el proceso de publicación en Windows
- `deploy_script.sh`: Script de Bash para publicación en macOS/Linux
- `documentacion/guia_despliegue.md`: Guía detallada de despliegue con instrucciones paso a paso
- `peces-deploy/`: Carpeta que contiene los archivos publicados de la aplicación

## Proceso de Publicación Automatizada

### En Windows (con PowerShell)

1. Abrir PowerShell como administrador
2. Navegar al directorio del proyecto:
   ```powershell
   cd "C:\ruta\al\proyecto\peces"
   ```
3. Ejecutar el script de despliegue:
   ```powershell
   .\deploy_script.ps1
   ```
4. Seguir las instrucciones en pantalla.

### En macOS/Linux (con Bash)

1. Abrir Terminal
2. Navegar al directorio del proyecto:
   ```bash
   cd /ruta/al/proyecto/peces
   ```
3. Dar permisos de ejecución al script:
   ```bash
   chmod +x deploy_script.sh
   ```
4. Ejecutar el script:
   ```bash
   ./deploy_script.sh
   ```
5. Seguir las instrucciones en pantalla.

## Proceso de Publicación Manual

Si los scripts automatizados no funcionan en su entorno, siga estos pasos para la publicación manual:

1. Abrir el proyecto en Visual Studio 2022
2. Clic derecho en el proyecto "peces" en el Explorador de soluciones
3. Seleccionar "Publicar"
4. Elegir "Carpeta" como destino
5. Establecer la ruta como "peces-deploy" en la carpeta del proyecto
6. Hacer clic en "Publicar"

## Proceso de Despliegue en IIS

Para el despliegue en IIS, siga la guía detallada en `documentacion/guia_despliegue.md`. A continuación, un resumen:

1. Configurar una máquina virtual con Windows Server 2022
2. Instalar IIS con soporte para ASP.NET 4.7.2
3. Copiar la carpeta "peces-deploy" a `C:\inetpub\wwwroot\`
4. Configurar permisos y crear un nuevo sitio web en IIS
5. Realizar pruebas de funcionamiento

## Verificación del Despliegue

Después de completar el despliegue, verifique que:

1. El sitio web es accesible en http://localhost
2. Las funcionalidades principales funcionan correctamente:
   - Listar tickets
   - Agregar nuevo ticket
   - Ver detalles de ticket
   - Actualizar ticket
   - Eliminar ticket

## Solución de Problemas

Si encuentra errores durante el despliegue, consulte la sección "Solución de Problemas Comunes" en la guía de despliegue.

Para preguntas o asistencia adicional, contactar al desarrollador.

## Especificaciones Técnicas

- Lenguaje: C#
- Framework: ASP.NET Web Forms
- Versión .NET: 4.7.2
- Servidor Web: IIS 10
- Sistema Operativo: Windows Server 2022