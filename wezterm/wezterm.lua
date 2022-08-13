local wezterm = require("wezterm")
local darcula = require("darcula")
local act = wezterm.action

local function K(prefix, key, action)
    return { key = key, mods = prefix, action = action }
end

local K_CTSH = function (key, action)
    return K('CTRL|SHIFT', key, action)
end

local keys = {
    K_CTSH('(', act.SplitHorizontal { domain = 'CurrentPaneDomain' }),
    K_CTSH(')', act.SplitVertical { domain = 'CurrentPaneDomain' }),
    K_CTSH('x', act.TogglePaneZoomState ),
    K('CTRL', 'w', act.CloseCurrentPane { confirm = true }),
    K('CTRL', 'q', act.CloseCurrentTab { confirm = true }),
    K_CTSH('z', act.ActivateCopyMode)
}

for _, v in ipairs {'Left', 'Right', 'Up', 'Down'} do
    table.insert(keys, K('ALT', v .. 'Arrow', act.ActivatePaneDirection(v)))
end

for i = 1, 8 do
  -- CTRL+ALT + number to activate that tab
  table.insert(keys, {
    key = tostring(i),
    mods = 'CTRL|ALT',
    action = act.ActivateTab(i - 1),
  })
end

return {
    keys = keys,
    colors = darcula,
    tab_bar_at_bottom = true,
    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = true,
    enable_scroll_bar = true,
    window_background_opacity = 0.90,
    font = wezterm.font('JetBrains Mono Nerd Font'),
    font_size = 14,
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
}
