# Cómo subir archivos a GitHub o actualizar tu repositorio desde VS Code

> Guía práctica para principiantes. No hace falta saber Git de antemano.
> Funciona en **Visual Studio Code** y en editores basados en él, como **Qoder**.
> Si trabajas en este repositorio, recuerda que `clase_de_lisp/` es de **solo lectura**.

**Si tienes prisa:** ve directamente a la **sección 15** (resumen de una página).

| Si estás en este caso... | Lee... |
|---|---|
| Nunca usé Git ni GitHub | Secciones 1 a 4 |
| Ya tengo el repositorio y quiero subir cambios | Sección 4 |
| Quiero subir un proyecto nuevo | Sección 5 |
| Quiero crear el repositorio y clonarlo | Sección 6 |
| Solo quiero subir un archivo suelto | Sección 7 |
| Algo falló | Sección 8 |

---

## 0. Lo que vas a aprender

Al terminar esta guía vas a poder:

1. Entender qué es un **commit** y qué es un **push**.
2. **Actualizar** un repositorio que ya existe en GitHub.
3. **Subir por primera vez** un proyecto nuevo.
4. **Crear un repositorio en GitHub y clonarlo** en tu computadora.
5. Subir un archivo suelto **desde el navegador**, sin usar Git.
6. Reconocer y resolver los errores más comunes.
7. Evitar las tres equivocaciones que más trabajo cuestan: subir secretos, borrar cambios sin querer y hacer `force push`.

---

## 1. Las tres ideas básicas

### 1.1. Tu copia y la copia de GitHub

- **Repositorio local:** la carpeta de tu computadora.
- **Repositorio remoto:** la copia que está en GitHub.
- **`origin`:** el apodo que Git le da a ese remoto. No es una carpeta especial; es un nombre.

Tú trabajas en la copia local. GitHub no se entera de nada hasta que haces **push**.

### 1.2. Commit y push no son lo mismo

| Acción | Qué hace | ¿Sube a GitHub? |
|---|---|---|
| Guardar el archivo | Escribe el archivo en tu disco | No |
| **Commit** | Guarda una «foto» de tus cambios en el historial local | **No** |
| **Push** | Sube los commits locales a GitHub | **Sí** |

Analogía: el commit es guardar una foto en tu teléfono; el push es enviarla a la nube.

### 1.3. El recorrido completo

```text
Tu carpeta
   │
   │  git add  (o el botón +)
   ▼
Cambios preparados (staging)
   │
   │  git commit  (o el botón ✓)
   ▼
Historial local
   │
   │  git push  (o Sync Changes)
   ▼
GitHub
```

Si cierras la computadora después del commit y antes del push, GitHub **no** tiene esos cambios.

### 1.4. La rama `main`

Una **rama** es una línea de trabajo. La principal suele llamarse `main` (antes se usaba `master`).

En esta guía siempre trabajamos sobre `main`. Si tu repositorio usa `master`, los pasos son los mismos: cambia solo el nombre.

---

## 2. Antes de empezar (una sola vez)

### 2.1. Cuenta de GitHub

Necesitas una cuenta en <https://github.com>. Es gratis.

### 2.2. Git instalado

Abre una terminal y escribe:

```bash
git --version
```

Debe responder algo como `git version 2.x.x`. Si dice «command not found», instálalo:

- **Ubuntu / WSL:** `sudo apt install git`
- **macOS:** `brew install git` o las herramientas de línea de comandos de Xcode.
- **Windows:** <https://git-scm.com/download/win>

### 2.3. VS Code abierto en la carpeta correcta

Abre la carpeta del proyecto, no un archivo suelto:

```text
File → Open Folder... → elige la carpeta del repositorio
```

Si trabajas dentro de WSL, abre la carpeta con la extensión **Remote - WSL**. Abajo a la izquierda debe verse algo como **WSL: Ubuntu**. Si ves **Windows**, estás abriendo la misma carpeta desde el otro sistema; eso puede cambiar credenciales y finales de línea.

### 2.4. Tu nombre y correo en Git

La primera vez, Git necesita saber quién firma los commits. En una terminal:

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu-correo@ejemplo.com"
```

Usa el correo asociado a tu cuenta de GitHub. Esto se hace **una sola vez** en cada computadora.

Si no lo configuras, el primer commit puede fallar con:

```text
Please tell me who you are.
```

### 2.5. Iniciar sesión en GitHub desde VS Code

1. Haz clic en el icono de **Accounts** (una persona) en la esquina inferior izquierda.
2. Elige **Sign in with GitHub**.
3. Se abre el navegador; autoriza el acceso.

Si al hacer push te pide usuario y contraseña, GitHub ya no acepta la contraseña normal de la cuenta. Lo más simple es usar el inicio de sesión del navegador. Si te pide un **token**, se genera en GitHub → Settings → Developer settings → Personal access tokens. **No pegues el token en el chat, en un archivo del repositorio ni en una captura.**

---

## 3. El panel de Source Control

Abre el panel con:

```text
Ctrl + Shift + G
```

o haz clic en el icono de **Source Control** (la bifurcación de tres puntos) en la barra izquierda.

Se ve parecido a esto:

```text
+--------------------------------------------------+
| SOURCE CONTROL                                   |
|                                                  |
|  Message (Ctrl+Enter to commit on 'main')        |
|  +--------------------------------------------+  |
|  | Añadir guía de GitHub                      |  |
|  +--------------------------------------------+  |
|                                                  |
|  [✓ Commit]        [↻ Sync Changes]              |
|                                                  |
|  Changes (2)                                  +  |
|   M  docs/otro.md                             +  |
|   U  docs/nuevo.md                            +  |
|                                                  |
|  Staged Changes (1)                           -  |
|   A  docs/guia.md                             -  |
+--------------------------------------------------+
```

### 3.1. Qué significa cada letra

| Letra | Significado |
|---|---|
| `U` | Untracked: archivo nuevo que Git todavía no sigue. |
| `M` | Modified: archivo que ya existía y cambió. |
| `A` | Added: archivo nuevo preparado para el próximo commit. |
| `D` | Deleted: archivo borrado. |
| `R` | Renamed: archivo renombrado. |
| `!` | Conflicto: hay que resolverlo antes de continuar. |

### 3.2. Qué hace cada botón

| Botón / icono | Qué hace |
|---|---|
| **`+`** junto a un archivo | Prepara ese archivo (lo pasa a **Staged Changes**). |
| **`+`** junto a **Changes** | Prepara **todos** los archivos. Úsalo con cuidado. |
| **`-`** junto a un archivo preparado | Lo quita de **Staged Changes**, sin borrar tus cambios. |
| **✓ Commit** | Guarda los archivos preparados en el historial local. |
| **↻ Sync Changes** | Hace pull y push: sincroniza con GitHub. |
| **Publish Branch** | Aparece cuando el repositorio todavía no existe en GitHub. |
| **Discard Changes** (flecha curvada) | **Borra tus cambios y vuelve al último commit. No se puede deshacer.** |
| **`...`** | Menú con Pull, Push, Fetch, Checkout y otras opciones. |

### 3.3. La barra inferior

Abajo a la izquierda ves la rama actual, por ejemplo:

```text
main*  ↑1
```

- `↑1`: tienes 1 commit local sin subir.
- `↓1`: GitHub tiene 1 commit que tú no tienes.
- Sin flechas: estás sincronizado.

Al hacer clic en ese indicador también puedes hacer pull o push.

---

## 4. Caso A: actualizar un repositorio que ya existe

Este es el flujo normal: el proyecto ya está en GitHub y tú quieres subir cambios.

### Paso 1: abre la carpeta correcta

```text
File → Open Folder... → carpeta del repositorio
```

Comprueba abajo a la izquierda que estás en la rama `main` y que el repositorio es el correcto.

### Paso 2: abre Source Control

```text
Ctrl + Shift + G
```

Si no aparece ningún cambio, pero sabes que editaste archivos, revisa la sección 8.7.

### Paso 3: revisa antes de preparar

Haz clic en cada archivo de **Changes**. Se abre una comparación:

- izquierda: cómo estaba antes;
- derecha: cómo queda ahora.

Antes de preparar, pregúntate:

- ¿Este archivo debe estar en el repositorio?
- ¿Tiene contraseñas, tokens o datos privados?
- ¿Es un archivo generado que no quiero versionar?
- ¿Está dentro de una carpeta que no debo tocar?

En este repositorio: **si aparece algo de `clase_de_lisp/`, no lo prepares**. Esa carpeta es de solo lectura.

### Paso 4: prepara solo lo que quieres subir

Pasa el ratón por encima del archivo y haz clic en **`+`**.

El archivo se mueve a **Staged Changes**. Los demás se quedan en **Changes** y **no** entran en el commit.

Si preparaste un archivo por error, haz clic en **`-`** para devolverlo. Eso no borra nada.

### Paso 5: escribe el mensaje

En **Message**, escribe una frase corta que explique qué hiciste:

```text
Añadir ficha 04 sobre Maclisp
```

Buenos mensajes:

```text
Corregir enlace roto en README
Actualizar estado de la serie
Añadir guía de GitHub para principiantes
```

Malos mensajes:

```text
cambios
asdf
update
```

El mensaje debe decir **qué** cambió y, si hace falta, **por qué**. No hace falta escribir un párrafo.

### Paso 6: haz el commit

Pulsa **Ctrl + Enter** o haz clic en **✓ Commit**.

Si VS Code pregunta:

```text
There are no staged changes. Do you want to stage all and commit?
```

Responde **No**. Eso significa que no preparaste nada; vuelve al paso 4. La opción **Always** haría que en el futuro prepare todo automáticamente, y eso es peligroso.

### Paso 7: sube a GitHub

Después del commit, el botón cambia:

- **Sync Changes** si tienes que sincronizar;
- **Push** si solo tienes commits por subir.

Haz clic. También puedes usar **`...` → Push**.

Si aparece una flecha junto al botón de commit, ahí también suele estar **Commit & Push**, que hace los dos pasos de golpe. Úsalo solo si ya revisaste y preparaste lo correcto.

### Paso 8: verifica

1. Abre el repositorio en <https://github.com>.
2. Comprueba que el archivo está y que el mensaje del commit es el tuyo.
3. En VS Code, mira la barra inferior: ya no debe aparecer `↑1`.

### Resumen del caso A

```text
Ctrl+Shift+G → revisar → + → mensaje → Ctrl+Enter → Sync Changes
```

---

## 5. Caso B: subir un proyecto nuevo por primera vez

Aquí la carpeta todavía **no** es un repositorio Git y el proyecto **no** está en GitHub.

### Paso 1: abre la carpeta del proyecto

```text
File → Open Folder... → carpeta del proyecto
```

### Paso 2: inicializa el repositorio

En **Source Control**, haz clic en **Initialize Repository**.

También puedes usar:

```text
Ctrl + Shift + P → Git: Initialize Repository
```

Eso crea una carpeta oculta `.git` dentro del proyecto. No la borres: ahí vive el historial.

Si el botón no aparece, probablemente la carpeta ya es un repositorio. En ese caso, no la inicialices otra vez.

### Paso 3: crea un `.gitignore` antes del primer commit

Un `.gitignore` es una lista de archivos que Git debe ignorar. Ejemplo:

```text
# Archivos generados
*.fasl
*.o
*.class

# Dependencias
node_modules/

# Secretos y configuración local
.env
*.key
*.pem

# Basura del sistema
.DS_Store
Thumbs.db
```

Crea el archivo en la raíz del proyecto y guárdalo. Si un archivo ya estaba siendo seguido por Git, añadirlo al `.gitignore` no lo deja de seguir; en ese caso hay que quitarlo del índice con `git rm --cached archivo` (avanzado).

### Paso 4: prepara y haz el primer commit

1. Revisa los archivos en **Changes**.
2. Prepara con **`+`** los que quieras incluir.
3. Mensaje: `Primer commit`.
4. **Ctrl + Enter** o **✓ Commit**.

### Paso 5: publica en GitHub

Después del primer commit aparece **Publish Branch** (una nube con flecha hacia arriba).

1. Haz clic en **Publish Branch**.
2. Inicia sesión en GitHub si te lo pide.
3. Elige el nombre del repositorio.
4. Elige **Public** o **Private**.
5. Confirma.

VS Code crea el repositorio en tu cuenta y sube el commit.

### Paso 6: verifica

Abre <https://github.com>, entra en tu perfil y comprueba que el repositorio aparece con los archivos.

### Resumen del caso B

```text
Abrir carpeta → Initialize Repository → + → mensaje → Commit → Publish Branch
```

---

## 6. Caso C: crear el repositorio en GitHub y clonarlo

Esta ruta es la más ordenada cuando quieres empezar un proyecto desde cero y ya sabes que irá a GitHub.

### Paso 1: crea el repositorio vacío en GitHub

1. Entra en <https://github.com>.
2. Haz clic en **New repository**.
3. Ponle nombre.
4. Elige **Public** o **Private**.
5. **No** marques «Add a README file» si vas a subir archivos que ya tienes. Un repositorio vacío evita el primer conflicto.
6. Crea el repositorio.

### Paso 2: copia la URL

En la página del repositorio, botón **Code** → copia la URL HTTPS, por ejemplo:

```text
https://github.com/tu-usuario/tu-repositorio.git
```

### Paso 3: clona desde VS Code

1. `Ctrl + Shift + P`.
2. Escribe **Git: Clone**.
3. Pega la URL.
4. Elige la carpeta donde quieres guardar el proyecto.
5. Cuando termine, pulsa **Open**.

### Paso 4: trabaja normalmente

Copia tus archivos dentro de la carpeta clonada, revisa, prepara, haz commit y pulsa **Sync Changes** o **Push**.

---

## 7. Subir un archivo suelto desde el navegador (sin Git)

Si solo quieres añadir un archivo rápido y no necesitas el flujo de Git:

1. Abre el repositorio en <https://github.com>.
2. Haz clic en **Add file → Upload files**.
3. Arrastra el archivo o la carpeta.
4. Escribe un mensaje en **Commit changes**.
5. Confirma.

Para crear un archivo de texto directamente: **Add file → Create new file**.

**Límites y advertencias:**

- GitHub acepta por la web archivos de hasta **25 MB** aproximadamente. Para archivos mayores hace falta Git LFS o subirlos por Git.
- Esto crea un commit **directamente en GitHub**.
- Si además tienes una copia local del repositorio, antes de seguir editando en local haz **Sync Changes** o **Pull**. Si no, tu copia estará desactualizada.

---

## 8. Problemas comunes y soluciones

### 8.1. «Please tell me who you are»

Git no sabe tu nombre o correo. Configúralo una vez:

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu-correo@ejemplo.com"
```

Vuelve a intentar el commit.

### 8.2. «There are no staged changes»

No preparaste ningún archivo. Haz clic en **`+`** junto al archivo que quieres incluir y vuelve a hacer commit. No elijas «stage all» sin revisar.

### 8.3. El push es rechazado («rejected», «non-fast-forward»)

GitHub tiene commits que tú no tienes. Solución:

1. Haz clic en **Sync Changes** o en **`...` → Pull**.
2. Si hay conflictos, resuélvelos (sección 8.5).
3. Vuelve a hacer push.

No uses `git push --force` para «arreglarlo». Puede borrar trabajo.

### 8.4. «Authentication failed» o «Permission denied»

- Cierra sesión y vuelve a iniciarla en VS Code: icono **Accounts** → **Sign out** → **Sign in with GitHub**.
- Comprueba que estás usando la cuenta correcta.
- Si usas un token, puede haber caducado o no tener permisos sobre ese repositorio.
- Si usas SSH y ves `Permission denied (publickey)`, lo más simple es cambiar la URL del remoto a HTTPS o configurar una clave SSH.

### 8.5. Conflictos

Ocurren cuando GitHub y tu copia local cambiaron las mismas líneas.

1. Haz **Pull** o **Sync Changes**.
2. VS Code marca los archivos en conflicto.
3. Ábrelos y elige:
   - **Accept Current Change**: quedarte con tu versión.
   - **Accept Incoming Change**: quedarte con la de GitHub.
   - **Accept Both Changes**: conservar las dos y editarlas a mano.
4. Guarda el archivo.
5. Prepara el archivo con **`+`**.
6. Haz commit.
7. Haz push.

Si no entiendes el conflicto, no borres archivos a ciegas: pide ayuda mostrando el archivo en conflicto.

### 8.6. «File too large» o el push falla por tamaño

GitHub rechaza archivos de más de **100 MB** y avisa a partir de 50 MB. La web tiene un límite menor.

Opciones:

- No subir el archivo (añadirlo al `.gitignore`).
- Usar **Git LFS** para archivos grandes.
- Comprimirlo o partirlo.

No intentes «arreglarlo» borrando el archivo del disco si ya está en el historial; eso no lo quita del repositorio.

### 8.7. No aparece nada en Source Control

Comprueba:

1. ¿Abriste la carpeta correcta, no solo un archivo?
2. ¿La carpeta tiene un `.git`? Si no, usa **Initialize Repository**.
3. ¿El archivo está en `.gitignore`?
4. ¿Guardaste el archivo? VS Code no muestra cambios sin guardar.
5. Recarga la ventana: `Ctrl + Shift + P` → **Developer: Reload Window**.

También puedes comprobarlo en la terminal:

```bash
git status
```

### 8.8. Commiteé algo incorrecto

- **Antes del push:** puedes deshacer el último commit desde **`...` → Commit → Undo Last Commit**. Los cambios vuelven a quedar preparados; edita y vuelve a commitear.
- **Después del push:** no reescribas el historial. Haz un commit nuevo que corrija lo anterior.

Evita `git reset --hard` y `git push --force` si no dominas el tema: pueden borrar trabajo.

### 8.9. Commiteé un secreto (contraseña, token, clave)

1. **Revoca o cambia el secreto inmediatamente** en el servicio correspondiente. Aunque lo borres después, puede haber quedado en el historial.
2. No lo arregles solo con un commit que borre la línea: el secreto sigue en commits anteriores.
3. Pide ayuda para limpiar el historial. Es una operación delicada y no se hace con prisa.

Prevención: revisa siempre **Changes** antes de preparar y mantén un `.gitignore` con `.env`, `*.key`, `*.pem`, etc.

### 8.10. Descarté cambios sin querer

El botón **Discard Changes** no se puede deshacer de forma fiable. Antes de usarlo, comprueba que no necesitas esos cambios.

Si el archivo estaba abierto, revisa si el editor conserva una copia. Si no, tendrás que rehacer el trabajo. Por eso conviene hacer commits pequeños y frecuentes.

### 8.11. Todo el archivo aparece cambiado sin motivo

Probablemente son los **finales de línea**: Windows usa CRLF y Linux/macOS usan LF.

- Abre siempre la carpeta de la misma forma: si el proyecto vive en WSL, ábrelo con **Remote - WSL**.
- Si ves que todo el archivo cambió y no tocaste nada, **no commitees**: revisa los finales de línea primero.

### 8.12. «Detached HEAD» o la rama aparece como un código raro

Significa que estás viendo un commit antiguo, no una rama. Haz clic en el indicador de la rama abajo a la izquierda y elige **main**. Si tienes cambios sin guardar, haz commit o guárdalos antes de cambiar.

---

## 9. Reglas de seguridad

1. **Nunca subas secretos:** contraseñas, tokens, claves privadas, archivos `.env`.
2. **Revisa antes de preparar.** No uses «stage all» a ciegas.
3. **No uses `git push --force`** salvo que sepas exactamente qué vas a sobrescribir.
4. **No uses «Discard Changes»** sobre trabajo que no esté commiteado.
5. **Haz commits pequeños y frecuentes.** Es más fácil deshacer un cambio pequeño.
6. **Pull antes de trabajar** si el repositorio lo usan otras personas.
7. **No commitees archivos generados** (`.fasl`, `node_modules/`, binarios) salvo que el proyecto lo pida.
8. **Respeta las carpetas de solo lectura.** En este repositorio, `clase_de_lisp/` no se modifica ni se sube con cambios.

### Regla especial de este repositorio

Si en **Changes** aparece cualquier archivo dentro de `clase_de_lisp/`:

- no lo prepares;
- no lo descartes;
- no lo edites;
- detente y avisa al autor.

---

## 10. Cómo escribir mensajes de commit

Un buen mensaje responde: **¿qué cambió?**

| Bien | Mal |
|---|---|
| `Añadir ficha 04 sobre Maclisp` | `cambios` |
| `Corregir enlace roto en README` | `asdf` |
| `Actualizar estado de la serie` | `update` |
| `Añadir guía de GitHub para principiantes` | `archivo nuevo` |

Consejos:

- Una línea corta, en imperativo: «Añadir», «Corregir», «Actualizar».
- Menos de 70 caracteres si es posible.
- Si necesitas explicar más, deja una línea en blanco y escribe un párrafo debajo.
- No uses el mensaje para decir «subida de archivos»; di qué archivo y para qué.

---

## 11. Chuleta de terminal (opcional)

Todo lo anterior se puede hacer con comandos. Esta tabla es para quien quiera entender qué hace VS Code por debajo.

| Quiero... | Comando |
|---|---|
| Ver el estado | `git status` |
| Ver los cambios | `git diff` |
| Preparar un archivo | `git add archivo.md` |
| Preparar todo | `git add .` (con cuidado) |
| Quitar un archivo de lo preparado | `git restore --staged archivo.md` |
| Hacer commit | `git commit -m "Mensaje"` |
| Subir | `git push` |
| Traer cambios | `git pull` |
| Ver los últimos commits | `git log --oneline -5` |
| Ver la rama y el estado | `git status -sb` |

**Cuidado con la diferencia:**

```bash
git restore --staged archivo.md   # lo saca de "preparado"; NO borra tus cambios
git restore archivo.md            # BORRA tus cambios; vuelve al último commit
```

La segunda orden es la versión de terminal del botón **Discard Changes**. Úsala solo si estás seguro.

---

## 12. Glosario

| Término | Significado |
|---|---|
| **Repositorio** | Carpeta del proyecto con su historial de cambios. |
| **Local** | En tu computadora. |
| **Remoto** | En GitHub (u otro servidor). |
| **`origin`** | Nombre que Git le da al remoto principal. |
| **Rama / branch** | Línea de trabajo. La principal suele ser `main`. |
| **Commit** | Foto de los cambios en el historial local. |
| **Staging** | Zona intermedia: archivos preparados para el próximo commit. |
| **Push** | Subir commits locales al remoto. |
| **Pull** | Traer commits del remoto al local. |
| **Clone** | Copiar un repositorio remoto a tu computadora. |
| **Conflicto** | Dos cambios incompatibles en las mismas líneas. |
| **`.gitignore`** | Lista de archivos que Git debe ignorar. |
| **Token (PAT)** | Contraseña especial para autenticarse con GitHub. |
| **Git LFS** | Extensión para guardar archivos grandes. |

---

## 13. Lista de verificación antes de cada push

- [ ] Abrí la carpeta correcta.
- [ ] Estoy en la rama `main`.
- [ ] Revisé los cambios archivo por archivo.
- [ ] No hay contraseñas, tokens ni claves.
- [ ] No hay cambios en `clase_de_lisp/` (en este repositorio).
- [ ] Preparé solo los archivos que quiero.
- [ ] El mensaje del commit es claro.
- [ ] Hice el commit.
- [ ] Hice **Sync Changes** o **Push**.
- [ ] Verifiqué el resultado en GitHub.
- [ ] La barra inferior ya no muestra `↑`.

---

## 14. Ejercicio práctico

Si quieres practicar sin miedo:

1. Crea un repositorio **privado** llamado `prueba-github`.
2. Cópialo a tu computadora con **Git: Clone**.
3. Crea un archivo `hola.md` con una línea de texto.
4. Haz commit con el mensaje `Añadir hola.md`.
5. Haz push.
6. Abre el repositorio en GitHub y comprueba que el archivo está.
7. Edita `hola.md` desde la web de GitHub y confirma el cambio.
8. En VS Code, haz **Sync Changes** o **Pull**.
9. Comprueba que la edición de la web aparece en tu copia local.
10. Cuando termines, puedes borrar el repositorio de prueba desde GitHub → Settings → Danger Zone.

Este ejercicio cubre el ciclo completo: crear, clonar, commit, push, pull y verificar.

---

## 15. Resumen de una página

### Actualizar un repositorio existente

```text
Abrir carpeta
  → Ctrl + Shift + G
  → revisar Changes
  → + en los archivos correctos
  → escribir mensaje
  → Ctrl + Enter
  → Sync Changes / Push
  → verificar en GitHub
```

### Subir un proyecto nuevo

```text
Abrir carpeta
  → Source Control → Initialize Repository
  → crear .gitignore
  → + en los archivos
  → mensaje
  → Commit
  → Publish Branch
  → elegir Public/Private
  → verificar en GitHub
```

### Regla de oro

> **Commit guarda en tu computadora. Push sube a GitHub.**
> Si dudas, revisa antes de preparar; si algo sale mal, no uses `--force` ni «Discard Changes».

---

*Guía independiente del manual de Lisp. Si trabajas en este repositorio, recuerda: `clase_de_lisp/` es solo de lectura; la documentación de `docs/` sí se puede mejorar.*
