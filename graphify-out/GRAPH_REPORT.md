# Graph Report - .  (2026-08-07)

## Corpus Check
- Corpus is ~8,533 words - fits in a single context window. You may not need a graph.

## Summary
- 38 nodes · 29 edges · 17 communities (16 shown, 1 thin omitted)
- Extraction: 97% EXTRACTED · 3% INFERRED · 0% AMBIGUOUS · INFERRED: 1 edges (avg confidence: 0.5)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- Plugin Initialization
- Diagnostic Tools
- Diagnostic UI

## God Nodes (most connected - your core abstractions)
1. `main()` - 6 edges
2. `M.for_astrocore()` - 2 edges
3. `M.apply_vim_diagnostic()` - 2 edges
4. `nvim-doctor.sh script` - 2 edges
5. `usage()` - 2 edges
6. `fix_treesitter()` - 2 edges
7. `run_checkhealth()` - 2 edges
8. `run_ts_sync()` - 2 edges

## Surprising Connections (you probably didn't know these)
- None detected - all connections are within the same source files.

## Import Cycles
- None detected.

## Communities (17 total, 1 thin omitted)

### Community 0 - "Plugin Initialization"
Cohesion: 0.32
Nodes (8): ESLint LSP Configuration, Lazy Initialization Check, Lazy Plugin Manager, Lazy Configuration Module, Lazy Installation Path, Polish Module, Neovim Configuration, Vim Runtime Path

### Community 2 - "Diagnostic Tools"
Cohesion: 0.52
Nodes (6): fix_treesitter(), main(), run_checkhealth(), run_ts_sync(), nvim-doctor.sh script, usage()

## Knowledge Gaps
- **1 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Not enough signal to generate questions. This usually means the corpus has no AMBIGUOUS edges, no bridge nodes, no INFERRED relationships, and all communities are tightly cohesive. Add more files or run with --mode deep to extract richer edges._