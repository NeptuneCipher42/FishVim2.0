# FishVim 1.0 Max Modernization Design

Date: 2026-02-21
Project: FishVim1.0
Author: Codex

## Goals
- Preserve FishVim identity and UX, especially the shark/FishVim startup display.
- Upgrade to a high-capability Neovim experience with robust language tooling, debugging, testing, git workflows, and project ergonomics.
- Improve maintainability with a clean modular architecture and predictable keymap namespaces.
- Update README with complete and accurate command documentation, including all `<leader>` mappings visible via `<Space>`/which-key.

## Non-Goals
- Replacing FishVim branding with a generic dashboard.
- Minimalist-only or ultra-light configuration at the expense of capability.
- One-off ad hoc plugin additions without structure.

## Architecture
- Keep repository layout centered around `config/nvim`.
- Normalize modules into:
  - `core`: options, keymaps, autocmds, diagnostics defaults.
  - `plugins`: plugin specs grouped by domain (ui, editing, nav, lsp, dap, test, git, productivity).
  - `features`: language/tool orchestration and shared behavior.
  - `ui`: dashboard, theme, statusline, notification/popup behavior.
- Keep lazy.nvim as plugin manager and preserve current startup behaviors.
- Preserve custom shark dashboard while improving readability, action entries, and startup metadata.

## Keymap Strategy
- Move to coherent namespaces:
  - `<leader>f`: file/find/search
  - `<leader>g`: git
  - `<leader>l`: LSP/lint/diagnostics
  - `<leader>d`: debugger (DAP)
  - `<leader>t`: tests/tasks/todos
  - `<leader>b`: buffers
  - `<leader>w`: windows/workspaces
  - `<leader>u`: UI toggles/utilities
- Keep compatibility aliases for important legacy mappings where practical.
- Ensure which-key labels are complete and descriptive.

## Capability Stack
- Editing: treesitter, surround, comment, autopairs, substitution, improved textobjects/motions.
- Navigation: telescope extensions, file explorer, symbols/diagnostics jump, buffers/projects/session navigation.
- LSP and Tooling: Mason, LSP servers, formatter/linter integration with sane auto/manual triggers.
- Debugging: nvim-dap plus adapters for primary languages.
- Testing: test runner integration and keymaps for nearest/file/suite flows.
- Git: gitsigns, trouble integration, LazyGit commands, hunk actions and blame flows.
- UX: dashboard upgrades, notifications, command UX via which-key, statusline and breadcrumb polish.

## Error Handling and Reliability
- Guard optional plugin setup with safe `pcall` where needed.
- Ensure startup doesn’t hard-fail if an external tool is missing.
- Keep health check and troubleshooting commands documented.

## Testing and Verification
- Functional verification:
  - `nvim --headless '+Lazy! sync' +qa` (plugin graph health)
  - `nvim --headless '+checkhealth' +qa` (core health)
- Static verification (if available): style/lint for Lua files.
- Runtime verification checklist:
  - Dashboard renders shark art and FishVim branding.
  - which-key displays reorganized leader tree.
  - LSP attach, formatting, linting, debugging, testing commands execute.
  - README command tables align with actual keymaps.

## README Plan
- Rewrite README to include:
  - Install and dependency setup.
  - First launch and plugin/tool bootstrap.
  - Leader key command catalog (complete `<Space>` menu mapping).
  - Category cheat sheets (files, git, lsp, dap, tests, sessions, windows, ui).
  - Tool matrix by language (LSP/formatter/linter/debugger/test).
  - Troubleshooting and recovery commands.

## Risks and Mitigations
- Risk: plugin overlap or key collisions.
  - Mitigation: namespace strategy and `which-key` grouping.
- Risk: increased startup time due to max capabilities.
  - Mitigation: lazy-loading and event-based plugin config.
- Risk: outdated README drift.
  - Mitigation: derive README mapping tables from final keymap definitions during final pass.

## Recommended Approach
Use structured modernization:
1. Restore tracked baseline config.
2. Refactor into modular domains with stable namespaces.
3. Add/upgrade capability plugins with lazy loading.
4. Preserve and improve FishVim dashboard identity.
5. Produce exhaustive README docs synchronized with keymaps.
