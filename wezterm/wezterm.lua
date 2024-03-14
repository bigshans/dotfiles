local wezterm = require 'wezterm'
local darcula = require 'darcula'
require 'remember-win-size'
local act = wezterm.action

local function K(prefix, key, action)
    return { key = key, mods = prefix, action = action }
end

local K_CTSH = function (key, action)
    return K('CTRL|SHIFT', key, action)
end

local K_C = function (key, action)
    return K('CTRL', key, action)
end

local K_CTAL = function (key, action)
  return K('CTRL|ALT', key, action)
end

local keys = {
    K_CTSH('(', act.SplitHorizontal { domain = 'CurrentPaneDomain' }),
    K_CTSH(')', act.SplitVertical { domain = 'CurrentPaneDomain' }),
    K_CTSH('x', act.TogglePaneZoomState ),
    K('CTRL', 'w', act.CloseCurrentPane { confirm = true }),
    K('CTRL', 'q', act.CloseCurrentTab { confirm = true }),
    K_CTSH('z', act.ActivateCopyMode),
   -- activate pane selection mode with numeric labels
   K_C('9', act.PaneSelect),
    -- show the pane selection mode, but have it swap the active and selected panes
    K_C('0', act.PaneSelect { mode = 'SwapWithActive' })
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
    -- 修复 vim 下使用 C-d 后 Meta 键失灵的问题。1
    enable_csi_u_key_encoding = true,
    keys = keys,
  mouse_bindings = {
    -- Bind 'Up' event of CTRL-Click to open hyperlinks
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.OpenLinkAtMouseCursor,
    },
    -- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
    {
      event = { Down = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.Nop,
    },
  },
    -- 隐藏标题
    -- window_decorations = "NONE",
    colors = darcula,
    tab_bar_at_bottom = true,
    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = true,
    enable_scroll_bar = true,
    window_background_opacity = 0.85,
    font = wezterm.font_with_fallback({
        -- 测试字符串 oO01Ili
        { family = 'monospace' },
        'Noto Sans CJK SC',
        'Source Code Pro',
        'Iosevka Nerd Font',
        'Hack Nerd Font',
        'FuraMono Nerd Font'
    }),
    harfbuzz_features = { 'zero' },
    font_size = 13.5,
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    hyperlink_rules = {
        -- Linkify things that look like URLs and the host has a TLD name.
        -- Compiled-in default. Used if you don't specify any hyperlink_rules.
        {
            regex = '\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b',
            format = '$0',
        },

        -- file:// URI
        -- Compiled-in default. Used if you don't specify any hyperlink_rules.
        {
            regex = [[\bfile://\S*\b]],
            format = '$0',
        },

        -- http url
        {
            regex = [[\bhttps?://\S*\b]],
            format = '$0',
        },

        -- Linkify things that look like URLs with numeric addresses as hosts.
        -- E.g. http://127.0.0.1:8000 for a local development server,
        -- or http://192.168.1.1 for the web interface of many routers.
        {
            regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
            format = '$0',
        },
    },
    warn_about_missing_glyphs = false,
}
