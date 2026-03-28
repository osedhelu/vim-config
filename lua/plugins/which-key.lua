return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    -- El preset "modern" a veces se comporta como lista (mover + Enter).
    -- "classic" / "helix": pulsas la letra del atajo y se ejecuta directo.
    opts.preset = "classic"
    opts.delay = function(ctx)
      return ctx.plugin and 0 or 0
    end
    opts.show_help = false
    opts.show_keys = false
    -- Grupos con pocos hijos se muestran “abiertos” y reduces un paso visual.
    if type(opts.expand) == "number" then
      opts.expand = math.max(opts.expand, 12)
    elseif opts.expand == nil then
      opts.expand = 12
    end
    return opts
  end,
}
