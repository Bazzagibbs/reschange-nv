# reschange-nv

This program ONLY WORKS with 5120x1440p displays as the only connected display. It will not do anything if it does not find the correct display.

## How to use

NOTE: Some resolutions may not work by default and require setting up a custom resolution in the nvidia control panel. 3440x1440 is not supported by default on my display.

### Option 1: From the command line

```bash
# List all supported resolutions
reschange.exe

# Set display to a resolution
reschange.exe 1920x720
```

### Option 2: From a desktop shortcut

1. Create a desktop shortcut where the location is

```
C:\\path\to\reschange.exe 5120x1440
```

2. Name it "5120x1440"
3. Repeat for each desired resolution


## Building

1. Clone with submodules

```bash
git clone --recurse-submodules
```

2. Build

```bash
odin build . -out:"reschange.exe"
```
