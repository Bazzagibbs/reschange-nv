package nvapi

import "core:sys/windows"

foreign import lib "nvapi/amd64/nvapi64.lib"


MAKE_NAPI_VERSION :: proc($T: typeid, ver: u32) -> u32 {
        return u32(size_of(T) | ver << 16)
} 

// use ver = nvapi.VER_<STRUCT_TYPE>
set_version :: proc(v: ^$T, ver: u32) {
        v.version = MAKE_NAPI_VERSION(T, ver)
}

Status :: enum i32 {
        OK                                    =  0,      //!< Success. Request is completed.
        ERROR                                 = -1,      //!< Generic error
        LIBRARY_NOT_FOUND                     = -2,      //!< NVAPI support library cannot be loaded.
        NO_IMPLEMENTATION                     = -3,      //!< not implemented in current driver installation
        API_NOT_INITIALIZED                   = -4,      //!< NvAPI_Initialize has not been called (successfully)
        INVALID_ARGUMENT                      = -5,      //!< The argument/parameter value is not valid or NULL.
        NVIDIA_DEVICE_NOT_FOUND               = -6,      //!< No NVIDIA display driver, or NVIDIA GPU driving a display, was found.
        END_ENUMERATION                       = -7,      //!< No more items to enumerate
        INVALID_HANDLE                        = -8,      //!< Invalid handle
        INCOMPATIBLE_STRUCT_VERSION           = -9,      //!< An argument's structure version is not supported
        HANDLE_INVALIDATED                    = -10,     //!< The handle is no longer valid (likely due to GPU or display re-configuration)
        OPENGL_CONTEXT_NOT_CURRENT            = -11,     //!< No NVIDIA OpenGL context is current (but needs to be)
        INVALID_POINTER                       = -14,     //!< An invalid pointer, usually NULL, was passed as a parameter
        NO_GL_EXPERT                          = -12,     //!< OpenGL Expert is not supported by the current drivers
        INSTRUMENTATION_DISABLED              = -13,     //!< OpenGL Expert is supported, but driver instrumentation is currently disabled
        NO_GL_NSIGHT                          = -15,     //!< OpenGL does not support Nsight
                                                                                                                                                                                                                          
        EXPECTED_LOGICAL_GPU_HANDLE           = -100,    //!< Expected a logical GPU handle for one or more parameters
        EXPECTED_PHYSICAL_GPU_HANDLE          = -101,    //!< Expected a physical GPU handle for one or more parameters
        EXPECTED_DISPLAY_HANDLE               = -102,    //!< Expected an NV display handle for one or more parameters
        INVALID_COMBINATION                   = -103,    //!< The combination of parameters is not valid. 
        NOT_SUPPORTED                         = -104,    //!< Requested feature is not supported in the selected GPU
        PORTID_NOT_FOUND                      = -105,    //!< No port ID was found for the I2C transaction
        EXPECTED_UNATTACHED_DISPLAY_HANDLE    = -106,    //!< Expected an unattached display handle as one of the input parameters.
        INVALID_PERF_LEVEL                    = -107,    //!< Invalid perf level 
        DEVICE_BUSY                           = -108,    //!< Device is busy; request not fulfilled
        NV_PERSIST_FILE_NOT_FOUND             = -109,    //!< NV persist file is not found
        PERSIST_DATA_NOT_FOUND                = -110,    //!< NV persist data is not found
        EXPECTED_TV_DISPLAY                   = -111,    //!< Expected a TV output display
        EXPECTED_TV_DISPLAY_ON_DCONNECTOR     = -112,    //!< Expected a TV output on the D Connector - HDTV_EIAJ4120.
        NO_ACTIVE_SLI_TOPOLOGY                = -113,    //!< SLI is not active on this device.
        SLI_RENDERING_MODE_NOTALLOWED         = -114,    //!< Setup of SLI rendering mode is not possible right now.
        EXPECTED_DIGITAL_FLAT_PANEL           = -115,    //!< Expected a digital flat panel.
        ARGUMENT_EXCEED_MAX_SIZE              = -116,    //!< Argument exceeds the expected size.
        DEVICE_SWITCHING_NOT_ALLOWED          = -117,    //!< Inhibit is ON due to one of the flags in NV_GPU_DISPLAY_CHANGE_INHIBIT or SLI active.
        TESTING_CLOCKS_NOT_SUPPORTED          = -118,    //!< Testing of clocks is not supported.
        UNKNOWN_UNDERSCAN_CONFIG              = -119,    //!< The specified underscan config is from an unknown source (e.g. INF)
        TIMEOUT_RECONFIGURING_GPU_TOPO        = -120,    //!< Timeout while reconfiguring GPUs
        DATA_NOT_FOUND                        = -121,    //!< Requested data was not found
        EXPECTED_ANALOG_DISPLAY               = -122,    //!< Expected an analog display
        NO_VIDLINK                            = -123,    //!< No SLI video bridge is present
        REQUIRES_REBOOT                       = -124,    //!< NVAPI requires a reboot for the settings to take effect
        INVALID_HYBRID_MODE                   = -125,    //!< The function is not supported with the current Hybrid mode.
        MIXED_TARGET_TYPES                    = -126,    //!< The target types are not all the same
        SYSWOW64_NOT_SUPPORTED                = -127,    //!< The function is not supported from 32-bit on a 64-bit system.
        IMPLICIT_SET_GPU_TOPOLOGY_CHANGE_NOT_ALLOWED = -128,    //!< There is no implicit GPU topology active. Use NVAPI_SetHybridMode to change topology.
        REQUEST_USER_TO_CLOSE_NON_MIGRATABLE_APPS = -129,      //!< Prompt the user to close all non-migratable applications.    
        OUT_OF_MEMORY                         = -130,    //!< Could not allocate sufficient memory to complete the call.
        WAS_STILL_DRAWING                     = -131,    //!< The previous operation that is transferring information to or from this surface is incomplete.
        FILE_NOT_FOUND                        = -132,    //!< The file was not found.
        TOO_MANY_UNIQUE_STATE_OBJECTS         = -133,    //!< There are too many unique instances of a particular type of state object.
        INVALID_CALL                          = -134,    //!< The method call is invalid. For example, a method's parameter may not be a valid pointer.
        D3D10_1_LIBRARY_NOT_FOUND             = -135,    //!< d3d10_1.dll cannot be loaded.
        FUNCTION_NOT_FOUND                    = -136,    //!< Couldn't find the function in the loaded DLL.
        INVALID_USER_PRIVILEGE                = -137,    //!< The application will require Administrator privileges to access this API.
                                                      //!< The application can be elevated to a higher permission level by selecting "Run as Administrator".
        EXPECTED_NON_PRIMARY_DISPLAY_HANDLE   = -138,    //!< The handle corresponds to GDIPrimary.
        EXPECTED_COMPUTE_GPU_HANDLE           = -139,    //!< Setting Physx GPU requires that the GPU is compute-capable.
        STEREO_NOT_INITIALIZED                = -140,    //!< The Stereo part of NVAPI failed to initialize completely. Check if the stereo driver is installed.
        STEREO_REGISTRY_ACCESS_FAILED         = -141,    //!< Access to stereo-related registry keys or values has failed.
        STEREO_REGISTRY_PROFILE_TYPE_NOT_SUPPORTED = -142, //!< The given registry profile type is not supported.
        STEREO_REGISTRY_VALUE_NOT_SUPPORTED   = -143,    //!< The given registry value is not supported.
        STEREO_NOT_ENABLED                    = -144,    //!< Stereo is not enabled and the function needed it to execute completely.
        STEREO_NOT_TURNED_ON                  = -145,    //!< Stereo is not turned on and the function needed it to execute completely.
        STEREO_INVALID_DEVICE_INTERFACE       = -146,    //!< Invalid device interface.
        STEREO_PARAMETER_OUT_OF_RANGE         = -147,    //!< Separation percentage or JPEG image capture quality is out of [0-100] range.
        STEREO_FRUSTUM_ADJUST_MODE_NOT_SUPPORTED = -148, //!< The given frustum adjust mode is not supported.
        TOPO_NOT_POSSIBLE                     = -149,    //!< The mosaic topology is not possible given the current state of the hardware.
        MODE_CHANGE_FAILED                    = -150,    //!< An attempt to do a display resolution mode change has failed.        
        D3D11_LIBRARY_NOT_FOUND               = -151,    //!< d3d11.dll/d3d11_beta.dll cannot be loaded.
        INVALID_ADDRESS                       = -152,    //!< Address is outside of valid range.
        STRING_TOO_SMALL                      = -153,    //!< The pre-allocated string is too small to hold the result.
        MATCHING_DEVICE_NOT_FOUND             = -154,    //!< The input does not match any of the available devices.
        DRIVER_RUNNING                        = -155,    //!< Driver is running.
        DRIVER_NOTRUNNING                     = -156,    //!< Driver is not running.
        ERROR_DRIVER_RELOAD_REQUIRED          = -157,    //!< A driver reload is required to apply these settings.
        SET_NOT_ALLOWED                       = -158,    //!< Intended setting is not allowed.
        ADVANCED_DISPLAY_TOPOLOGY_REQUIRED    = -159,    //!< Information can't be returned due to "advanced display topology".
        SETTING_NOT_FOUND                     = -160,    //!< Setting is not found.
        SETTING_SIZE_TOO_LARGE                = -161,    //!< Setting size is too large.
        TOO_MANY_SETTINGS_IN_PROFILE          = -162,    //!< There are too many settings for a profile. 
        PROFILE_NOT_FOUND                     = -163,    //!< Profile is not found.
        PROFILE_NAME_IN_USE                   = -164,    //!< Profile name is duplicated.
        PROFILE_NAME_EMPTY                    = -165,    //!< Profile name is empty.
        EXECUTABLE_NOT_FOUND                  = -166,    //!< Application not found in the Profile.
        EXECUTABLE_ALREADY_IN_USE             = -167,    //!< Application already exists in the other profile.
        DATATYPE_MISMATCH                     = -168,    //!< Data Type mismatch 
        PROFILE_REMOVED                       = -169,    //!< The profile passed as parameter has been removed and is no longer valid.
        UNREGISTERED_RESOURCE                 = -170,    //!< An unregistered resource was passed as a parameter. 
        ID_OUT_OF_RANGE                       = -171,    //!< The DisplayId corresponds to a display which is not within the normal outputId range.
        DISPLAYCONFIG_VALIDATION_FAILED       = -172,    //!< Display topology is not valid so the driver cannot do a mode set on this configuration.
        DPMST_CHANGED                         = -173,    //!< Display Port Multi-Stream topology has been changed.
        INSUFFICIENT_BUFFER                   = -174,    //!< Input buffer is insufficient to hold the contents.    
        ACCESS_DENIED                         = -175,    //!< No access to the caller.
        MOSAIC_NOT_ACTIVE                     = -176,    //!< The requested action cannot be performed without Mosaic being enabled.
        SHARE_RESOURCE_RELOCATED              = -177,    //!< The surface is relocated away from video memory.
        REQUEST_USER_TO_DISABLE_DWM           = -178,    //!< The user should disable DWM before calling NvAPI.
        D3D_DEVICE_LOST                       = -179,    //!< D3D device status is D3DERR_DEVICELOST or D3DERR_DEVICENOTRESET - the user has to reset the device.
        INVALID_CONFIGURATION                 = -180,    //!< The requested action cannot be performed in the current state.
        STEREO_HANDSHAKE_NOT_DONE             = -181,    //!< Call failed as stereo handshake not completed.
        EXECUTABLE_PATH_IS_AMBIGUOUS          = -182,    //!< The path provided was too short to determine the correct NVDRS_APPLICATION
        DEFAULT_STEREO_PROFILE_IS_NOT_DEFINED = -183,    //!< Default stereo profile is not currently defined
        DEFAULT_STEREO_PROFILE_DOES_NOT_EXIST = -184,    //!< Default stereo profile does not exist
        CLUSTER_ALREADY_EXISTS                = -185,    //!< A cluster is already defined with the given configuration.
        DPMST_DISPLAY_ID_EXPECTED             = -186,    //!< The input display id is not that of a multi stream enabled connector or a display device in a multi stream topology 
        INVALID_DISPLAY_ID                    = -187,    //!< The input display id is not valid or the monitor associated to it does not support the current operation
        STREAM_IS_OUT_OF_SYNC                 = -188,    //!< While playing secure audio stream, stream goes out of sync
        INCOMPATIBLE_AUDIO_DRIVER             = -189,    //!< Older audio driver version than required
        VALUE_ALREADY_SET                     = -190,    //!< Value already set, setting again not allowed.
        TIMEOUT                               = -191,    //!< Requested operation timed out 
        GPU_WORKSTATION_FEATURE_INCOMPLETE    = -192,    //!< The requested workstation feature set has incomplete driver internal allocation resources
        STEREO_INIT_ACTIVATION_NOT_DONE       = -193,    //!< Call failed because InitActivation was not called.
        SYNC_NOT_ACTIVE                       = -194,    //!< The requested action cannot be performed without Sync being enabled.    
        SYNC_MASTER_NOT_FOUND                 = -195,    //!< The requested action cannot be performed without Sync Master being enabled.
        INVALID_SYNC_TOPOLOGY                 = -196,    //!< Invalid displays passed in the NV_GSYNC_DISPLAY pointer.
        ECID_SIGN_ALGO_UNSUPPORTED            = -197,    //!< The specified signing algorithm is not supported. Either an incorrect value was entered or the current installed driver/hardware does not support the input value.
        ECID_KEY_VERIFICATION_FAILED          = -198,    //!< The encrypted public key verification has failed.
        FIRMWARE_OUT_OF_DATE                  = -199,    //!< The device's firmware is out of date.
        FIRMWARE_REVISION_NOT_SUPPORTED       = -200,    //!< The device's firmware is not supported.
        LICENSE_CALLER_AUTHENTICATION_FAILED  = -201,    //!< The caller is not authorized to modify the License.
        D3D_DEVICE_NOT_REGISTERED             = -202,    //!< The user tried to use a deferred context without registering the device first  
        RESOURCE_NOT_ACQUIRED                 = -203,    //!< Head or SourceId was not reserved for the VR Display before doing the Modeset or the dedicated display.
        TIMING_NOT_SUPPORTED                  = -204,    //!< Provided timing is not supported.
        HDCP_ENCRYPTION_FAILED                = -205,    //!< HDCP Encryption Failed for the device. Would be applicable when the device is HDCP Capable.
        PCLK_LIMITATION_FAILED                = -206,    //!< Provided mode is over sink device pclk limitation.
        NO_CONNECTOR_FOUND                    = -207,    //!< No connector on GPU found. 
        HDCP_DISABLED                         = -208,    //!< When a non-HDCP capable HMD is connected, we would inform user by this code.
        API_IN_USE                            = -209,    //!< Atleast an API is still being called
        NVIDIA_DISPLAY_NOT_FOUND              = -210,    //!< No display found on Nvidia GPU(s).
        PRIV_SEC_VIOLATION                    = -211,    //!< Priv security violation, improper access to a secured register.
        INCORRECT_VENDOR                      = -212,    //!< NVAPI cannot be called by this vendor
        DISPLAY_IN_USE                        = -213,    //!< DirectMode Display is already in use
        UNSUPPORTED_CONFIG_NON_HDCP_HMD       = -214,    //!< The Config is having Non-NVidia GPU with Non-HDCP HMD connected
        MAX_DISPLAY_LIMIT_REACHED             = -215,    //!< GPU's Max Display Limit has Reached
        INVALID_DIRECT_MODE_DISPLAY           = -216,    //!< DirectMode not Enabled on the Display
        GPU_IN_DEBUG_MODE                     = -217,    //!< GPU is in debug mode, OC is NOT allowed.
        D3D_CONTEXT_NOT_FOUND                 = -218,    //!< No NvAPI context was found for this D3D object
        STEREO_VERSION_MISMATCH               = -219,    //!< there is version mismatch between stereo driver and dx driver
        GPU_NOT_POWERED                       = -220,    //!< GPU is not powered and so the request cannot be completed.
        ERROR_DRIVER_RELOAD_IN_PROGRESS       = -221,    //!< The display driver update in progress.
        WAIT_FOR_HW_RESOURCE                  = -222,    //!< Wait for HW resources allocation
        REQUIRE_FURTHER_HDCP_ACTION           = -223,    //!< operation requires further HDCP action
        DISPLAY_MUX_TRANSITION_FAILED         = -224,    //!< Dynamic Mux transition failure
        INVALID_DSC_VERSION                   = -225,    //!< Invalid DSC version
        INVALID_DSC_SLICECOUNT                = -226,    //!< Invalid DSC slice count
        INVALID_DSC_OUTPUT_BPP                = -227,    //!< Invalid DSC output BPP
        FAILED_TO_LOAD_FROM_DRIVER_STORE      = -228,    //!< There was an error while loading nvapi.dll from the driver store.
        NO_VULKAN                             = -229,    //!< OpenGL does not export Vulkan fake extensions
        REQUEST_PENDING                       = -230,    //!< A request for NvTOPPs telemetry CData has already been made and is pending a response.
        RESOURCE_IN_USE                       = -231,    //!< Operation cannot be performed because the resource is in use.
        INVALID_IMAGE                         = -232,    //!< Device kernel image is invalid
        INVALID_PTX                           = -233,    //!< PTX JIT compilation failed
        NVLINK_UNCORRECTABLE                  = -234,    //!< Uncorrectable NVLink error was detected during the execution
        JIT_COMPILER_NOT_FOUND                = -235,    //!< PTX JIT compiler library was not found.
        INVALID_SOURCE                        = -236,    //!< Device kernel source is invalid.
        ILLEGAL_INSTRUCTION                   = -237,    //!< While executing a kernel, the device encountered an illegal instruction.
        INVALID_PC                            = -238,    //!< While executing a kernel, the device program counter wrapped its address space
        LAUNCH_FAILED                         = -239,    //!< An exception occurred on the device while executing a kernel
        NOT_PERMITTED                         = -240,    //!< Attempted operation is not permitted.
        CALLBACK_ALREADY_REGISTERED           = -241,    //!< The callback function has already been registered.
        CALLBACK_NOT_FOUND                    = -242,    //!< The callback function is not found or not registered.
        INVALID_OUTPUT_WIRE_FORMAT            = -243,    //!< Invalid Wire Format for the VR HMD
}


ROTATE :: enum u32 {
        _0      = 0,
        _90     = 1,
        _180    = 2,
        _270    = 3,
        IGNORED = 4,
}

SCALING :: enum u32 {
    DEFAULT          = 0,        //!< No change

    // New Scaling Declarations
    GPU_SCALING_TO_CLOSEST                   = 1,  //!< Balanced  - Full Screen
    GPU_SCALING_TO_NATIVE                    = 2,  //!< Force GPU - Full Screen
    GPU_SCANOUT_TO_NATIVE                    = 3,  //!< Force GPU - Centered\No Scaling
    GPU_SCALING_TO_ASPECT_SCANOUT_TO_NATIVE  = 5,  //!< Force GPU - Aspect Ratio
    GPU_SCALING_TO_ASPECT_SCANOUT_TO_CLOSEST = 6,  //!< Balanced  - Aspect Ratio
    GPU_SCANOUT_TO_CLOSEST                   = 7,  //!< Balanced  - Centered\No Scaling
    GPU_INTEGER_ASPECT_SCALING               = 8,  //!< Force GPU - Integer Scaling

    // Legacy Declarations
    MONITOR_SCALING                          = GPU_SCALING_TO_CLOSEST,
    ADAPTER_SCALING                          = GPU_SCALING_TO_NATIVE,
    CENTERED                                 = GPU_SCANOUT_TO_NATIVE,
    ASPECT_SCALING                           = GPU_SCALING_TO_ASPECT_SCANOUT_TO_NATIVE,

    CUSTOMIZED       = 255       //!< For future use
} 

GPU_CONNECTOR_TYPE :: enum u32 {
        VGA_15_PIN                      = 0x00000000,
        TV_COMPOSITE                    = 0x00000010,
        TV_SVIDEO                       = 0x00000011,
        TV_HDTV_COMPONENT               = 0x00000013,
        TV_SCART                        = 0x00000014,
        TV_COMPOSITE_SCART_ON_EIAJ4120  = 0x00000016,
        TV_HDTV_EIAJ4120                = 0x00000017,
        PC_POD_HDTV_YPRPB               = 0x00000018,
        PC_POD_SVIDEO                   = 0x00000019,
        PC_POD_COMPOSITE                = 0x0000001A,
        DVI_I_TV_SVIDEO                 = 0x00000020,
        DVI_I_TV_COMPOSITE              = 0x00000021,
        DVI_I                           = 0x00000030,
        DVI_D                           = 0x00000031,
        ADC                             = 0x00000032,
        LFH_DVI_I_1                     = 0x00000038,
        LFH_DVI_I_2                     = 0x00000039,
        SPWG                            = 0x00000040,
        OEM                             = 0x00000041,
        DISPLAYPORT_EXTERNAL            = 0x00000046,
        DISPLAYPORT_INTERNAL            = 0x00000047,
        DISPLAYPORT_MINI_EXT            = 0x00000048,
        HDMI_A                          = 0x00000061,
        HDMI_C_MINI                     = 0x00000063,
        LFH_DISPLAYPORT_1               = 0x00000064,
        LFH_DISPLAYPORT_2               = 0x00000065,
        VIRTUAL_WFD                     = 0x00000070, //!< Deprecated.
        USB_C                           = 0x00000071,
        UNKNOWN                         = 0xFFFFFFFF,
}

DISPLAY_TV_FORMAT :: enum u32 {
        NONE               = 0,
        SD_NTSCM           = 0x00000001,
        SD_NTSCJ           = 0x00000002,
        SD_PALM            = 0x00000004,
        SD_PALBDGH         = 0x00000008,
        SD_PALN            = 0x00000010,
        SD_PALNC           = 0x00000020,
        SD_576i            = 0x00000100,
        SD_480i            = 0x00000200,
        ED_480p            = 0x00000400,
        ED_576p            = 0x00000800,
        HD_720p            = 0x00001000,
        HD_1080i           = 0x00002000,
        HD_1080p           = 0x00004000,
        HD_720p50          = 0x00008000,
        HD_1080p24         = 0x00010000,
        HD_1080i50         = 0x00020000,
        HD_1080p50         = 0x00040000,
        UHD_4Kp30          = 0x00080000,
        UHD_4Kp30_3840     = UHD_4Kp30,
        UHD_4Kp25          = 0x00100000,
        UHD_4Kp25_3840     = UHD_4Kp25,
        UHD_4Kp24          = 0x00200000,
        UHD_4Kp24_3840     = UHD_4Kp24,
        UHD_4Kp24_SMPTE    = 0x00400000,
        UHD_4Kp50_3840     = 0x00800000,
        UHD_4Kp60_3840     = 0x00900000,
        UHD_4Kp30_4096     = 0x00A00000,
        UHD_4Kp25_4096     = 0x00B00000,
        UHD_4Kp24_4096     = 0x00C00000,
        UHD_4Kp50_4096     = 0x00D00000,
        UHD_4Kp60_4096     = 0x00E00000,
        UHD_8Kp24_7680     = 0x01000000,
        UHD_8Kp25_7680     = 0x02000000,
        UHD_8Kp30_7680     = 0x04000000,
        UHD_8Kp48_7680     = 0x08000000,
        UHD_8Kp50_7680     = 0x09000000,
        UHD_8Kp60_7680     = 0x0A000000,
        UHD_8Kp100_7680    = 0x0B000000,
        UHD_8Kp120_7680    = 0x0C000000,
        UHD_4Kp48_3840     = 0x0D000000,
        UHD_4Kp48_4096     = 0x0E000000,
        UHD_4Kp100_4096    = 0x0F000000,
        UHD_4Kp100_3840    = 0x10000000,
        UHD_4Kp120_4096    = 0x11000000,
        UHD_4Kp120_3840    = 0x12000000,
        UHD_4Kp100_5120    = 0x13000000,
        UHD_4Kp120_5120    = 0x14000000,
        UHD_4Kp24_5120     = 0x15000000,
        UHD_4Kp25_5120     = 0x16000000,
        UHD_4Kp30_5120     = 0x17000000,
        UHD_4Kp48_5120     = 0x18000000,
        UHD_4Kp50_5120     = 0x19000000,
        UHD_4Kp60_5120     = 0x20000000,
        UHD_10Kp24_10240   = 0x21000000,
        UHD_10Kp25_10240   = 0x22000000,
        UHD_10Kp30_10240   = 0x23000000,
        UHD_10Kp48_10240   = 0x24000000,
        UHD_10Kp50_10240   = 0x25000000,
        UHD_10Kp60_10240   = 0x26000000,
        UHD_10Kp100_10240   = 0x27000000,
        UHD_10Kp120_10240   = 0x28000000,


        SD_OTHER           = 0x30000000,
        ED_OTHER           = 0x40000000,
        HD_OTHER           = 0x50000000,

        ANY                = 0x80000000,
}

TIMING_OVERRIDE :: enum u32 {
        CURRENT = 0,          //!< get the current timing
        AUTO,                 //!< the timing the driver will use based the current policy
        EDID,                 //!< EDID timing
        DMT,                  //!< VESA DMT timing
        DMT_RB,               //!< VESA DMT timing with reduced blanking
        CVT,                  //!< VESA CVT timing
        CVT_RB,               //!< VESA CVT timing with reduced blanking
        GTF,                  //!< VESA GTF timing
        EIA861,               //!< EIA 861x pre-defined timing
        ANALOG_TV,            //!< analog SD/HDTV timing
        CUST,                 //!< NV custom timings
        NV_PREDEFINED,        //!< NV pre-defined timing (basically the PsF timings)
        NV_PSF                = NV_PREDEFINED,
        NV_ASPR,
        SDI,                  //!< Override for SDI timing

        MAX,
}

TIMINGEXT :: struct {
        flag   : u32,
        rr     : u16,
        rrx1k  : u32,
        aspect : u32,
        rep    : u16,
        status : u32,
        name   : [40]u8,
}

TIMING :: struct {
        HVisible: u16,
        HBorder: u16,
        HFrontPorch: u16,
        HSyncWidth: u16,
        HTotal: u16,
        HSyncPol: u8,

        VVisible: u16,
        VBorder: u16,
        VFrontPorch: u16,
        VSyncWidth: u16,
        VTotal: u16,
        VSyncPol: u8,

        interlaced: u16,
        pclk: u32,

        etc: TIMINGEXT,
}


DISPLAYCONFIG_PATH_ADVANCED_TARGET_INFO_V1 :: struct{
        version       : u32,
        rotation      : ROTATE,
        scaling       : SCALING,
        refreshRate1K : u32,
        using _: bit_field u32 {
                interlaced                : b32 | 1,
                primary                   : b32 | 1,
                isPanAndScanTarget        : b32 | 1, // May be undefined?
                disableVirtualModeSupport : b32 | 1,
                isPreferredUnscaledTarget : b32 | 1,
                reserved                  : u32 | 27,
        },
        connector      : GPU_CONNECTOR_TYPE,
        tvFormat       : DISPLAY_TV_FORMAT,
        timingOverride : TIMING_OVERRIDE,
        timing         : TIMING,
}
VER_DISPLAYCONFIG_PATH_ADVANCED_TARGET_INFO :: 1


RESOLUTION :: struct {
        width      : u32,
        height     : u32,
        colorDepth : u32,
}

FORMAT :: enum i32 {
        UNKNOWN       = 0,
        P8            = 41,
        R5G6B5        = 23,
        A8R8G8B8      = 21,
        A16B16G16R16F = 113,
}

POSITION :: distinct [2]i32

DISPLAYCONFIG_SPANNING_ORIENTATION :: enum i32 {
        NONE       = 0,
        HORIZONTAL = 1,
        VERTICAL   = 2,
}


DISPLAYCONFIG_PATH_TARGET_INFO_V2 :: struct {
        displayId : u32,
        details   : ^DISPLAYCONFIG_PATH_ADVANCED_TARGET_INFO_V1, // May be nil if no advanced settings are required
        targetId  : u32,
}
VER_DISPLAYCONFIG_PATH_TARGET_INFO :: 2

DISPLAYCONFIG_SOURCE_MODE_INFO_V1 :: struct {
        resolution          : RESOLUTION,
        colorFormat         : FORMAT,
        position            : POSITION,
        spanningOrientation : DISPLAYCONFIG_SPANNING_ORIENTATION,
        using _: bit_field u32 {
                bGDIPrimary : b32 | 1,
                bSLIFocus   : b32 | 1,
                reserved    : u32 | 30 `fmt:-`,
        },
}
VER_DISPLAYCONFIG_SOURCE_MODE_INFO :: 1

DISPLAYCONFIG_PATH_INFO_V2 :: struct {
        version: u32,
        using _: struct #raw_union {
                sourceId          : u32,
                reserved_sourceId : u32,
        },
        targetInfoCount    : u32,
        targetInfo         : [^]DISPLAYCONFIG_PATH_TARGET_INFO_V2 `v:targetInfoCount`,
        sourceModeInfo     : ^DISPLAYCONFIG_SOURCE_MODE_INFO_V1, // may be nil if mode info is not important
        using _: bit_field u32 {
                IsNonNVIDIAAdapter : b32 | 1, // maybe need bit_field
                reserved           : u32 | 30 `fmt:-`,
        },
        pOSAdapterID       : rawptr,
}


DISPLAYCONFIG_PATH_INFO :: DISPLAYCONFIG_PATH_INFO_V2
VER_DISPLAYCONFIG_PATH_INFO :: 2

DISPLAYCONFIG_FLAGS :: bit_set[DISPLAYCONFIG_FLAG; u32]
DISPLAYCONFIG_FLAG :: enum u32 {
        VALIDATE_ONLY          = 0x00000001,
        SAVE_TO_PERSISTENCE    = 0x00000002,
        DRIVER_RELOAD_ALLOWED  = 0x00000004,               //!< Driver reload is permitted if necessary
        FORCE_MODE_ENUMERATION = 0x00000008,               //!< Refresh OS mode list.
        FORCE_COMMIT_VIDPN     = 0x00000010,               //!< Tell OS to avoid optimizing CommitVidPn call during a modeset
}




@(default_calling_convention="c")
@(link_prefix="NvAPI_")
foreign lib {

        ///////////////////////////////////////////////////////////////////////////////
        //
        // FUNCTION NAME: NvAPI_Initialize
        //
        //! This function initializes the NvAPI library (if not already initialized) but always increments the ref-counter.
        //! This must be called before calling other NvAPI_ functions.
        //! Note: It is now mandatory to call NvAPI_Initialize before calling any other NvAPI.
        //! NvAPI_Unload should be called to unload the NVAPI Library.
        //!
        //! SUPPORTED OS:  Windows 10 and higher
        //!
        //!
        //! \since Release: 80
        //!
        //! \return      This API can return any of the error codes enumerated in #NvAPI_Status. If there are return error codes with
        //!              specific meaning for this API, they are listed below.
        //! \retval      NVAPI_LIBRARY_NOT_FOUND  Failed to load the NVAPI support library
        //! \sa nvapistatus
        //! \ingroup nvapifunctions
        ///////////////////////////////////////////////////////////////////////////////
        Initialize :: proc() -> Status ---

        ///////////////////////////////////////////////////////////////////////////////
        //
        // FUNCTION NAME: NvAPI_Unload
        //
        //!   DESCRIPTION: Decrements the ref-counter and when it reaches ZERO, unloads NVAPI library.
        //!                This must be called in pairs with NvAPI_Initialize.
        //!
        //! SUPPORTED OS:  Windows 10 and higher
        //!
        //!
        //!        If the client wants unload functionality, it is recommended to always call NvAPI_Initialize and NvAPI_Unload in pairs.
        //!
        //!  Unloading NvAPI library is not supported when the library is in a resource locked state.
        //!  Some functions in the NvAPI library initiates an operation or allocates certain resources
        //!  and there are corresponding functions available, to complete the operation or free the
        //!  allocated resources. All such function pairs are designed to prevent unloading NvAPI library.
        //!
        //!  For example, if NvAPI_Unload is called after NvAPI_XXX which locks a resource, it fails with
        //!  NVAPI_ERROR. Developers need to call the corresponding NvAPI_YYY to unlock the resources,
        //!  before calling NvAPI_Unload again.
        //!
        //! \return      This API can return any of the error codes enumerated in #NvAPI_Status. If there are return error codes with
        //!              specific meaning for this API, they are listed below.
        //! \retval      NVAPI_API_IN_USE       Atleast an API is still being called hence cannot unload requested driver.
        //!
        //! \ingroup nvapifunctions
        ///////////////////////////////////////////////////////////////////////////////
        Unload :: proc() -> Status ---

        ///////////////////////////////////////////////////////////////////////////////
        // FUNCTION NAME:   NvAPI_DISP_GetDisplayConfig
        //
        //! DESCRIPTION:     This API lets caller retrieve the current global display
        //!                  configuration.
        //!       USAGE:     The caller might have to call this three times to fetch all the required configuration details as follows:
        //!                  First  Pass: Caller should Call NvAPI_DISP_GetDisplayConfig() with pathInfo set to NULL to fetch pathInfoCount.
        //!                  Second Pass: Allocate memory for pathInfo with respect to the number of pathInfoCount(from First Pass) to fetch
        //!                               targetInfoCount. If sourceModeInfo is needed allocate memory or it can be initialized to NULL.
        //!             Third  Pass(Optional, only required if target information is required): Allocate memory for targetInfo with respect
        //!                               to number of targetInfoCount(from Second Pass).
        //! SUPPORTED OS:  Windows 10 and higher
        //!
        //!
        //! \param [in,out]  pathInfoCount    Number of elements in pathInfo array, returns number of valid topologies, this cannot be null.
        //! \param [in,out]  pathInfo         Array of path information
        //!
        //! \return    This API can return any of the error codes enumerated in #NvAPI_Status. If there are return error codes with
        //!            specific meaning for this API, they are listed below.
        //!
        //! \retval    NVAPI_INVALID_ARGUMENT  -   Invalid input parameter. Following can be the reason for this return value:
        //!                                        -# pathInfoCount is NULL.
        //!                                        -# *pathInfoCount is 0 and pathInfo is not NULL.
        //!                                        -# *pathInfoCount is not 0 and pathInfo is NULL.
        //! \retval    NVAPI_DEVICE_BUSY       -   ModeSet has not yet completed. Please wait and call it again.
        //!
        //! \ingroup dispcontrol
        ///////////////////////////////////////////////////////////////////////////////
        DISP_GetDisplayConfig :: proc(pathInfoCount: ^u32, pathInfo: [^]DISPLAYCONFIG_PATH_INFO) -> Status ---


        ///////////////////////////////////////////////////////////////////////////////
        // FUNCTION NAME:   NvAPI_DISP_SetDisplayConfig
        //
        //
        //! DESCRIPTION:     This API lets caller apply a global display configuration
        //!                  across multiple GPUs.
        //!
        //!                  If all sourceIds are zero, then NvAPI will pick up sourceId's based on the following criteria :
        //!                  - If user provides sourceModeInfo then we are trying to assign 0th sourceId always to GDIPrimary.
        //!                     This is needed since active windows always moves along with 0th sourceId.
        //!                  - For rest of the paths, we are incrementally assigning the sourceId per adapter basis.
        //!                  - If user doesn't provide sourceModeInfo then NVAPI just picks up some default sourceId's in incremental order.
        //!                  Note : NVAPI will not intelligently choose the sourceIDs for any configs that does not need a modeset.
        //!
        //! SUPPORTED OS:  Windows 10 and higher
        //!
        //!
        //! \param [in]      pathInfoCount   Number of supplied elements in pathInfo
        //! \param [in]      pathInfo        Array of path information
        //! \param [in]      flags           A bitwise OR of supported flags from NV_DISPLAYCONFIG_FLAGS.
        //!
        //! \retval ::NVAPI_OK - completed request
        //! \retval ::NVAPI_API_NOT_INTIALIZED - NVAPI not initialized
        //! \retval ::NVAPI_ERROR - miscellaneous error occurred
        //! \retval ::NVAPI_INVALID_ARGUMENT - Invalid input parameter.
        //!
        //! \ingroup dispcontrol
        ///////////////////////////////////////////////////////////////////////////////
        DISP_SetDisplayConfig :: proc(pathInfoCount: u32, pathInfo: [^]DISPLAYCONFIG_PATH_INFO, flags: DISPLAYCONFIG_FLAGS) -> Status --- 


        //! SUPPORTED OS:  Windows 10 and higher
        //!
        ///////////////////////////////////////////////////////////////////////////////
        //
        // FUNCTION NAME:   NvAPI_DISP_GetDisplayIdByDisplayName
        //
        //! DESCRIPTION:     This API retrieves the Display Id of a given display by
        //!                  display name. The display must be active to retrieve the
        //!                  displayId. In the case of clone mode or Surround gaming,
        //!                  the primary or top-left display will be returned.
        //!
        //! \param [in]     displayName  Name of display (Eg: "\\DISPLAY1" to
        //!                              retrieve the displayId for.
        //! \param [out]    displayId    Display ID of the requested display.
        //!
        //! retval ::NVAPI_OK:                          Capabilties have been returned.
        //! retval ::NVAPI_INVALID_ARGUMENT:            One or more args passed in are invalid.
        //! retval ::NVAPI_API_NOT_INTIALIZED:          The NvAPI API needs to be initialized first
        //! retval ::NVAPI_NO_IMPLEMENTATION:           This entrypoint not available
        //! retval ::NVAPI_ERROR:                       Miscellaneous error occurred
        //!
        //! \ingroup dispcontrol
        ///////////////////////////////////////////////////////////////////////////////
        DISP_GetDisplayIdByDisplayName :: proc(displayName: cstring, displayId: ^u32) -> Status ---
}

