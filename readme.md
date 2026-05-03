# reschange-nv

This program ONLY WORKS with 5120x1440p displays as the only connected display. It will not do anything if it does not find the correct display.

## How to use

### Option 1: From the command line

```bash
# List all supported resolutions
reschange.exe

# Set display to a resolution
reschange.exe 1920x720
```

### Option 2: From a desktop shortcut



## Building

1. Clone with submodules

```bash
git clone --recurse-submodules
```

2. Build

```bash
odin build . -out:"reschange.exe"
```
