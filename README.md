# AstroNvim Template

**NOTE:** This is for AstroNvim v4+

Plantilla basada en [AstroNvim](https://github.com/AstroNvim/AstroNvim).

## Teclas líder

| Tecla | Rol |
|-------|-----|
| **Espacio** (`Space`) | `<Leader>` — prefijo principal de la mayoría de atajos |
| **`,`** | `<LocalLeader>` — líder local (complementario) |

En esta documentación, **`<Leader>`** significa **Espacio** salvo que se indique lo contrario.

---

## Atajos definidos en esta configuración

Los bloques siguientes reflejan lo que está en `lua/plugins/` (AstroCore personalizado, AstroLSP, Neo-tree, EasyMotion, etc.). AstroNvim añade **muchos** atajos extra (Telescope, Git, terminal, depurador…). Para verlos todos en el editor usa **`:WhichKey`** o pulsa **Espacio** y espera a que aparezca el menú jerárquico (con *which-key*).

### Archivos, guardado y ventanas

| Atajo | Modo | Acción |
|-------|------|--------|
| `<Leader>w` | Normal | Guardar buffer |
| `<C-S>` | Normal / Inserción | Forzar escritura en disco (`update`) |
| `<C-Q>` | Normal | Salir sin guardar (`q!`) |
| `<Leader>c` | Normal | Cerrar ventana (`confirm q`) |
| `<Leader>C` | Normal | Salir de todas las ventanas / Neovim (`confirm qall`) |
| `<Leader>n` | Normal | Nuevo buffer vacío (`enew`) |
| `\|` | Normal | Dividir ventana verticalmente (`vsplit`) |
| `\` | Normal | Dividir ventana horizontalmente (`split`) |
| `gx` | Normal / Visual | Abrir ruta o URL bajo el cursor con la app del sistema *(según versión de Neovim puede usar el mapa nativo `gx`)* |

### Buffers y pestañas (tabs)

| Atajo | Modo | Acción |
|-------|------|--------|
| `<Leader>q` | Normal | Cerrar buffer actual |
| `<Leader>Q` | Normal | Forzar cierre del buffer |
| `<S-h>` / `<S-l>` | Normal | Buffer anterior / siguiente |
| `[b` / `]b` | Normal | Buffer anterior / siguiente (con contador) |
| `>b` / `<b` | Normal | Mover pestaña de buffer a derecha / izquierda |
| `<Leader>bd` | Normal | Cerrar buffer desde el selector de la tabline |
| `<Leader>bc` | Normal | Cerrar todos los buffers excepto el actual |
| `<Leader>bC` | Normal | Cerrar todos los buffers |
| `<Leader>bl` / `<Leader>br` | Normal | Cerrar buffers a la izquierda / derecha del actual |
| `<Leader>bp` | Normal | Ir al buffer anterior |
| `<Leader>bse` / `bsr` / `bsp` / `bsi` / `bsm` | Normal | Ordenar buffers por extensión, ruta relativa, ruta completa, número o fecha de modificación |
| `[t` / `]t` | Normal | Pestaña (tab) anterior / siguiente |

### Comentarios y movimiento en líneas largas

| Atajo | Modo | Acción |
|-------|------|--------|
| `<Leader>/` | Normal | Alternar comentario de línea (usa `gcc` / Comment.nvim) |
| `<Leader>/` | Visual | Alternar comentario en selección (`gc`) |
| `j` / `k` | Normal / Visual | Bajar/subir respetando líneas visuales (`gj`/`gk` si no hay contador) |

### Buscar archivos del proyecto

| Atajo | Modo | Acción |
|-------|------|--------|
| `<Leader>p` | Normal | **Telescope**: buscar archivos en la raíz detectada del proyecto (git, etc.) |

### Plugins (Lazy)

| Atajo | Modo | Acción |
|-------|------|--------|
| `<Leader>L` | Normal | Prefijo del menú Plugins (Espacio, **Shift+L**) |
| `<Leader>Li` | Normal | Instalar plugins |
| `<Leader>Ls` | Normal | UI estado de Lazy |
| `<Leader>LS` | Normal | Sincronizar plugins |
| `<Leader>Lu` | Normal | Comprobar actualizaciones |
| `<Leader>LU` | Normal | Actualizar plugins |
| `<Leader>La` | Normal | Actualizar Lazy y Mason |

### Diagnósticos LSP

| Atajo | Modo | Acción |
|-------|------|--------|
| `<Leader>ld` / `gl` | Normal | Diagnóstico en ventana flotante |
| `[d` / `]d` | Normal | Diagnóstico anterior/siguiente *(en Neovim 0.11+ parte de esto pasa a atajos nativos)* |
| `[e` / `]e` | Normal | Error anterior/siguiente |
| `[w` / `]w` | Normal | Advertencia anterior/siguiente |
| `<C-W>d` / `<C-W><C-D>` | Normal | Flotante de diagnóstico *(fallback en versiones antiguas de Neovim)* |

### Navegación entre splits y terminal integrada

| Atajo | Modo | Acción |
|-------|------|--------|
| `<C-H>` / `<C-J>` / `<C-K>` / `<C-L>` | Normal | Ir al split izquierda/abajo/arriba/derecha |
| `<C-Up>` / `<C-Down>` | Normal | Reducir/aumentar altura del split |
| `<C-Left>` / `<C-Right>` | Normal | Reducir/aumentar anchura del split |
| `<C-H>` … `<C-L>` | Terminal | Misma lógica de ventanas desde modo terminal |

### Quickfix y listas de ubicación

| Atajo | Modo | Acción |
|-------|------|--------|
| `<Leader>xq` / `<Leader>xl` | Normal | Abrir quickfix / localización |
| `[q` / `]q` / `[Q` / `]Q` | Normal | Anterior/siguiente/primer/último en quickfix |
| `[l` / `]l` / `[L` / `]L` | Normal | Igual para lista de ubicación |

### Modo visual: sangría

| Atajo | Modo | Acción |
|-------|------|--------|
| `<Tab>` / `<S-Tab>` | Visual | Aumentar / reducir sangría y mantener selección |

### Toggles UI (`<Leader>u…`)

| Atajo | Acción (resumen) |
|-------|------------------|
| `<Leader>uA` | Alternar `autochdir` (rooter) |
| `<Leader>ub` | Alternar tema claro/oscuro (fondo) |
| `<Leader>ud` | Alternar diagnósticos en UI |
| `<Leader>ug` | Alternar columna de señales (`signcolumn`) |
| `<Leader>u>` | Alternar columna de plegado (`foldcolumn`) |
| `<Leader>ui` | Cambiar estilo de sangría |
| `<Leader>ul` | Alternar línea de estado |
| `<Leader>un` | Modo de numeración de líneas |
| `<Leader>uN` | Alternar notificaciones |
| `<Leader>up` | Modo pegado |
| `<Leader>us` | Ortografía |
| `<Leader>uS` | Conceal |
| `<Leader>ut` | Tabline |
| `<Leader>uu` | Resaltado de URLs |
| `<Leader>uw` | Ajuste de línea (`wrap`) |
| `<Leader>uy` | Resaltado de sintaxis del buffer |

### LSP (`<Leader>l…`, `g…`) — cuando el servidor lo soporte

| Atajo | Modo | Acción |
|-------|------|--------|
| `gd` / `gD` | Normal | Definición / declaración |
| `gI` | Normal | Implementaciones |
| `gy` | Normal | Definición de tipo |
| `gK` | Normal | Firma (signature help) |
| `K` | Normal | Hover *(mapa extra en Neovim antiguo; en versiones recientes puede ser nativo)* |
| `ga` | Normal | Formatear buffer (LSP) |
| `<Leader>ga` | Visual | Formatear selección (rango LSP) |
| `<Leader>la` / `<Leader>lA` | Normal, Visual | Code action / source action |
| `<Leader>ll` / `<Leader>lL` | Normal | Refrescar / ejecutar CodeLens |
| `<Leader>lr` / `<Leader>lR` | Normal | Renombrar / referencias |
| `<Leader>lh` | Normal | Ayuda de firma |
| `<Leader>lG` | Normal | Símbolos en el workspace |
| `<Leader>uf` / `<Leader>uF` | Normal | Autoformato buffer / global |
| `<Leader>uh` / `<Leader>uH` | Normal | Inlay hints buffer / global |
| `<Leader>uL` | Normal | Alternar CodeLens |
| `<Leader>uY` | Normal | Tokens semánticos (buffer) |

### Mapas LSP tipo Neovim 0.11 (solo si aplica tu versión)

En Neovim sin 0.11, a veces se definen `gra` (code action), `grn` (rename), `grr` (referencias). Con 0.11+ suelen usarse los atajos por defecto del propio Neovim.

---

## Neo-tree (explorador de archivos)

### Atajos globales

| Atajo | Acción |
|-------|--------|
| `<Leader>o` | Mostrar/ocultar Neo-tree |
| `<Leader>e` | Enfocar Neo-tree (o volver al buffer anterior si ya estás en Neo-tree) |

### Dentro de la ventana Neo-tree

| Atajo | Acción |
|-------|--------|
| `h` / `l` | Subir al padre / expandir u abrir hijo |
| `o` | Abrir |
| `O` / `<S-Enter>` | Abrir con app del sistema |
| `Y` | Copiar al portapapeles (ruta, nombre, etc., menú) |
| `[b` / `]b` | Fuente anterior/siguiente (archivos, git, etc.) |
| `F` | Buscar archivos en carpeta con Telescope *(si está instalado)* |
| `T`, luego `f` / `h` / `v` | Terminal flotante / horizontal / vertical en el directorio del nodo *(si Toggleterm está disponible)* |

En el buscador difuso (**fuzzy**) del árbol: `<C-J>` / `<C-K>` mover el cursor.

---

## EasyMotion

| Atajo | Modo | Acción |
|-------|------|--------|
| `mm` | Normal | Buscar carácter en dos pulsaciones (`easymotion-s2`) |
| `<Leader>vw` | Normal | Saltar a inicio de palabras (`easymotion-w`) |

---

## Plegado de código (folding) — Vim/Neovim

| Atajo | Acción |
|-------|--------|
| `zc` | Plegar el bloque bajo el cursor |
| `zo` | Desplegar el bloque bajo el cursor |
| `za` | Alternar plegado bajo el cursor |
| `zM` | Plegar todo el archivo |
| `zR` | Desplegar todo el archivo |
| `zm` | Aumentar nivel de plegado (plegar más) |
| `zr` | Reducir nivel de plegado (plegar menos) |

---

## Requisitos del sistema (Linux Ubuntu / macOS)

Esta configuración es **AstroNvim v4**. Funciona en **Ubuntu/Debian** y en **macOS** si instalas las mismas herramientas base. Los LSP y formateadores principales se instalan **desde Neovim** con **Mason** (`:Mason`), pero hace falta software en el sistema para compilar parsers de Tree-sitter, construir `telescope-fzf-native`, usar Git con Lazy, etc.

### Versiones recomendadas

| Componente | Notas |
|------------|--------|
| **Neovim** | AstroNvim 4 ya no soporta Neovim 0.8. Usa **0.9.4 o superior**; se recomienda la **última estable 0.10+**. |
| **Git** | Obligatorio: Lazy.nvim clona plugins al arrancar. |
| **Compilador C + make** | Obligatorio para **nvim-treesitter** (parsers) y **telescope-fzf-native**. |
| **curl** | Descargas (Mason, parsers, etc.). |

### Ubuntu / Debian — paquetes con `apt`

Actualiza índices e instala herramientas de compilación, Git y utilidades:

```bash
sudo apt update
sudo apt install -y \
  git \
  curl \
  wget \
  ca-certificates \
  build-essential \
  pkg-config \
  unzip \
  ripgrep \
  fd-find \
  python3 \
  python3-venv \
  python3-pip
```

En Ubuntu el paquete `fd-find` instala el ejecutable como **`fdfind`**. Si alguna herramienta espera el nombre `fd`, crea un enlace (ajusta la ruta si hace falta):

```bash
sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd
```

**Neovim estable (PPA oficial):**

```bash
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install -y neovim
```

**Node.js (recomendado para TypeScript/JavaScript y herramientas npm del ecosistema):** opción con **NodeSource** (elige la versión LTS que indique la web) o instala `nodejs` y `npm` desde el repositorio si te basta para tu uso:

```bash
# Ejemplo genérico desde repositorios Ubuntu (versiones pueden ser antiguas):
sudo apt install -y nodejs npm
```

Para una **LTS actual**, sigue las instrucciones de [NodeSource](https://github.com/nodesource/distributions) o usa **nvm**: [https://github.com/nvm-sh/nvm](https://github.com/nvm-sh/nvm).

**Rust (opcional):** solo necesario si quieres el toolchain `rustc`/`cargo` en el sistema (por ejemplo proyectos Rust fuera de Mason). No es obligatorio para que Neovim arranque.

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

**Flutter / Dart (opcional):** esta repo incluye **flutter-tools.nvim**. Si trabajas con Flutter, instala el SDK y asegúrate de que `flutter` y `dart` estén en el `PATH` ([documentación oficial](https://docs.flutter.dev/get-started/install/linux)).

**Fuente con iconos (recomendado):** AstroNvim usa iconos; instala una [Nerd Font](https://www.nerdfonts.com/) y configúrala en la terminal (por ejemplo `sudo apt install fonts-hack-ttf` o descarga una Nerd Font manualmente).

---

### macOS — con Homebrew

Instala [Homebrew](https://brew.sh/) si aún no lo tienes:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Herramientas base (Git, compilación, búsqueda):

```bash
brew install git curl wget pkg-config unzip ripgrep fd python@3.12
```

Neovim y Node:

```bash
brew install neovim node
```

Xcode Command Line Tools (compilador para Tree-sitter y fzf-native; acepta la licencia si macOS lo pide):

```bash
xcode-select --install
```

**Rust (opcional):** igual que en Linux, vía rustup si lo necesitas para desarrollo Rust:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

**Flutter (opcional):** para Dart/Flutter con esta configuración:

```bash
brew install --cask flutter
flutter doctor
```

**Nerd Font (recomendado):** por ejemplo:

```bash
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
```

Configura la terminal para usar esa fuente.

---

### Comprobar instalación (Linux y macOS)

Ejecuta y revisa que no falte nada en el PATH:

```bash
command -v nvim git curl make gcc python3
nvim --version
git --version
curl --version
make --version
gcc --version   # o clang --version en macOS
python3 --version
```

Si usas TypeScript/JavaScript en proyectos reales:

```bash
node --version
npm --version
```

Si instalaste Rust:

```bash
rustc --version
cargo --version
```

Si usas Flutter:

```bash
flutter --version
dart --version
```

**Diagnóstico dentro de Neovim:**

```bash
nvim --headless "+checkhealth" +qa
```

En el repo hay un script auxiliar (no sustituye instalar dependencias del sistema):

```bash
chmod +x scripts/nvim-doctor.sh
./scripts/nvim-doctor.sh check
```

---

### ESLint en JS/TS (error `-32603` o “textDocument/diagnostic failed”)

El pack **astrocommunity.pack.typescript** instala **ESLint** como LSP. Si en un repo el **ESLint del proyecto** está roto (plugins mal instalados, `eslint.config` inválido, `node_modules` incompletos), el servidor puede lanzar **error interno JSON-RPC (-32603)** y notificaciones en bucle. **Ir a definición** lo sigue haciendo **vtsls**; el fallo suele ser solo del cliente `eslint`.

**En el proyecto (recomendado):**

```bash
cd /ruta/al/repo   # p. ej. disglobal-page
npm ci             # o npm install / pnpm install
npx eslint .       # debe terminar sin excepción; si aquí falla, Neovim también fallará
```

**En Neovim (silenciar ESLint LSP hasta arreglar el repo):** en `init.lua`, antes de `require "lazy_setup"`, descomenta:

```lua
vim.g.disable_eslint_lsp = true
```

También se ajustó `workingDirectory.mode = "auto"` para monorepos (ver `lua/plugins/astrolsp.lua`).

---

### Primera vez después de clonar

1. Abre `nvim` y deja que **Lazy** instale plugins (puede tardar y requiere red).
2. Ejecuta **`:Mason`** e instala/actualiza los servidores que uses (`lua_ls`, `jsonls`, `vtsls`, `pyright`, etc.; TypeScript/JS va con **vtsls**, no hace falta `tsserver` por separado).
3. Si Tree-sitter falla al compilar, instala/actualiza `build-essential` (Linux) o Xcode CLT (macOS) y en Neovim: **`:TSUpdateSync all`** (o `./scripts/nvim-doctor.sh repair`).

---

## Instalación

#### Copia de seguridad de tu configuración actual

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

```shell
rm -rf ~/.local/share/nvim &&
rm -rf ~/.local/state/nvim && 
rm -rf ~/.cache/nvim 
```

#### Plantilla en GitHub o clonar

Puedes usar el botón "Use this template" en GitHub o clonar:

```shell
git clone https://github.com/osedhelu/vim-config ~/.config/nvim
```

#### Iniciar Neovim

```shell
nvim
```

---

## Más ayuda en el editor

- Documentación oficial: [https://docs.astronvim.com/](https://docs.astronvim.com/)
- Comando **`:WhichKey`**: lista grupos y sub-atajos según lo cargado.
- **Espacio** seguido de una letra abre el menú del grupo (`f`, `g`, `p`, `l`, `t`, etc., según AstroNvim y *community packs*).
