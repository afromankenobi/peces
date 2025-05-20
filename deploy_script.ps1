# Script de despliegue para la aplicación PeCe's
# Este script automatiza el proceso de publicación y empaquetado para despliegue

# 1. Definir variables
$projectPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectFile = Join-Path $projectPath "peces.csproj"
$deployFolderName = "peces-deploy"
$deployPath = Join-Path $projectPath $deployFolderName
$zipFileName = "peces_entrega.zip"
$zipFilePath = Join-Path $projectPath $zipFileName
$documentationFolder = Join-Path $projectPath "documentacion"
$guideFile = Join-Path $documentationFolder "guia_despliegue.md"

# 2. Verificar que el entorno es correcto
Write-Host "Verificando entorno de desarrollo..." -ForegroundColor Cyan
if (-not (Test-Path $projectFile)) {
    Write-Host "Error: No se encuentra el archivo de proyecto en $projectFile" -ForegroundColor Red
    exit 1
}

# 3. Crear el directorio de despliegue si no existe
if (-not (Test-Path $deployPath)) {
    Write-Host "Creando directorio de despliegue: $deployPath" -ForegroundColor Cyan
    New-Item -ItemType Directory -Path $deployPath | Out-Null
} else {
    Write-Host "Limpiando directorio de despliegue anterior..." -ForegroundColor Cyan
    Remove-Item -Path "$deployPath\*" -Recurse -Force
}

# 4. Crear directorio de documentación si no existe
if (-not (Test-Path $documentationFolder)) {
    Write-Host "Creando directorio de documentación: $documentationFolder" -ForegroundColor Cyan
    New-Item -ItemType Directory -Path $documentationFolder | Out-Null
}

# 5. Publicar el proyecto con MSBuild
Write-Host "Publicando proyecto a $deployPath..." -ForegroundColor Cyan
& msbuild $projectFile /p:Configuration=Release /p:Platform="Any CPU" /p:DeployOnBuild=true /p:WebPublishMethod=FileSystem /p:publishUrl=$deployPath

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: La publicación falló con código $LASTEXITCODE" -ForegroundColor Red
    exit 1
}

# 6. Generar guía de despliegue si no existe
if (-not (Test-Path $guideFile)) {
    Write-Host "Generando guía de despliegue en $guideFile" -ForegroundColor Cyan
    $guideContent = @"
# Guía de Despliegue - Aplicación PeCe's

## Requisitos previos

- Windows Server 2022
- VMware Workstation
- IIS con soporte para ASP.NET 4.7.2

## Configuración de la Máquina Virtual

1. Crear una nueva máquina virtual en VMware Workstation con las siguientes características:
   - 3GB de RAM
   - 3 núcleos de procesador
   - 60GB de disco duro
   - Sistema operativo: Windows Server 2022

2. Instalar VMware Tools para permitir la migración del sitio.

## Instalación y Configuración de IIS

1. En el Administrador del servidor, seleccionar "Agregar roles y características".
2. Elegir "Instalación basada en roles o características".
3. Seleccionar el servidor actual.
4. Marcar "Servidor web (IIS)" y seleccionar las siguientes características adicionales:
   - Desarrollo de aplicaciones > ASP.NET 4.7
   - Desarrollo de aplicaciones > .NET Extensibility 4.7
   - Desarrollo de aplicaciones > ISAPI Extensions
   - Desarrollo de aplicaciones > ISAPI Filters
5. Completar el asistente y reiniciar si es necesario.

## Despliegue del Sitio Web

1. Copiar la carpeta "peces-deploy" al directorio `C:\inetpub\wwwroot\` de la máquina virtual.
2. Verificar que el grupo IIS_IUSRS tenga permisos sobre la carpeta:
   - Clic derecho en la carpeta > Propiedades > Seguridad
   - Editar > Agregar > Escribir "IIS_IUSRS" > Comprobar nombres > Aceptar
   - Asignar permisos de Lectura y Ejecución, Mostrar contenido de la carpeta y Lectura

3. Abrir el Administrador de Internet Information Services (IIS).
4. Detener el sitio web por defecto:
   - En el panel izquierdo, expandir el servidor
   - Expandir "Sitios"
   - Clic derecho en "Default Web Site" > Detener

5. Crear un nuevo sitio web:
   - Clic derecho en "Sitios" > Agregar sitio web
   - Nombre del sitio: peces-web
   - Ruta física: C:\inetpub\wwwroot\peces-deploy
   - Puerto: 80
   - Clic en Aceptar

6. Configurar el documento predeterminado:
   - Seleccionar el sitio "peces-web"
   - Doble clic en "Documento predeterminado"
   - Clic en "Agregar" en el panel derecho
   - Escribir "Home.aspx" y hacer clic en Aceptar
   - Mover "Home.aspx" al principio de la lista

## Pruebas del Sitio

1. Abrir un navegador en la máquina virtual.
2. Navegar a http://localhost
3. Verificar que se muestra la página de inicio correctamente.
4. Probar las funcionalidades principales:
   - Listar tickets
   - Agregar un nuevo ticket
   - Ver detalle de un ticket
   - Actualizar un ticket
   - Eliminar un ticket

## Solución de Problemas Comunes

1. Error 500.19 - Internal Server Error:
   - Verificar que ASP.NET está correctamente registrado en IIS
   - Ejecutar: `%windir%\Microsoft.NET\Framework64\v4.0.30319\aspnet_regiis.exe -ir`

2. Error de permisos:
   - Verificar los permisos de la carpeta de despliegue
   - Asegurar que IIS_IUSRS tiene los permisos correctos

3. Error de configuración:
   - Revisar el archivo Web.config y asegurar que UnobtrusiveValidationMode está configurado como None
"@
    Set-Content -Path $guideFile -Value $guideContent
}

# 7. Preparar el archivo ZIP para entrega
Write-Host "Creando archivo ZIP para entrega: $zipFilePath" -ForegroundColor Cyan

# Eliminar ZIP anterior si existe
if (Test-Path $zipFilePath) {
    Remove-Item -Path $zipFilePath -Force
}

# Comprimir archivos para la entrega
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::CreateFromDirectory($projectPath, $zipFilePath, 
    [System.IO.Compression.CompressionLevel]::Optimal, $false)

# 8. Resumen final
Write-Host "`nResumen del despliegue:" -ForegroundColor Green
Write-Host "- Publicación completada en: $deployPath" -ForegroundColor Green
Write-Host "- Guía de despliegue generada en: $guideFile" -ForegroundColor Green
Write-Host "- Archivo ZIP para entrega creado en: $zipFilePath" -ForegroundColor Green
Write-Host "`nPaso siguiente: Seguir la guía de despliegue para configurar la máquina virtual e IIS." -ForegroundColor Yellow