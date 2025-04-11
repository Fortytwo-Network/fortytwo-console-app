function Animate-Text {
    param (
        [string]$text
    )

    foreach ($char in $text.ToCharArray()) {
        Write-Host -NoNewline $char
        Start-Sleep -Milliseconds 10
    }
    Write-Host ""
}


function Auto-Select-Model {
    $AVAILABLE_MEM = $null

    if (Get-Command nvidia-smi -ErrorAction SilentlyContinue) {
        $AVAILABLE_MEM = ((nvidia-smi --query-gpu=memory.free --format=csv,noheader,nounits | Select-Object -First 1) -as [double]) / 1024
        Animate-Text "System analysis: $AVAILABLE_MEM GB VRAM detected"
    } else {
        $TotalMemoryKB = [double]((Get-CimInstance Win32_OperatingSystem).TotalVisibleMemorySize)
        $AVAILABLE_MEM = $TotalMemoryKB / 1024 / 1024  # Перевод в ГБ
        Animate-Text "System analysis: $AVAILABLE_MEM GB RAM detected"
    }

    $AVAILABLE_MEM_INT = [math]::Round($AVAILABLE_MEM)
    if ($AVAILABLE_MEM_INT -ge 22) {
        Animate-Text "Recommended: SAPIENCE PYLON for problem solving & logical reasoning"
        $global:LLM_HF_REPO = "Qwen/Qwen2.5-Coder-32B-Instruct-GGUF"
        $global:LLM_HF_MODEL_NAME = "qwen2.5-coder-32b-instruct-q4_k_m-00001-of-00003.gguf"
        $global:NODE_NAME = "SAPIENCE PYLON"
    } elseif ($AVAILABLE_MEM_INT -ge 16) {
        Animate-Text "Recommended: NUMERICON PYLON for mathematical intelligence"
        $global:LLM_HF_REPO = "unsloth/phi-4-GGUF"
        $global:LLM_HF_MODEL_NAME = "phi-4-Q4_K_M.gguf"
        $global:NODE_NAME = "NUMERICON PYLON"
    } elseif ($AVAILABLE_MEM_INT -ge 8) {
        Animate-Text "Recommended: NOUMENAL PYLON for balanced capability"
        $global:LLM_HF_REPO = "bartowski/Llama-3.2-3B-Instruct-GGUF"
        $global:LLM_HF_MODEL_NAME = "Llama-3.2-3B-Instruct-Q4_K_M.gguf"
        $global:NODE_NAME = "NOUMENAL PYLON"
    } else {
        Animate-Text "Recommended: NEXUS optimized for efficiency"
        $global:LLM_HF_REPO = "Qwen/Qwen2.5-1.5B-Instruct-GGUF"
        $global:LLM_HF_MODEL_NAME = "qwen2.5-1.5b-instruct-q4_k_m.gguf"
        $global:NODE_NAME = "Nexus-Compact"
    }
}


$BANNER = [char[]]@(0x000A, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x0020, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x0020, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x0020, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x2588, 0x2588, 0x2557, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2557, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x2588, 0x2588, 0x2557, 0x0020, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2557, 0x0020, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x000A, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x2550, 0x2550, 0x255D, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x2550, 0x2588, 0x2588, 0x2557, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x2588, 0x2588, 0x2557, 0x255A, 0x2550, 0x2550, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x255D, 0x255A, 0x2588, 0x2588, 0x2557, 0x0020, 0x2588, 0x2588, 0x2554, 0x255D, 0x255A, 0x2550, 0x2550, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x255D, 0x2588, 0x2588, 0x2551, 0x0020, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x2550, 0x2588, 0x2588, 0x2557, 0x000A, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2554, 0x255D, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x0020, 0x0020, 0x0020, 0x0020, 0x255A, 0x2588, 0x2588, 0x2588, 0x2588, 0x2554, 0x255D, 0x0020, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x0020, 0x2588, 0x2557, 0x0020, 0x2588, 0x2588, 0x2551, 0x2588, 0x2588, 0x2551, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x000A, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x255D, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x2588, 0x2588, 0x2557, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x0020, 0x0020, 0x0020, 0x0020, 0x0020, 0x255A, 0x2588, 0x2588, 0x2554, 0x255D, 0x0020, 0x0020, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x2588, 0x2588, 0x2588, 0x2557, 0x2588, 0x2588, 0x2551, 0x2588, 0x2588, 0x2551, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x000A, 0x2588, 0x2588, 0x2551, 0x0020, 0x0020, 0x0020, 0x0020, 0x0020, 0x255A, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2554, 0x255D, 0x2588, 0x2588, 0x2551, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x0020, 0x0020, 0x0020, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x0020, 0x0020, 0x0020, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x0020, 0x0020, 0x0020, 0x255A, 0x2588, 0x2588, 0x2588, 0x2554, 0x2588, 0x2588, 0x2588, 0x2554, 0x255D, 0x255A, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2554, 0x255D, 0x000A, 0x255A, 0x2550, 0x255D, 0x0020, 0x0020, 0x0020, 0x0020, 0x0020, 0x0020, 0x255A, 0x2550, 0x2550, 0x2550, 0x2550, 0x2550, 0x255D, 0x0020, 0x255A, 0x2550, 0x255D, 0x0020, 0x0020, 0x255A, 0x2550, 0x255D, 0x0020, 0x0020, 0x0020, 0x255A, 0x2550, 0x255D, 0x0020, 0x0020, 0x0020, 0x0020, 0x0020, 0x0020, 0x255A, 0x2550, 0x255D, 0x0020, 0x0020, 0x0020, 0x0020, 0x0020, 0x0020, 0x255A, 0x2550, 0x255D, 0x0020, 0x0020, 0x0020, 0x0020, 0x255A, 0x2550, 0x2550, 0x255D, 0x255A, 0x2550, 0x2550, 0x255D, 0x0020, 0x0020, 0x255A, 0x2550, 0x2550, 0x2550, 0x2550, 0x2550, 0x255D, 0x000A, 0x000A, 0x2588, 0x2588, 0x2588, 0x2557, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2557, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x2588, 0x2588, 0x2557, 0x0020, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2557, 0x0020, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x0020, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x0020, 0x2588, 0x2588, 0x2557, 0x0020, 0x0020, 0x2588, 0x2588, 0x2557, 0x000A, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x2550, 0x2550, 0x255D, 0x255A, 0x2550, 0x2550, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x255D, 0x2588, 0x2588, 0x2551, 0x0020, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x2550, 0x2588, 0x2588, 0x2557, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x2588, 0x2588, 0x2557, 0x2588, 0x2588, 0x2551, 0x0020, 0x2588, 0x2588, 0x2554, 0x255D, 0x000A, 0x2588, 0x2588, 0x2554, 0x2588, 0x2588, 0x2557, 0x0020, 0x2588, 0x2588, 0x2551, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x0020, 0x0020, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x0020, 0x2588, 0x2557, 0x0020, 0x2588, 0x2588, 0x2551, 0x2588, 0x2588, 0x2551, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2554, 0x255D, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2554, 0x255D, 0x000A, 0x2588, 0x2588, 0x2551, 0x255A, 0x2588, 0x2588, 0x2557, 0x2588, 0x2588, 0x2551, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x255D, 0x0020, 0x0020, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x2588, 0x2588, 0x2588, 0x2557, 0x2588, 0x2588, 0x2551, 0x2588, 0x2588, 0x2551, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x2588, 0x2588, 0x2554, 0x2550, 0x2550, 0x2588, 0x2588, 0x2557, 0x2588, 0x2588, 0x2554, 0x2550, 0x2588, 0x2588, 0x2557, 0x000A, 0x2588, 0x2588, 0x2551, 0x0020, 0x255A, 0x2588, 0x2588, 0x2588, 0x2588, 0x2551, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2557, 0x0020, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x0020, 0x0020, 0x0020, 0x255A, 0x2588, 0x2588, 0x2588, 0x2554, 0x2588, 0x2588, 0x2588, 0x2554, 0x255D, 0x255A, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2588, 0x2554, 0x255D, 0x2588, 0x2588, 0x2551, 0x0020, 0x0020, 0x2588, 0x2588, 0x2551, 0x2588, 0x2588, 0x2551, 0x0020, 0x0020, 0x2588, 0x2588, 0x2557, 0x000A, 0x255A, 0x2550, 0x255D, 0x0020, 0x0020, 0x255A, 0x2550, 0x2550, 0x2550, 0x255D, 0x255A, 0x2550, 0x2550, 0x2550, 0x2550, 0x2550, 0x2550, 0x255D, 0x0020, 0x0020, 0x0020, 0x255A, 0x2550, 0x255D, 0x0020, 0x0020, 0x0020, 0x0020, 0x255A, 0x2550, 0x2550, 0x255D, 0x255A, 0x2550, 0x2550, 0x255D, 0x0020, 0x0020, 0x255A, 0x2550, 0x2550, 0x2550, 0x2550, 0x2550, 0x255D, 0x0020, 0x255A, 0x2550, 0x255D, 0x0020, 0x0020, 0x255A, 0x2550, 0x255D, 0x255A, 0x2550, 0x255D, 0x0020, 0x0020, 0x255A, 0x2550, 0x255D, 0x000A)
Write-Host ($BANNER -join '')

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
$PROTOCOL_DB_DIR = "$PROJECT_DEBUG_DIR\internal_db"

$ACCOUNT_PRIVATE_KEY_FILE = "$PROJECT_DIR\.account_private_key"

$UTILS_EXEC="$PROJECT_DIR\FortytwoUtilsWindows.exe"

if (-Not (Test-Path $PROJECT_DEBUG_DIR) -or -Not (Test-Path $PROJECT_MODEL_CACHE_DIR)) {
    New-Item -ItemType Directory -Path $PROJECT_DEBUG_DIR -Force | Out-Null
    New-Item -ItemType Directory -Path $PROJECT_MODEL_CACHE_DIR -Force | Out-Null
    Animate-Text "Project directory created: $PROJECT_DIR"
} else {
    Animate-Text "Project directory already exists: $PROJECT_DIR"
}

function Cleanup {
    if ($CAPSULE_PROC -and $CAPSULE_PROC.HasExited -eq $false) {
        Animate-Text "Stopping Capsule..."
        Stop-Process -Id $CAPSULE_PROC.Id -Force -ErrorAction SilentlyContinue
    } else {
        Animate-Text "Capsule process is not running."
    }

    if ($PROTOCOL_PROC -and $PROTOCOL_PROC.HasExited -eq $false) {
        Animate-Text "Stopping Node..."
        Stop-Process -Id $PROTOCOL_PROC.Id -Force -ErrorAction SilentlyContinue
    } else {
        Animate-Text "Node process is not running."
    }

    Animate-Text "Processes stopped. Exiting."
    exit 0
}

trap {
    Animate-Text "`nDetected Ctrl+C. Stopping processes..."
    Cleanup
}


$PROTOCOL_VERSION = (Invoke-RestMethod "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/protocol/latest").Trim()
Animate-Text "Latest protocol version is $PROTOCOL_VERSION"
$DOWNLOAD_PROTOCOL_URL = "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/protocol/v$PROTOCOL_VERSION/FortytwoProtocolNode-windows-amd64.exe"

$CAPSULE_VERSION = (Invoke-RestMethod "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/latest").Trim()
Animate-Text "Latest capsule version is $CAPSULE_VERSION"

$UTILS_VERSION = (Invoke-RestMethod "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/utilities/latest").Trim()
Animate-Text "Latest utils version is $UTILS_VERSION"
$DOWNLOAD_UTILS_URL = "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/utilities/v$UTILS_VERSION/FortytwoUtilsWindows.exe"


if (Test-Path $CAPSULE_EXEC) {
    $CURRENT_CAPSULE_VERSION_OUTPUT = & $CAPSULE_EXEC --version 2>$null
    if ($CURRENT_CAPSULE_VERSION_OUTPUT -match $CAPSULE_VERSION) {
        Animate-Text "Capsule is already up to date (version found: $CURRENT_CAPSULE_VERSION_OUTPUT). Skipping download."
    } else {
        if (Get-Command "nvidia-smi.exe" -ErrorAction SilentlyContinue) {
            Animate-Text "NVIDIA detected. Downloading Capsule (CUDA version)..."
            $DOWNLOAD_CAPSULE_URL = "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/v$CAPSULE_VERSION/windows-amd64-cuda124.zip"
            Invoke-WebRequest -Uri $DOWNLOAD_CAPSULE_URL -OutFile $CAPSULE_ZIP
            Animate-Text "Extracting CUDA Capsule..."
            Remove-Item $CAPSULE_EXEC -Force
            Remove-Item "$PROJECT_DIR\cublas64_12.dll" -Force
            Remove-Item "$PROJECT_DIR\cublasLt64_12.dll" -Force
            Expand-Archive -Path $CAPSULE_ZIP -DestinationPath $PROJECT_DIR -Force
            Remove-Item $CAPSULE_ZIP -Force

            if (Test-Path $EXTRACTED_CUDA_EXEC) {
                Rename-Item -Path $EXTRACTED_CUDA_EXEC -NewName "FortytwoCapsule.exe" -Force
                Animate-Text "Renamed CUDA Capsule to: $CAPSULE_EXEC"
            } else {
                Write-Host "ERROR: Expected CUDA executable not found in extracted files!"
                Exit 1
            }
        } else {
            Write-Host "No NVIDIA GPU detected. Downloading CPU Capsule..."
            $DOWNLOAD_CAPSULE_URL = "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/v$CAPSULE_VERSION/FortytwoCapsule-windows-amd64.exe"
            Invoke-WebRequest -Uri $DOWNLOAD_CAPSULE_URL -OutFile $CAPSULE_EXEC
            Animate-Text "Capsule downloaded to: $CAPSULE_EXEC"
        }
    }
} else {
    if (Get-Command "nvidia-smi.exe" -ErrorAction SilentlyContinue) {
        Animate-Text "NVIDIA detected. Downloading Capsule (CUDA version)..."
        $DOWNLOAD_CAPSULE_URL = "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/v$CAPSULE_VERSION/windows-amd64-cuda124.zip"
        Invoke-WebRequest -Uri $DOWNLOAD_CAPSULE_URL -OutFile $CAPSULE_ZIP
        Animate-Text "Extracting CUDA Capsule..."
        Expand-Archive -Path $CAPSULE_ZIP -DestinationPath $PROJECT_DIR -Force
        Remove-Item $CAPSULE_ZIP -Force

        if (Test-Path $EXTRACTED_CUDA_EXEC) {
            Rename-Item -Path $EXTRACTED_CUDA_EXEC -NewName "FortytwoCapsule.exe" -Force
            Write-Host "Renamed CUDA Capsule to: $CAPSULE_EXEC"
        } else {
            Write-Host "ERROR: Expected CUDA executable not found in extracted files!"
            Exit 1
        }
    } else {
        Animate-Text "No NVIDIA GPU detected. Downloading CPU Capsule..."
        $DOWNLOAD_CAPSULE_URL = "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/v$CAPSULE_VERSION/FortytwoCapsule-windows-amd64.exe"
        Invoke-WebRequest -Uri $DOWNLOAD_CAPSULE_URL -OutFile $CAPSULE_EXEC
        Animate-Text "Capsule downloaded to: $CAPSULE_EXEC"
    }
}

if (Test-Path $PROTOCOL_EXEC) {
    $CURRENT_PROTOCOL_VERSION_OUTPUT = & $PROTOCOL_EXEC --version 2>$null
    if ($CURRENT_PROTOCOL_VERSION_OUTPUT -match $PROTOCOL_VERSION) {
        Animate-Text "Node is already up to date ($CURRENT_PROTOCOL_VERSION_OUTPUT). Skipping download."
    } else {
        Animate-Text "Downloading updated Node..."
        Invoke-WebRequest -Uri $DOWNLOAD_PROTOCOL_URL -OutFile $PROTOCOL_EXEC
    }
} else {
    Animate-Text "Downloading Node..."
    Invoke-WebRequest -Uri $DOWNLOAD_PROTOCOL_URL -OutFile $PROTOCOL_EXEC
}

if (Test-Path $UTILS_EXEC) {
    $CURRENT_UTILS_VERSION_OUTPUT = & $UTILS_EXEC --version 2>$null
    if ($CURRENT_UTILS_VERSION_OUTPUT -match $UTILS_VERSION) {
        Animate-Text "Utils is already up to date ($CURRENT_UTILS_VERSION_OUTPUT). Skipping download."
    } else {
        Invoke-WebRequest -Uri $DOWNLOAD_UTILS_URL -OutFile $UTILS_EXEC
    }
} else {
    Invoke-WebRequest -Uri $DOWNLOAD_UTILS_URL -OutFile $UTILS_EXEC
}

if (Test-Path $ACCOUNT_PRIVATE_KEY_FILE) {
    $ACCOUNT_PRIVATE_KEY = Get-Content $ACCOUNT_PRIVATE_KEY_FILE
    Write-Host "Using saved account private key."
} else {
    Write-Host ""
    Write-Host "|==================== NETWORK IDENTITY ===================|"
    Write-Host "|                                                         |"
    Write-Host "|  Every node requires a secure blockchain identity.      |"
    Write-Host "|  Choose one of the following options:                   |"
    Write-Host "|                                                         |"
    Write-Host "|  1. Create a new identity with an invite code           |"
    Write-Host "|     Recommended for new nodes                           |"
    Write-Host "|                                                         |"
    Write-Host "|  2. Recover an existing identity with recovery phrase   |"
    Write-Host "|     Use this if you're restoring a previous node        |"
    Write-Host "|                                                         |"
    Write-Host "|=========================================================|"
    Write-Host ""

    $IDENTITY_OPTION = Read-Host "Select option [1-2]"
    if (-not $IDENTITY_OPTION) { $IDENTITY_OPTION = "1" }

    if ($IDENTITY_OPTION -eq "2") {
        Write-Host "Recovering existing identity..."
        while ($true) {
            $ACCOUNT_SEED_PHRASE = Read-Host "Enter your account recovery phrase (12, 18, or 24 words), then press Enter: "
            try {
                $ACCOUNT_PRIVATE_KEY = & $UTILS_EXEC --phrase $ACCOUNT_SEED_PHRASE
                if ($LASTEXITCODE -ne 0) {
                    throw "Converter execution failed!"
                } else {
                    $ACCOUNT_PRIVATE_KEY | Set-Content -Path $ACCOUNT_PRIVATE_KEY_FILE
                    Write-Host "Private key saved."
                    break
                }
            } catch {
                Write-Host "Error: Please check the recovery phrase and try again."
                continue
            }
        }
    } else {
        Write-Host "You selected: Create a new identity with an invite code"
        while ($true) {
            $INVITE_CODE = Read-Host "Enter your invite code"
            if (-not $INVITE_CODE -or $INVITE_CODE.Length -lt 12) {
                Write-Host "Invalid invite code. Please check and try again."
                continue
            } else {
                break
            }
        }
        Write-Host "Creating your node identity..."
        $WALLET_UTILS_EXEC_OUTPUT = & $UTILS_EXEC --create-wallet $ACCOUNT_PRIVATE_KEY_FILE --drop-code $INVITE_CODE
        if ($LASTEXITCODE -ne 0) {
            Write-Host ($WALLET_UTILS_EXEC_OUTPUT | Select-Object -Last 1)
            Write-Host "Error: Invalid invite code. Please check your code and try again. You entered: $INVITE_CODE"
            if (Test-Path $ACCOUNT_PRIVATE_KEY_FILE) {
                Remove-Item $ACCOUNT_PRIVATE_KEY_FILE -Force
            }
            exit 1
        }
        $ACCOUNT_PRIVATE_KEY = Get-Content $ACCOUNT_PRIVATE_KEY_FILE
        Write-Host $WALLET_UTILS_EXEC_OUTPUT
        Write-Host "Identity configured and securely stored!"
        while ($true) {
            $user_input = Read-Host "To continue, please type '42'"
            if ($user_input -eq "42") {
                break
            }
            Write-Host "Input not recognized. Please type '42' to continue."
        }
    }
}

Write-Host ""
Animate-Text "Time to choose your node's specialization!"
Write-Host ""
Write-Host "Every AI node in the Fortytwo Network has unique strengths."
Write-Host "Choose how your node will contribute to the collective intelligence:"
Auto-Select-Model
Write-Host ""
Write-Host "|===========================================================================|"
Write-Host "| 0. AUTO-SELECT - Optimal Configuration                                    |"
Write-Host "|    Let the system determine the best model for your hardware.             |"
Write-Host "|    Balanced for performance and capabilities.                             |"
Write-Host "|===========================================================================|"
Write-Host "| 1. NOUMENAL PYLON - General Knowledge                                     |"
Write-Host "|    Versatile multi-domain intelligence core with balanced capabilities.   |"
Write-Host "|    Model: Llama-3.2-3B-Instruct (2.2GB VRAM)                              |"
Write-Host "|===========================================================================|"
Write-Host "| 2. TELEOLOGY PYLON - Advanced Reasoning                                   |"
Write-Host "|    High-precision logical analysis matrix optimized for problem-solving.  |"
Write-Host "|    Model: INTELLECT-1-Instruct (6.5GB VRAM)                               |"
Write-Host "|===========================================================================|"
Write-Host "| 3. MACHINIC PYLON - Programming & Technical                               |"
Write-Host "|    Specialized system for code synthesis and framework construction.      |"
Write-Host "|    Model: Qwen2.5-Coder-7B-Instruct (4.8GB VRAM)                          |"
Write-Host "|===========================================================================|"
Write-Host "| 4. SCHOLASTIC PYLON - Academic Knowledge                                  |"
Write-Host "|    Advanced data integration and research synthesis protocol.             |"
Write-Host "|    Model: Ministral-8B-Instruct-2410 (5.2GB VRAM)                         |"
Write-Host "|===========================================================================|"
Write-Host "| 5. LOGOTOPOLOGY PYLON - Language & Writing                                |"
Write-Host "|    Optimized for creative writing, analysis, and linguistic processing.   |"
Write-Host "|    Model: Qwen2.5-7B-Instruct (4.8GB VRAM)                                |"
Write-Host "|===========================================================================|"
Write-Host "| 6. SAPIENCE PYLON - Problem Solving & Logical Reasoning                   |"
Write-Host "|    Engineered for high-level coding, mathematical logic, and strategy.    |"
Write-Host "|    Model: Qwen2.5-Coder-32B-Instruct (21GB VRAM)                          |"
Write-Host "|===========================================================================|"
Write-Host "| 7. NUMERICON PYLON - Mathematical Intelligence                            |"
Write-Host "|    Optimized for complex symbolic reasoning and stepwise math solutions.  |"
Write-Host "|    Model: Phi-4-14B (9.1GB VRAM)                                          |"
Write-Host "|===========================================================================|"
Write-Host "| 8. POLYGLOSSIA PYLON - Multilingual Understanding                         |"
Write-Host "|    Designed for cross-lingual comprehension, translation, and reasoning.  |"
Write-Host "|    Model: Gemma-3 4B (3.3GB VRAM)                                         |"
Write-Host "|===========================================================================|"
Write-Host "| 9. OLYMPIAD PYLON - Competitive Programming & Algorithms                  |"
Write-Host "|    Optimized for algorithmic challenges and CodeForces-style competitions.|"
Write-Host "|    Model: OlympicCoder 7B (4.8GB VRAM)                                    |"
Write-Host "|===========================================================================|"
Write-Host "| 10. CUSTOM - Advanced Configuration                                       |"
Write-Host "|    Define your own HuggingFace model repository and configuration.        |"
Write-Host "|===========================================================================|"
Write-Host ""
$NODE_CLASS = Read-Host "Select your node's specialization [0-10] (0 for auto-select)"

switch ($NODE_CLASS) {
    "0" {
        Write-Host "Analyzing system for optimal configuration..."
        Auto-Select-Model
    }
    "1" {
        $LLM_HF_REPO = "bartowski/Llama-3.2-3B-Instruct-GGUF"
        $LLM_HF_MODEL_NAME = "Llama-3.2-3B-Instruct-Q4_K_M.gguf"
        $NODE_NAME = "NOUMENAL PYLON"
    }
    "2" {
        $LLM_HF_REPO = "bartowski/INTELLECT-1-Instruct-GGUF"
        $LLM_HF_MODEL_NAME = "INTELLECT-1-Instruct-Q4_K_M.gguf"
        $NODE_NAME = "TELEOLOGY PYLON"
    }
    "3" {
        $LLM_HF_REPO = "Qwen/Qwen2.5-Coder-7B-Instruct-GGUF"
        $LLM_HF_MODEL_NAME = "qwen2.5-coder-7b-instruct-q4_k_m-00001-of-00002.gguf"
        $NODE_NAME = "MACHINIC PYLON"
    }
    "4" {
        $LLM_HF_REPO = "bartowski/Ministral-8B-Instruct-2410-GGUF"
        $LLM_HF_MODEL_NAME = "Ministral-8B-Instruct-2410-Q4_K_M.gguf"
        $NODE_NAME = "SCHOLASTIC PYLON"
    }
    "5" {
        $LLM_HF_REPO = "Qwen/Qwen2.5-7B-Instruct-GGUF"
        $LLM_HF_MODEL_NAME = "qwen2.5-7b-instruct-q4_k_m-00001-of-00002.gguf"
        $NODE_NAME = "LOGOTOPOLOGY PYLON"
    }
    "6" {
        $LLM_HF_REPO = "Qwen/Qwen2.5-Coder-32B-Instruct-GGUF"
        $LLM_HF_MODEL_NAME = "qwen2.5-coder-32b-instruct-q4_k_m-00001-of-00003.gguf"
        $NODE_NAME = "SAPIENCE PYLON"
    }
    "7" {
        $LLM_HF_REPO = "unsloth/phi-4-GGUF"
        $LLM_HF_MODEL_NAME = "phi-4-Q4_K_M.gguf"
        $NODE_NAME = "NUMERICON PYLON"
    }
    "8" {
        $LLM_HF_REPO = "unsloth/gemma-3-12b-it-GGUF"
        $LLM_HF_MODEL_NAME = "gemma-3-12b-it-Q4_K_M.gguf"
        $NODE_NAME = "POLYGLOSSIA PYLON"
    }
    "9" {
        $LLM_HF_REPO = "bartowski/open-r1_OlympicCoder-7B-GGUF"
        $LLM_HF_MODEL_NAME = "open-r1_OlympicCoder-7B-Q4_K_M.gguf"
        $NODE_NAME = "OLYMPIAD PYLON"
    }
    "10" {
        Write-Host "`n===================== ADVANCED SETUP ====================="
        Write-Host "This option is for users familiar with language models`n"

        $LLM_HF_REPO = Read-Host "Enter HuggingFace repository (e.g., Qwen/Qwen2.5-3B-Instruct-GGUF)"
        $LLM_HF_MODEL_NAME = Read-Host "Enter model filename (e.g., qwen2.5-3b-instruct-q4_k_m.gguf)"
        $NODE_NAME = "Custom (HF: $($LLM_HF_REPO -split '/' | Select-Object -Last 1))"
    }
    Default {
        Write-Host "No selection made. Proceeding with auto-select..."
        Auto-Select-Model
    }
}
Animate-Text "${NODE_NAME} is selected"
Animate-Text "Downloading model and preparing the environment (this may take several minutes)..."
& $UTILS_EXEC --hf-repo $LLM_HF_REPO --hf-model-name $LLM_HF_MODEL_NAME --model-cache $PROJECT_MODEL_CACHE_DIR

Animate-Text "Setup completed."
clear
Write-Host ($BANNER -join '')
Animate-Text "Starting Capsule.."

$CAPSULE_PROC = Start-Process -FilePath $CAPSULE_EXEC -ArgumentList "--llm-hf-repo $LLM_HF_REPO --llm-hf-model-name $LLM_HF_MODEL_NAME --model-cache $PROJECT_MODEL_CACHE_DIR" -PassThru -RedirectStandardOutput $CAPSULE_LOGS -RedirectStandardError $CAPSULE_ERR_LOGS -NoNewWindow
Animate-Text "Be patient during the first launch of the capsule; it will take some time."
while ($true) {
    if ($CAPSULE_PROC.HasExited) {
        Write-Host "Capsule process exited (exit code: $($CAPSULE_PROC.ExitCode))" -ForegroundColor Red
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
            Write-Host "Capsule is ready!"
            break
        }
    } catch {
        # Just Ignore Error
    }

    Start-Sleep -Seconds 5
}
Animate-Text "Starting Protocol.."
$PROTOCOL_PROC = Start-Process -FilePath $PROTOCOL_EXEC -ArgumentList "--account-private-key $ACCOUNT_PRIVATE_KEY --db-folder $PROTOCOL_DB_DIR" -PassThru -NoNewWindow

while ($true) {
    if ($CAPSULE_PROC.HasExited) {
        Animate-Text "Capsule has stopped. Exiting..."
        Cleanup
        Exit 1
    }
    if ($PROTOCOL_PROC.HasExited) {
        Animate-Text "Node has stopped. Exiting..."
        Cleanup
        Exit 1
    }
    Start-Sleep -Seconds 5
}
