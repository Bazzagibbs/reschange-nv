#+feature dynamic-literals
package reschange

import "core:flags"
import "core:fmt"
import "core:os"
import "core:strings"
import "core:slice"

import "nvapi"



EXPECTED_NATIVE_RESOLUTION :: [2]u16{5120, 1440}


main :: proc() {
        ok := run_main()
        if !ok {
                os.exit(-1)
        }
}


run_main :: proc() -> (ok: bool) {
        resolutions := map[string][2]u32 {
                "1920x1080" = {1920, 1080},
                "2560x1440" = {2560, 1440},
                "3440x1440" = {3440, 1440}, // Might need custom resolution in nvidia control panel
                "5120x1440" = {5120, 1440},
        }
        defer delete(resolutions)

        if len(os.args) != 2 {
                print_usage(&resolutions)
                return false
        }
        
        resolution_u32, resolution_exists := resolutions[os.args[1]]
        if !resolution_exists {
                print_usage(&resolutions)
                return false
        }
       
        check(nvapi.Initialize()) or_return
        defer nvapi.Unload()


        // Get path_info count
        path_info_count: u32
        check(nvapi.DISP_GetDisplayConfig(&path_info_count, nil)) or_return
        

        // Alloc path infos
        source_mode_infos := make([]nvapi.DISPLAYCONFIG_SOURCE_MODE_INFO_V1, path_info_count)
        defer delete(source_mode_infos)

        path_infos := make([]nvapi.DISPLAYCONFIG_PATH_INFO, path_info_count)
        for &pi, i in path_infos {
                nvapi.set_version(&pi, nvapi.VER_DISPLAYCONFIG_PATH_INFO)
                pi.sourceModeInfo = &source_mode_infos[i]
        }
        defer delete(path_infos)

        check(nvapi.DISP_GetDisplayConfig(&path_info_count, raw_data(path_infos))) or_return


        // Alloc target infos for each path_info AND advanced infos
        details_count : u32 = 0
        for &pi in path_infos {
                details_count += pi.targetInfoCount
        }
        details := make([]nvapi.DISPLAYCONFIG_PATH_ADVANCED_TARGET_INFO_V1, details_count)
        defer delete(details)

        current_details_idx := 0
        for &pi in path_infos {
                target_infos := make([^]nvapi.DISPLAYCONFIG_PATH_TARGET_INFO_V2, pi.targetInfoCount)
                pi.targetInfo = target_infos
                for &ti in pi.targetInfo[:pi.targetInfoCount] {
                        ti.details = &details[current_details_idx]
                        nvapi.set_version(ti.details, nvapi.VER_DISPLAYCONFIG_PATH_ADVANCED_TARGET_INFO)
                        current_details_idx += 1
                }
        }
        defer {
                for &pi in path_infos {
                        free(pi.targetInfo)
                }
        }
        check(nvapi.DISP_GetDisplayConfig(&path_info_count, raw_data(path_infos))) or_return


        // Make sure this is the expected monitor (5120x1440 native resolution)
        if len(path_infos) <= 0 || path_infos[0].targetInfoCount <= 0 {
                fmt.eprintfln("Unexpected display configuration:\n%#v", path_infos)
                return false
        }
     
        path := &path_infos[0]
        timing := &path.targetInfo[0].details.timing
        native_res := [2]u16{timing.HVisible, timing.VVisible}
        if native_res != EXPECTED_NATIVE_RESOLUTION {
                fmt.eprintfln("Unexpected monitor 0 resolution: %v but expected %v", native_res, EXPECTED_NATIVE_RESOLUTION)
                return false
        }

        fmt.println("Found monitor with resolution", native_res)
        fmt.println("Setting resolution to", resolution_u32)

        path.sourceModeInfo.resolution.width = resolution_u32.x
        path.sourceModeInfo.resolution.height = resolution_u32.y
        check(nvapi.DISP_SetDisplayConfig(path_info_count, raw_data(path_infos), {})) or_return


        return true
}



check :: proc(status: nvapi.Status, expr := #caller_expression(status)) -> (ok: bool) {
        if status == .OK {
                return true
        }

        fmt.eprintfln("ERROR: %v returned from %v", status, expr)
        return false
}


print_usage :: proc(resolutions: ^map[string][2]u32) {
        res_strings := make([]string, len(resolutions))
        defer delete(res_strings)
        i := 0
        for k, _ in resolutions {
                res_strings[i] = k
                i += 1
        }

        slice.sort(res_strings)


        // fmt.eprintfln("Usage:\n\treschange <display_name> <width>x<height>\n")
        fmt.eprintfln("Usage:    reschange <width>x<height>")
        fmt.eprintln( "Example:  reschange 1920x1080")
        fmt.eprintln("\nSupported resolutions:")
        for str in res_strings {
                fmt.eprintfln("\t\t\t%v", str)
        }
}


