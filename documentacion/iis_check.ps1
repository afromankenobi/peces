# Script para verificar la configuración de IIS y ASP.NET
# Este script debe ejecutarse en la máquina virtual Windows Server 2022 después de instalar IIS

# Colores para mejor visualización
function Write-ColorOutput($ForegroundColor) {
    $fc = $host.UI.RawUI.ForegroundColor
    $host.UI.RawUI.ForegroundColor = $ForegroundColor
    if ($args) {
        Write-Output $args
    }
    else {
        $input | Write-Output
    }
    $host.UI.RawUI.ForegroundColor = $fc
}

# Función para verificar si una característica de Windows está instalada
function Test-WindowsFeature {
    param (
        [string]$FeatureName
    )
    
    $feature = Get-WindowsFeature -Name $FeatureName -ErrorAction SilentlyContinue
    if ($feature -and $feature.Installed) {
        return $true
    } else {
        return $false
    }
}

# Encabezado
Write-ColorOutput Green "=========================================================="
Write-ColorOutput Green "      Verificación de Configuración IIS para PeCe's"
Write-ColorOutput Green "=========================================================="

# Verificar que IIS está instalado
Write-ColorOutput Cyan "`nVerificando instalación de IIS..."
$iisService = Get-Service -Name W3SVC -ErrorAction SilentlyContinue
if ($iisService) {
    Write-ColorOutput Green "✓ IIS está instalado"
} else {
    Write-ColorOutput Red "❌ IIS no está instalado."
    Write-ColorOutput Yellow "  Ejecute el siguiente comando para instalar IIS con soporte ASP.NET:"
    Write-ColorOutput Yellow "  Install-WindowsFeature -Name Web-Server,Web-Asp-Net45 -IncludeManagementTools"
}

# Verificar si .NET Framework está instalado
Write-ColorOutput Cyan "`nVerificando instalación de .NET Framework 4.7.2..."
if (Test-Path "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full") {
    $releaseKey = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" -Name Release -ErrorAction SilentlyContinue
    if ($releaseKey.Release -ge 461808) {
        Write-ColorOutput Green "✓ .NET Framework 4.7.2 o superior está instalado"
    } else {
        Write-ColorOutput Yellow "⚠ .NET Framework 4.7.2 o superior podría no estar instalado."
    }
} else {
    Write-ColorOutput Red "❌ No se puede verificar la instalación de .NET Framework."
}

# Verificar características de IIS para ASP.NET
Write-ColorOutput Cyan "`nVerificando características de IIS para ASP.NET..."

$features = @(
    @{Name="Web-Asp-Net45"; Description="ASP.NET 4.7"},
    @{Name="Web-Net-Ext45"; Description=".NET Extensibility 4.7"},
    @{Name="Web-ISAPI-Ext"; Description="ISAPI Extensions"},
    @{Name="Web-ISAPI-Filter"; Description="ISAPI Filters"}
)

$allFeaturesInstalled = $true
foreach ($feature in $features) {
    if (Test-WindowsFeature -FeatureName $feature.Name) {
        Write-ColorOutput Green "✓ $($feature.Description) está instalado"
    } else {
        Write-ColorOutput Red "❌ $($feature.Description) no está instalado"
        $allFeaturesInstalled = $false
    }
}

if (-not $allFeaturesInstalled) {
    Write-ColorOutput Yellow "`nAlgunas características de IIS necesarias no están instaladas."
    Write-ColorOutput Yellow "Ejecute el siguiente comando para instalar las características faltantes:"
    Write-ColorOutput Yellow "Install-WindowsFeature -Name Web-Asp-Net45,Web-Net-Ext45,Web-ISAPI-Ext,Web-ISAPI-Filter"
}

# Verificar si el App Pool para ASP.NET 4.0 existe
Write-ColorOutput Cyan "`nVerificando Application Pools..."
$appPools = & $env:SystemRoot\System32\inetsrv\appcmd.exe list apppool /state:Started
if ($appPools -match "DefaultAppPool") {
    Write-ColorOutput Green "✓ El DefaultAppPool está ejecutándose"
} else {
    Write-ColorOutput Red "❌ El DefaultAppPool no está ejecutándose."
}

# Verificar sitio web PeCe's
Write-ColorOutput Cyan "`nVerificando sitio web PeCe's..."
$sites = & $env:SystemRoot\System32\inetsrv\appcmd.exe list site
if ($sites -match "peces-web") {
    Write-ColorOutput Green "✓ El sitio 'peces-web' existe"
    
    # Verificar configuración del sitio
    $siteInfo = & $env:SystemRoot\System32\inetsrv\appcmd.exe list site "peces-web" /text:*
    
    if ($siteInfo -match "bindings:http/\*:80:") {
        Write-ColorOutput Green "✓ El sitio está configurado en el puerto 80 (HTTP)"
    } else {
        Write-ColorOutput Yellow "⚠ El sitio podría no estar configurado en el puerto 80 (HTTP)"
    }
    
    if ($siteInfo -match "state:Started") {
        Write-ColorOutput Green "✓ El sitio está iniciado"
    } else {
        Write-ColorOutput Red "❌ El sitio no está iniciado"
    }
} else {
    Write-ColorOutput Red "❌ El sitio 'peces-web' no existe."
    Write-ColorOutput Yellow "  Siga los pasos de la guía para crear el sitio web."
}

# Verificar permisos de carpeta
Write-ColorOutput Cyan "`nVerificando permisos de carpeta..."
$deployPath = "C:\inetpub\wwwroot\peces-deploy"
if (Test-Path $deployPath) {
    Write-ColorOutput Green "✓ La carpeta de despliegue existe: $deployPath"
    
    $acl = Get-Acl $deployPath
    if ($acl.Access | Where-Object { $_.IdentityReference -match "IIS_IUSRS" }) {
        Write-ColorOutput Green "✓ El grupo IIS_IUSRS tiene permisos sobre la carpeta"
    } else {
        Write-ColorOutput Red "❌ El grupo IIS_IUSRS no tiene permisos sobre la carpeta"
        Write-ColorOutput Yellow "  Asigne permisos al grupo IIS_IUSRS sobre la carpeta"
    }
} else {
    Write-ColorOutput Red "❌ La carpeta de despliegue no existe: $deployPath"
    Write-ColorOutput Yellow "  Cree la carpeta y copie los archivos de la aplicación."
}

# Verificar que Home.aspx es el documento predeterminado
Write-ColorOutput Cyan "`nVerificando documentos predeterminados..."
$defaultDocs = & $env:SystemRoot\System32\inetsrv\appcmd.exe list config "peces-web" /section:defaultDocument
if ($defaultDocs -match "Home.aspx") {
    Write-ColorOutput Green "✓ Home.aspx está configurado como documento predeterminado"
} else {
    Write-ColorOutput Yellow "⚠ Home.aspx podría no estar configurado como documento predeterminado"
    Write-ColorOutput Yellow "  Configure Home.aspx como documento predeterminado."
}

# Verificar acceso al sitio web
Write-ColorOutput Cyan "`nVerificando acceso al sitio web..."
try {
    $response = Invoke-WebRequest -Uri "http://localhost" -UseBasicParsing
    if ($response.StatusCode -eq 200) {
        Write-ColorOutput Green "✓ El sitio web responde correctamente (HTTP 200)"
    } else {
        Write-ColorOutput Yellow "⚠ El sitio web responde con un código inesperado: $($response.StatusCode)"
    }
} catch {
    Write-ColorOutput Red "❌ No se puede acceder al sitio web: $_"
    Write-ColorOutput Yellow "  Verifique que el sitio esté iniciado y configurado correctamente."
}

# Resumen final
Write-ColorOutput Cyan "`nResumen de la verificación:"
Write-ColorOutput Cyan "================================="
Write-ColorOutput Cyan "Esta verificación comprueba la configuración básica de IIS"
Write-ColorOutput Cyan "para ejecutar la aplicación PeCe's. Si encuentra errores,"
Write-ColorOutput Cyan "consulte la guía de despliegue para resolverlos."
Write-ColorOutput Cyan "`nRecuerde realizar pruebas manuales para verificar todas las"
Write-ColorOutput Cyan "funcionalidades de la aplicación."