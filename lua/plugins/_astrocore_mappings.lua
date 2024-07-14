return {
  "AstroNvim/astrocore",
  ---@param opts AstroCoreOpts
  opts = function(_, opts)
    local astro = require "astrocore"
    local get_icon = require("astroui").get_icon
    -- Inicializa las secciones de mapeo internamente usando títulos
    opts._map_sections = {
      f = { desc = get_icon("Search", 1, true) .. "Buscar" },
      p = { desc = get_icon("Package", 1, true) .. "Paquetes" },
      l = { desc = get_icon("ActiveLSP", 1, true) .. "Herramientas de Lenguaje" },
      u = { desc = get_icon("Window", 1, true) .. "UI/UX" },
      b = { desc = get_icon("Tab", 1, true) .. "Buffers" },
      bs = { desc = get_icon("Sort", 1, true) .. "Ordenar Buffers" },
      d = { desc = get_icon("Debugger", 1, true) .. "Depurador" },
      g = { desc = get_icon("Git", 1, true) .. "Git" },
      S = { desc = get_icon("Session", 1, true) .. "Sesión" },
      t = { desc = get_icon("Terminal", 1, true) .. "Terminal" },
      x = { desc = get_icon("List", 1, true) .. "Quickfix/Listas" },
    }

    -- Inicializa la tabla de mapeos
    local maps = astro.empty_map_table()
    local sections = assert(opts._map_sections)

    -- Mapeos Normales --
    -- Operaciones estándar
    maps.n["j"] = { "v:count == 0 ? 'gj' : 'j'", expr = true, silent = true, desc = "Mover cursor abajo" }
    maps.x["j"] = maps.n["j"]
    maps.n["k"] = { "v:count == 0 ? 'gk' : 'k'", expr = true, silent = true, desc = "Mover cursor arriba" }
    maps.x["k"] = maps.n["k"]
    maps.n["<Leader>w"] = { "<Cmd>w<CR>", desc = "Guardar" }
    maps.n["<Leader>c"] = { "<Cmd>confirm q<CR>", desc = "Cerrar Ventana" }
    maps.n["<Leader>C"] = { "<Cmd>confirm qall<CR>", desc = "Salir de AstroNvim" }
    maps.n["<Leader>n"] = { "<Cmd>enew<CR>", desc = "Nuevo Archivo" }
    maps.n["<C-S>"] = { "<Cmd>silent! update! | redraw<CR>", desc = "Forzar escritura" }
    -- TODO: eliminar guardar en inserción en AstroNvim v5 cuando se usa para ayuda de firma
    maps.i["<C-S>"] = { "<Esc>" .. maps.n["<C-S>"][1], desc = maps.n["<C-S>"].desc }
    maps.x["<C-S>"] = maps.i["<C-s>"]
    maps.n["<C-Q>"] = { "<Cmd>q!<CR>", desc = "Forzar salir" }
    maps.n["|"] = { "<Cmd>vsplit<CR>", desc = "División Vertical" }
    maps.n["\\"] = { "<Cmd>split<CR>", desc = "División Horizontal" }
    -- TODO: eliminar método obsoleto después de dejar de soportar neovim v0.9
    if not vim.ui.open then
      local gx_desc = "Abre la ruta de archivo o URI bajo el cursor con el manejador del sistema (explorador de archivos, navegador web, ...)"
      maps.n["gx"] = { function() astro.system_open(vim.fn.expand "<cfile>") end, desc = gx_desc }
      maps.x["gx"] = {
        function()
          local lines = vim.fn.getregion(vim.fn.getpos ".", vim.fn.getpos "v", { type = vim.fn.mode() })
          astro.system_open(table.concat(vim.tbl_map(vim.trim, lines)))
        end,
        desc = gx_desc,
      }
    end
    maps.n["<Leader>/"] = { "gcc", remap = true, desc = "Alternar comentario de línea" }
    maps.x["<Leader>/"] = { "gc", remap = true, desc = "Alternar comentario" }

    -- Mapeos LSP por defecto de Neovim
    if vim.fn.has "nvim-0.11" ~= 1 then
      maps.n["gra"] = { function() vim.lsp.buf.code_action() end, desc = "vim.lsp.buf.code_action()" }
      maps.x["gra"] = { function() vim.lsp.buf.code_action() end, desc = "vim.lsp.buf.code_action()" }
      maps.n["grn"] = { function() vim.lsp.buf.rename() end, desc = "vim.lsp.buf.rename()" }
      maps.n["grr"] = { function() vim.lsp.buf.references() end, desc = "vim.lsp.buf.references()" }
      -- --- TODO: AstroNvim v5 agregar compatibilidad hacia atrás para seguir mapeos neovim 0.11
      -- maps.i["<C-S>"] = { function() vim.lsp.buf.signature_help() end, desc = "vim.lsp.buf.signature_help()" }
    end

    -- Gestor de Plugins
    maps.n["<Leader>p"] = vim.tbl_get(sections, "p")
    maps.n["<Leader>pi"] = { function() require("lazy").install() end, desc = "Instalar Plugins" }
    maps.n["<Leader>ps"] = { function() require("lazy").home() end, desc = "Estado de Plugins" }
    maps.n["<Leader>pS"] = { function() require("lazy").sync() end, desc = "Sincronización de Plugins" }
    maps.n["<Leader>pu"] = { function() require("lazy").check() end, desc = "Verificar Actualizaciones de Plugins" }
    maps.n["<Leader>pU"] = { function() require("lazy").update() end, desc = "Actualizar Plugins" }
    maps.n["<Leader>pa"] = { function() require("astrocore").update_packages() end, desc = "Actualizar Lazy y Mason" }

    -- Manejo de Buffers
    maps.n["<Leader>q"] = { function() require("astrocore.buffer").close() end, desc = "Cerrar buffer" }
    maps.n["<Leader>Q"] = { function() require("astrocore.buffer").close(0, true) end, desc = "Forzar cerrar buffer" }
    maps.n["<S-l>"] = {
      function() require("astrocore.buffer").nav(vim.v.count1) end,
      desc = "Siguiente buffer",
    }
    maps.n["<S-h>"] = {
      function() require("astrocore.buffer").nav(-vim.v.count1) end,
      desc = "Buffer anterior",
    }
    maps.n[">b"] = {
      function() require("astrocore.buffer").move(vim.v.count1) end,
      desc = "Mover pestaña de buffer a la derecha",
    }
    maps.n["<b"] = {
      function() require("astrocore.buffer").move(-vim.v.count1) end,
      desc = "Mover pestaña de buffer a la izquierda",
    }

    maps.n["<Leader>b"] = vim.tbl_get(sections, "b")
    maps.n["<Leader>bc"] =
      { function() require("astrocore.buffer").close_all(true) end, desc = "Cerrar todos los buffers excepto el actual" }
    maps.n["<Leader>bC"] = { function() require("astrocore.buffer").close_all() end, desc = "Cerrar todos los buffers" }
    maps.n["<Leader>bl"] =
      { function() require("astrocore.buffer").close_left() end, desc = "Cerrar todos los buffers a la izquierda" }
    maps.n["<Leader>bp"] = { function() require("astrocore.buffer").prev() end, desc = "Buffer anterior" }
    maps.n["<Leader>br"] =
      { function() require("astrocore.buffer").close_right() end, desc = "Cerrar todos los buffers a la derecha" }
    maps.n["<Leader>bs"] = vim.tbl_get(sections, "bs")
    maps.n["<Leader>bse"] = { function() require("astrocore.buffer").sort "extension" end, desc = "Por extensión" }
    maps.n["<Leader>bsr"] = { function() require("astrocore.buffer").sort "unique_path" end, desc = "Por ruta relativa" }
    maps.n["<Leader>bsp"] = { function() require("astrocore.buffer").sort "full_path" end, desc = "Por ruta completa" }
    maps.n["<Leader>bsi"] = { function() require("astrocore.buffer").sort "bufnr" end, desc = "Por número de buffer" }
    maps.n["<Leader>bsm"] = { function() require("astrocore.buffer").sort "modified" end, desc = "Por modificación" }

    maps.n["<Leader>l"] = vim.tbl_get(sections, "l")
    maps.n["<Leader>ld"] = { function() vim.diagnostic.open_float() end, desc = "Diagnósticos de desplazamiento" }
    local function diagnostic_goto(dir, severity)
      local go = vim.diagnostic["goto_" .. (dir and "next" or "prev")]
      if type(severity) == "string" then severity = vim.diagnostic.severity[severity] end
      return function() go { severity = severity } end
    end
    -- TODO: Eliminar mapeo después de dejar de soportar Neovim v0.10, es automático
    if vim.fn.has "nvim-0.11" == 0 then
      maps.n["[d"] = { diagnostic_goto(false), desc = "Diagnóstico anterior" }
      maps.n["]d"] = { diagnostic_goto(true), desc = "Diagnóstico siguiente" }
    end
    maps.n["[e"] = { diagnostic_goto(false, "ERROR"), desc = "Error anterior" }
    maps.n["]e"] = { diagnostic_goto(true, "ERROR"), desc = "Error siguiente" }
    maps.n["[w"] = { diagnostic_goto(false, "WARN"), desc = "Advertencia anterior" }
    maps.n["]w"] = { diagnostic_goto(true, "WARN"), desc = "Advertencia siguiente" }
    -- TODO: Eliminar mapeo después de dejar de soportar Neovim v0.9, es automático
    if vim.fn.has "nvim-0.10" == 0 then
      maps.n["<C-W>d"] = { function() vim.diagnostic.open_float() end, desc = "Diagnósticos de desplazamiento" }
      maps.n["<C-W><C-D>"] = { function() vim.diagnostic.open_float() end, desc = "Diagnósticos de desplazamiento" }
    end
    maps.n["gl"] = { function() vim.diagnostic.open_float() end, desc = "Diagnósticos de desplazamiento" }

    -- Navegación entre pestañas
    maps.n["]t"] = { function() vim.cmd.tabnext() end, desc = "Pestaña siguiente" }
    maps.n["[t"] = { function() vim.cmd.tabprevious() end, desc = "Pestaña anterior" }

    -- Navegación entre divisiones
    maps.n["<C-H>"] = { "<C-w>h", desc = "Mover a división izquierda" }
    maps.n["<C-J>"] = { "<C-w>j", desc = "Mover a división abajo" }
    maps.n["<C-K>"] = { "<C-w>k", desc = "Mover a división arriba" }
    maps.n["<C-L>"] = { "<C-w>l", desc = "Mover a división derecha" }
    maps.n["<C-Up>"] = { "<Cmd>resize -2<CR>", desc = "Redimensionar división hacia arriba" }
    maps.n["<C-Down>"] = { "<Cmd>resize +2<CR>", desc = "Redimensionar división hacia abajo" }
    maps.n["<C-Left>"] = { "<Cmd>vertical resize -2<CR>", desc = "Redimensionar división hacia la izquierda" }
    maps.n["<C-Right>"] = { "<Cmd>vertical resize +2<CR>", desc = "Redimensionar división hacia la derecha" }

    -- Gestión de listas
    maps.n["<Leader>x"] = vim.tbl_get(sections, "x")
    maps.n["<Leader>xq"] = { "<Cmd>copen<CR>", desc = "Lista de Quickfix" }
    maps.n["<Leader>xl"] = { "<Cmd>lopen<CR>", desc = "Lista de Localización" }
    maps.n["]q"] = { vim.cmd.cnext, desc = "Siguiente Quickfix" }
    maps.n["[q"] = { vim.cmd.cprev, desc = "Anterior Quickfix" }
    maps.n["]Q"] = { vim.cmd.clast, desc = "Fin Quickfix" }
    maps.n["[Q"] = { vim.cmd.cfirst, desc = "Inicio Quickfix" }

    maps.n["]l"] = { vim.cmd.lnext, desc = "Siguiente lista de locación" }
    maps.n["[l"] = { vim.cmd.lprev, desc = "Anterior lista de locación" }
    maps.n["]L"] = { vim.cmd.llast, desc = "Fin lista de locación" }
    maps.n["[L"] = { vim.cmd.lfirst, desc = "Inicio lista de locación" }

    -- Permanecer en modo de sangría
    maps.v["<S-Tab>"] = { "<gv", desc = "Reducir sangría de línea" }
    maps.v["<Tab>"] = { ">gv", desc = "Aumentar sangría de línea" }

    -- Mejora de navegación de terminal
    maps.t["<C-H>"] = { "<Cmd>wincmd h<CR>", desc = "Navegación izquierda en ventana de terminal" }
    maps.t["<C-J>"] = { "<Cmd>wincmd j<CR>", desc = "Navegación abajo en ventana de terminal" }
    maps.t["<C-K>"] = { "<Cmd>wincmd k<CR>", desc = "Navegación arriba en ventana de terminal" }
    maps.t["<C-L>"] = { "<Cmd>wincmd l<CR>", desc = "Navegación derecha en ventana de terminal" }

    maps.n["<Leader>u"] = vim.tbl_get(sections, "u")
    -- Menú personalizado para modificación de la experiencia de usuario
    maps.n["<Leader>uA"] = { function() require("astrocore.toggles").autochdir() end, desc = "Alternar autochdir de rooter" }
    maps.n["<Leader>ub"] = { function() require("astrocore.toggles").background() end, desc = "Alternar fondo" }
    maps.n["<Leader>ud"] = { function() require("astrocore.toggles").diagnostics() end, desc = "Alternar diagnósticos" }
    maps.n["<Leader>ug"] = { function() require("astrocore.toggles").signcolumn() end, desc = "Alternar signcolumn" }
    maps.n["<Leader>u>"] = { function() require("astrocore.toggles").foldcolumn() end, desc = "Alternar foldcolumn" }
    maps.n["<Leader>ui"] = { function() require("astrocore.toggles").indent() end, desc = "Cambiar configuración de sangría" }
    maps.n["<Leader>ul"] = { function() require("astrocore.toggles").statusline() end, desc = "Alternar línea de estado" }
    maps.n["<Leader>un"] = { function() require("astrocore.toggles").number() end, desc = "Cambiar numeración de líneas" }
    maps.n["<Leader>uN"] =
      { function() require("astrocore.toggles").notifications() end, desc = "Alternar Notificaciones" }
    maps.n["<Leader>up"] = { function() require("astrocore.toggles").paste() end, desc = "Alternar modo de pegado" }
    maps.n["<Leader>us"] = { function() require("astrocore.toggles").spell() end, desc = "Alternar revisión ortográfica" }
    maps.n["<Leader>uS"] = { function() require("astrocore.toggles").conceal() end, desc = "Alternar ocultar" }
    maps.n["<Leader>ut"] = { function() require("astrocore.toggles").tabline() end, desc = "Alternar tabline" }
    maps.n["<Leader>uu"] = { function() require("astrocore.toggles").url_match() end, desc = "Alternar resaltado de URL" }
    maps.n["<Leader>uw"] = { function() require("astrocore.toggles").wrap() end, desc = "Alternar ajuste de línea" }
    maps.n["<Leader>uy"] =
      { function() require("astrocore.toggles").buffer_syntax() end, desc = "Alternar resaltado de sintaxis" }

    opts.mappings = maps
  end,
}
