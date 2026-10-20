---@type LazySpec
return {
  -- ==========================================================================
  -- Java + Spring Boot
  --
  -- Pensado para proyectos Kotlin/Spring Boot que además tienen código .java.
  -- jdtls se inicia con nvim-jdtls (no con lspconfig ni con el handler de
  -- mason-lspconfig) para poder cargar las extensiones de Mason:
  --   java-debug-adapter, java-test y vscode-spring-boot-tools (spring-tools).
  --
  -- Pasos de instalación y atajos: README.md > "Kotlin y Spring Boot".
  -- ==========================================================================

  -- 1) jdtls: se instala con Mason, pero no se habilita desde mason-lspconfig
  --    porque lo arranca nvim-jdtls (si no, se abrirían dos servidores jdtls).
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed or {}, {
        "jdtls",
      })
      opts.handlers = opts.handlers or {}
      -- AstroNvim registra un handler por defecto (el del array). Se añade una
      -- entrada para jdtls que no hace nada: lo gestiona nvim-jdtls más abajo.
      opts.handlers.jdtls = function() end
      return opts
    end,
  },

  -- 2) Adaptadores de depuración de Java para nvim-dap.
  --    Luego se cargan como bundles de jdtls (ver más abajo) y nvim-jdtls
  --    registra las configuraciones con setup_dap().
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed or {}, {
        "javadbg", -- java-debug-adapter
        "javatest", -- java-test
      })
      return opts
    end,
  },

  -- 3) vscode-spring-boot-tools (spring-tools) aporta la extensión de Spring
  --    Boot para jdtls. No es un servidor de nvim-lspconfig ni un paquete que
  --    mason-lspconfig conozca, así que se instala con mason-registry tras el
  --    arranque. También se puede hacer a mano: :MasonInstall vscode-spring-boot-tools
  {
    "williamboman/mason.nvim",
    optional = true,
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        group = vim.api.nvim_create_augroup("AstroSpringBootTools", { clear = true }),
        once = true,
        desc = "Instalar vscode-spring-boot-tools (extensión de Spring Boot para jdtls) si falta",
        callback = function()
          local ok, registry = pcall(require, "mason-registry")
          if not ok then return end
          local function ensure()
            local has_pkg, pkg = pcall(registry.get_package, "vscode-spring-boot-tools")
            if has_pkg and not pkg:is_installed() then pkg:install() end
          end
          if registry.refresh then
            registry.refresh(ensure)
          else
            ensure()
          end
        end,
      })
    end,
  },

  -- 4) nvim-jdtls con las extensiones de Spring Boot, depuración y tests.
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    opts = function(_, opts)
      local astrocore = require "astrocore"
      -- $MASON lo define mason.nvim al configurarse; con reserva por si acaso.
      local share = (vim.env.MASON or (vim.fn.stdpath "data" .. "/mason")) .. "/share"

      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      local workspace_dir = vim.fn.stdpath "data" .. "/site/java/workspace-root/" .. project_name
      vim.fn.mkdir(workspace_dir, "p")

      -- glob() con lista (3.er argumento true) devuelve una tabla Lua vacía si no
      -- hay coincidencias, así que no se cuelan rutas "" en los bundles.
      local function glob_jars(pattern)
        local jars = {}
        for _, jar in ipairs(vim.fn.glob(pattern, true, true)) do
          if jar ~= "" then table.insert(jars, jar) end
        end
        return jars
      end

      -- Extensiones (jars) que jdtls debe cargar
      local bundles = { share .. "/java-debug-adapter/com.microsoft.java.debug.plugin.jar" }
      vim.list_extend(bundles, glob_jars(share .. "/java-test/*.jar")) -- Java Test Runner
      vim.list_extend(bundles, glob_jars(share .. "/vscode-spring-boot-tools/jdtls/**/*.jar")) -- Spring Boot

      return astrocore.extend_tbl({
        cmd = {
          "java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-javaagent:" .. share .. "/jdtls/lombok.jar",
          "-Xms1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",
          "-jar",
          share .. "/jdtls/plugins/org.eclipse.equinox.launcher.jar",
          "-configuration",
          share .. "/jdtls/config",
          "-data",
          workspace_dir,
        },
        root_dir = function(fname)
          return vim.fs.root(fname, {
            ".git",
            "mvnw",
            "gradlew",
            "pom.xml",
            "build.gradle",
            "build.gradle.kts",
            "settings.gradle",
            "settings.gradle.kts",
          })
        end,
        settings = {
          java = {
            eclipse = { downloadSources = true },
            maven = { downloadSources = true },
            configuration = { updateBuildConfiguration = "interactive" },
            implementationsCodeLens = { enabled = true },
            referencesCodeLens = { enabled = true },
            inlayHints = { parameterNames = { enabled = "all" } },
            signatureHelp = { enabled = true },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
            completion = {
              favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
              },
            },
          },
        },
        init_options = { bundles = bundles },
        filetypes = { "java" },
        handlers = { ["$/progress"] = function() end }, -- sin avisos de progreso
        on_attach = function(client, bufnr)
          local jdtls_ok, jdtls = pcall(require, "jdtls")
          if jdtls_ok then jdtls.setup_dap { hotcodereplace = "auto" } end
          local astrolsp_ok, astrolsp = pcall(require, "astrolsp")
          if astrolsp_ok then astrolsp.on_attach(client, bufnr) end
        end,
      }, opts)
    end,
    config = function(_, opts)
      local jdtls = require "jdtls"

      local function start(bufnr)
        bufnr = bufnr or 0
        local fname = vim.api.nvim_buf_get_name(bufnr)
        -- root_dir es una función: se evalúa por buffer para no arrancar jdtls
        -- en archivos que no pertenecen a ningún proyecto (.git, gradlew, pom.xml…).
        -- Ojo: no usar `x and f() or y`, porque si f() devuelve nil el
        -- resultado terminaría siendo la propia función (truthy).
        local root
        if type(opts.root_dir) == "function" then
          root = opts.root_dir(fname)
        else
          root = opts.root_dir
        end
        if root and root ~= "" then
          jdtls.start_or_attach(opts)
        else
          require("astrocore").notify(
            "jdtls: no se encontró la raíz del proyecto (.git, gradlew, pom.xml, build.gradle…)",
            vim.log.levels.WARN
          )
        end
      end

      -- jdtls solo aplica a archivos .java
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        group = vim.api.nvim_create_augroup("AstroJdtls", { clear = true }),
        callback = function(event) start(event.buf) end,
      })
      -- Si el plugin se cargó justo al abrir un .java (lazy `ft`), el autocmd de
      -- arriba no alcanza al buffer actual: se arranca explícitamente.
      if vim.bo.filetype == "java" then start(0) end

      -- Configuraciones de clase principal para nvim-dap, cuando jdtls ya cargó.
      vim.api.nvim_create_autocmd("LspAttach", {
        pattern = "*.java",
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "jdtls" then
            pcall(function() require("jdtls.dap").setup_dap_main_class_configs() end)
          end
        end,
      })
    end,
  },

  -- 5) Ejecutar Gradle / Maven y Spring Boot desde Neovim (terminal de AstroNvim).
  {
    "AstroNvim/astrocore",
    optional = true,
    opts = function(_, opts)
      -- Raíz del proyecto actual (o cwd si AstroCore no puede detectarla)
      local function project_root()
        local ok, roots = pcall(function() return require("astrocore.rooter").detect(0, false) end)
        if ok and roots and roots[1] and roots[1].paths and roots[1].paths[1] then return roots[1].paths[1] end
        return vim.fn.getcwd()
      end

      -- Devuelve el comando del wrapper del proyecto: Gradle o Maven
      local function build_cmd(root, gradle_task, maven_goal)
        local function is_executable(rel) return vim.fn.executable(root .. "/" .. rel) == 1 end
        if is_executable "gradlew" then
          return "./gradlew " .. gradle_task
        elseif is_executable "mvnw" then
          return "./mvnw " .. maven_goal
        elseif vim.fn.executable "gradle" == 1 then
          return "gradle " .. gradle_task
        elseif vim.fn.executable "mvn" == 1 then
          return "mvn " .. maven_goal
        end
      end

      local function run(gradle_task, maven_goal)
        return function()
          local root = project_root()
          local cmd = build_cmd(root, gradle_task, maven_goal)
          if not cmd then
            require("astrocore").notify(
              "No se encontró ./gradlew, ./mvnw, gradle ni mvn en " .. root,
              vim.log.levels.WARN
            )
            return
          end
          require("astrocore").toggle_term_cmd { cmd = cmd, dir = root, direction = "float" }
        end
      end

      opts.mappings = require("astrocore").extend_tbl(opts.mappings or {}, {
        n = {
          ["<Leader>kr"] = { run("bootRun", "spring-boot:run"), desc = "Spring Boot: ejecutar la app" },
          ["<Leader>kt"] = { run("test", "test"), desc = "Ejecutar tests (Gradle/Maven)" },
          ["<Leader>kb"] = { run("build", "package"), desc = "Compilar (build/package)" },
          ["<Leader>kc"] = { run("clean build", "clean package"), desc = "Compilar desde cero (clean)" },
        },
      })
    end,
  },
}
