# Limpieza de disco en Windows y WSL

Guía de comandos para liberar espacio en Windows y en distribuciones WSL 2 sin dañar el sistema. Cada comando incluye **qué hace**, **para qué sirve** y su **nivel de riesgo**.

> Última revisión: 2026-10-31.
> Probado en WSL 3.0.3.0 (Ubuntu, WSL 2) sobre Windows 10.0.26300.
> Las rutas con `<usuario>` o `<Distro>` deben sustituirse por los valores de tu equipo.

## Índice

- [Niveles de riesgo](#niveles-de-riesgo)
- [Antes de empezar](#antes-de-empezar)
- [1. Diagnóstico (solo lectura)](#1-diagnóstico-solo-lectura)
- [2. Limpieza segura en Windows](#2-limpieza-segura-en-windows)
- [3. Limpieza en WSL](#3-limpieza-en-wsl)
- [4. Compactar y mover el disco virtual de WSL](#4-compactar-y-mover-el-disco-virtual-de-wsl)
- [5. Qué no hacer](#5-qué-no-hacer)
- [6. Resumen de riesgos](#6-resumen-de-riesgos)
- [7. Checklist rápida](#7-checklist-rápida)
- [Referencias](#referencias)

## Niveles de riesgo

| Nivel | Significado |
| --- | --- |
| **Seguro** | Solo lee información o borra datos regenerables/temporales. No daña el sistema. |
| **Precaución** | Irreversible o con efectos secundarios (pierdes caché, funciones o datos concretos). Requiere leer las notas. |
| **Riesgo alto** | Puede borrar datos de usuario o dejar el sistema en un estado difícil de recuperar. Haz copia de seguridad antes. |

## Antes de empezar

1. Cierra programas y guarda tu trabajo. Varios comandos requieren que WSL esté detenido.
2. Crea un punto de restauración de Windows (PowerShell **como administrador**):

   ```powershell
   Checkpoint-Computer -Description "Antes de limpiar disco" -RestorePointType MODIFY_SETTINGS
   ```

   *Qué hace:* crea un punto de restauración del sistema.
   *Utilidad:* permite volver atrás si algo sale mal. Requiere que Protección del sistema esté activada.

3. Si vas a compactar o mover el disco de WSL, exporta primero la distro:

   ```powershell
   wsl --export Ubuntu D:\wsl\ubuntu-backup.tar
   ```

   *Qué hace:* empaqueta toda la distro (sistema de archivos completo) en un archivo `.tar`.
   *Utilidad:* copia de seguridad restaurable con `wsl --import`. Necesita espacio libre equivalente a lo usado dentro de la distro.

## 1. Diagnóstico (solo lectura)

Antes de borrar nada, mide dónde está el espacio.

### `Get-Volume` (PowerShell)

```powershell
Get-Volume
```

*Qué hace:* lista volúmenes con tamaño total y espacio libre.
*Utilidad:* identificar qué unidad está llena.
*Riesgo:* **Seguro**.

### Buscar los archivos más grandes (PowerShell)

```powershell
Get-ChildItem C:\Users\<usuario> -Recurse -File -ErrorAction SilentlyContinue |
  Sort-Object Length -Descending |
  Select-Object -First 25 FullName, @{n='GB';e={[math]::Round($_.Length/1GB,2)}}
```

*Qué hace:* recorre el perfil del usuario y muestra los 25 archivos más grandes.
*Utilidad:* localizar vídeos, ISOs, backups o cachés olvidadas.
*Riesgo:* **Seguro** (puede tardar varios minutos). Para un análisis visual completo, usa WizTree o TreeSize.

### `df` y `du` (WSL)

```bash
df -h /
sudo du -xh --max-depth=1 / | sort -rh | head -15
```

*Qué hace:* `df` muestra el uso del sistema de archivos; `du` suma el tamaño del primer nivel de directorios. `-x` evita entrar en `/mnt/c`.
*Utilidad:* ver qué consume espacio dentro de la distro.
*Riesgo:* **Seguro**. `du` puede tardar; ejecútalo con `sudo` para leer todo.

### `wsl -l -v` (PowerShell)

```powershell
wsl --list --verbose
```

*Qué hace:* lista distros, estado y versión de WSL.
*Utilidad:* saber el nombre exacto de la distro (`Ubuntu`, etc.) antes de usar `--manage`, `--export` o `--move`.
*Riesgo:* **Seguro**.

## 2. Limpieza segura en Windows

### Papelera de reciclaje

```powershell
Clear-RecycleBin -Force
# O solo una unidad:
Clear-RecycleBin -DriveLetter C -Force
```

*Qué hace:* vacía la papelera de reciclaje de forma permanente.
*Utilidad:* suele liberar varios GB si hace tiempo que no se vacía.
*Riesgo:* **Precaución**: lo borrado no se puede recuperar.

### Archivos temporales

```powershell
Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

# Requiere PowerShell como administrador
Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
```

*Qué hace:* borra el contenido de las carpetas temporales del usuario y del sistema.
*Utilidad:* elimina restos de instaladores, actualizaciones y aplicaciones.
*Riesgo:* **Seguro**. Los archivos en uso no se borran (el error se ignora); no afecta a programas instalados.

### Liberador de espacio (`cleanmgr`)

```powershell
cleanmgr /sageset:1     # una sola vez: elige categorías en la ventana
cleanmgr /sagerun:1     # ejecuta la limpieza con esas categorías
```

*Qué hace:* abre el Liberador de espacio con un perfil guardado y luego lo ejecuta sin interfaz.
*Utilidad:* limpia de forma oficial `Windows.old`, actualizaciones antiguas, miniaturas, registros de errores, caché de Optimización de entrega, etc. Es la vía más segura para los restos de Windows.
*Riesgo:* **Seguro** si no marcas "Descargas" (esa carpeta es tuya).

### Analizar y limpiar el almacén de componentes (`DISM`)

```powershell
Dism /Online /Cleanup-Image /AnalyzeComponentStore
Dism /Online /Cleanup-Image /StartComponentCleanup
```

*Qué hace:* analiza `C:\Windows\WinSxS` y elimina componentes reemplazados por actualizaciones.
*Utilidad:* recupera espacio de versiones antiguas de archivos del sistema sin tocar los actuales.
*Riesgo:* **Seguro**. Puede tardar bastante. No borres `WinSxS` a mano.

```powershell
Dism /Online /Cleanup-Image /StartComponentCleanup /ResetBase
```

*Qué hace:* además elimina las copias que permiten desinstalar actualizaciones ya aplicadas.
*Utilidad:* libera más espacio.
*Riesgo:* **Precaución**: después no podrás desinstalar actualizaciones instaladas. No lo uses si el sistema está inestable.

### Desactivar la hibernación

```powershell
powercfg /h off
```

*Qué hace:* elimina `C:\hiberfil.sys`.
*Utilidad:* libera varios GB (proporcional a la RAM).
*Riesgo:* **Precaución**: pierdes hibernación e inicio rápido. Se revierte con `powercfg /h on`.

### Limitar los puntos de restauración

```powershell
vssadmin list shadowstorage
vssadmin resize shadowstorage /for=C: /on=C: /maxsize=10GB
```

*Qué hace:* consulta y limita el espacio reservado para instantáneas (Restaurar sistema y Versiones anteriores).
*Utilidad:* evita que los puntos de restauración crezcan sin control; no los desactiva.
*Riesgo:* **Precaución**: al reducir el límite se eliminan las instantáneas más antiguas.

### Desinstalar programas que no usas

```powershell
winget list
winget uninstall <id-del-paquete>
```

*Qué hace:* lista y desinstala aplicaciones desde la línea de comandos.
*Utilidad:* los programas grandes olvidados suelen ser la mayor fuente de espacio recuperable.
*Riesgo:* **Precaución**: desinstalar puede borrar datos o configuración de la aplicación. Revisa qué seleccionas.

### TRIM en el SSD

```powershell
Optimize-Volume -DriveLetter C -ReTrim -Verbose
```

*Qué hace:* envía el comando TRIM a las celdas libres del SSD.
*Utilidad:* mantiene el rendimiento y permite que el disco recupere bloques. No es una desfragmentación.
*Riesgo:* **Seguro**.

### Sensor de almacenamiento

```powershell
start ms-settings:storagesense
```

*Qué hace:* abre la configuración del Sensor de almacenamiento.
*Utilidad:* activa la limpieza automática de temporales y papelera cuando queda poco espacio.
*Riesgo:* **Seguro**.

## 3. Limpieza en WSL

Ejecuta estos comandos **dentro** de la distro (terminal Ubuntu).

### Paquetes huérfanos y caché de APT

```bash
sudo apt autoremove --purge
sudo apt clean
```

*Qué hace:* `autoremove --purge` elimina paquetes que ya no son dependencia de nada (y sus configuraciones); `apt clean` vacía `/var/cache/apt/archives`.
*Utilidad:* elimina kernels antiguos, dependencias sueltas y `.deb` descargados.
*Riesgo:* **Seguro**. `--purge` borra también ficheros de configuración de esos paquetes; si quieres conservarlos, usa solo `autoremove`.

### Registro del sistema (`journald`)

```bash
sudo journalctl --vacuum-size=100M
```

*Qué hace:* recorta el journal de systemd hasta dejar 100 MB.
*Utilidad:* los logs pueden crecer durante meses.
*Riesgo:* **Seguro**. Solo aplica si el journal está activo; si no, el comando no existe o no hace nada.

### Cachés de lenguajes

```bash
npm cache clean --force
pip cache purge
```

*Qué hace:* vacía la caché de npm y de pip.
*Utilidad:* recupera cientos de MB; las dependencias se vuelven a descargar cuando hagan falta.
*Riesgo:* **Seguro**.

### Servidores remotos de editores

```bash
rm -rf ~/.vscode-server ~/.qoder-server
```

*Qué hace:* borra la instalación remota de VS Code / Qoder y sus extensiones en WSL.
*Utilidad:* en este tipo de entornos suelen ocupar más de 1 GB.
*Riesgo:* **Precaución**: se regeneran al reconectar, pero perderás las extensiones instaladas hasta reinstalarlas. No toca tus proyectos.

### Docker (solo si lo usas)

```bash
docker system df
docker system prune
```

*Qué hace:* `df` muestra qué ocupa; `prune` elimina contenedores detenidos, redes sin uso, imágenes colgantes y caché de build.
*Utilidad:* Docker guarda capas e imágenes antiguas que pueden sumar decenas de GB.
*Riesgo:* **Precaución**. `prune` no borra volúmenes por defecto.

```bash
docker system prune -a --volumes
```

*Qué hace:* elimina además **todas** las imágenes sin contenedor y los volúmenes no usados.
*Utilidad:* limpieza profunda.
*Riesgo:* **Riesgo alto**: borra datos de volúmenes (bases de datos, configuraciones). Revisa `docker volume ls` antes.

### TRIM dentro de WSL

```bash
sudo fstrim -av
```

*Qué hace:* informa al disco virtual de qué bloques ya no se usan.
*Utilidad:* imprescindible antes de compactar el `.vhdx`; sin esto, el archivo no encoge aunque borres datos.
*Riesgo:* **Seguro**.

## 4. Compactar y mover el disco virtual de WSL

WSL 2 guarda la distro en un archivo `ext4.vhdx` que **crece pero no se encoge solo**. Aunque borres archivos dentro, el `.vhdx` mantiene su tamaño en `C:` hasta que lo compactas.

### Localizar el disco virtual

```powershell
Get-ChildItem "$env:LOCALAPPDATA\wsl" -Recurse -Filter ext4.vhdx |
  Select-Object FullName, @{n='GB';e={[math]::Round($_.Length/1GB,2)}}
```

*Qué hace:* encuentra el `.vhdx` de las distros instaladas desde la Store (WSL moderno).
*Utilidad:* obtener la ruta exacta que necesitan `diskpart` u `Optimize-VHD`. En instalaciones antiguas puede estar en `%LOCALAPPDATA%\Packages\CanonicalGroupLimited...\LocalState\`.
*Riesgo:* **Seguro**.

### Preparar la distro

```bash
# dentro de WSL
sudo fstrim -av
```

```powershell
# en PowerShell
wsl --shutdown
```

*Qué hace:* `fstrim` marca los bloques libres; `wsl --shutdown` detiene todas las distros.
*Utilidad:* sin esto, la compactación no recupera espacio y el archivo puede estar bloqueado.
*Riesgo:* **Seguro**, pero `wsl --shutdown` cierra todas las sesiones: guarda tu trabajo antes.

### Opción A: disco disperso (WSL 2.0+)

```powershell
wsl --manage Ubuntu --set-sparse true
```

*Qué hace:* convierte el `.vhdx` en un disco disperso que devuelve espacio a Windows de forma automática.
*Utilidad:* evita tener que compactar manualmente en el futuro.
*Riesgo:* **Precaución**. Versiones antiguas de WSL tuvieron problemas de corrupción con discos dispersos; en WSL 3.x es estable, pero exporta la distro antes por seguridad.

### Opción B: `diskpart` (funciona en Windows Home)

PowerShell **como administrador**, con WSL detenido:

```powershell
diskpart
select vdisk file="C:\Users\<usuario>\AppData\Local\wsl\{GUID}\ext4.vhdx"
attach vdisk readonly
compact vdisk
detach vdisk
exit
```

*Qué hace:* monta el disco virtual en **solo lectura** y compacta los bloques libres.
*Utilidad:* recupera en `C:` el espacio que ya no usas dentro de la distro.
*Riesgo:* **Precaución**. Montarlo en modo lectura es deliberado: no lo adjuntes en modo escritura desde Windows. Haz copia con `wsl --export` antes.

### Opción C: `Optimize-VHD` (requiere Hyper-V)

```powershell
Optimize-VHD -Path "C:\Users\<usuario>\AppData\Local\wsl\{GUID}\ext4.vhdx" -Mode Full
```

*Qué hace:* compacta el `.vhdx` con el cmdlet de Hyper-V.
*Utilidad:* alternativa a `diskpart`, más directa.
*Riesgo:* **Precaución**. Solo disponible en Windows Pro/Enterprise con el módulo de Hyper-V; WSL debe estar detenido.

### Mover la distro a otra unidad

```powershell
wsl --shutdown
wsl --manage Ubuntu --move D:\WSL\Ubuntu
```

*Qué hace:* traslada el `.vhdx` a otra ruta o unidad.
*Utilidad:* si `C:` sigue lleno, mueve la distro (y su crecimiento futuro) a otro disco.
*Riesgo:* **Precaución**. No interrumpas el proceso; exporta antes con `wsl --export`.

### Verificar el resultado

```powershell
Get-ChildItem "$env:LOCALAPPDATA\wsl" -Recurse -Filter ext4.vhdx |
  Select-Object FullName, @{n='GB';e={[math]::Round($_.Length/1GB,2)}}
Get-Volume
```

*Qué hace:* muestra el nuevo tamaño del `.vhdx` y el espacio libre.
*Utilidad:* comprobar cuánto se recuperó.
*Riesgo:* **Seguro**.

## 5. Qué no hacer

- **No borrar a mano** `C:\Windows\WinSxS`, `C:\Windows\SoftwareDistribution`, `C:\Windows\System32` ni `pagefile.sys`. Usa `DISM` y el Liberador de espacio.
- **No desactivar** el archivo de paginación ni el swap de WSL para "ganar espacio": provoca cuelgues y errores de memoria.
- **No usar** limpiadores de registro ni "optimizadores" de terceros.
- **No desfragmentar** un SSD; usa TRIM (`Optimize-Volume -ReTrim`) y deja que Windows lo gestione.
- **No borrar** `Windows.old` a mano: el Liberador de espacio lo hace correctamente.
- **No ejecutar** `rm -rf` sobre `/usr`, `/var`, `/etc`, `/lib` ni `~/.local` "para limpiar". Usa `apt autoremove` y `apt clean`.
- **No adjuntar** el `.vhdx` de WSL en modo lectura/escritura desde Windows: puede corromper la distro. Solo en modo `readonly` para compactar.
- **No vaciar** `SoftwareDistribution` mientras hay actualizaciones pendientes o en curso.
- **No ejecutar** `docker system prune -a --volumes` sin revisar los volúmenes: borra datos de aplicaciones.

## 6. Resumen de riesgos

| Comando | Qué hace | Riesgo |
| --- | --- | --- |
| `Get-Volume`, `df`, `du` | Diagnóstico de espacio | Seguro |
| `Get-ChildItem ... Sort-Object Length` | Localiza archivos grandes | Seguro |
| `Checkpoint-Computer` | Crea punto de restauración | Seguro |
| `Clear-RecycleBin` | Vacía la papelera | Precaución |
| `Remove-Item $env:TEMP\*` | Borra temporales | Seguro |
| `cleanmgr /sageset` + `/sagerun` | Liberador de espacio de Windows | Seguro |
| `Dism ... /AnalyzeComponentStore` | Analiza WinSxS | Seguro |
| `Dism ... /StartComponentCleanup` | Limpia componentes antiguos | Seguro |
| `Dism ... /StartComponentCleanup /ResetBase` | Elimina copias de actualizaciones | Precaución |
| `powercfg /h off` | Borra hiberfil.sys | Precaución |
| `vssadmin resize shadowstorage` | Limita puntos de restauración | Precaución |
| `winget uninstall` | Desinstala aplicaciones | Precaución |
| `Optimize-Volume -ReTrim` | TRIM del SSD | Seguro |
| `apt autoremove --purge` | Quita paquetes huérfanos | Seguro |
| `apt clean` | Vacía caché de APT | Seguro |
| `journalctl --vacuum-size` | Recorta logs | Seguro |
| `npm cache clean`, `pip cache purge` | Vacía cachés | Seguro |
| `rm -rf ~/.vscode-server` | Borra servidor remoto del editor | Precaución |
| `docker system prune` | Limpia Docker (sin volúmenes) | Precaución |
| `docker system prune -a --volumes` | Limpieza total de Docker | Riesgo alto |
| `fstrim -av` | Marca bloques libres | Seguro |
| `wsl --export` | Copia de seguridad de la distro | Seguro |
| `wsl --shutdown` | Detiene todas las distros | Seguro (cierra sesiones) |
| `wsl --manage --set-sparse true` | Disco disperso automático | Precaución |
| `diskpart ... compact vdisk` | Compacta el `.vhdx` | Precaución |
| `Optimize-VHD` | Compacta el `.vhdx` (Hyper-V) | Precaución |
| `wsl --manage --move` | Mueve la distro de unidad | Precaución |

## 7. Checklist rápida

1. `Get-Volume` y `du` para saber dónde está el espacio.
2. `Checkpoint-Computer` y `wsl --export Ubuntu D:\wsl\ubuntu-backup.tar`.
3. `cleanmgr /sagerun:1` + `Clear-RecycleBin` en Windows.
4. `winget list` y desinstalar lo que sobre.
5. Dentro de WSL: `apt autoremove --purge`, `apt clean`, cachés de npm/pip.
6. `sudo fstrim -av`, luego `wsl --shutdown`.
7. Compactar con `diskpart` o `--set-sparse` y verificar con `Get-Volume`.

## Referencias

- [Comandos básicos de WSL](https://learn.microsoft.com/windows/wsl/basic-commands)
- [Gestión de espacio en disco de WSL](https://learn.microsoft.com/windows/wsl/disk-space)
- [Opciones de DISM para mantenimiento de imágenes](https://learn.microsoft.com/windows-hardware/manufacture/desktop/dism-image-management-command-line-options-s14)
- [cleanmgr](https://learn.microsoft.com/windows-server/administration/windows-commands/cleanmgr)
- [Optimize-VHD](https://learn.microsoft.com/powershell/module/storage/optimize-vhd)
- [Documentación de npm cache](https://docs.npmjs.com/cli/v10/commands/npm-cache)
- [Documentación de pip cache](https://pip.pypa.io/en/stable/cli/pip_cache/)
