function Animate-Text {
    param (
        [string]$text
    )

    if (![string]::IsNullOrEmpty($text)) {
        foreach ($char in $text.ToCharArray()) {
            try {
                Write-Host -NoNewline $char -ErrorAction SilentlyContinue
                Start-Sleep -Milliseconds 1.5
            } catch {
                Write-Host $text -ErrorAction SilentlyContinue
            }
        }
        Write-Host ""
    }
}
function Animate-Text-x2 {
    param (
        [string]$text
    )
    if (![string]::IsNullOrEmpty($text)) {
        foreach ($char in $text.ToCharArray()) {
            try {
                Write-Host -NoNewline $char -ErrorAction SilentlyContinue
                Start-Sleep -Milliseconds 0.5
            } catch {
                Write-Host $text -ErrorAction SilentlyContinue
            }
        }
        Write-Host ""
    }
}

# Custom symbols
$SYMBOL_CROWN = [char]0x2654
$SYMBOL_NEWLINE = [char]0x2514
$SYMBOL_SEPARATOR_DOT = [char]0x2022
$SYMBOL_SETTINGS = [char]0x1368
$SYMBOL_RIGHTWARDS_ARROW = [char]0x2192
$SYMBOL_MODEL_SELECTED = [char]0x1362
$SYMBOL_MODEL_CUSTOM = [char]0x2736
$SYMBOL_MODEL_AUTOSELECT = [char]0x1360
$SYMBOL_MODEL_LASTUSED = [char]0x25C1
$SYMBOL_COMP_SETUPSCRIPT = [char]0x144E
$SYMBOL_COMP_CONNECTION = [char]0x39E
$SYMBOL_COMP_CAPSULE = [char]0x1403
$SYMBOL_COMP_NODE = [char]0x46A
$SYMBOL_COMP_UTILS = [char]0x15D1
$SYMBOL_STATE_SUCCESS = [char]0x2713
$SYMBOL_STATE_FAILURE = [char]0xD7
$SYMBOL_STATE_WARNING = [char]0x26A0
$SYMBOL_STATE_SADFACE = [char[]]@(0x2D9, 0x1422, 0x2D9)
$SYMBOL_STATE_HAPPYFACE = [char[]]@(0x2D9, 0x1D55, 0x2D9)
$SYMBOL_HEADER_IN = [char[]]@(0x2592, 0x2593, 0x2591)
$SYMBOL_HEADER_OUT = [char[]]@(0x2591, 0x2593, 0x2592)
$BANNER = [char[]]@(0xA, 0x20, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0xA, 0x20, 0x20, 0x2593, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x20, 0x2593, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0xA, 0x20, 0x2591, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2591, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0xA, 0x20, 0x20, 0x2593, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x20, 0x2593, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0xA, 0x20, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0xA, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0xA, 0x20, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0xA, 0x20, 0x20, 0x2593, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x20, 0x2593, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0xA, 0x20, 0x2591, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2591, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0xA, 0x20, 0x20, 0x2593, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x20, 0x2593, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0xA, 0x20, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0xA)
$BANNER_FULLNAME = [char[]]@(0xA, 0xA, 0x2591, 0x2593, 0x2588, 0x2593, 0x20, 0x20, 0x2591, 0x2593, 0x2588, 0x2593, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x2588, 0x2593, 0xA, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x2592, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x2591, 0x2588, 0x2588, 0x2593, 0x2591, 0x20, 0x20, 0x2593, 0x2588, 0x2588, 0x2593, 0x2591, 0x2588, 0x2588, 0x2588, 0x2593, 0x2592, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x2588, 0x2593, 0x2588, 0x2588, 0x2588, 0x2593, 0x2591, 0x2588, 0x2593, 0x20, 0x20, 0x2588, 0x2591, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x2591, 0x2588, 0x2588, 0x2593, 0x2591, 0xA, 0x2592, 0x2588, 0x2593, 0x2591, 0x20, 0x20, 0x2591, 0x2588, 0x2593, 0x2591, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x2588, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x2588, 0x2593, 0x20, 0x2591, 0x2591, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x2591, 0x2588, 0x2593, 0x20, 0x2593, 0x2588, 0x2593, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x2593, 0x2588, 0x2593, 0x20, 0x2593, 0x2588, 0x2593, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x2588, 0x2593, 0xA, 0x2591, 0x2593, 0x2588, 0x2593, 0x20, 0x20, 0x2591, 0x2593, 0x2588, 0x2593, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x2592, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x2591, 0x2588, 0x2592, 0x2588, 0x2593, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x2593, 0x2588, 0x2592, 0x2588, 0x2592, 0x2588, 0x2592, 0x2588, 0x2593, 0x2591, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x2588, 0x2593, 0xA, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x2588, 0x2588, 0x2588, 0x2588, 0x2591, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x2592, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x20, 0x2593, 0x2588, 0x2588, 0x2593, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x2588, 0x2588, 0x2588, 0x2591, 0x2588, 0x2588, 0x2588, 0x2593, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x2588, 0x2593, 0xA, 0x2592, 0x2588, 0x2593, 0x2591, 0x20, 0x20, 0x2591, 0x2588, 0x2593, 0x2591, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x2592, 0x2588, 0x2588, 0x2588, 0x20, 0x20, 0x2592, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x20, 0x2593, 0x2588, 0x2593, 0x2591, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x20, 0x2593, 0x2588, 0x2593, 0x2591, 0x20, 0x20, 0x20, 0x2588, 0x2593, 0x20, 0x20, 0x20, 0x2593, 0x2588, 0x2593, 0x2592, 0x20, 0x20, 0x2588, 0x2593, 0x2591, 0x20, 0x2588, 0x2593, 0x2591, 0x20, 0x20, 0x20, 0x2593, 0x2588, 0x2593, 0x2591, 0xA, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x2592, 0x2588, 0x2593, 0x2591)

function Auto-Select-Model {
    $AVAILABLE_MEM = $null
    $TOTAL_MEM = $null

    if (Get-Command nvidia-smi -ErrorAction SilentlyContinue) {
        $AVAILABLE_MEM = [math]::Round(((nvidia-smi --query-gpu=memory.free --format=csv,noheader,nounits | Select-Object -First 1) -as [double]) / 1024, 2, [System.MidpointRounding]::AwayFromZero)
        $TOTAL_MEM = ((nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits | Select-Object -First 1) -as [double]) / 1024
    } else {
        $TotalMemoryKB = [double]((Get-CimInstance Win32_OperatingSystem).TotalVisibleMemorySize)
        $AVAILABLE_MEM = $TotalMemoryKB / 1024 / 1024
    }
    Animate-Text "    $SYMBOL_NEWLINE System analysis:"
    Animate-Text-x2 "    $SYMBOL_NEWLINE $TOTAL_MEM GB $MEMORY_TYPE total, $AVAILABLE_MEM GB $MEMORY_TYPE available"

    $AVAILABLE_MEM_INT = [math]::Round($AVAILABLE_MEM)
    if ($AVAILABLE_MEM_INT -ge 22) {
        Animate-Text-x2 "    $SYMBOL_CROWN Recommending: $SYMBOL_MODEL_SELECTED 7 Qwen3 for problem solving & coding"
        $script:LLM_HF_REPO = "unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF"
        $script:LLM_HF_MODEL_NAME = "Qwen3-Coder-30B-A3B-Instruct-Q4_K_M.gguf"
        $script:NODE_NAME = "Qwen3 Coder 30B A3B Instruct Q4"
    } elseif ($AVAILABLE_MEM_INT -ge 15) {
        Animate-Text-x2 "    $SYMBOL_CROWN Recommending: $SYMBOL_MODEL_SELECTED 13 Qwen3 14B for high-precision logical analysis"
        $script:LLM_HF_REPO = "unsloth/Qwen3-14B-GGUF"
        $script:LLM_HF_MODEL_NAME = "Qwen3-14B-Q4_K_M.gguf"
        $script:NODE_NAME = "Qwen3 14B Q4"
    } elseif ($AVAILABLE_MEM_INT -ge 7) {
        Animate-Text-x2 "    $SYMBOL_CROWN Recommending: $SYMBOL_MODEL_SELECTED 14 Qwen3 8B for balanced capability"
        $script:LLM_HF_REPO = "unsloth/Qwen3-8B-GGUF"
        $script:LLM_HF_MODEL_NAME = "Qwen3-8B-Q4_K_M.gguf"
        $script:NODE_NAME = "Qwen3 8B Q4"
    } else {
        Animate-Text-x2 "    $SYMBOL_CROWN Recommending: $SYMBOL_MODEL_SELECTED 23 Qwen 3 7.1B optimized for efficiency"
        $script:LLM_HF_REPO = "unsloth/Qwen3-1.7B-GGUF"
        $script:LLM_HF_MODEL_NAME = "Qwen3-1.7B-Q4_K_M.gguf"
        $script:NODE_NAME = "Qwen3 1.7B Q4"
    }

    Animate-Text "    $SYMBOL_NEWLINE Or pick a model smaller than $AVAILABLE_MEM GB"
}

Write-Host ""
Animate-Text-x2 ($BANNER -join '')
Animate-Text "      Welcome to ::|| Fortytwo, Noderunner."
Write-Host ""
if (Get-Command "nvidia-smi.exe" -ErrorAction SilentlyContinue) {
    $MEMORY_TYPE="VRAM"
} else {
    $MEMORY_TYPE=" RAM"
    Write-Output "    $SYMBOL_STATE_FAILURE ERROR: No compatible GPU found. This application requires an NVIDIA GPU. Please verify that your system has a supported NVIDIA GPU by reviewing our hardware requirements documentation: https://docs.fortytwo.network/docs/hardware-requirements"
    exit 1
}

$PROJECT_DIR = "FortytwoNode"
$PROJECT_DEBUG_DIR = "$PROJECT_DIR\debug"
$PROJECT_MODEL_CACHE_DIR="$PROJECT_DIR\model_cache"
$CAPSULE_ZIP = "$PROJECT_DIR\capsule_cuda.zip"
$EXTRACTED_CUDA_EXEC = "$PROJECT_DIR\FortytwoCapsule-windows-amd64-cuda124.exe"
$CAPSULE_EXEC = "$PROJECT_DIR\FortytwoCapsule.exe"
$CAPSULE_LOGS = "$PROJECT_DEBUG_DIR\FortytwoCapsule.log"
$CAPSULE_ERR_LOGS = "$PROJECT_DEBUG_DIR\FortytwoCapsule_err.log"
$CAPSULE_READY_URL = "http://localhost:42442/ready"

$PROTOCOL_EXEC = "$PROJECT_DIR\FortytwoProtocol.exe"

$ACCOUNT_PRIVATE_KEY_FILE = "$PROJECT_DIR\.account_private_key"

$UTILS_EXEC="$PROJECT_DIR\FortytwoUtilsWindows.exe"

# KV-cache settings
$KV_CACHE_MODE="auto"
$KV_CACHE_TOKENS=$false
$KV_CACHE_GB=$false

$LLM_IS_LOCAL_PATH=$false

Write-Host "Preparing your node environment..."

if (-Not (Test-Path $PROJECT_DEBUG_DIR) -or -Not (Test-Path $PROJECT_MODEL_CACHE_DIR)) {
    New-Item -ItemType Directory -Path $PROJECT_DEBUG_DIR -Force | Out-Null
    New-Item -ItemType Directory -Path $PROJECT_MODEL_CACHE_DIR -Force | Out-Null
    Write-Host ""
    # Animate-Text "Project directory created: $PROJECT_DIR"
} else {
    Write-Host ""
    # Animate-Text "Project directory already exists: $PROJECT_DIR"
}

function Cleanup {
    if ($CAPSULE_PROC) {
        $CAPSULE_PROC.Refresh()
    }
    if ($PROTOCOL_PROC) {
        $PROTOCOL_PROC.Refresh()
    }

    if ($CAPSULE_PROC -and $CAPSULE_PROC.HasExited -eq $false) {
        Animate-Text " $SYMBOL_COMP_CAPSULE Stopping Capsule..."
        Stop-Process -Id $CAPSULE_PROC.Id -Force -ErrorAction SilentlyContinue
    } else {
        Animate-Text " $SYMBOL_COMP_CAPSULE Capsule is not running."
    }

    if ($PROTOCOL_PROC -and $PROTOCOL_PROC.HasExited -eq $false) {
        Animate-Text " $SYMBOL_COMP_NODE Stopping Node..."
        Stop-Process -Id $PROTOCOL_PROC.Id -Force -ErrorAction SilentlyContinue
    } else {
        Animate-Text " $SYMBOL_COMP_NODE Node is not running."
    }
    Write-Host ""
    Animate-Text "Processes stopped"
    Animate-Text "Bye, Noderunner"
    exit 0
}

function Test-UrlAvailability {
    param (
        [string]$Url
    )
    try {
        $response = Invoke-WebRequest -UseBasicParsing -Uri $Url -Method Head -TimeoutSec 5 -ErrorAction Stop
        return $true
    } catch {
        return $false
    }
}

function Test-Connection {
    Animate-Text-x2 " $SYMBOL_COMP_CONNECTION Connection check to update endpoints"

    $capsuleOk = Test-UrlAvailability -Url "https://download.swarminference.io/capsule/latest"
    $protocolOk = Test-UrlAvailability -Url "https://download.swarminference.io/protocol/latest"

    if ($capsuleOk -and $protocolOk) {
        Write-Host "    $SYMBOL_STATE_SUCCESS Connected to all services"
        Write-Host ""
        return $true

    } elseif (-not $capsuleOk -and -not $protocolOk) {
        Write-Host "    $SYMBOL_STATE_FAILURE ERROR: No connection to services. Check your internet connection, try using a VPN, and restart the script."
        Write-Host ""
        return $false

    } else {
        Write-Host "    $SYMBOL_STATE_WARNING WARNING: Partial connection detected"
        Write-Host "    $SYMBOL_SEPARATOR_DOT Capsule endpoint: $(if ($capsuleOk) { "$SYMBOL_STATE_SUCCESS" } else { "$SYMBOL_STATE_FAILURE" })"
        Write-Host "    $SYMBOL_SEPARATOR_DOT Protocol endpoint: $(if ($protocolOk) { "$SYMBOL_STATE_SUCCESS" } else { "$SYMBOL_STATE_FAILURE" })"
        Write-Host ""
        return $false
    }
}

function Start-ConnectionLoop {
    while ($true) {
        if (Test-Connection) {
            break
        } else {
            Write-Host "    [1] Try Reconnecting"
            Write-Host "    [2] Restart App"
            $userChoice = Read-Host "    Select option"

            switch ($userChoice) {
                "1" {
                    Write-Host "    $SYMBOL_RIGHTWARDS_ARROW Attempting reconnection..."
                    Write-Host ""
                    continue
                }
                "2" {
                    Write-Host "    $SYMBOL_RIGHTWARDS_ARROW Restarting application..."
                    & $PSCommandPath
                    exit
                }
                default {
                    Write-Host "    $SYMBOL_STATE_FAILURE Invalid input. Please try again."
                    Write-Host ""
                }
            }
        }
    }
}

Start-ConnectionLoop

Animate-Text-x2 ($SYMBOL_HEADER_IN -join ''),"Checking for the Latest Components Versions",($SYMBOL_HEADER_OUT -join '')
Write-Host ""
Animate-Text " $SYMBOL_COMP_SETUPSCRIPT Setup script - version validation"

# --- Update setup script ---
$UpdateUrl = "https://raw.githubusercontent.com/Fortytwo-Network/fortytwo-console-app/main/windows.ps1"
$ScriptPath = $MyInvocation.MyCommand.Path
$TempFile = [System.IO.Path]::GetTempFileName()

# Download updated script
try {
    Invoke-WebRequest -UseBasicParsing -Uri $UpdateUrl -OutFile $TempFile -ErrorAction Stop
} catch {
    Write-Output "    $SYMBOL_STATE_FAILURE ERROR: Failed to download the update. Check your internet connection and try again."
    exit 1
}

# Compare
if ((Get-FileHash $ScriptPath).Hash -eq (Get-FileHash $TempFile).Hash) {
    Write-Output "    $SYMBOL_STATE_SUCCESS Up to date"
    Remove-Item $TempFile
} else {
    Write-Output "    $SYMBOL_NEWLINE Updating..."
    Copy-Item $ScriptPath "$ScriptPath.bak" -Force
    Copy-Item $TempFile $ScriptPath -Force
    Remove-Item $TempFile

    Write-Output "    $SYMBOL_NEWLINE Restarting script..."
    Write-Host ""
    Start-Sleep -Seconds 3
    # Start the new version and exit current
    Start-Process -FilePath "powershell.exe" -ArgumentList "-ExecutionPolicy Bypass -File `"$ScriptPath`""
    exit
}
# --- End Update setup script ---

trap {
    Animate-Text "`nDetected Ctrl+C. Stopping processes..."
    Cleanup
}

$CAPSULE_VERSION = (Invoke-RestMethod "https://download.swarminference.io/capsule/latest").Trim()
Animate-Text-x2 " $SYMBOL_COMP_CAPSULE Capsule - version $CAPSULE_VERSION"
if (Test-Path $CAPSULE_EXEC) {
    $CURRENT_CAPSULE_VERSION_OUTPUT = & $CAPSULE_EXEC --version 2>$null
    if ($CURRENT_CAPSULE_VERSION_OUTPUT -match $CAPSULE_VERSION) {
        Animate-Text "    $SYMBOL_STATE_SUCCESS Up to date"
    } else {
        if (Get-Command "nvidia-smi.exe" -ErrorAction SilentlyContinue) {
            Animate-Text "    $SYMBOL_NEWLINE NVIDIA detected. Downloading CUDA Capsule..."
            $DOWNLOAD_CAPSULE_URL = "https://download.swarminference.io/capsule/v$CAPSULE_VERSION/windows-amd64-cuda124.zip"
            Start-BitsTransfer -Source $DOWNLOAD_CAPSULE_URL -Destination $CAPSULE_ZIP
            Animate-Text "    $SYMBOL_NEWLINE Extracting CUDA Capsule..."
            Remove-Item $CAPSULE_EXEC -Force
            Remove-Item "$PROJECT_DIR\cublas64_12.dll" -Force
            Remove-Item "$PROJECT_DIR\cublasLt64_12.dll" -Force
            Remove-Item "$PROJECT_DIR\MSVCP140.DLL" -Force
            Remove-Item "$PROJECT_DIR\VCOMP140.DLL" -Force
            Remove-Item "$PROJECT_DIR\VCRUNTIME140.DLL" -Force
            Remove-Item "$PROJECT_DIR\VCRUNTIME140_1.DLL" -Force
            Expand-Archive -Path $CAPSULE_ZIP -DestinationPath $PROJECT_DIR -Force
            Remove-Item $CAPSULE_ZIP -Force

            if (Test-Path $EXTRACTED_CUDA_EXEC) {
                Rename-Item -Path $EXTRACTED_CUDA_EXEC -NewName "FortytwoCapsule.exe" -Force
                Animate-Text "    $SYMBOL_NEWLINE Renamed CUDA Capsule to: $CAPSULE_EXEC"
            } else {
                Write-Host "    $SYMBOL_STATE_FAILURE ERROR: Expected CUDA executable not found in extracted files!"
                Exit 1
            }
            Animate-Text "    $SYMBOL_STATE_SUCCESS Successfully updated"
        } else {
            Write-Host "    $SYMBOL_NEWLINE No NVIDIA GPU detected. Downloading CPU Capsule..."
            $DOWNLOAD_CAPSULE_URL = "https://download.swarminference.io/capsule/v$CAPSULE_VERSION/FortytwoCapsule-windows-amd64.exe"
            Start-BitsTransfer -Source $DOWNLOAD_CAPSULE_URL -Destination $CAPSULE_EXEC
            Animate-Text "    $SYMBOL_STATE_SUCCESS Successfully updated"
        }
    }
} else {
    if (Get-Command "nvidia-smi.exe" -ErrorAction SilentlyContinue) {
        Animate-Text "    $SYMBOL_NEWLINE NVIDIA detected. Downloading CUDA Capsule..."
        $DOWNLOAD_CAPSULE_URL = "https://download.swarminference.io/capsule/v$CAPSULE_VERSION/windows-amd64-cuda124.zip"
        Start-BitsTransfer -Source $DOWNLOAD_CAPSULE_URL -Destination $CAPSULE_ZIP
        Animate-Text "    $SYMBOL_NEWLINE Extracting CUDA Capsule..."
        Expand-Archive -Path $CAPSULE_ZIP -DestinationPath $PROJECT_DIR -Force
        Remove-Item $CAPSULE_ZIP -Force

        if (Test-Path $EXTRACTED_CUDA_EXEC) {
            Rename-Item -Path $EXTRACTED_CUDA_EXEC -NewName "FortytwoCapsule.exe" -Force
            Write-Host "    $SYMBOL_NEWLINE Renamed CUDA Capsule to: $CAPSULE_EXEC"
        } else {
            Write-Host "    $SYMBOL_STATE_FAILURE ERROR: Expected CUDA executable not found in extracted files!"
            Exit 1
        }
        Animate-Text "    $SYMBOL_STATE_SUCCESS Installed to: $CAPSULE_EXEC"
    } else {
        Animate-Text "    $SYMBOL_NEWLINE No NVIDIA GPU detected. Downloading CPU Capsule..."
        $DOWNLOAD_CAPSULE_URL = "https://download.swarminference.io/capsule/v$CAPSULE_VERSION/FortytwoCapsule-windows-amd64.exe"
        Start-BitsTransfer -Source $DOWNLOAD_CAPSULE_URL -Destination $CAPSULE_EXEC
        Animate-Text "    $SYMBOL_STATE_SUCCESS Installed to: $CAPSULE_EXEC"
    }
}
$PROTOCOL_VERSION = (Invoke-RestMethod "https://download.swarminference.io/protocol/latest").Trim()
Animate-Text-x2 " $SYMBOL_COMP_NODE Protocol Node - version $PROTOCOL_VERSION"
$DOWNLOAD_PROTOCOL_URL = "https://download.swarminference.io/protocol/v$PROTOCOL_VERSION/FortytwoProtocolNode-windows-amd64.exe"
if (Test-Path $PROTOCOL_EXEC) {
    $CURRENT_PROTOCOL_VERSION_OUTPUT = & $PROTOCOL_EXEC --version 2>$null
    if ($CURRENT_PROTOCOL_VERSION_OUTPUT -match $PROTOCOL_VERSION) {
        Animate-Text "    $SYMBOL_STATE_SUCCESS Up to date"
    } else {
        Animate-Text "    $SYMBOL_NEWLINE Updating..."
        Start-BitsTransfer -Source $DOWNLOAD_PROTOCOL_URL -Destination $PROTOCOL_EXEC
        Animate-Text "    $SYMBOL_STATE_SUCCESS Successfully updated"
    }
} else {
    Animate-Text "    $SYMBOL_NEWLINE Downloading..."
    Start-BitsTransfer -Source $DOWNLOAD_PROTOCOL_URL -Destination $PROTOCOL_EXEC
    Animate-Text "    $SYMBOL_STATE_SUCCESS Installed to: $PROTOCOL_EXEC"
}
$UTILS_VERSION = (Invoke-RestMethod "https://download.swarminference.io/utilities/latest").Trim()
Animate-Text-x2 " $SYMBOL_COMP_UTILS Utils - version $UTILS_VERSION"
$DOWNLOAD_UTILS_URL = "https://download.swarminference.io/utilities/v$UTILS_VERSION/FortytwoUtilsWindows.exe"
if (Test-Path $UTILS_EXEC) {
    $CURRENT_UTILS_VERSION_OUTPUT = & $UTILS_EXEC --version 2>$null
    if ($CURRENT_UTILS_VERSION_OUTPUT -match $UTILS_VERSION) {
        Animate-Text "    $SYMBOL_STATE_SUCCESS Up to date"
    } else {
        Animate-Text "    $SYMBOL_NEWLINE Updating..."
        Start-BitsTransfer -Source $DOWNLOAD_UTILS_URL -Destination $UTILS_EXEC
        Animate-Text "    $SYMBOL_STATE_SUCCESS Successfully updated"
    }
} else {
    Animate-Text "    $SYMBOL_NEWLINE Downloading..."
    Start-BitsTransfer -Source $DOWNLOAD_UTILS_URL -Destination $UTILS_EXEC
    Animate-Text "     $SYMBOL_STATE_SUCCESS Installed to: $UTILS_EXEC"
}

Write-Host ""
Animate-Text-x2 ($SYMBOL_HEADER_IN -join ''),"Identity Initialization",($SYMBOL_HEADER_OUT -join '')

if (Test-Path $ACCOUNT_PRIVATE_KEY_FILE) {
    $ACCOUNT_PRIVATE_KEY = Get-Content $ACCOUNT_PRIVATE_KEY_FILE
    Write-Host ""
    Animate-Text "    $SYMBOL_NEWLINE Private key found at $PROJECT_DIR /.account_private_key."
    Animate-Text "    $SYMBOL_NEWLINE Initiating the node using an existing identity."
    Animate-Text-x2 "    $SYMBOL_STATE_WARNING Keep the private key safe. Do not share with anyone."
    Animate-Text-x2 "    $SYMBOL_STATE_WARNING Recover your node or access your wallet with it."
    Animate-Text-x2 "    $SYMBOL_STATE_WARNING We will not be able to recover it if it is lost."
} else {
    Write-Host ""
    Write-Host "|==================== NETWORK IDENTITY ===================|"
    Write-Host "|                                                         |"
    Write-Host "|  Each node requires a secure blockchain identity.       |"
    Write-Host "|  Select one of the following options:                   |"
    Write-Host "|                                                         |"
    Write-Host "|  1. Create a new identity with an activation code.      |"
    Write-Host "|     Recommended for new nodes.                          |"
    Write-Host "|                                                         |"
    Write-Host "|  2. Recover an existing identity with recovery phrase.  |"
    Write-Host "|     Use this if you're restoring a previous node.       |"
    Write-Host "|                                                         |"
    Write-Host "|=========================================================|"
    Write-Host ""

    $IDENTITY_OPTION = Read-Host "Select option [1-2]"
    Write-Host ""
    if (-not $IDENTITY_OPTION) { $IDENTITY_OPTION = "1" }

    if ($IDENTITY_OPTION -eq "2") {
        Animate-Text "2 : RECOVERING EXISTING IDENTITY"
        Write-Host ""
        while ($true) {
            $ACCOUNT_SEED_PHRASE = Read-Host "Enter your account recovery phrase (12, 18, or 24 words), then press Enter"
            Write-Host ""
            try {
                $ACCOUNT_PRIVATE_KEY = & $UTILS_EXEC --phrase $ACCOUNT_SEED_PHRASE
                if ($LASTEXITCODE -ne 0) {
                    throw ($SYMBOL_STATE_SADFACE -join ''),"Error: Please check the recovery phrase and try again."
                } else {
                    $ACCOUNT_PRIVATE_KEY | Set-Content -Path $ACCOUNT_PRIVATE_KEY_FILE
                    Animate-Text " ",($SYMBOL_STATE_HAPPYFACE -join ''),"The identity successfully restored!"
                    Write-Host ""
                    Animate-Text "    $SYMBOL_NEWLINE Private key saved to $PROJECT_DIR /.account_private_key."
                    Animate-Text-x2 "    $SYMBOL_STATE_WARNING Keep the key secure. Do not share with anybody."
                    Animate-Text-x2 "    $SYMBOL_STATE_WARNING Restore your node or access your wallet with it."
                    Animate-Text-x2 "    $SYMBOL_STATE_WARNING We will not be able to recover it would it be lost."
                    break
                }
            } catch {
                Write-Host " ",($SYMBOL_STATE_SADFACE -join ''),"Error: Please check the recovery phrase and try again."
                continue
            }
        }
    } else {
        Animate-Text "1 : CREATING A NEW IDENTITY WITH AN ACTIVATION CODE"
        Write-Host ""
        & $UTILS_EXEC --check-drop-service; if ($LASTEXITCODE) { exit 1 }
        while ($true) {
            $INVITE_CODE = Read-Host "Enter your activation code"
            Write-Host ""
            if (-not $INVITE_CODE -or $INVITE_CODE.Length -lt 12) {
                Write-Host " ",($SYMBOL_STATE_SADFACE -join ''),"Invalid activation code. Check the code and try again."
                Write-Host ""
                continue
            } else {
                break
            }
        }
        Animate-Text "    $SYMBOL_NEWLINE Validating your identity..."
        $WALLET_UTILS_EXEC_OUTPUT = & $UTILS_EXEC --create-wallet $ACCOUNT_PRIVATE_KEY_FILE --drop-code $INVITE_CODE
        if ($LASTEXITCODE -ne 0) {
            Write-Host ($WALLET_UTILS_EXEC_OUTPUT | Select-Object -Last 1)
            Write-Host ""
            Write-Host " ",($SYMBOL_STATE_SADFACE -join ''),"This code has already been activated. Please check your code and try again. You entered: $INVITE_CODE"
            Write-Host ""
            if (Test-Path $ACCOUNT_PRIVATE_KEY_FILE) {
                Remove-Item $ACCOUNT_PRIVATE_KEY_FILE -Force
            }
            exit 1
        }
        Animate-Text "    $SYMBOL_NEWLINE Write down your new node identity:"
        $ACCOUNT_PRIVATE_KEY = Get-Content $ACCOUNT_PRIVATE_KEY_FILE
        $WALLET_UTILS_EXEC_OUTPUT
        Write-Host ""
        Animate-Text "    $SYMBOL_STATE_SUCCESS Identity configured and securely stored!"
        Write-Host ""
        Write-Host "|================= ATTENTION, NODERUNNER =================|"
        Write-Host "|                                                         |"
        Write-Host "|  1. Write down your secret recovery phrase              |"
        Write-Host "|  2. Keep your private key safe                          |"
        Write-Host "|     $SYMBOL_NEWLINE Get .account_private_key key from ./FortytwoNode/ |"
        Write-Host "|     $SYMBOL_NEWLINE Store it outside the App directory                |"
        Write-Host "|                                                         |"
        Write-Host "|  $SYMBOL_STATE_WARNING Keep the recovery phrase and private key safe.       |"
        Write-Host "|  $SYMBOL_STATE_WARNING Do not share them with anyone.                       |"
        Write-Host "|  $SYMBOL_STATE_WARNING Use them to restore your node or access your wallet. |"
        Write-Host "|  $SYMBOL_STATE_WARNING We won't be able to recover them if they are lost.   |"
        Write-Host "|                                                         |"
        Write-Host "|=========================================================|"
        Write-Host ""
        while ($true) {
            $user_input = Read-Host "To continue, please type 'I wrote down my recovery phrase'"
            if ($user_input -eq "I wrote down my recovery phrase") {
                break
            }
            Write-Host "Incorrect input. Please type 'I wrote down my recovery phrase' to continue."
        }
    }
}

function Configure-KvCache {
    Write-Host ""
    Animate-Text "1 : KV-CACHE SET-UP"
    Write-Host "    - Memory control for longer context."
    Write-Host "    - Defines how much of your system resources are allocated"
    Write-Host "      in addition to inference generation."
    Write-Host "    - Read more: https://docs.fortytwo.network/docs/how-to-pick-the-right-model-for-your-node"

    while ($true) {
        Write-Host ""
        Write-Host "[0] Default (Mode Auto)"
        Write-Host "[1] Mode (auto|min|medium|max)"
        Write-Host "[2] Size in Tokens"
        Write-Host "[3] Size in GB"
        $KV_MODE_CHOICE = Read-Host "Select an option"

        switch ($KV_MODE_CHOICE) {
            "0" {
                Write-Host ""
                Animate-Text "$SYMBOL_STATE_SUCCESS KV-Cache size is now managed automatically."
                $script:KV_CACHE_MODE = "auto"
                return
            }
            "1" {
                while ($true) {
                    Write-Host ""
                    Write-Host "Pick your desired mode:"
                    Write-Host "[0] Auto"
                    Write-Host "[1] Min (33% of available memory)"
                    Write-Host "[2] Medium (66% of available memory)"
                    Write-Host "[3] Max (100% of available memory)"
                    $MODE_OPTION = Read-Host "Select an option"

                    switch ($MODE_OPTION) {
                        "0" {
                            $script:KV_CACHE_MODE = "auto"
                            Write-Host ""
                            Animate-Text "$SYMBOL_STATE_SUCCESS KV-Cache size is set to Mode $script:KV_CACHE_MODE."
                            return
                        }
                        "1" {
                            $script:KV_CACHE_MODE = "min"
                            Write-Host ""
                            Animate-Text "$SYMBOL_STATE_SUCCESS KV-Cache size is set to Mode $script:KV_CACHE_MODE."
                            return
                        }
                        "2" {
                            $script:KV_CACHE_MODE = "medium"
                            Write-Host ""
                            Animate-Text "$SYMBOL_STATE_SUCCESS KV-Cache size is set to Mode $script:KV_CACHE_MODE."
                            return
                        }
                        "3" {
                            $script:KV_CACHE_MODE = "max"
                            Write-Host ""
                            Animate-Text "$SYMBOL_STATE_SUCCESS KV-Cache size is set to Mode $script:KV_CACHE_MODE."
                            return
                        }
                        default {
                            Write-Host ""
                            Write-Host "$SYMBOL_STATE_FAILURE Incorrect input."
                        }
                    }
                }
            }
            "2" {
                while ($true) {
                    Write-Host ""
                    $TOKEN_SIZE = Read-Host "Define your target cache in tokens, min is 1024"

                    if ($TOKEN_SIZE -match '^\d+$' -and [int]$TOKEN_SIZE -ge 1024) {
                        $script:KV_CACHE_TOKENS = $true
                        $script:KV_CACHE_TOKENS_SIZE = $TOKEN_SIZE
                        Animate-Text "$SYMBOL_STATE_SUCCESS KV-Cache size is set to $TOKEN_SIZE Tokens."
                        return
                    } else {
                        Write-Host ""
                        Write-Host "$SYMBOL_STATE_FAILURE Incorrect input."
                    }
                }
            }
            "3" {
                while ($true) {
                    Write-Host ""
                    $GB_SIZE = Read-Host "Define your target cache in GB, min is '0.3' GB"

                    if ($GB_SIZE -match '^\d+(\.\d+)?$' -and [double]$GB_SIZE -ge 0.3) {
                        $script:KV_CACHE_GB = $true
                        $script:KV_CACHE_GB_SIZE = $GB_SIZE
                        Animate-Text "$SYMBOL_STATE_SUCCESS KV-Cache size is set to '$GB_SIZE' GB."
                        return
                    } else {
                        if ([double]$GB_SIZE -lt 0.3) {
                            Write-Host "$SYMBOL_STATE_FAILURE Value must be at least 0.3 GB."
                        } else {
                            Write-Host ""
                            Write-Host "$SYMBOL_STATE_FAILURE Incorrect input."
                        }
                    }
                }
            }
            default {
                Write-Host ""
                Write-Host "$SYMBOL_STATE_FAILURE Incorrect input."
            }
        }
    }

    Write-Host ""
    Animate-Text "KV-Cache configuration completed!"
}

function Show-Settings {
    while ($true) {
        Write-Host ""
        Write-Host "0 : $SYMBOL_SETTINGS SETTINGS"
        Write-Host ""
        Write-Host "[1] KV-Cache Size"
        Write-Host "[2] Back"
        $SETTINGS_OPTION = Read-Host "Select an option"

        switch ($SETTINGS_OPTION) {
            "1" {
                Configure-KvCache
            }
            "2" {
                return
            }
            default {
                Write-Host ""
                Animate-Text "$SYMBOL_STATE_FAILURE Incorrect input."
            }
        }
    }
}

function Select-CustomModel {
    Write-Host ""
    Write-Host "|========= $SYMBOL_MODEL_CUSTOM CUSTOM MODEL IMPORT"
    Write-Host "|"
    Write-Host "|  - Intended for users familiar with language models."
    Write-Host "|  - Import from Hugging Face or import a local model."
    Write-Host "|  - GGUF model format is expected."
    Write-Host "|"
    Write-Host "|========= $SYMBOL_MODEL_CUSTOM"

    while ($true) {
        Write-Host ""
        Write-Host "[1] Hugging Face Import"
        Write-Host "[2] Local GGUF Model Import"
        Write-Host "[3] Back"
        $choice = Read-Host "Select an option"

        switch ($choice) {
            "1" {
                if (Import-FromHub) {
                    return $true
                }
            }
            "2" {
                if (Import-LocalModel) {
                    return $true
                }
            }
            "3" {
                return $false
            }
            default {
                Write-Host ""
                Write-Host "$SYMBOL_STATE_FAILURE Incorrect input."
            }
        }
    }
}

function Import-FromHub {
    Write-Host ""
    Write-Host "1 : LOADING MODEL FROM HUGGING FACE"
    Write-Host ""
    Write-Host "Step 1/2"
    Write-Host "Enter Hugging Face repository, e.g.: 'Qwen/Qwen2.5-3B-Instruct-"
    Write-Host "GGUF' (skip the quotes). Type 'Cancel' to go back."
    $repo_path = Read-Host "Define the repository"

    if ($repo_path.ToLower() -eq "cancel") {
        Write-Host ""
        Write-Host "Cancelled."
        return $false
    }
    Write-Host ""
    Write-Host "Step 2/2"
    Write-Host "Enter model filename. e.g.: 'qwen2.5-3b-instruct-q4_k_m.gguf'"
    Write-Host "(skip the quotes). For models with multiple files, include the "
    Write-Host "subpath and define the first one, e.g. 'Q4_K_M/gpt-oss-120b-"
    Write-Host "Q4_K_M-00001-of-00002.gguf'."
    Write-Host "Type 'Cancel' to go back."
    $model_filename = Read-Host "Enter model filename"

    if ($model_filename.ToLower() -eq "cancel") {
        Write-Host ""
        Write-Host "Cancelled."
        return $false
    }

    Write-Host ""
    Write-Host "$SYMBOL_STATE_SUCCESS Model linked successfully"

    $script:LLM_HF_REPO = $repo_path
    $script:LLM_HF_MODEL_NAME = $model_filename
    $script:NODE_NAME = "$SYMBOL_MODEL_CUSTOM CUSTOM IMPORT: HuggingFace $($repo_path -split '/' | Select-Object -Last 1)"

    return $true
}

function Import-LocalModel {
    Write-Host ""
    Write-Host "2 : LOADING MODEL FROM CUSTOM LOCATION"
    Write-Host ""
    Write-Host "Define the path to the model in form of 'C:\Users\Username\Downloads\"
    Write-Host "qwen2.5-3b-instruct-q4_k_m.gguf' (skip the quotes). For models with"
    Write-Host "multiple files, define the first one, e.g. 'C:\Users\Username\"
    Write-Host "Downloads\gpt-oss-120b-Q4_K_M-00001-of-00002.gguf'."
    Write-Host "Type 'Cancel' to go back."
    $model_path = Read-Host "Define the path"

    if ($model_path.ToLower() -eq "cancel") {
        Write-Host ""
        Write-Host "Cancelled."
        return $false
    }

    if (-not (Test-Path $model_path)) {
        Write-Host ""
        Write-Host "$SYMBOL_STATE_FAILURE Cannot reach the defined path."
        return $false
    }

    if ($model_path -notmatch '\.gguf$') {
        Write-Host ""
        Write-Host "$SYMBOL_STATE_FAILURE Defined file is not in GGUF format. Currently only the GGUF model file format is supported."
        return $false
    }

    Write-Host ""
    Write-Host "$SYMBOL_STATE_SUCCESS Model found successfully"

    $script:LLM_IS_LOCAL_PATH = $true
    $script:LLM_LOCAL_PATH = $model_path
    $script:NODE_NAME = "$SYMBOL_MODEL_CUSTOM CUSTOM IMPORT: FROM CUSTOM LOCATION $(Split-Path $model_path -Leaf)"

    return $true
}

function Select-NodeModel {
    Write-Host ""
    Animate-Text ($SYMBOL_HEADER_IN -join ''),"The Unique Strength of Your Node",($SYMBOL_HEADER_OUT -join '')
    Write-Host ""
    Animate-Text "Choose how your node will contribute its unique strengths to the collective intelligence."
    Write-Host ""
    Auto-Select-Model
    Write-Host ""
    Animate-Text "Use setup assist options [0-2] or pick an option from three model tiers [3-23]:"
    Write-Host ""
    Write-Host "|========= SETUP ASSIST OPTIONS ========================================|"
    Animate-Text-x2 "| 0 $SYMBOL_SETTINGS SETTINGS                                                          |"
    Write-Host "|=======================================================================|"
    Animate-Text-x2 "| 1 $SYMBOL_MODEL_AUTOSELECT AUTO-SELECT - Optimal configuration                               |"
    Write-Host "|     Let the system determine the best model for your hardware.        |"
    Write-Host "|     Balanced for performance and capabilities.                        |"
    Write-Host "|=======================================================================|"
    Animate-Text-x2 "| 2 $SYMBOL_MODEL_CUSTOM IMPORT CUSTOM - Advanced configuration                            |"
    Write-Host "|=======================================================================|"
    Write-Host ""
    Write-Host "|========= EXTREME TIER | Models with very high memory requirements"
    Animate-Text-x2 "| 3 $SYMBOL_MODEL_SELECTED SUPERIOR GENERALIST"
    Write-Host "|     65.9 GB $MEMORY_TYPE $SYMBOL_SEPARATOR_DOT GPT-oss 120B Q4"
    Write-Host "|     Frontier-level multi-step answers across coding, math, science,"
    Write-Host "|     general knowledge questions."
    Write-Host "|"
    Animate-Text-x2 "| 4 $SYMBOL_MODEL_SELECTED SUPERIOR GENERALIST"
    Write-Host "|     76.5 GB $MEMORY_TYPE $SYMBOL_SEPARATOR_DOT GLM-4.5-Air Q4"
    Write-Host "|     Deliberate multi-step reasoning in logic, math, and coding;"
    Write-Host "|     excels at clear, long-form breakdowns of complex questions."
    Write-Host "|"
    Animate-Text-x2 "| 5 $SYMBOL_MODEL_SELECTED SUPERIOR GENERALIST"
    Write-Host "|     31.7 GB $MEMORY_TYPE $SYMBOL_SEPARATOR_DOT Nemotron-Super-49B-v1.5 Q4"
    Write-Host "|     High-precision multi-step reasoning in general domains, math and"
    Write-Host "|     coding; produces clear step-by-step solutions to complex problems."
    Write-Host "|========= EXTREME TIER END"
    Write-Host ""
    Write-Host "|========= HEAVY TIER | Dedicating all Compute to the Node"
    Animate-Text-x2 "| 6 $SYMBOL_MODEL_SELECTED ADVANCED REASONING"
    Write-Host "|     19.5 GB $MEMORY_TYPE $SYMBOL_SEPARATOR_DOT Qwen3 30B A3B Thinking 2507 Q4"
    Write-Host "|     Long-context reasoning at high efficiency, with steady logic,"
    Write-Host "|     math, and coding across large inputs."
    Write-Host "|"
    Animate-Text-x2 "| 7 $SYMBOL_MODEL_SELECTED PROGRAMMING & ALGORITHMS"
    Write-Host "|     19.5 GB $MEMORY_TYPE $SYMBOL_SEPARATOR_DOT Qwen3-Coder-30B-A3B-Instruct Q4"
    Write-Host "|     Writes robust, well-structured code with step-by-step reasoning;"
    Write-Host "|     handles large, multi-file tasks and refactors."
    Write-Host "|"
    Animate-Text-x2 "| 8 $SYMBOL_MODEL_SELECTED ADVANCED GENERALIST"
    Write-Host "|     12.2 GB $MEMORY_TYPE $SYMBOL_SEPARATOR_DOT gpt-oss-20b Q4"
    Write-Host "|     Fast, capable multi-domain reasoning;"
    Write-Host "|     solid for day-to-day coding, math, and research."
    Write-Host "|"
    Animate-Text-x2 "| 9 $SYMBOL_MODEL_SELECTED MATH, SCIENCE & CODING"
    Write-Host "|     20.9 GB $MEMORY_TYPE $SYMBOL_SEPARATOR_DOT OpenReasoning Nemotron 32B Q4"
    Write-Host "|     Meticulous step-by-step logic in math, science and code;"
    Write-Host "|     great for explainable solutions and error analysis."
    Write-Host "|"
    Animate-Text-x2 "| 10 $SYMBOL_MODEL_SELECTED ADVANCED GENERALIST"
    Write-Host "|     20.3 GB $MEMORY_TYPE $SYMBOL_SEPARATOR_DOT EXAONE 4.0 32B Q4"
    Write-Host "|     Strong science and world knowledge with dependable math and coding;"
    Write-Host "|     clear, well-grounded explanations."
    Write-Host "|"
    Animate-Text-x2 "| 11 $SYMBOL_MODEL_SELECTED PROGRAMMING & ALGORITHMS"
    Write-Host "|     20.9 GB $MEMORY_TYPE $SYMBOL_SEPARATOR_DOT OlympicCoder 32B Q4"
    Write-Host "|     Excels at contest-style algorithms;"
    Write-Host "|     produces correct, efficient code with clear step-by-step reasoning."
    Write-Host "|"
    Animate-Text-x2 "| 12 $SYMBOL_MODEL_SELECTED ADVANCED REASONING"
    Write-Host "|     9.6 GB $MEMORY_TYPE $SYMBOL_SEPARATOR_DOT Apriel-Nemotron-15b-Thinker Q4"
    Write-Host "|     Deliberate, reflective multi-step reasoning across mixed tasks;"
    Write-Host "|     steady performance on logic, math, and coding."
    Write-Host "|========= HEAVY TIER END"
    Write-Host ""
    Write-Host "|========= LIGHT TIER | Operating the Node in Background"
    Animate-Text-x2 "| 13 $SYMBOL_MODEL_SELECTED EVERYDAY GENERALIST"
    Write-Host "|     9.6 GB $MEMORY_TYPE $SYMBOL_SEPARATOR_DOT Qwen3 14B Q4"
    Write-Host "|     Balanced everyday reasoning with multilingual support;"
    Write-Host "|     clear, reliable answers across common topics."
    Write-Host "|"
    Animate-Text-x2 "| 14 $SYMBOL_MODEL_SELECTED EVERYDAY GENERALIST"
    Write-Host "|     5.4 GB $MEMORY_TYPE $SYMBOL_SEPARATOR_DOT Qwen3 8B Q4"
    Write-Host "|     Smooth daily Q&A with concise reasoning;"
    Write-Host "|     dependable on summaries, explanations, and light code."
    Write-Host "|"
    Animate-Text-x2 "| 15 $SYMBOL_MODEL_SELECTED MULTILINGUAL GENERALIST"
    Write-Host "|     7.7 GB $MEMORY_TYPE $SYMBOL_SEPARATOR_DOT Gemma-3 4B Q4"
    Write-Host "|     Multilingual chat with long-context support;"
    Write-Host "|     dependable everyday assistant with clear explanations."
    Write-Host "|"
    Animate-Text-x2 "| 16 $SYMBOL_MODEL_SELECTED PROGRAMMING & ALGORITHMS"
    Write-Host "|     9.3 GB $MEMORY_TYPE $SYMBOL_SEPARATOR_DOT DeepCoder 14B Q4"
    Write-Host "|     Generates accurate code and understands complex programming logic;"
    Write-Host "|     reliable for feature drafts and fixes."
    Write-Host "|"
    Animate-Text-x2 "| 17 $SYMBOL_MODEL_SELECTED PROGRAMMING & ALGORITHMS"
    Write-Host "|     4.8 GB $MEMORY_TYPE $SYMBOL_SEPARATOR_DOT OlympicCoder 7B Q4"
    Write-Host "|     Balanced coding contest solver;"
    Write-Host "|     step-by-step algorithmic reasoning and efficient code."
    Write-Host "|"
    Animate-Text-x2 "| 18 $SYMBOL_MODEL_SELECTED MATH & FORMAL LOGIC"
    Write-Host "|     9.3 GB $MEMORY_TYPE $SYMBOL_SEPARATOR_DOT OpenMath-Nemotron 14B Q4"
    Write-Host "|     Excels at math questions and structured problem-solving;"
    Write-Host "|     clear steps for academic and competition problems."
    Write-Host "|"
    Animate-Text-x2 "| 19 $SYMBOL_MODEL_SELECTED MATH & CODING"
    Write-Host "|     4.9 GB $MEMORY_TYPE $SYMBOL_SEPARATOR_DOT AceReason-Nemotron-1.1-7B Q4"
    Write-Host "|     Handles math and logic puzzles with minimal resources;"
    Write-Host "|     concise, step-by-step solutions."
    Write-Host "|"
    Animate-Text-x2 "| 20 $SYMBOL_MODEL_SELECTED THEOREM PROVER"
    Write-Host "|     5.4 GB $MEMORY_TYPE $SYMBOL_SEPARATOR_DOT Kimina Prover Distill 8B Q4"
    Write-Host "|     Specialist in formal logic and proof steps;"
    Write-Host "|     ideal for theorem-style tasks and verification."
    Write-Host "|"
    Animate-Text-x2 "| 21 $SYMBOL_MODEL_SELECTED RUST PROGRAMMING"
    Write-Host "|     9 GB $MEMORY_TYPE $SYMBOL_SEPARATOR_DOT Strand-Rust-Coder 14B Q4"
    Write-Host "|     Built by Fortytwo:"
    Write-Host "|     Rust specialist that outputs idiomatic, compile-ready code and"
    Write-Host "|     handles fixes/refactors; state-of-the-art on Rust benchmarks."
    Write-Host "|"
    Animate-Text-x2 "| 22 $SYMBOL_MODEL_SELECTED MEDICAL EXPERT"
    Write-Host "|     5.4 GB $MEMORY_TYPE $SYMBOL_SEPARATOR_DOT II-Medical-8B Q5"
    Write-Host "|     Works through clinical Q&A step by step;"
    Write-Host "|     useful for study and drafting (non-diagnostic)."
    Write-Host "|"
    Animate-Text-x2 "| 23 $SYMBOL_MODEL_SELECTED LOW MEMORY MODEL"
    Write-Host "|     1.3 GB $MEMORY_TYPE $SYMBOL_SEPARATOR_DOT Qwen3 1.7B Q4"
    Write-Host "|     Ultra-efficient for basic instructions and quick answers;"
    Write-Host "|     suitable for nodes with tight memory."
    Write-Host "|"
    Animate-Text-x2 "| 24 $SYMBOL_MODEL_SELECTED LOW MEMORY MODEL"
    Write-Host "|     1.2 GB $MEMORY_TYPE $SYMBOL_SEPARATOR_DOT VibeThinker 1.5B Q4"
    Write-Host "|     Efficient reasoning performance with math and coding problems;"
    Write-Host "|     suitable for nodes with limited memory."
    Write-Host "|========= LIGHT TIER END"
    while ($true) {
        Write-Host ""
        Write-Host "[0] Settings"
        Write-Host "[1] Auto"
        Write-Host "[2] Import"
        Write-Host "[3-24] Specialized Model"
        $NODE_CLASS = Read-Host "Select your node's specialization option"

        $exit = $false

        switch ($NODE_CLASS) {
            "0" {
                Show-Settings
                Select-NodeModel
                $exit = $true
            }
            "1" {
                Write-Host ""
                Write-Host "1 : $SYMBOL_MODEL_AUTOSELECT AUTO-SELECT"
                Write-Host ""
                Animate-Text " $SYMBOL_MODEL_AUTOSELECT Analyzing system for optimal configuration:"
                Auto-Select-Model
                $exit = $true
            }
            "2" {
                if (-not (Select-CustomModel)) {
                    Select-NodeModel
                } else {
                    $exit = $true
                }
            }
            "3" {
                $script:LLM_HF_REPO = "unsloth/gpt-oss-120b-GGUF"
                $script:LLM_HF_MODEL_NAME = "Q4_K_M/gpt-oss-120b-Q4_K_M-00001-of-00002.gguf"
                $script:NODE_NAME = " $SYMBOL_MODEL_SELECTED SUPERIOR GENERALIST: gpt-oss-120b Q4"
                $exit = $true
            }
            "4" {
                $script:LLM_HF_REPO = "unsloth/GLM-4.5-Air-GGUF"
                $script:LLM_HF_MODEL_NAME = "Q4_K_M/GLM-4.5-Air-Q4_K_M-00001-of-00002.gguf"
                $script:NODE_NAME = " $SYMBOL_MODEL_SELECTED SUPERIOR GENERALIST: GLM-4.5-Air Q4"
                $exit = $true
            }
            "5" {
                $script:LLM_HF_REPO = "unsloth/Llama-3_3-Nemotron-Super-49B-v1_5-GGUF"
                $script:LLM_HF_MODEL_NAME = "Llama-3_3-Nemotron-Super-49B-v1_5-Q4_K_M.gguf"
                $script:NODE_NAME = " $SYMBOL_MODEL_SELECTED SUPERIOR GENERALIST: Nemotron-Super-49B-v1.5 Q4"
                $exit = $true
            }
            "6" {
                $script:LLM_HF_REPO = "unsloth/Qwen3-30B-A3B-Thinking-2507-GGUF"
                $script:LLM_HF_MODEL_NAME = "Qwen3-30B-A3B-Thinking-2507-Q4_K_M.gguf"
                $script:NODE_NAME = " $SYMBOL_MODEL_SELECTED ADVANCED REASONING: Qwen3 30B A3B Thinking 2507 Q4"
                $exit = $true
            }
            "7" {
                $script:LLM_HF_REPO = "unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF"
                $script:LLM_HF_MODEL_NAME = "Qwen3-Coder-30B-A3B-Instruct-Q4_K_M.gguf"
                $script:NODE_NAME = " $SYMBOL_MODEL_SELECTED PROGRAMMING & ALGORITHMS: Qwen3-Coder-30B-A3B-Instruct Q4"
                $exit = $true
            }
            "8" {
                $script:LLM_HF_REPO = "unsloth/gpt-oss-20b-GGUF"
                $script:LLM_HF_MODEL_NAME = "gpt-oss-20b-Q4_K_M.gguf"
                $script:NODE_NAME = " $SYMBOL_MODEL_SELECTED ADVANCED GENERALIST: gpt-oss-20b Q4"
                $exit = $true
            }
            "9" {
                $script:LLM_HF_REPO = "unsloth/OpenReasoning-Nemotron-32B-GGUF"
                $script:LLM_HF_MODEL_NAME = "OpenReasoning-Nemotron-32B-Q4_K_M.gguf"
                $script:NODE_NAME = " $SYMBOL_MODEL_SELECTED MATH, SCIENCE & CODING: OpenReasoning Nemotron 32B Q4"
                $exit = $true
            }
            "10" {
                $script:LLM_HF_REPO = "LGAI-EXAONE/EXAONE-4.0-32B-GGUF"
                $script:LLM_HF_MODEL_NAME = "LGAI-EXAONE_EXAONE-4.0-32B-Q4_K_M.gguf"
                $script:NODE_NAME = " $SYMBOL_MODEL_SELECTED ADVANCED GENERALIST: EXAONE 4.0 32B Q4"
                $exit = $true
            }
            "11" {
                $script:LLM_HF_REPO = "bartowski/open-r1_OlympicCoder-32B-GGUF"
                $script:LLM_HF_MODEL_NAME = "open-r1_OlympicCoder-32B-Q4_K_M.gguf"
                $script:NODE_NAME = " $SYMBOL_MODEL_SELECTED PROGRAMMING & ALGORITHMS: OlympicCoder 32B Q4"
                $exit = $true
            }
            "12" {
                $script:LLM_HF_REPO = "bartowski/ServiceNow-AI_Apriel-Nemotron-15b-Thinker-GGUF"
                $script:LLM_HF_MODEL_NAME = "ServiceNow-AI_Apriel-Nemotron-15b-Thinker-Q4_K_M.gguf"
                $script:NODE_NAME = " $SYMBOL_MODEL_SELECTED ADVANCED REASONING: Apriel-Nemotron-15b-Thinker Q4"
                $exit = $true
            }
            "13" {
                $script:LLM_HF_REPO = "unsloth/Qwen3-14B-GGUF"
                $script:LLM_HF_MODEL_NAME = "Qwen3-14B-Q4_K_M.gguf"
                $script:NODE_NAME = " $SYMBOL_MODEL_SELECTED EVERYDAY GENERALIST: Qwen3 14B Q4"
                $exit = $true
            }
            "14" {
                $script:LLM_HF_REPO = "unsloth/Qwen3-8B-GGUF"
                $script:LLM_HF_MODEL_NAME = "Qwen3-8B-Q4_K_M.gguf"
                $script:NODE_NAME = " $SYMBOL_MODEL_SELECTED EVERYDAY GENERALIST: Qwen3 8B Q4"
                $exit = $true
            }
            "15" {
                $script:LLM_HF_REPO = "unsloth/gemma-3-12b-it-GGUF"
                $script:LLM_HF_MODEL_NAME = "gemma-3-12b-it-Q4_K_M.gguf"
                $script:NODE_NAME = " $SYMBOL_MODEL_SELECTED MULTILINGUAL GENERALIST: Gemma-3 4B Q4"
                $exit = $true
            }
            "16" {
                $script:LLM_HF_REPO = "bartowski/agentica-org_DeepCoder-14B-Preview-GGUF"
                $script:LLM_HF_MODEL_NAME = "agentica-org_DeepCoder-14B-Preview-Q4_K_M.gguf"
                $script:NODE_NAME = " $SYMBOL_MODEL_SELECTED PROGRAMMING & ALGORITHMS: DeepCoder 14B Q4"
                $exit = $true
            }
            "17" {
                $script:LLM_HF_REPO = "bartowski/open-r1_OlympicCoder-7B-GGUF"
                $script:LLM_HF_MODEL_NAME = "open-r1_OlympicCoder-7B-Q4_K_M.gguf"
                $script:NODE_NAME = " $SYMBOL_MODEL_SELECTED PROGRAMMING & ALGORITHMS: OlympicCoder 7B Q4"
                $exit = $true
            }
            "18" {
                $script:LLM_HF_REPO = "bartowski/nvidia_OpenMath-Nemotron-14B-GGUF"
                $script:LLM_HF_MODEL_NAME = "nvidia_OpenMath-Nemotron-14B-Q4_K_M.gguf"
                $script:NODE_NAME = " $SYMBOL_MODEL_SELECTED MATH & FORMAL LOGIC: OpenMath-Nemotron 14B Q4"
                $exit = $true
            }
            "19" {
                $script:LLM_HF_REPO = "bartowski/nvidia_AceReason-Nemotron-1.1-7B-GGUF"
                $script:LLM_HF_MODEL_NAME = "nvidia_AceReason-Nemotron-1.1-7B-Q4_K_M.gguf"
                $script:NODE_NAME = " $SYMBOL_MODEL_SELECTED MATH & CODING: AceReason-Nemotron-1.1-7B Q4"
                $exit = $true
            }
            "20" {
                $script:LLM_HF_REPO = "mradermacher/Kimina-Prover-Distill-8B-GGUF"
                $script:LLM_HF_MODEL_NAME = "Kimina-Prover-Distill-8B.Q4_K_M.gguf"
                $script:NODE_NAME = " $SYMBOL_MODEL_SELECTED THEOREM PROVER: Kimina Prover Distill 8B Q4"
                $exit = $true
            }
            "21" {
                $script:LLM_HF_REPO = "Fortytwo-Network/Strand-Rust-Coder-14B-v1-GGUF"
                $script:LLM_HF_MODEL_NAME = "Fortytwo_Strand-Rust-Coder-14B-v1-Q4_K_M.gguf"
                $script:NODE_NAME = " $SYMBOL_MODEL_SELECTED RUST PROGRAMMING: Strand-Rust-Coder 14B Q4"
                $exit = $true
            }
            "22" {
                $script:LLM_HF_REPO = "Intelligent-Internet/II-Medical-8B-1706-GGUF"
                $script:LLM_HF_MODEL_NAME = "II-Medical-8B-1706.Q4_K_M.gguf"
                $script:NODE_NAME = " $SYMBOL_MODEL_SELECTED MEDICAL EXPERT: II-Medical-8B Q5"
                $exit = $true
            }
            "23" {
                $script:LLM_HF_REPO = "unsloth/Qwen3-1.7B-GGUF"
                $script:LLM_HF_MODEL_NAME = "Qwen3-1.7B-Q4_K_M.gguf"
                $script:NODE_NAME = " $SYMBOL_MODEL_SELECTED LOW MEMORY MODEL: Qwen3 1.7B Q4"
                $exit = $true
            }
            "24" {
                $script:LLM_HF_REPO = "mradermacher/VibeThinker-1.5B-GGUF"
                $script:LLM_HF_MODEL_NAME = "VibeThinker-1.5B.Q4_K_M.gguf"
                $script:NODE_NAME = " $SYMBOL_MODEL_SELECTED LOW MEMORY MODEL: VibeThinker 1.5B Q4"
                $exit = $true
            }
            Default {
                Write-Host ""
                Write-Host "$SYMBOL_STATE_FAILURE Incorrect input."
                continue
            }
        }
        if ($exit) { break }
    }

    Write-Host ""
    Write-Host "Model selected:"
    Animate-Text "${NODE_NAME}"
}

Select-NodeModel
if ($LLM_IS_LOCAL_PATH -eq $false) {
    Animate-Text "    $SYMBOL_NEWLINE Downloading the model and preparing the environment may take several minutes..."
    & $UTILS_EXEC --hf-repo $LLM_HF_REPO --hf-model-name $LLM_HF_MODEL_NAME --model-cache $PROJECT_MODEL_CACHE_DIR
    Write-Host ""
}
Animate-Text "Setup completed. Ready to launch."
# clear
Animate-Text-x2 ($BANNER_FULLNAME -join '')
Write-Host ""

function Node-Startup {
    Animate-Text " $SYMBOL_COMP_CAPSULE Starting Capsule..."

    $CMD_ARGS = @(
        "--model-cache", $PROJECT_MODEL_CACHE_DIR,
        "--kv-size-mode", $KV_CACHE_MODE
    )

    if ($LLM_IS_LOCAL_PATH -eq $true) {
        $CMD_ARGS += "--llm-model-path"
        $CMD_ARGS += $LLM_LOCAL_PATH
    } else {
        $CMD_ARGS += "--llm-hf-repo"
        $CMD_ARGS += $LLM_HF_REPO
        $CMD_ARGS += "--llm-hf-model-name"
        $CMD_ARGS += $LLM_HF_MODEL_NAME
    }

    if ($KV_CACHE_TOKENS -eq $true) {
        $CMD_ARGS += "--kv-size-tokens"
        $CMD_ARGS += $KV_CACHE_TOKENS_SIZE
    }

    if ($KV_CACHE_GB -eq $true) {
        $CMD_ARGS += "--kv-size-gb"
        $CMD_ARGS += $KV_CACHE_GB_SIZE
    }

    $global:CAPSULE_PROC = Start-Process -FilePath $CAPSULE_EXEC -ArgumentList $CMD_ARGS -PassThru -RedirectStandardOutput $CAPSULE_LOGS -RedirectStandardError $CAPSULE_ERR_LOGS -NoNewWindow
    Animate-Text "Be patient, it may take some time."
    while ($true) {
        if ($global:CAPSULE_PROC.HasExited) {
            Write-Host " $SYMBOL_COMP_CAPSULE Capsule process exited (exit code: $($global:CAPSULE_PROC.ExitCode))" -ForegroundColor Red
            try {
                Get-Content $CAPSULE_LOGS -Tail 1
            } catch {
                # pass
            }
            try {
                Get-Content $CAPSULE_ERR_LOGS -Tail 1
            } catch {
            # pass
            }
            exit 1
        }
        try {
            $STATUS_CODE = (Invoke-WebRequest -Uri $CAPSULE_READY_URL -UseBasicParsing -ErrorAction Stop).StatusCode
            if ($STATUS_CODE -eq 200) {
                Animate-Text "Capsule is ready."
                break
            }
        } catch {
            # Just Ignore Error
        }

        Start-Sleep -Seconds 5
    }
    Animate-Text " $SYMBOL_COMP_NODE Starting Protocol..."
    Write-Host "" 
    Animate-Text "Joining ::||"
    Write-Host "" 
    $global:PROTOCOL_PROC = Start-Process -FilePath $PROTOCOL_EXEC -ArgumentList "--account-private-key $ACCOUNT_PRIVATE_KEY" -PassThru -NoNewWindow
}

Node-Startup
while ($true) {
    $IsAlive = $true
    $CAPSULE_PROC.Refresh()
    $PROTOCOL_PROC.Refresh()

    # Check if Capsule process is running
    if (-not (Get-Process -Id $CAPSULE_PROC.Id -ErrorAction SilentlyContinue)) {
        Write-Host ""
        Write-Output " $SYMBOL_COMP_CAPSULE Capsule has stopped. Restarting..."
        $IsAlive = $false
    }

    # Check if Protocol process is running
    if (-not (Get-Process -Id $PROTOCOL_PROC.Id -ErrorAction SilentlyContinue)) {
        $PROTOCOL_EXIT_CODE = $PROTOCOL_PROC.ExitCode
        Write-Host ""
        Write-Output " $SYMBOL_COMP_NODE Node has stopped. Restarting..."
        $PROTOCOL_VERSION = (Invoke-RestMethod "https://download.swarminference.io/protocol/latest").Trim()
        if (-not($CURRENT_PROTOCOL_VERSION_OUTPUT -match $PROTOCOL_VERSION)) {
            Write-Output " $SYMBOL_STATE_WARNING New protocol version is available!"
            Animate-Text " $SYMBOL_COMP_NODE Protocol Node - version $PROTOCOL_VERSION"
            $DOWNLOAD_PROTOCOL_URL = "https://download.swarminference.io/protocol/v$PROTOCOL_VERSION/FortytwoProtocolNode-windows-amd64.exe"
            Animate-Text "    $SYMBOL_NEWLINE Updating..."
            Start-BitsTransfer -Source $DOWNLOAD_PROTOCOL_URL -Destination $PROTOCOL_EXEC
            Animate-Text "    $SYMBOL_STATE_SUCCESS Successfully updated"
        }
        $IsAlive = $false
    }

    # Restart logic
    if (-not $IsAlive) {
        Write-Host ""
        Write-Output " $SYMBOL_STATE_WARNING Capsule or Protocol process has stopped. Restarting..."

        # Kill processes if they exist
        if ($CAPSULE_PROC -and $CAPSULE_PROC.HasExited -eq $false) {
            Write-Output " $SYMBOL_COMP_CAPSULE Stopping Capsule before restart..."
            Stop-Process -Id $CAPSULE_PROC.Id -Force -ErrorAction SilentlyContinue
        }
    
        if ($PROTOCOL_PROC -and $PROTOCOL_PROC.HasExited -eq $false) {
            Write-Output " $SYMBOL_COMP_NODE Stopping Node before restart..."
            Stop-Process -Id $PROTOCOL_PROC.Id -Force -ErrorAction SilentlyContinue
        }
    
        # Call startup function (you need to define this)
        Node-Startup
    }

    Start-Sleep -Seconds 5
}
