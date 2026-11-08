# Neovim personal (LazyVim)

Configuración personal de Neovim basada en [LazyVim](https://lazyvim.github.io).
Funciona en macOS y Linux, con soporte para Python, Dart/Flutter, Kotlin,
TypeScript/JavaScript, JSON y YAML.

> **Notación**
>
> - `<leader>` es la **barra espaciadora** (Espacio).
> - `<localleader>` es `\`.
> - `<C-x>` = `Ctrl + x`, `<S-x>` = `Shift + x`, `<A-x>` = `Alt/Option + x`.
> - `n` = modo normal, `x` = modo visual, `i` = modo inserción, `t` = terminal.
> - Pulsa `<leader>` y espera: **which-key** muestra el menú de atajos disponibles.

---

## 1. Empezar

```bash
# Abrir Neovim
nvim .

# Primera vez / tras actualizar la configuración
:Lazy sync
```

Dentro de Neovim:

| Comando                 | Qué hace                                        |
| ----------------------- | ----------------------------------------------- |
| `:Lazy` o `<leader>l`   | Panel de plugins                                |
| `:LazyExtras`           | Activar/desactivar extras de LazyVim            |
| `:Lazy sync`            | Instalar/actualizar todo según `lazy-lock.json` |
| `:Lazy update`          | Actualizar plugins                              |
| `:Lazy clean`           | Eliminar plugins que ya no se usan              |
| `:Lazy profile`         | Ver tiempos de arranque                         |
| `:Mason` o `<leader>cm` | Gestor de LSP, linters y formateadores          |
| `:checkhealth`          | Diagnóstico de Neovim                           |
| `:Tutor`                | Tutorial interactivo de Vim                     |

---

## 2. Archivos y búsqueda

| Atajo             | Acción                                       |
| ----------------- | -------------------------------------------- |
| `<leader><space>` | Buscar archivo en la raíz del proyecto       |
| `<leader>ff`      | Buscar archivo (raíz del proyecto)           |
| `<leader>fF`      | Buscar archivo (directorio actual)           |
| `<leader>fg`      | Buscar archivos versionados por Git          |
| `<leader>fr`      | Archivos recientes                           |
| `<leader>fR`      | Recientes del directorio actual              |
| `<leader>fb`      | Buffers abiertos                             |
| `<leader>fB`      | Todos los buffers (incluye ocultos)          |
| `<leader>fc`      | Buscar en tu configuración de Neovim         |
| `<leader>fp`      | Proyectos                                    |
| `<leader>fn`      | Archivo nuevo                                |
| `<leader>e`       | Abrir/enfocar el explorador (Neo-tree)       |
| `<leader>E`       | Explorador flotante en el directorio actual  |
| `<leader>fe`      | Explorador en la raíz del proyecto           |
| `<leader>fE`      | Explorador en el directorio actual           |
| `<leader>be`      | Explorador de buffers                        |
| `<leader>ge`      | Explorador de Git                            |
| `<leader>o`       | Abrir/cerrar el explorador sin mover el foco |

### Buscar texto

| Atajo        | Acción                                                   |
| ------------ | -------------------------------------------------------- |
| `<leader>/`  | Buscar texto en el proyecto (grep)                       |
| `<leader>sg` | Buscar texto en la raíz del proyecto                     |
| `<leader>sG` | Buscar texto en el directorio actual                     |
| `<leader>sw` | Buscar la palabra bajo el cursor (o selección en visual) |
| `<leader>sW` | Igual que `sw`, pero en el directorio actual             |
| `<leader>sb` | Buscar líneas dentro de los buffers abiertos             |
| `<leader>sB` | Grep en los buffers abiertos                             |
| `<leader>s/` | Buscar en el historial de búsquedas                      |
| `<leader>s"` | Registers                                                |
| `<leader>sR` | Reabrir la última búsqueda (resume)                      |

### Buscar dentro de Neovim

| Atajo        | Acción                           |
| ------------ | -------------------------------- |
| `<leader>sh` | Ayuda (`:help`)                  |
| `<leader>sk` | Atajos de teclado                |
| `<leader>sc` | Historial de comandos            |
| `<leader>sC` | Todos los comandos               |
| `<leader>sa` | Autocmds                         |
| `<leader>sj` | Jumps                            |
| `<leader>sm` | Marks                            |
| `<leader>sM` | Páginas `man`                    |
| `<leader>si` | Iconos                           |
| `<leader>sH` | Grupos de resaltado              |
| `<leader>su` | Historial de deshacer (undotree) |
| `<leader>sq` | Quickfix                         |
| `<leader>sl` | Location list                    |
| `<leader>sp` | Buscar spec de un plugin         |
| `<leader>st` | TODOs del proyecto               |
| `<leader>sT` | TODO/FIX/FIXME                   |
| `<leader>n`  | Historial de notificaciones      |

---

## 3. Buffers, ventanas y pestañas

### Buffers

| Atajo                       | Acción                                   |
| --------------------------- | ---------------------------------------- |
| `<S-h>` o `[b`              | Buffer anterior                          |
| `<S-l>` o `]b`              | Buffer siguiente                         |
| `[B` / `]B`                 | Mover buffer a la izquierda/derecha      |
| `<leader>bb`                | Volver al buffer anterior                |
| `<leader>` + acento grave   | Volver al buffer anterior (alternativa)  |
| `<leader>bd`                | Cerrar buffer actual                     |
| `<leader>qq`                | **Cerrar buffer actual** (personalizado) |
| `<leader>bD`                | Cerrar buffer y ventana                  |
| `<leader>bo`                | Cerrar los demás buffers                 |
| `<leader>bi`                | Cerrar buffers invisibles                |
| `<leader>bp`                | Fijar/quitar fijado (pin)                |
| `<leader>bP`                | Cerrar buffers no fijados                |
| `<leader>br` / `<leader>bl` | Cerrar buffers a la derecha/izquierda    |
| `<leader>bj`                | Elegir buffer por letra                  |

### Ventanas

| Atajo                           | Acción                     |
| ------------------------------- | -------------------------- |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | Moverse entre ventanas     |
| `<C-Up>` `<C-Down>`             | Aumentar/disminuir altura  |
| `<C-Left>` `<C-Right>`          | Disminuir/aumentar anchura |
| `<leader>-`                     | Dividir abajo              |
| `<leader>\|`                    | Dividir a la derecha       |
| `<leader>wd`                    | Cerrar ventana             |
| `<leader>wm` o `<leader>uZ`     | Zoom de ventana            |
| `<leader>uz`                    | Modo zen                   |
| `<C-w><Space>`                  | Menú hydra de ventanas     |

### Pestañas

| Atajo                               | Acción             |
| ----------------------------------- | ------------------ |
| `<leader><tab><tab>`                | Nueva pestaña      |
| `<leader><tab>]` / `<leader><tab>[` | Siguiente/anterior |
| `<leader><tab>f` / `<leader><tab>l` | Primera/última     |
| `<leader><tab>d`                    | Cerrar pestaña     |
| `<leader><tab>o`                    | Cerrar las demás   |

---

## 4. Edición

| Atajo                 | Acción                                                 |
| --------------------- | ------------------------------------------------------ |
| `gcc`                 | Comentar/descomentar línea                             |
| `gc` (visual)         | Comentar/descomentar selección                         |
| `gbc` / `gb` (visual) | Comentario de bloque                                   |
| `gco` / `gcO`         | Comentario debajo/encima                               |
| `ga`                  | **Formatear el buffer o la selección** (personalizado) |
| `<leader>cf`          | Formatear                                              |
| `<leader>cF`          | Formatear también lenguajes inyectados                 |
| `<A-j>` / `<A-k>`     | Mover línea(s) abajo/arriba                            |
| `<` / `>` (visual)    | Indentar manteniendo la selección                      |
| `<C-s>`               | Guardar                                                |
| `s`                   | **Flash**: saltar a cualquier parte visible            |
| `S`                   | Flash con Treesitter (selecciona nodos)                |
| `R` (visual/operador) | Búsqueda con Treesitter                                |
| `<C-Space>`           | Ampliar selección con Treesitter                       |
| `u` / `<C-r>`         | Deshacer / rehacer                                     |
| `.`                   | Repetir última acción                                  |
| `<esc>`               | Limpiar búsqueda y detener snippet                     |

> En esta configuración **el autoformato está desactivado** (`vim.g.autoformat = false`).
> Formatea manualmente con `ga` o `<leader>cf`.

### Explorador Neo-tree

| Tecla        | Acción                               |
| ------------ | ------------------------------------ |
| `<CR>` / `o` | Abrir archivo                        |
| `s` / `S`    | Abrir en split vertical / horizontal |
| `t` / `T`    | Abrir en pestaña / pestaña nueva     |
| `a`          | Crear archivo/directorio             |
| `d`          | Borrar                               |
| `r`          | Renombrar                            |
| `c` / `m`    | Copiar / mover                       |
| `x`          | Cortar                               |
| `y`          | Copiar nombre al portapapeles        |
| `p`          | Pegar                                |
| `H`          | Mostrar/ocultar archivos ocultos     |
| `R`          | Refrescar                            |
| `?`          | Ayuda del explorador                 |
| `q`          | Cerrar                               |

---

## 5. Código y LSP

| Atajo          | Acción                                     |
| -------------- | ------------------------------------------ |
| `gd`           | Ir a la definición                         |
| `gD`           | Ir a la declaración                        |
| `gI`           | Ir a la implementación                     |
| `gy`           | Ir a la definición de tipo                 |
| `gr`           | Ver referencias                            |
| `K`            | Documentación del símbolo (hover)          |
| `gK` o `<C-k>` | Ayuda de firma                             |
| `<leader>ca`   | Acciones de código (refactor, imports…)    |
| `<leader>cr`   | Renombrar símbolo                          |
| `<leader>cR`   | Renombrar archivo                          |
| `<leader>cA`   | Source action                              |
| `<leader>cc`   | Ejecutar codelens                          |
| `<leader>cC`   | Refrescar codelens                         |
| `<leader>cl`   | Información del LSP                        |
| `<leader>cs`   | Símbolos del buffer (Trouble)              |
| `<leader>cS`   | Referencias/definiciones del LSP (Trouble) |
| `<leader>ss`   | Símbolos del buffer (picker)               |
| `<leader>sS`   | Símbolos del proyecto                      |

### Diagnósticos

| Atajo        | Acción                           |
| ------------ | -------------------------------- |
| `<leader>cd` | Ver diagnóstico de la línea      |
| `]d` / `[d`  | Siguiente/anterior diagnóstico   |
| `]e` / `[e`  | Siguiente/anterior error         |
| `]w` / `[w`  | Siguiente/anterior advertencia   |
| `<leader>xx` | Todos los diagnósticos (Trouble) |
| `<leader>xX` | Diagnósticos del buffer          |
| `<leader>xL` | Location list                    |
| `<leader>xQ` | Quickfix list                    |
| `]q` / `[q`  | Siguiente/anterior en quickfix   |
| `]t` / `[t`  | Siguiente/anterior TODO          |

---

## 6. Git

| Atajo                       | Acción                                |
| --------------------------- | ------------------------------------- |
| `<leader>gg`                | Abrir **lazygit** en la raíz del repo |
| `<leader>gG`                | Abrir lazygit en el directorio actual |
| `<leader>gs`                | Estado de Git                         |
| `<leader>gd`                | Diff por hunks                        |
| `<leader>gD`                | Diff contra `origin`                  |
| `<leader>gS`                | Stash                                 |
| `<leader>gl`                | Log del repositorio                   |
| `<leader>gL`                | Log del directorio actual             |
| `<leader>gf`                | Historial del archivo actual          |
| `<leader>gb`                | Blame de la línea                     |
| `<leader>gB`                | Abrir en el navegador                 |
| `<leader>gY`                | Copiar URL del archivo/línea          |
| `<leader>gi` / `<leader>gI` | Issues de GitHub (abiertos/todos)     |
| `<leader>gp` / `<leader>gP` | Pull requests (abiertos/todos)        |

### Gitsigns (dentro del buffer)

| Atajo                  | Acción                  |
| ---------------------- | ----------------------- |
| `]h` / `[h`            | Siguiente/anterior hunk |
| `]H` / `[H`            | Último/primer hunk      |
| `<leader>ghs`          | Stage del hunk          |
| `<leader>ghr`          | Reset del hunk          |
| `<leader>ghS`          | Stage del buffer        |
| `<leader>ghu`          | Deshacer stage          |
| `<leader>ghR`          | Reset del buffer        |
| `<leader>ghp`          | Previsualizar hunk      |
| `<leader>ghb`          | Blame de la línea       |
| `<leader>ghB`          | Blame del buffer        |
| `<leader>ghd`          | Diff del archivo        |
| `ih` (operador/visual) | Seleccionar hunk        |

---

## 7. Sesiones

| Atajo        | Acción                          |
| ------------ | ------------------------------- |
| `<leader>qs` | Restaurar sesión del directorio |
| `<leader>ql` | Restaurar la última sesión      |
| `<leader>qS` | Elegir sesión                   |
| `<leader>qd` | Detener el guardado de sesión   |

---

## 8. Interfaz y toggles

| Atajo                       | Acción                                |
| --------------------------- | ------------------------------------- |
| `<leader>uf` / `<leader>uF` | Autoformato (global / buffer)         |
| `<leader>us`                | Corrector ortográfico                 |
| `<leader>uw`                | Ajuste de línea (wrap)                |
| `<leader>uL`                | Números relativos                     |
| `<leader>ul`                | Números de línea                      |
| `<leader>ud`                | Diagnósticos                          |
| `<leader>uc`                | Conceal level                         |
| `<leader>uA`                | Tabline                               |
| `<leader>uT`                | Treesitter                            |
| `<leader>ub`                | Fondo oscuro/claro                    |
| `<leader>uD`                | Modo dim                              |
| `<leader>ua`                | Animaciones                           |
| `<leader>ug`                | Guías de indentación                  |
| `<leader>uS`                | Animación de scroll                   |
| `<leader>uh`                | Inlay hints del LSP                   |
| `<leader>uG`                | Señales de Git                        |
| `<leader>ui`                | Inspeccionar posición                 |
| `<leader>uI`                | Inspeccionar árbol de Treesitter      |
| `<leader>uC`                | Elegir colorscheme                    |
| `<leader>um`                | Activar/desactivar render de Markdown |
| `<leader>un`                | Cerrar notificaciones                 |
| `<leader>L`                 | Changelog de LazyVim                  |

---

## 9. Terminal

| Atajo             | Acción                                    |
| ----------------- | ----------------------------------------- |
| `<C-/>` o `<C-_>` | Terminal flotante en la raíz del proyecto |
| `<leader>ft`      | Terminal en la raíz                       |
| `<leader>fT`      | Terminal en el directorio actual          |
| `<leader>oc`      | Terminal de **OpenCode** (derecha)        |

> Dentro de la terminal, `<C-/>` vuelve a enfocar/ocultar la terminal.
> Para salir del modo terminal: `<Esc>` y luego los atajos normales.

---

## 10. Inteligencia artificial

### OpenCode (`opencode.nvim`)

| Atajo        | Modo  | Acción                                                            |
| ------------ | ----- | ----------------------------------------------------------------- |
| `<leader>oa` | n / x | Preguntar con el contexto actual (`@this`)                        |
| `<leader>os` | n / x | Menú de acciones: explicar, revisar, corregir, documentar, tests… |
| `<leader>ot` | n / x | Enviar la selección directamente al prompt                        |
| `<leader>oc` | n / t | Abrir/cerrar la terminal de OpenCode                              |

Contextos disponibles al preguntar: `@this`, `@buffer`, `@buffers`,
`@diagnostics`, `@marks`, `@quickfix`, `@visible`.

### CodeCompanion + Ollama

Configurado contra un Ollama remoto (por defecto `http://deoslv.local:11434`,
modelo `qwen2.5:7b`). Se puede cambiar sin editar el archivo:

```bash
export OLLAMA_HOST="http://deoslv.tail1ad40d.ts.net:11434"
export OLLAMA_MODEL="qwen2.5:7b"
```

| Comando                       | Acción                                     |
| ----------------------------- | ------------------------------------------ |
| `:CodeCompanionChat`          | Abrir chat                                 |
| `:CodeCompanionChat Toggle`   | Abrir/cerrar chat                          |
| `:CodeCompanionChat <prompt>` | Abrir chat y enviar prompt                 |
| `:CodeCompanion <prompt>`     | Edición inline (escribe en el buffer)      |
| `:CodeCompanionCmd <prompt>`  | Generar un comando en la línea de comandos |
| `:CodeCompanionActions`       | Paleta de acciones                         |

Atajos dentro del chat:

| Tecla            | Acción                            |
| ---------------- | --------------------------------- |
| `<CR>` / `<C-s>` | Enviar mensaje                    |
| `?`              | Opciones del chat                 |
| `q`              | Detener la petición actual        |
| `gr`             | Regenerar la última respuesta     |
| `<C-c>`          | Cerrar el chat                    |
| `gx`             | Limpiar mensajes                  |
| `gc`             | Insertar bloque de código         |
| `gy`             | Copiar el último bloque de código |
| `ga`             | Cambiar adaptador/modelo          |
| `gf`             | Plegar bloques de código          |
| `gs`             | Mostrar/ocultar system prompt     |
| `gd`             | Información de depuración         |
| `]]` / `[[`      | Siguiente/anterior encabezado     |
| `}` / `{`        | Siguiente/anterior chat           |

> Usa `#buffer`, `#lsp`, `#rules` y similares dentro del prompt para dar contexto.

---

## 11. Markdown y outline

| Atajo                    | Acción                             |
| ------------------------ | ---------------------------------- |
| `<leader>um`             | Render de Markdown on/off          |
| `<F9>`                   | Outline / estructura del documento |
| `:AerialToggle`          | Abrir/cerrar outline               |
| `<CR>` en el outline     | Saltar al símbolo                  |
| `{` / `}` en el outline  | Símbolo anterior/siguiente         |
| `o` / `za` en el outline | Plegar/desplegar nodo              |
| `q` en el outline        | Cerrar                             |

En archivos Markdown el outline se abre automáticamente a la derecha.
El render usa el preset **Obsidian**, con tablas, checkboxes y enlaces.
En modo inserción se muestra el texto crudo para escribir cómodo.

> **Nota:** el atajo `<leader>o` de Aerial choca con el de Neo-tree; actualmente
> gana Neo-tree. Para el outline usa `<F9>`.

---

## 12. Lenguajes soportados

Los extras de LazyVim activados están en `lazyvim.json`:

- **Python** (LSP `pyright`, `ruff` para lint/formato, venv de `uv`)
- **Dart/Flutter** (LSP vía `fvm`)
- **Kotlin** (con `kotlin-language-server` y JDK 21)
- **TypeScript/JavaScript**
- **JSON** (con `SchemaStore`)
- **YAML**
- **Prettier** (formato)
- **ESLint** (lint)

| Atajo        | Acción                                           |
| ------------ | ------------------------------------------------ |
| `<leader>cv` | Seleccionar virtualenv de Python (`:VenvSelect`) |

Requisitos externos:

```bash
brew install fd                    # necesario para venv-selector
brew install kotlin-language-server # LSP de Kotlin
brew install openjdk@21            # JDK para el LSP de Kotlin
# fvm en ~/fvm y uv para Python
```

- Python: `pyright` busca `.venv` en la raíz del proyecto (creado con `uv sync`).
- Dart: si Neovim se abre desde Finder, se añade `~/fvm/default/bin` al `PATH`.
- Kotlin: si existe el JDK 21 de Homebrew, se usa solo para ese LSP.

---

## 13. Vim esencial

| Atajo                        | Acción                                                |
| ---------------------------- | ----------------------------------------------------- |
| `i` / `a`                    | Insertar antes / después                              |
| `v` / `V` / `<C-v>`          | Visual / línea / bloque                               |
| `y` / `d` / `c`              | Copiar / borrar / cambiar                             |
| `p` / `P`                    | Pegar después / antes                                 |
| `/` / `?`                    | Buscar adelante / atrás                               |
| `n` / `N`                    | Siguiente / anterior resultado                        |
| `:%s/viejo/nuevo/g`          | Reemplazo global                                      |
| `gg` / `G`                   | Inicio / fin del archivo                              |
| `0` / `^` / `$`              | Inicio de línea / primer carácter / fin               |
| `w` / `b` / `e`              | Siguiente palabra / anterior / fin                    |
| `ciw` / `diw` / `yiw`        | Cambiar/borrar/copiar palabra                         |
| `ci"` / `ci(`                | Cambiar dentro de comillas/paréntesis                 |
| `>>` / `<<`                  | Indentar / desindentar                                |
| `J`                          | Unir líneas                                           |
| `~`                          | Cambiar mayúsculas/minúsculas                         |
| `zz`                         | Centrar la línea actual                               |
| `q:`                         | Historial de comandos                                 |
| `:w` / `:q` / `:wq` / `:qa!` | Guardar / salir / guardar y salir / salir sin guardar |

---

## 14. Estructura de la configuración

```
~/.config/nvim/
├── init.lua                     # entrada
├── lazyvim.json                 # extras de LazyVim activados
├── lua/
│   ├── config/
│   │   ├── lazy.lua             # bootstrap de lazy.nvim
│   │   ├── options.lua          # opciones globales
│   │   ├── keymaps.lua          # atajos personales
│   │   ├── autocmds.lua         # autocmds
│   │   └── remote_clipboard.lua # portapapeles remoto (Linux/Wayland/tmux)
│   └── plugins/                 # specs de plugins
└── plugin/after/transparency.lua # fondos transparentes
```

### Atajos personalizados (no estándar de LazyVim)

| Atajo                             | Acción                |
| --------------------------------- | --------------------- |
| `<leader>qq`                      | Cerrar buffer actual  |
| `<leader>qx`                      | Salir de Neovim       |
| `ga`                              | Formatear código      |
| `<leader>o`                       | Explorador (Neo-tree) |
| `<F9>`                            | Outline (Aerial)      |
| `<leader>um`                      | Render de Markdown    |
| `<leader>oa` / `os` / `ot` / `oc` | OpenCode              |

### Notas

- **Portapapeles:** en macOS se usa `pbcopy`/`pbpaste` nativo. El shim remoto
  (Wayland/tmux/SSH) solo se activa en Linux.
- **Tema:** se carga el tema actual de Omarchy si existe
  (`~/.local/state/omarchy/current/theme/neovim.lua`); si no, se usa
  `tokyonight`. Cambia de tema con `<leader>uC`.
- **Transparencia:** los fondos son transparentes, incluida la statusline.
- **Autoformato:** desactivado por defecto; formatea manualmente.
- **Números relativos:** desactivados por defecto (`<leader>uL` para activarlos).

---

## 15. Solución de problemas

| Síntoma                   | Solución                                          |
| ------------------------- | ------------------------------------------------- |
| Un plugin no carga        | `:Lazy sync` y reiniciar                          |
| LSP no arranca            | `:Mason`, `:checkhealth`, `<leader>cl`            |
| Formato no funciona       | Verifica el formateador con `:Mason`; prueba `ga` |
| Python no detecta el venv | `<leader>cv` y elige el entorno                   |
| Conflicto de atajos       | `<leader>sk` para inspeccionar                    |
| Neovim arranca lento      | `:Lazy profile`                                   |
