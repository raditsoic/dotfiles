local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

config.default_domain = 'WSL:Ubuntu'

config.wsl_domains = {
  {
    name = 'WSL:Ubuntu',
    distribution = 'Ubuntu',
    default_cwd = '/home/soic',
  },
}

config.launch_menu = {
  {
    label = 'SSH: cloud-ws',
    args = {
      'wsl.exe', '-d', 'Ubuntu', '--',
      'bash', '-lc', 'ssh cloud-ws',
    },
  },
}

config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = wezterm.action_callback(function(window, pane)
      local has_selection = window:get_selection_text_for_pane(pane) ~= ""
      if has_selection then
        window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
        window:perform_action(act.ClearSelection, pane)
      else
        window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
      end
    end),
  },
}

config.keys = {
  {
    key = 'c',
    mods = 'CTRL',
    action = wezterm.action_callback(function(window, pane)
      local sel = window:get_selection_text_for_pane(pane)
      if sel ~= '' then
        window:perform_action(act.CopyTo 'ClipboardAndPrimarySelection', pane)
        window:perform_action(act.ClearSelection, pane)
      else
        window:perform_action(act.SendKey { key = 'c', mods = 'CTRL' }, pane)
      end
    end),
  },
  { key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
  -- WezTerm default Alt+Enter = fullscreen; send ESC CR to the shell instead
  { key = 'Enter', mods = 'ALT', action = act.SendString '\x1b\r' },
  { key = '+', mods = 'CTRL', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '+', mods = 'CTRL|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = '-', mods = 'CTRL', action = act.CloseCurrentPane { confirm = false } },
}

for i = 1, 9 do
  -- Alt+N: focus pane by index
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'ALT',
    action = act.ActivatePaneByIndex(i - 1),
  })
  -- Alt+Shift+N: focus tab by index (phys: avoids Shift turning 1 into !)
  table.insert(config.keys, {
    key = 'phys:' .. tostring(i),
    mods = 'ALT|SHIFT',
    action = act.ActivateTab(i - 1),
  })
end

return config