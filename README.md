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

### Plugins (Lazy)

| Atajo | Modo | Acción |
|-------|------|--------|
| `<Leader>pi` | Normal | Instalar plugins |
| `<Leader>ps` | Normal | UI estado de Lazy |
| `<Leader>pS` | Normal | Sincronizar plugins |
| `<Leader>pu` | Normal | Comprobar actualizaciones |
| `<Leader>pU` | Normal | Actualizar plugins |
| `<Leader>pa` | Normal | Actualizar Lazy y Mason |

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

## Instalación

#### Copia de seguridad de tu configuración actual

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
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
