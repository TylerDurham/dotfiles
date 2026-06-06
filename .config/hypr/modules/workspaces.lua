local MONITORS = require("modules.globals").monitors

local function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end
local function clear_desc(s)
  local l = string.len("desc: ")
  return trim(string.sub(s, l))
end

local function log_monitor(f, m)
  if f then
    f:write("\n")
    f:write("MONITOR ID: " .. m.id .. "\n")
    f:write("MONITOR NAME: " .. m.name .. "\n")
    f:write("MONITOR DESC: " .. m.description .. "\n")
    f:write("\n")
  end
end

local workspaces_per_monitor = 10
local function bind_workspaces(log, monitor, priority)
  if monitor == nil then return end

  for i = 1, workspaces_per_monitor do
    local workspace = tostring((workspaces_per_monitor * priority + i) - 10)
    log:write("Binding workspace " .. workspace .. " to monitor " .. monitor.description .. "\n")
    hl.workspace_rule({
      workspace = workspace,
      monitor = monitor.name,
      default = (i == 1)
    })
  end
end

local function find_monitor_by_desc(description)
  for _, monitor in ipairs(hl.get_monitors()) do
    if clear_desc(description) == monitor.description then
      return monitor
    end
  end
  return nil
end
local file = io.open("/tmp//monitor.log", "w")

file:write("RIGHT MONITOR: " .. clear_desc(MONITORS.EXTERNAL_RIGHT) .. "\n")
file:write("LEFT MONITOR:  " .. clear_desc(MONITORS.EXTERNAL_LEFT) .. "\n")
file:write("\n")

if file then
  bind_workspaces(file, find_monitor_by_desc(MONITORS.EXTERNAL_RIGHT), 1)
  bind_workspaces(file, find_monitor_by_desc(MONITORS.EXTERNAL_LEFT), 2)
  file:flush()
  file:close()
end


-- if monitor_count > 1 then for _, monitor in ipairs(hl.get_monitors()) do if monitor.description == clear_desc(MONITORS.EXTERNAL_LEFT) then file:write("Found LEFT Monitor! PRIORITY: " .. tostring(priority))
--       log_monitor(file, monitor)
--       bind_workspaces(monitor, priority)
--       priority = priority + 1
--     elseif monitor.description == clear_desc(MONITORS.EXTERNAL_RIGHT) then
--       file:write("Found RIGHT Monitor! PRIORITY: " .. tostring(priority))
--       log_monitor(file, monitor)
--       bind_workspaces(monitor, priority)
--       priority = priority + 1
--     else
--       file:write("found laptop monitor! priority: " .. tostring(priority))
--       log_monitor(file, monitor)
--       bind_workspaces(monitor, priority)
--     end
--   end
-- else
--   log_monitor(file, monitors[0])
-- end
-- if (count_of_monitors > 1) then
--   hl.workspace_rule({
--     workspace = "1",
--     default = true,
--     monitor = MONITORS.EXTERNAL_RIGHT,
--     default_name = ""
--   })
-- end
--
-- hl.workspace_rule({
-- 	workspace = "1",
-- 	default = true,
-- 	monitor = MONITORS.EXT_RIGHT,
-- 	default_name = "",
-- })
--
-- hl.workspace_rule({
-- 	workspace = "2",
-- 	default = true,
-- 	monitor = MONITORS.EXT_RIGHT,
-- 	default_name = "",
-- })
--
-- for i = 3, 10 do
-- 	if i > 0 or i <= 9 then
-- 		hl.workspace_rule({
-- 			workspace = tostring(i),
-- 			monitor = MONITORS.EXT_RIGHT,
-- 		})
-- 	end
-- end
