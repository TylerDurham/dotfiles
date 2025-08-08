source ./scripts/lib-colors.sh

debug "Debugging output"

info "Starting install."
task "This is task 1"
task "This is task 2"
debug "Debugging output"
task-list "This is a list of tasks:"
subtask "This is task 1.1"
subdebug "Debugging output"
subinfo "Success!"
subtask "This is task 1.2"
subwarning "This is a warning!"
error "Oh, crap!"
info "Finished!"
