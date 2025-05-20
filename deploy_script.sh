#!/bin/bash
# Script de despliegue para la aplicación PeCe's (versión Unix/macOS)
# Este script automatiza el proceso de publicación y empaquetado para despliegue

# Colores para mejor visualización
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 1. Definir variables
PROJECT_PATH=$(dirname "$(realpath "$0")")
PROJECT_FILE="$PROJECT_PATH/peces.csproj"
DEPLOY_FOLDER_NAME="peces-deploy"
DEPLOY_PATH="$PROJECT_PATH/$DEPLOY_FOLDER_NAME"
ZIP_FILE_NAME="peces_entrega.zip"
ZIP_FILE_PATH="$PROJECT_PATH/$ZIP_FILE_NAME"
DOCUMENTATION_FOLDER="$PROJECT_PATH/documentacion"
GUIDE_FILE="$DOCUMENTATION_FOLDER/guia_despliegue.md"

# 2. Verificar que el entorno es correcto
echo -e "${CYAN}Verificando entorno de desarrollo...${NC}"
if [ ! -f "$PROJECT_FILE" ]; then
    echo -e "${RED}Error: No se encuentra el archivo de proyecto en $PROJECT_FILE${NC}"
    exit 1
fi

# 3. Crear el directorio de despliegue si no existe
if [ ! -d "$DEPLOY_PATH" ]; then
    echo -e "${CYAN}Creando directorio de despliegue: $DEPLOY_PATH${NC}"
    mkdir -p "$DEPLOY_PATH"
else
    echo -e "${CYAN}Limpiando directorio de despliegue anterior...${NC}"
    rm -rf "$DEPLOY_PATH"/*
fi

# 4. Crear directorio de documentación si no existe
if [ ! -d "$DOCUMENTATION_FOLDER" ]; then
    echo -e "${CYAN}Creando directorio de documentación: $DOCUMENTATION_FOLDER${NC}"
    mkdir -p "$DOCUMENTATION_FOLDER"
fi

# 5. Publicar el proyecto
echo -e "${CYAN}Nota: En macOS/Linux necesitas tener configurado dotnet o msbuild${NC}"
echo -e "${CYAN}Publicando proyecto a $DEPLOY_PATH...${NC}"

# Intentar con dotnet primero, luego con msbuild
if command -v dotnet &> /dev/null; then
    dotnet publish "$PROJECT_FILE" -c Release -o "$DEPLOY_PATH"
elif command -v msbuild &> /dev/null; then
    msbuild "$PROJECT_FILE" /p:Configuration=Release /p:Platform="Any CPU" /p:DeployOnBuild=true /p:WebPublishMethod=FileSystem /p:publishUrl="$DEPLOY_PATH"
else
    echo -e "${YELLOW}Advertencia: No se pudo ejecutar la publicación automatizada.${NC}"
    echo -e "${YELLOW}Por favor, usa Visual Studio para publicar el proyecto en la carpeta: $DEPLOY_PATH${NC}"
    mkdir -p "$DEPLOY_PATH"
fi

# 6. Generar guía de despliegue si no existe
if [ ! -f "$GUIDE_FILE" ]; then
    echo -e "${CYAN}Generando guía de despliegue en $GUIDE_FILE${NC}"
    mkdir -p "$DOCUMENTATION_FOLDER"
    cat > "$GUIDE_FILE" << 'EOL'
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
EOL
fi

# 7. Preparar el archivo ZIP para entrega
echo -e "${CYAN}Creando archivo ZIP para entrega: $ZIP_FILE_PATH${NC}"

# Eliminar ZIP anterior si existe
if [ -f "$ZIP_FILE_PATH" ]; then
    rm "$ZIP_FILE_PATH"
fi

# Comprimir archivos para la entrega (excluir archivos temporales y directorios .git)
cd "$PROJECT_PATH"
zip -r "$ZIP_FILE_NAME" . -x "*.git*" "*/.vs/*" "*/bin/*" "*/obj/*" "*/packages/*" "*$ZIP_FILE_NAME"

# 8. Resumen final
echo -e "${GREEN}\nResumen del despliegue:${NC}"
echo -e "${GREEN}- Publicación completada en: $DEPLOY_PATH${NC}"
echo -e "${GREEN}- Guía de despliegue generada en: $GUIDE_FILE${NC}"
echo -e "${GREEN}- Archivo ZIP para entrega creado en: $ZIP_FILE_PATH${NC}"
echo -e "${YELLOW}\nPaso siguiente: Seguir la guía de despliegue para configurar la máquina virtual e IIS.${NC}"