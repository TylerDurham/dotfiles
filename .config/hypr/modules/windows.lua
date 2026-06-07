-- Tag all windows for default opacity (apps can override with -default-opacity tag).
--o.window(".*", { tag = "+default-opacity" })

-- Fix some dragging issues with XWayland.
hl.window_rule({
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },
  no_focus = true,
})

hl.window_rule({
  name = "floating-window",
  match = {
    tag = "floating-window"
  },
  float = true,
  center = true,
  size = { 1080, 800 }
})

hl.window_rule({
  name = "multimedia-window",
  match = {
    class = "^([s|S]potify|plexamp)$"
  },
  workspace = "9",
  opacity = "1.0 override"
})

hl.window_rule({
  name = "terminal-window",
  match = {
    class = "^(com.mitchellh.ghostty)$"
  },
  workspace = "1",
  opacity = "0.9 override"
})

hl.window_rule({
  name = "modal-utility-window",
  match = {
    class = "^(blueman-manager|nm-connection-editor|org.pulseaudio.pavucontrol)$"
  },
  tag = "+floating-window",
  dim_around = true,
  confine_pointer = true
})

hl.window_rule({
  name = "1password",
  match = {
    class = "^(1[p|P]assword)$"
  },
  no_screen_share = true,
  tag = "+floating-window",
  workspace = "10",
  opacity = "1.0 override"
})
