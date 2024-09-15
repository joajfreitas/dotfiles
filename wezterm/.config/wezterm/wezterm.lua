local wezterm = require 'wezterm'

return {
  font = wezterm.font 'FiraCode',
  font_size=10,
  color_scheme = "GruvboxDark",
  use_fancy_tab_bar = false,
  keys = {
  {
      key = 'h',
      mods = 'ALT', 
      action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
      key = 'l',
      mods = 'ALT', 
      action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
      key = 'k',
      mods = 'ALT', 
      action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
      key = 'j',
      mods = 'ALT', 
      action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
      key = 'LeftArrow',
      mods = 'ALT|SHIFT', 
      action = wezterm.action.SplitPane {
          direction = 'Left',
          size = {Percent = 50},
      },
  },
  {
      key = 'l',
      mods = 'ALT|SHIFT', 
      action = wezterm.action.SplitPane {
          direction = 'Right',
          size = {Percent = 50},
      },
  },
  {
      key = 'k',
      mods = 'ALT|SHIFT', 
      action = wezterm.action.SplitPane {
          direction = 'Up',
          size = {Percent = 50},
      },
  },
  {
      key = 'j',
      mods = 'ALT|SHIFT', 
      action = wezterm.action.SplitPane {
          direction = 'Down',
          size = {Percent = 50},
      },
  },
  { key = 'g', mods = 'ALT', action = wezterm.action.ShowLauncher },
  { key = 't', mods = 'ALT', action = wezterm.action.ShowTabNavigator },
  {
    key = 't',
    mods = 'SHIFT|ALT',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain',
  },
  {
    key = "1",
    mods = 'ALT',
    action = wezterm.action.ActivateTab(0),
  },
  {
    key = "2",
    mods = 'ALT',
    action = wezterm.action.ActivateTab(1),
  },
  {
    key = "3",
    mods = 'ALT',
    action = wezterm.action.ActivateTab(2),
  },
  {
    key = "4",
    mods = 'ALT',
    action = wezterm.action.ActivateTab(3),
  },
  {
    key = "5",
    mods = 'ALT',
    action = wezterm.action.ActivateTab(4),
  },
  {
    key = "6",
    mods = 'ALT',
    action = wezterm.action.ActivateTab(5),
  },
  {
    key = "7",
    mods = 'ALT',
    action = wezterm.action.ActivateTab(6),
  },
  {
    key = "8",
    mods = 'ALT',
    action = wezterm.action.ActivateTab(7),
  },
  {
    key = "9",
    mods = 'ALT',
    action = wezterm.action.ActivateTab(8),
  },
  {
    key = "0",
    mods = 'ALT',
    action = wezterm.action.ActivateTab(9),
  },
  },
}

