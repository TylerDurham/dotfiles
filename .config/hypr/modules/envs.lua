-- ###################################
--
-- ███████╗███╗   ██╗██╗   ██╗███████╗
-- ██╔════╝████╗  ██║██║   ██║██╔════╝
-- █████╗  ██╔██╗ ██║██║   ██║███████╗
-- ██╔══╝  ██║╚██╗██║╚██╗ ██╔╝╚════██║
-- ███████╗██║ ╚████║ ╚████╔╝ ███████║
-- ╚══════╝╚═╝  ╚═══╝  ╚═══╝  ╚══════╝
-- ###################################

hl.config({
	env = {
		"XCURSOR_SIZE,24",
		"XCURSOR_THEME,Adwaita",
		"QT_QPA_PLATFORM,wayland",
		"QT_QPA_PLATFORMTHEME,qt6ct",
		"QT_WAYLAND_DISABLE_WINDOWDECORATION,1",
		"SDL_VIDEODRIVER,wayland",
		"CLUTTER_BACKEND,wayland",
		"GDK_BACKEND,wayland,x11",
		"MOZ_ENABLE_WAYLAND,1",
	},
})
