local MONITORS = require("modules.globals").monitors

hl.workspace_rule({
	workspace = "1",
	default = true,
	monitor = MONITORS.EXT_RIGHT,
	default_name = "",
})

hl.workspace_rule({
	workspace = "2",
	default = true,
	monitor = MONITORS.EXT_RIGHT,
	default_name = "",
})

for i = 3, 10 do
	if i > 0 or i <= 9 then
		hl.workspace_rule({
			workspace = tostring(i),
			monitor = MONITORS.EXT_RIGHT,
		})
	end
end
