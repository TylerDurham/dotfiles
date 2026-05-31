-- ###################################################################
--
-- ███╗   ███╗ ██████╗ ███╗   ██╗██╗████████╗ ██████╗ ██████╗ ███████╗
-- ████╗ ████║██╔═══██╗████╗  ██║██║╚══██╔══╝██╔═══██╗██╔══██╗██╔════╝
-- ██╔████╔██║██║   ██║██╔██╗ ██║██║   ██║   ██║   ██║██████╔╝███████╗
-- ██║╚██╔╝██║██║   ██║██║╚██╗██║██║   ██║   ██║   ██║██╔══██╗╚════██║
-- ██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██║   ██║   ╚██████╔╝██║  ██║███████║
-- ╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚══════╝
-- ###################################################################

local MONITORS = require("modules.globals").monitors

-- monitor=,preferred,auto,auto
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
})

-- monitor = desc: Dell Inc. DELL S2725QS 7DCMT84, 2560x1440@120.00Hz, 0x0, 1.33
hl.monitor({
	output = MONITORS.EXTERNAL_LEFT,
	mode = "2560x1440@120.00Hz",
	position = "0x0",
	scale = 1.33,
})

-- monitor = desc: LG Electronics LG ULTRAGEAR 404MXCR52499, 2560x1440@120.00Hz, 1924x0, 1.33
hl.monitor({
	output = MONITORS.EXTERNAL_RIGHT,
	mode = "2560x1440@120.00Hz",
	position = "1924x0",
	scale = 1.33,
})
