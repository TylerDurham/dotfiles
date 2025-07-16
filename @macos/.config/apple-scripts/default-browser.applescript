#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Set Default Browser
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/Safari.png
# @raycast.argument1 { "type": "text", "placeholder": "Browser Name" }

# Documentation:
# @raycast.author scott_willsey
# @raycast.authorURL https://raycast.com/scott_willsey

on run argv
	# check for null or empty item 1 of argv
	if (item 1 of argv) is "" then
		log "You must enter a browser name."
	else
		set currentDefaultBrowser to my getCurrentDefaultBrowser()
		set browserName to item 1 of argv
		
		set repeatCount to 0
		
		tell application "System Events"
			try
				my changeDefaultBrowser(browserName)
				repeat until button 2 of window 1 of process "CoreServicesUIAgent" exists
					delay 0.01
					set repeatCount to repeatCount + 1
					if repeatCount = 15 then exit repeat
				end repeat
				try
					if currentDefaultBrowser contains "com.google.chrome" then
						click button 1 of window 1 of process "CoreServicesUIAgent"
					else
						click button 2 of window 1 of process "CoreServicesUIAgent"
					end if
					log browserName & " is now your default browser"
				on error
					log browserName & " is already your default browser"
				end try
			on error
				log "The \"defaultbrowser\" CLI tool is required: https://github.com/kerma/defaultbrowser"
			end try
		end tell
	end if
	
end run

to getCurrentDefaultBrowser()
	set filePath to "~/Library/Preferences/com.apple.LaunchServices/com.apple.launchservices.secure.plist"
	
	set output to do shell script "plutil -p " & filePath & " | awk '/LSHandlerRoleAll/{a=$3}/LSHandlerURLScheme/{if($3==\"\\\"https\\\"\") print a}'"
	return output
end getCurrentDefaultBrowser

to changeDefaultBrowser(browserName)
	do shell script "
  if ! command -v /opt/homebrew/bin/defaultbrowser &> /dev/null; then
    exit 1
  fi
  defaultbrowser " & browserName & "
  exit 0
 "
end changeDefaultBrowser