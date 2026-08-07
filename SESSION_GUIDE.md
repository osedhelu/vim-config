# 🎯 Guía Completa de Sesiones en Neovim con Auto-Session

## ¿Qué es una Sesión?

Una sesión en Neovim guarda el **estado completo** de tu editor:
- 📄 Archivos abiertos
- 📍 Posición del cursor en cada archivo
- 🪟 Divisiones de ventanas (splits)
- 🔖 Marcas (marks) y cambios sin guardar
- 🎨 Configuración local (folds, syntax, etc.)

## ¿Cómo Funciona con auto-session?

### Automático (Sin hacer nada)

```
Cuando cierras Neovim          →  auto-session guarda la sesión
     ↓
Cuando abres Neovim en la      →  auto-session restaura automáticamente
carpeta nuevamente
```

### Ejemplo Real

```bash
# 1. Abre Neovim en una carpeta
cd ~/projects/mi-app
nvim

# 2. Abre varios archivos
# - src/main.tsx
# - src/utils.ts
# - config.json

# 3. Haz cambios y deja splits abiertos
# - (tu editor está así: 3 archivos abiertos, 2 splits)

# 4. Cierra Neovim
:q

# 5. LA SESIÓN SE GUARDÓ AUTOMÁTICAMENTE ✅
ls ~/.local/share/nvim/sessions/
# → Verás un archivo con el nombre de tu rama de Git

# 6. Abre Neovim de nuevo en la MISMA carpeta
nvim

# 7. ¡BOOM! 🎉 Los 3 archivos se restauran exactamente como los dejaste
```

## Atajos Disponibles

| Atajo | Acción | Cuándo Usarla |
|-------|--------|---------------|
| `<Leader>Ss` | Guardar sesión manualmente | Cuando quieras guardar antes de hacer cambios drásticos |
| `<Leader>Sr` | Restaurar última sesión | Si cerraste archivos accidentalmente |
| `<Leader>Sd` | Eliminar sesión actual | Para comenzar "limpio" en un proyecto |
| `<Leader>Sf` | Buscar sesiones con Telescope | Para cambiar entre sesiones guardadas |

## Casos de Uso

### Caso 1: Trabajar en Múltiples Proyectos

```bash
# Proyecto A
cd ~/projects/project-a
nvim
# → Abre project-a-session
# → Edita los archivos
# → Cierra con :q
# → Session se guarda automáticamente

# Proyecto B
cd ~/projects/project-b
nvim
# → Abre project-b-session
# → Diferente configuración, archivos, splits
# → Tu proyecto A está intacto esperándote

# Vuelve a Proyecto A
cd ~/projects/project-a
nvim
# → ¡Project A se restaura exactamente como lo dejaste!
```

### Caso 2: Cambiar de Rama Git

```bash
git checkout main
nvim
# → Restaura sesión de "main"

git checkout feature/new-feature
nvim
# → Restaura sesión de "feature/new-feature"
# → Diferente configuración de archivos

git checkout main
nvim
# → Vuelve a la sesión de "main"
```

### Caso 3: Usar desde OpenCode

Cuando usas `/editor` en OpenCode:

```
/editor
# → Abre Neovim en el directorio actual
# → auto-session detecta el directorio
# → Restaura la sesión del directorio automáticamente
```

## Directorio de Sesiones

```
~/.local/share/nvim/sessions/
```

Cada sesión es un archivo de Vim guardado como `.vim`:

```
~/.local/share/nvim/sessions/
├── main%home%osedhelu%projects%project-a.vim
├── feature-new-feature%home%osedhelu%projects%project-b.vim
└── ...
```

**Nota**: El nombre incluye:
- Rama de Git (ej: `main`, `feature-new-feature`)
- Ruta completa del directorio

## Directorios Donde NO Se Guardan Sesiones

Configurado en `lua/plugins/auto-session.lua`:

- `~/` (home)
- `~/Downloads`
- `/tmp`
- `/var/tmp`

**Razón**: Evitar conflictos en directorios temporales

## Solucionar Problemas

### Problema: No se restaura la sesión

**Solución 1: Verificar que estás en el directorio correcto**

```bash
# ✅ Correcto
cd ~/projects/mi-app
nvim

# ❌ Incorrecto (fuera del directorio)
nvim ~/projects/mi-app/src/main.tsx
# → No restaura la sesión (estás en ~, no en ~/projects/mi-app)
```

**Solución 2: Verificar rama de Git**

```bash
cd ~/projects/mi-app
git branch
# → Asegúrate que estés en la rama correcta
```

**Solución 3: Restaurar manualmente**

```
<Leader>Sr
# → Restaura la sesión manualmente
```

### Problema: Quiero empezar sin sesión guardada

```
<Leader>Sd
# → Elimina la sesión actual
# → Próxima vez que abras, tendrás un Neovim limpio
```

### Problema: Ver todas las sesiones guardadas

```
<Leader>Sf
# → Abre Telescope con todas las sesiones
# → Puedes ver, buscar y cambiar entre ellas
```

## Cómo Funciona Internamente

### 1. Al abrir Neovim

```lua
auto-session:
  1. Detecta directorio actual → getcwd()
  2. Detecta rama de Git → git branch
  3. Genera nombre: "rama%ruta%del%directorio"
  4. Busca archivo de sesión en ~/.local/share/nvim/sessions/
  5. Si existe → restaura automáticamente
  6. Si no existe → abre Neovim limpio
```

### 2. Al cerrar Neovim

```lua
auto-session:
  1. Guarda el estado actual (archivos, splits, posiciones)
  2. Crea/actualiza archivo de sesión
  3. Guarda en ~/.local/share/nvim/sessions/rama%ruta.vim
```

## Configuración en tu Nvim

Archivo: `lua/plugins/auto-session.lua`

Opciones clave:

```lua
auto_restore_enabled = true              -- Restaurar automáticamente ✅
auto_save_enabled = true                 -- Guardar automáticamente ✅
use_git_branch_as_session_name = true    -- Usar rama Git como nombre ✅
suppress_session_restore_message = false -- Mostrar notificación
```

## Integración con OpenCode

Cuando usas `/editor` desde OpenCode:

```
OpenCode
  ↓
/editor [archivo]
  ↓
Neovim se abre en el directorio
  ↓
auto-session detecta el directorio
  ↓
Restaura la sesión automáticamente ✨
```

**Clave**: OpenCode pasa el directorio actual, auto-session hace el resto.

## Resumen

✨ **auto-session es transparente**: 
- Guarda automáticamente ✅
- Restaura automáticamente ✅  
- No necesitas hacer nada extra 🎉

🎮 **Controla manualmente cuando quieras**:
- `<Leader>Ss` - Guardar ahora
- `<Leader>Sr` - Restaurar
- `<Leader>Sd` - Eliminar
- `<Leader>Sf` - Ver todas

🚀 **Diseñado para trabajar perfecto con OpenCode**: 
- `/editor` abre Neovim con sesión automática

¡Disfruta tu experiencia de Neovim! 🚀
