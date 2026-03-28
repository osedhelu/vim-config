#!/usr/bin/env bash
# Diagnóstico rápido de Neovim + limpieza de artefactos rotos de nvim-treesitter.
# Uso: ./scripts/nvim-doctor.sh [check|fix-treesitter|repair|all]
set -euo pipefail

NVIM_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"

usage() {
  cat <<'EOF'
Uso: nvim-doctor.sh [comando]

Comandos:
  check           Ejecuta nvim --headless +checkhealth (carga tu init.lua).
  fix-treesitter  Borra en $XDG_DATA_HOME/nvim los directorios tree-sitter-*-tmp
                  y los tree-sitter-*.tar.gz (descargas corruptas o a medias).
  repair          fix-treesitter y luego :TSUpdateSync all en headless
                  (requiere red; puede tardar varios minutos).
  all             fix-treesitter + check (sin descargar parsers).

Variables útiles: XDG_DATA_HOME, NVIM_APPNAME

Tras fix-treesitter, si no ejecutas repair, abre nvim y corre: :TSUpdateSync all
EOF
}

fix_treesitter() {
  echo "==> Limpiando artefactos de nvim-treesitter en: $NVIM_DATA"
  local removed=0

  shopt -s nullglob
  for path in "$NVIM_DATA"/tree-sitter-*-tmp; do
    if [[ -d "$path" ]]; then
      echo "    eliminando: $path"
      rm -rf "$path"
      removed=$((removed + 1))
    fi
  done
  for path in "$NVIM_DATA"/tree-sitter-*.tar.gz; do
    if [[ -f "$path" ]]; then
      echo "    eliminando: $path"
      rm -f "$path"
      removed=$((removed + 1))
    fi
  done
  shopt -u nullglob

  if [[ "$removed" -eq 0 ]]; then
    echo "    (no había tmp/tar.gz de tree-sitter en ese directorio)"
  else
    echo "    listo: $removed rutas eliminadas."
  fi
}

run_checkhealth() {
  if ! command -v nvim &>/dev/null; then
    echo "ERROR: nvim no está en PATH." >&2
    return 1
  fi
  echo "==> nvim --headless +checkhealth (+qa)"
  echo "    Los errores de plugins suelen aparecer antes del bloque 'Running healthchecks'."
  nvim --headless "+checkhealth" +qa 2>&1 || true
}

run_ts_sync() {
  if ! command -v nvim &>/dev/null; then
    echo "ERROR: nvim no está en PATH." >&2
    return 1
  fi
  echo "==> Reinstalando/actualizando parsers (:TSUpdateSync all en headless)…"
  echo "    Necesitas Internet. Puede tardar."
  set +e
  nvim --headless "+TSUpdateSync all" +qa 2>&1
  local st=$?
  set -e
  if [[ "$st" -ne 0 ]]; then
    echo "AVISO: TSUpdateSync devolvió $st. Prueba en nvim: :TSUpdateSync all" >&2
    return "$st"
  fi
}

main() {
  case "${1:-}" in
    check)
      run_checkhealth
      ;;
    fix-treesitter)
      fix_treesitter
      ;;
    repair)
      fix_treesitter
      echo ""
      run_ts_sync
      ;;
    all)
      fix_treesitter
      echo ""
      run_checkhealth
      ;;
    -h|--help|help|"")
      usage
      ;;
    *)
      echo "Comando desconocido: $1" >&2
      usage
      return 1
      ;;
  esac
}

main "$@"
