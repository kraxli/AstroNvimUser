return {
  cmd = function(dispatchers)
    -- check for nvim-lspconfig julia sysimage shim
    local julia_bin = "julia"
    for _, depot in
      ipairs(
        vim.env.JULIA_DEPOT_PATH and vim.split(vim.env.JULIA_DEPOT_PATH, vim.fn.has "win32" == 1 and ";" or ":")
          or { vim.fn.expand "~/.julia" }
      )
    do
      local bin = vim.fs.joinpath(depot, "environments", "nvim-lspconfig", "bin", "julia")
      local file = (vim.uv or vim.loop).fs_stat(bin)
      if file and file.type == "file" then
        julia_bin = bin
        break
      end
    end
    local cmd = {
      julia_bin,
      "--startup-file=no",
      "--history-file=no",
      "-e",
      [[
        # Load LanguageServer.jl: attempt to load from ~/.julia/environments/nvim-lspconfig
        # with the regular load path as a fallback
        ls_install_path = joinpath(
            get(DEPOT_PATH, 1, joinpath(homedir(), ".julia")),
            "environments", "nvim-lspconfig"
        )
        pushfirst!(LOAD_PATH, ls_install_path)
        using LanguageServer, SymbolServer, StaticLint
        popfirst!(LOAD_PATH)
        depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
        project_path = let
            dirname(something(
                ## 1. Finds an explicitly set project (JULIA_PROJECT)
                Base.load_path_expand((
                    p = get(ENV, "JULIA_PROJECT", nothing);
                    p === nothing ? nothing : isempty(p) ? nothing : p
                )),
                ## 2. Look for a Project.toml file in the current working directory,
                ##    or parent directories, with $HOME as an upper boundary
                Base.current_project(),
                ## 3. First entry in the load path
                get(Base.load_path(), 1, nothing),
                ## 4. Fallback to default global environment,
                ##    this is more or less unreachable
                Base.load_path_expand("@v#.#"),
            ))
        end
        @info "Running language server" VERSION pwd() project_path depot_path
        server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)
        server.runlinter = true
        run(server)
      ]],
    }

    return vim.lsp.rpc.start(cmd, dispatchers)
  end,
  on_attach = function(client)
    local environment = vim.tbl_get(client, "settings", "julia", "environmentPath")
    if environment then client.notify("julia/activateenvironment", { envPath = environment }) end
  end,
  settings = {
    julia = {
      completionmode = "qualify",
      lint = { missingrefs = "none" },
    },
  },
}
