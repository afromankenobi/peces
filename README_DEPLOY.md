# Despliegue de Aplicación PeCe's

Este documento proporciona una guía completa para el despliegue de la aplicación web PeCe's en un servidor Windows Server 2022 con IIS.

## Contenido del Paquete de Despliegue

El paquete de despliegue contiene los siguientes elementos:

| Archivo/Carpeta | Descripción |
|-----------------|-------------|
| `deploy_script.ps1` | Script de PowerShell para automatizar la publicación (Windows) |
| `deploy_script.sh` | Script de Bash para automatizar la publicación (macOS/Linux) |
| `documentacion/` | Directorio con guías y plantillas |
| `documentacion/guia_despliegue.md` | Guía detallada paso a paso para el despliegue |
| `documentacion/plantilla_informe_despliegue.md` | Plantilla para documentar el proceso con capturas de pantalla |
| `documentacion/iis_check.ps1` | Script para verificar la configuración de IIS |
| `documentacion/README.md` | Instrucciones generales de despliegue |
| `peces-deploy/` | Carpeta con los archivos publicados (generada por los scripts) |

## Proceso de Despliegue - Guía Rápida

1. **Publicar la aplicación**:
   - En Windows: Ejecutar `deploy_script.ps1` con PowerShell
   - En macOS/Linux: Ejecutar `deploy_script.sh` con Bash
   - Alternativa: Usar Visual Studio para publicar en la carpeta "peces-deploy"

2. **Configurar la máquina virtual**:
   - Crear VM con Windows Server 2022 (3GB RAM, 3 núcleos, 60GB disco)
   - Instalar VMware Tools

3. **Instalar y configurar IIS**:
   - Instalar rol de Servidor Web (IIS) con soporte para ASP.NET 4.7
   - Verificar la instalación con `documentacion/iis_check.ps1`

4. **Desplegar el sitio web**:
   - Copiar carpeta "peces-deploy" a `C:\inetpub\wwwroot\` en la VM
   - Configurar permisos para el grupo IIS_IUSRS
   - Detener el sitio web por defecto
   - Crear nuevo sitio "peces-web" apuntando a la carpeta copiada
   - Configurar Home.aspx como documento predeterminado

5. **Probar el sitio**:
   - Acceder a http://localhost en la VM
   - Verificar todas las funcionalidades

6. **Documentar el proceso**:
   - Utilizar la plantilla `documentacion/plantilla_informe_despliegue.md`
   - Incluir capturas de pantalla de cada paso

## Requisitos de Entrega

El entregable final debe incluir:

1. Código fuente de la aplicación
2. Carpeta "peces-deploy" con los archivos publicados
3. Documento con capturas de pantalla del proceso de despliegue
4. Todo empaquetado en un archivo ZIP

## Solución de Problemas Comunes

Si encuentra problemas durante el despliegue:

1. Ejecutar el script `documentacion/iis_check.ps1` para verificar la configuración de IIS
2. Consultar la sección de "Solución de Problemas" en la guía de despliegue
3. Verificar los permisos de la carpeta de despliegue
4. Comprobar que ASP.NET está correctamente registrado en IIS

## Información Adicional

- La aplicación requiere .NET Framework 4.7.2 o superior
- El sitio debe configurarse para usar el puerto 80 (HTTP)
- Para una guía detallada paso a paso, consultar `documentacion/guia_despliegue.md`