#!/usr/bin/python3

import argparse
import subprocess
import tempfile

MODULES = ["waybar", "hyprland", "bluetooth", "network"]
WOFI_CMD = ["wofi", "--show", "dmenu", "-W", "300", "-p", "Choose a module:"]
ROFI_CMD = ["rofi", "-dmenu"]

def get_module_list():
    return ("\n".join(MODULES))

def prompt():
    # lines = (subprocess.check_output(["wofi", "--show", "dmenu", "--dmenu"])).decode().splitlines()
    menu = get_module_list()
    p1 = subprocess.Popen(["echo", menu], stdout=subprocess.PIPE)
    p2 = subprocess.Popen(WOFI_CMD, stdin=p1.stdout, stdout=subprocess.PIPE) 
    module = p2.communicate()[0]

    restart(module.decode().strip())

def restart(module: str):

    print(f'Restarting module {module}...')

    match module:

        case "waybar":
            p1 = subprocess.Popen(["killall", "-SIGUSR2",  "waybar"], stdout=subprocess.PIPE)
            print(p1)
        case _:
            print(f'Unknown module {module}')

def get_args():
    description = "Restarts various modules from Waybar."
    
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument("-m", "--module", type=str, help="The module to be restarted.")
    parser.add_argument("-l", "--list", action='store_true', help="List all the modules that can be restarted.")
    parser.add_argument("-p", "--prompt", action='store_true', help="Prompts for the module to be restarted.")
    args = parser.parse_args()

    return args

args = get_args()

if args.list == True:
    print(get_module_list())
    quit(0)

if args.prompt == True:
    prompt()

if args.module:
    restart(args.module)

