local wezterm = require 'wezterm'
local mux = wezterm.mux

local cache_dir = os.getenv('HOME') .. '/.cache/wezterm/'
local window_size_cache_path = cache_dir .. 'window_size_cache.txt'

local function file_exists(path)
  local file = io.open(path, "rb")
  if file then file:close() end
  return file ~= nil
end

local function detect_folder()
  if not file_exists(cache_dir) then
    os.execute('mkdir ' .. cache_dir)
  end
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

wezterm.on('gui-startup', function()
  detect_folder()

  local window_size_cache_file = io.open(window_size_cache_path, 'r')
  if window_size_cache_file ~= nil then
    local _, _, width, height = string.find(window_size_cache_file:read(), '(%d+),(%d+)')
      local tab, pane, window = mux.spawn_window{}
      print("mux", dump(mux))
      mux.spawn_window{ width = tonumber(width), height = tonumber(height) }
      window_size_cache_file:close()
  end
end)

wezterm.on('window-resized', function(win, pane)
  detect_folder()
  local window_size_cache_file = io.open(window_size_cache_path, 'r')
  if window_size_cache_file ~= nil then
    local tab_size = pane:tab():get_size()
    local cols = tab_size['cols']
    local rows = tab_size['rows'] + 2 -- Without adding the 2 here, the window doesn't maximize
    local contents = string.format('%d,%d,%d', cols, rows)
    window_size_cache_file = assert(io.open(window_size_cache_path, 'w'))
    window_size_cache_file:write(contents)
    window_size_cache_file:close()
  end
end)
