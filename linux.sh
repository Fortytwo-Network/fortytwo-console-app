#!/bin/bash

animate_text() {
    local text="$1"
    for ((i=0; i<${#text}; i++)); do
        echo -n "${text:$i:1}"
        sleep 0.002
    done
    echo
}
animate_text_x2() {
    local text="$1"
    for ((i=0; i<${#text}; i++)); do
        echo -n "${text:$i:1}"
        sleep 0.0005
    done
    echo
}

auto_select_model() {

    if command -v nvidia-smi >/dev/null 2>&1; then
        AVAILABLE_MEM=$(nvidia-smi --query-gpu=memory.free --format=csv,noheader,nounits 2>/dev/null \
          | awk 'BEGIN{max=0} {g=$1/1024; if(g>max) max=g} END{printf "%.2f", max}')
        TOTAL_MEM=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits 2>/dev/null \
          | awk 'BEGIN{max=0} {g=$1/1024; if(g>max) max=g} END{printf "%.2f", max}')
    fi

    if [[ -z "$AVAILABLE_MEM" || "$AVAILABLE_MEM" == "0.00" ]]; then
        AVAILABLE_MEM=$(awk '
            $1=="MemAvailable:" {avail=$2/1024/1024}
            $1=="MemFree:"      {free=$2}
            $1=="Buffers:"      {buf=$2}
            $1=="Cached:"       {cached=$2}
            $1=="SReclaimable:" {srec=$2}
            $1=="Shmem:"        {shm=$2}
            END{
              if (avail > 0)      printf "%.2f", avail/1.0;
              else                 printf "%.2f", (free+buf+cached+srec-shm)/1024/1024;
            }' /proc/meminfo)
        TOTAL_MEM=$(awk '/MemTotal/ {print $2 / 1024 / 1024}' /proc/meminfo)
    fi


    AVAILABLE_MEM_INT=$(awk -v v="$AVAILABLE_MEM" 'BEGIN{printf "%d", int(v)}')

    animate_text "    ↳ System analysis:"
    animate_text "    ↳ ${TOTAL_MEM} GB ${MEMORY_TYPE} total, ${AVAILABLE_MEM} GB ${MEMORY_TYPE} available"

    if [ "$AVAILABLE_MEM_INT" -ge 22 ]; then
        animate_text "    🜲 Recommending: ⬢ 7 Qwen3 for problem solving & coding"
        LLM_HF_REPO="unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF"
        LLM_HF_MODEL_NAME="Qwen3-Coder-30B-A3B-Instruct-Q4_K_M.gguf"
        NODE_NAME="Qwen3 Coder 30B A3B Instruct Q4"
    elif [ "$AVAILABLE_MEM_INT" -ge 15 ]; then
        animate_text "    🜲 Recommending: ⬢ 13 Qwen3 14B for high-precision logical analysis"
        LLM_HF_REPO="unsloth/Qwen3-14B-GGUF"
        LLM_HF_MODEL_NAME="Qwen3-14B-Q4_K_M.gguf"
        NODE_NAME="Qwen3 14B Q4"
    elif [ "$AVAILABLE_MEM_INT" -ge 7 ]; then
        animate_text "    🜲 Recommending: ⬢ 14 Qwen3 8B for balanced capability"
        LLM_HF_REPO="unsloth/Qwen3-8B-GGUF"
        LLM_HF_MODEL_NAME="Qwen3-8B-Q4_K_M.gguf"
        NODE_NAME="Qwen3 8B Q4"
    else
        animate_text "    🜲 Recommending: ⬢ 23 Qwen3 1.7B optimized for efficiency"
        LLM_HF_REPO="unsloth/Qwen3-1.7B-GGUF"
        LLM_HF_MODEL_NAME="Qwen3-1.7B-Q4_K_M.gguf"
        NODE_NAME="Qwen3 1.7B Q4"
    fi
    animate_text "    ↳ Or pick a model smaller than ${AVAILABLE_MEM} GB"
}

BANNER="
   ▒█████░      ▒█████░    █████████░  █████████░
  ▓███████▓    ▓███████▓   █████████░  █████████░
 ░█████████░  ░█████████░  █████████░  █████████░
  ▓███████▓    ▓███████▓   █████████░  █████████░
   ▒█████░      ▒█████░    █████████░  █████████░
                           █████████░  █████████░
   ▒█████░      ▒█████░    █████████░  █████████░
  ▓███████▓    ▓███████▓   █████████░  █████████░
 ░█████████░  ░█████████░  █████████░  █████████░
  ▓███████▓    ▓███████▓   █████████░  █████████░
   ▒█████░      ▒█████░    █████████░  █████████░
"
BANNER_FULLNAME="

 ▒██  ░█▓░  ▒███  ▒███   ▒█████▒             █▓           ▒▓
████░ ████░ ▒███  ▒███   ▒█▒     ▒▓░▒  ▒██▓░▓██▒▒▓▓   ▓▒▒███▓░█▓  █▓  ▓█  ▒▓░▒
 ▒▓░   ▒▓░  ▒███  ▒███   ▒████▒ ▒█  ▓█ ██▒ ░ ██░  █▓  ▓█░ ██  ██ ▓▓█  ██ ▒█  ▓█
 ░▓▓   ░▓▓  ▒███  ▒███   ▒█░    █▓  █▓ ▓█    █▒   ▒█▒█▓   █▓  ░█▒█▒██▒█▓ █▓  █▓
████░ ████░ ▒███  ▒███   ▒█░    ▒█  ▓█ ██    █▓    ▓██░   ██   ███ ▒██▒  ▒█  ▓█
 ▒██   ░▓▒  ▒███  ▒███   ▒█░     ░▒▓░  █▓    ░░▓▒   ▓█░   ▒░▓▒  █▒  █▒░   ░▓▓░
                                                 ░░█▓
"
animate_text_x2 "$BANNER"
animate_text "      Welcome to ::|| Fortytwo, Noderunner."
echo
if command -v nvidia-smi &> /dev/null; then
    MEMORY_TYPE="VRAM"
else
    MEMORY_TYPE=" RAM"
    echo "    ✕ ERROR: No compatible GPU found. This application requires an NVIDIA GPU. Please verify that your system has a supported NVIDIA GPU by reviewing our hardware requirements documentation: https://docs.fortytwo.network/docs/hardware-requirements"
    exit 1
fi
PROJECT_DIR="./FortytwoNode"
PROJECT_DEBUG_DIR="$PROJECT_DIR/debug"
PROJECT_MODEL_CACHE_DIR="$PROJECT_DIR/model_cache"

CAPSULE_EXEC="$PROJECT_DIR/FortytwoCapsule"
CAPSULE_LOGS="$PROJECT_DEBUG_DIR/FortytwoCapsule.logs"
CAPSULE_READY_URL="http://0.0.0.0:42442/ready"

PROTOCOL_EXEC="$PROJECT_DIR/FortytwoProtocol"

ACCOUNT_PRIVATE_KEY_FILE="$PROJECT_DIR/.account_private_key"

UTILS_EXEC="$PROJECT_DIR/FortytwoUtils"

# KV-cache settings
KV_CACHE_MODE="auto"
KV_CACHE_TOKENS=false
KV_CACHE_GB=false

LLM_IS_LOCAL_PATH=false

animate_text "Preparing your node environment..."

if [[ ! -d "$PROJECT_DEBUG_DIR" || ! -d "$PROJECT_MODEL_CACHE_DIR" ]]; then
    mkdir -p "$PROJECT_DEBUG_DIR" "$PROJECT_MODEL_CACHE_DIR"
    echo
    # animate_text "Project directory created: $PROJECT_DIR"
else
    echo
    # animate_text "Project directory already exists: $PROJECT_DIR"
fi

USER=$(logname)
chown "$USER:$USER" "$PROJECT_DIR"

if ! command -v curl &> /dev/null; then
    animate_text "    ↳ Curl is not installed. Installing curl..."
    apt update && apt install -y curl
    echo
fi

check_connection() {
    animate_text "Ξ Connection check to update endpoints"

    curl -s --connect-timeout 3 --max-time 5 -o /dev/null "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/latest"
    CAPSULE_S3_STATUS=$?

    curl -s --connect-timeout 3 --max-time 5 -o /dev/null "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/protocol/latest"
    PROTOCOL_S3_STATUS=$?

    if [ "$CAPSULE_S3_STATUS" -eq 0 ] && [ "$PROTOCOL_S3_STATUS" -eq 0 ]; then
        echo "    ✓ Connected to all services"
        echo
        return 0

    elif [ "$CAPSULE_S3_STATUS" -ne 0 ] && [ "$PROTOCOL_S3_STATUS" -ne 0 ]; then
        echo "    ✕ ERROR: No connection to services. Check your internet connection, try using a VPN, and restart the script."
        echo
        return 1

    else
        echo "    ⚠ WARNING: Partial connection detected"
        echo "    • Capsule endpoint: $([ "$CAPSULE_S3_STATUS" -eq 0 ] && echo "✓" || echo "✕")"
        echo "    • Protocol endpoint: $([ "$PROTOCOL_S3_STATUS" -eq 0 ] && echo "✓" || echo "✕")"
        echo
        return 1
    fi
}

# shellcheck disable=SC2120
connection_loop() {
    while true; do
        if check_connection; then
            break
        else
            echo "    [1] Try Reconnecting"
            echo "    [2] Restart App"
            read -p "    Select option: " user_choice

            case "$user_choice" in
                1)
                    echo "    → Attempting reconnection..."
                    echo
                    continue
                    ;;
                2)
                    echo "    → Restarting application..."
                    exec "$0" "$@"
                    ;;
                *)
                    echo "    ✕ Invalid input. Please try again."
                    echo
                    ;;
            esac
        fi
    done
}

connection_loop

animate_text "▒▓░ Checking for the Latest Components Versions ░▓▒"
echo
animate_text "◰ Setup script — version validation"

# --- Update setup script ---
INSTALLER_UPDATE_URL="https://raw.githubusercontent.com/Fortytwo-Network/fortytwo-console-app/main/linux.sh"
SCRIPT_PATH="$0"
TEMP_FILE=$(mktemp)

curl -fsSL -o "$TEMP_FILE" "$INSTALLER_UPDATE_URL"

# Check download
if [ ! -s "$TEMP_FILE" ]; then
    echo "    ✕ ERROR: Failed to download the update. Check your internet connection and try again."
    exit 1
fi

# Compare
if cmp -s "$SCRIPT_PATH" "$TEMP_FILE"; then
    # No update needed
    echo "    ✓ Up to date"
    rm "$TEMP_FILE"
else
    echo "    ↳ Updating..."
    cp "$SCRIPT_PATH" "${SCRIPT_PATH}.bak"
    cp "$TEMP_FILE" "$SCRIPT_PATH"
    chmod +x "$SCRIPT_PATH"
    rm "$TEMP_FILE"
    echo "    ↺ Restarting script..."
    sleep 3
    exec "$SCRIPT_PATH" "$@"
    echo "    ✕ ERROR: exec failed."
    exit 1
fi
# --- End Update setup script ---

CAPSULE_VERSION=$(curl -s "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/latest")
animate_text "⎔ Capsule — version $CAPSULE_VERSION"
DOWNLOAD_CAPSULE_URL="https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/v$CAPSULE_VERSION/FortytwoCapsule-linux-amd64"
if [[ -f "$CAPSULE_EXEC" ]]; then
    CURRENT_CAPSULE_VERSION_OUTPUT=$("$CAPSULE_EXEC" --version 2>/dev/null)
    if [[ "$CURRENT_CAPSULE_VERSION_OUTPUT" == *"$CAPSULE_VERSION"* ]]; then
        animate_text "    ✓ Up to date"
    else
        animate_text "    ↳ Updating..."
        if command -v nvidia-smi &> /dev/null; then
            animate_text "    ↳ NVIDIA detected. Downloading capsule for NVIDIA systems..."
            DOWNLOAD_CAPSULE_URL+="-cuda124"
        else
            animate_text "    ↳ No NVIDIA GPU detected. Downloading CPU capsule..."
        fi
        curl -L -o "$CAPSULE_EXEC" "$DOWNLOAD_CAPSULE_URL"
        chmod +x "$CAPSULE_EXEC"
        animate_text "    ✓ Successfully updated"
    fi
else
    if command -v nvidia-smi &> /dev/null; then
        animate_text "    ↳ NVIDIA detected. Downloading capsule for NVIDIA systems..."
        DOWNLOAD_CAPSULE_URL+="-cuda124"
    else
        animate_text "    ↳ No NVIDIA GPU detected. Downloading CPU capsule..."
    fi
    curl -L -o "$CAPSULE_EXEC" "$DOWNLOAD_CAPSULE_URL"
    chmod +x "$CAPSULE_EXEC"
    animate_text "    ✓ Installed to: $CAPSULE_EXEC"
fi
PROTOCOL_VERSION=$(curl -s "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/protocol/latest")
animate_text "⏃ Protocol Node — version $PROTOCOL_VERSION"
DOWNLOAD_PROTOCOL_URL="https://fortytwo-network-public.s3.us-east-2.amazonaws.com/protocol/v$PROTOCOL_VERSION/FortytwoProtocolNode-linux-amd64"
if [[ -f "$PROTOCOL_EXEC" ]]; then
    CURRENT_PROTOCOL_VERSION_OUTPUT=$("$PROTOCOL_EXEC" --version 2>/dev/null)

    if [[ "$CURRENT_PROTOCOL_VERSION_OUTPUT" == *"$PROTOCOL_VERSION"* ]]; then
        animate_text "    ✓ Up to date"
    else
        animate_text "    ↳ Updating..."
        curl -L -o "$PROTOCOL_EXEC" "$DOWNLOAD_PROTOCOL_URL"
        chmod +x "$PROTOCOL_EXEC"
        animate_text "    ✓ Successfully updated"
    fi
else
    animate_text "    ↳ Downloading..."
    curl -L -o "$PROTOCOL_EXEC" "$DOWNLOAD_PROTOCOL_URL"
    chmod +x "$PROTOCOL_EXEC"
    animate_text "    ✓ Installed to: $PROTOCOL_EXEC"
fi
UTILS_VERSION=$(curl -s "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/utilities/latest")
animate_text "⨳ Utils — version $UTILS_VERSION"
DOWNLOAD_UTILS_URL="https://fortytwo-network-public.s3.us-east-2.amazonaws.com/utilities/v$UTILS_VERSION/FortytwoUtilsLinux"
if [[ -f "$UTILS_EXEC" ]]; then
    CURRENT_UTILS_VERSION_OUTPUT=$("$UTILS_EXEC" --version 2>/dev/null)
    if [[ "$CURRENT_UTILS_VERSION_OUTPUT" == *"$UTILS_VERSION"* ]]; then
        animate_text "    ✓ Up to date"
    else
        animate_text "    ↳ Updating..."
        curl -L -o "$UTILS_EXEC" "$DOWNLOAD_UTILS_URL"
        chmod +x "$UTILS_EXEC"
        animate_text "    ✓ Successfully updated"
    fi
else
    animate_text "    ↳ Downloading..."
    curl -L -o "$UTILS_EXEC" "$DOWNLOAD_UTILS_URL"
    chmod +x "$UTILS_EXEC"
    animate_text "    ✓ Installed to: $UTILS_EXEC"
fi

echo
animate_text "▒▓░ Identity Initialization ░▓▒"

if [[ -f "$ACCOUNT_PRIVATE_KEY_FILE" ]]; then
    ACCOUNT_PRIVATE_KEY=$(cat "$ACCOUNT_PRIVATE_KEY_FILE")
    echo
    animate_text "    ↳ Private key found at $PROJECT_DIR/.account_private_key."
    animate_text "    ↳ Initiating the node using an existing identity."
    animate_text "    ⚠ Keep the private key safe. Do not share with anyone."
    echo "    ⚠ Recover your node or access your wallet with it."
    echo "    ⚠ We will not be able to recover it if it is lost."
else
    echo
    echo -e "╔════════════════════ NETWORK IDENTITY ═══════════════════╗"
    echo -e "║                                                         ║"
    echo -e "║  Each node requires a secure blockchain identity.       ║"
    echo -e "║  Select one of the following options:                   ║"
    echo -e "║                                                         ║"
    echo -e "║  1. Create a new identity with an activation code.      ║"
    echo -e "║     Recommended for new nodes.                          ║"
    echo -e "║                                                         ║"
    echo -e "║  2. Recover an existing identity with recovery phrase.  ║"
    echo -e "║     Use this if you're restoring a previous node.       ║"
    echo -e "║                                                         ║"
    echo -e "╚═════════════════════════════════════════════════════════╝"
    echo
    read -r -p "Select option [1-2]: " IDENTITY_OPTION
    echo
    IDENTITY_OPTION=${IDENTITY_OPTION:-1}
    if [[ "$IDENTITY_OPTION" == "2" ]]; then
        animate_text "[2] Recovering existing identity"
        echo
        while true; do
            read -r -p "Enter your account recovery phrase (12, 18, or 24 words), then press Enter: " ACCOUNT_SEED_PHRASE
            echo
            if ! ACCOUNT_PRIVATE_KEY=$("$UTILS_EXEC" --phrase "$ACCOUNT_SEED_PHRASE"); then
                echo "˙◠˙ Error: Please check the recovery phrase and try again."
                continue
            else
                animate_text "$ACCOUNT_PRIVATE_KEY" > "$ACCOUNT_PRIVATE_KEY_FILE"
                animate_text "˙ᵕ˙ The identity successfully restored!"
                animate_text "    ↳ Private key saved to $PROJECT_DIR/.account_private_key."
                echo "    ⚠ Keep the key secure. Do not share with anybody."
                echo "    ⚠ Restore your node or access your wallet with it."
                echo "    ⚠ We will not be able to recover it would it be lost."
                break
            fi
        done
    else
        animate_text "[1] Creating a new identity with an activation code"
        echo
        "$UTILS_EXEC" --check-drop-service || exit 1
        while true; do
            read -r -p "Enter your activation code: " INVITE_CODE
            echo
            if [[ -z "$INVITE_CODE" || ${#INVITE_CODE} -lt 12 ]]; then
                echo "˙◠˙ Invalid activation code. Check the code and try again."
                echo
                continue
            fi
            break
        done
        animate_text "    ↳ Validating your identity..."
        WALLET_UTILS_EXEC_OUTPUT="$("$UTILS_EXEC" --create-wallet "$ACCOUNT_PRIVATE_KEY_FILE" --drop-code "$INVITE_CODE" 2>&1)"
        UTILS_EXEC_CODE=$?

        if [ "$UTILS_EXEC_CODE" -gt 0 ]; then
            echo "$WALLET_UTILS_EXEC_OUTPUT" | tail -n 1
            echo
            echo "˙◠˙ This code has already been activated. Please check your code and try again. You entered: $INVITE_CODE"
            echo
            rm -f "$ACCOUNT_PRIVATE_KEY_FILE"
            exit 1
        fi
        animate_text "    ↳ Write down your new node identity:"
        echo "$WALLET_UTILS_EXEC_OUTPUT"
        ACCOUNT_PRIVATE_KEY=$(<"$ACCOUNT_PRIVATE_KEY_FILE")
        echo
        animate_text "    ✓ Identity configured and securely stored!"
        echo
        echo -e "╔═════════════════ ATTENTION, NODERUNNER ═════════════════╗"
        echo -e "║                                                         ║"
        echo -e "║  1. Write down your secret recovery phrase              ║"
        echo -e "║  2. Keep your private key safe                          ║"
        echo -e "║     ↳ Get .account_private_key key from ./FortytwoNode/ ║"
        echo -e "║     ↳ Store it outside the App directory                ║"
        echo -e "║                                                         ║"
        echo -e "║  ⚠ Keep the recovery phrase and private key safe.       ║"
        echo -e "║  ⚠ Do not share them with anyone.                       ║"
        echo -e "║  ⚠ Use them to restore your node or access your wallet. ║"
        echo -e "║  ⚠ We won't be able to recover them if they are lost.   ║"
        echo -e "║                                                         ║"
        echo -e "╚═════════════════════════════════════════════════════════╝"
        echo
        while true; do
            read -r -p "To continue, please type 'I wrote down my recovery phrase': " user_input
            echo
            if [ "$user_input" = "I wrote down my recovery phrase" ]; then
                break
            fi
            echo "Incorrect input. Please type 'I wrote down my recovery phrase' to continue."
        done
    fi
fi

configure_kv_cache() {
    echo
    animate_text "1 : KV-CACHE SET-UP"
    echo "    - Memory control for longer context."
    echo "    - Defines how much of your system resources are allocated"
    echo "      in addition to inference generation."
    echo "    - Read more: https://docs.fortytwo.network/docs/how-to-pick-the-right-model-for-your-node"
    echo
    while true; do
        echo
        echo "[0] Default (Mode Auto)"
        echo "[1] Mode (auto|min|medium|max)"
        echo "[2] Size in Tokens"
        echo "[3] Size in GB"
        read -r -p "Select an option: " KV_MODE_CHOICE
        echo

        case $KV_MODE_CHOICE in
            0)
                echo
                animate_text "✓ KV-Cache size is now managed automatically."
                KV_CACHE_MODE="auto"
                break
                ;;
            1)
                while true; do
                    echo
                    echo "Pick your desired mode:"
                    echo "[0] Auto"
                    echo "[1] Min (33% of available memory)"
                    echo "[2] Medium (66% of available memory)"
                    echo "[3] Max (100% of available memory)"
                    read -r -p "Select an option: " MODE_OPTION
                    echo
                    case $MODE_OPTION in
                        0)
                            KV_CACHE_MODE="auto"
                            echo
                            animate_text "✓ KV-Cache size is set to Mode ${KV_CACHE_MODE}."
                            break 2
                            ;;
                        1)
                            KV_CACHE_MODE="min"
                            echo
                            animate_text "✓ KV-Cache size is set to Mode ${KV_CACHE_MODE}."
                            break 2
                            ;;
                        2)
                            KV_CACHE_MODE="medium"
                            echo
                            animate_text "✓ KV-Cache size is set to Mode ${KV_CACHE_MODE}."
                            break 2
                            ;;
                        3)
                            KV_CACHE_MODE="max"
                            echo
                            animate_text "✓ KV-Cache size is set to Mode ${KV_CACHE_MODE}."
                            break 2
                            ;;
                        *)
                            echo
                            echo "✗ Incorrect input."
                            ;;
                    esac
                done
                ;;
            2)
                while true; do
                    echo
                    read -r -p "Define your target cache in tokens, min is 1024: " TOKEN_SIZE
                    echo
                    if [[ "$TOKEN_SIZE" =~ ^[0-9]+$ ]] && [ "$TOKEN_SIZE" -ge 1024 ]; then
                        KV_CACHE_TOKENS=true
                        KV_CACHE_TOKENS_SIZE="$TOKEN_SIZE"
                        animate_text "✓ KV-Cache size is set to ${TOKEN_SIZE} Tokens."
                        break 2
                    else
                        echo
                        echo "✗ Incorrect input."
                    fi
                done
                ;;
            3)
                while true; do
                    echo
                    read -r -p "Define your target cache in GB, min is '0.3' GB: " GB_SIZE
                    echo
                    if [[ "$GB_SIZE" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
                        if (( $(echo "$GB_SIZE >= 0.3" | bc -l) )); then
                            KV_CACHE_GB=true
                            KV_CACHE_GB_SIZE="$GB_SIZE"
                            animate_text "✓ KV-Cache size is set to '${GB_SIZE}' GB."
                            break 2
                        else
                            echo "✗ Value must be at least 0.3 GB."
                        fi
                    else
                        echo "✗ Incorrect input."
                    fi
                done
                ;;
            *)
                echo
                echo "✗ Incorrect input."
                ;;
        esac
    done

    echo
    animate_text "KV-Cache configuration completed!"
}

show_settings() {
    while true; do
        echo
        echo "[1] KV-Cache Size"
        echo "[2] Back"
        read -r -p "Select an option: " SETTINGS_OPTION
        echo
        case $SETTINGS_OPTION in
            1)
                configure_kv_cache
                ;;
            2)
                break
                ;;
            *)
                animate_text "✕ Incorrect input."
                ;;
        esac
    done
}

select_custom_model() {
    echo
    echo "╔═════════ ✶ CUSTOM MODEL IMPORT"
    echo "║"
    echo "║  - Intended for users familiar with language models."
    echo "║  - Import from Hugging Face or import a local model."
    echo "║  - GGUF model format is expected."
    echo "║"
    echo "╚═════════ ✶"
    while true; do
        echo
        echo "[1] Hugging Face Import"
        echo "[2] Local GGUF Model Import"
        echo "[3] Back"
        read -p "Select an option: " choice
        echo
        case "$choice" in
            1)
                import_from_hub
                if [[ $? -eq 0 ]]; then
                    return 0
                fi
                ;;
            2)
                import_local_model
                if [[ $? -eq 0 ]]; then
                    return 0
                fi
                ;;
            3)
                return 1
                ;;
            *)
                echo
                echo "✕ Incorrect input."
                ;;
        esac
    done
}

import_from_hub() {
    echo
    echo "1 : LOADING MODEL FROM HUGGING FACE"
    echo
    echo "Step 1/2"
    echo "Enter Hugging Face repository, e.g.: 'Qwen/Qwen2.5-3B-Instruct-"
    echo "GGUF' (skip the quotes). Type 'Cancel' to go back."
    read -p "Define the repository: " repo_path
    if [[ "$(echo "$repo_path" | tr '[:upper:]' '[:lower:]')" == "cancel" ]]; then
        echo
        echo "Cancelled."
        return 1
    fi
    echo
    echo "Step 2/2"
    echo "Enter model filename. e.g.: 'qwen2.5-3b-instruct-q4_k_m.gguf'"
    echo "(skip the quotes). For models with multiple files, include the "
    echo "subpath and define the first one, e.g. 'Q4_K_M/gpt-oss-120b-"
    echo "Q4_K_M-00001-of-00002.gguf'."
    echo "Type 'Cancel' to go back."
    read -p "Enter model filename: " model_filename
    echo
    if [[ "$(echo "$model_filename" | tr '[:upper:]' '[:lower:]')" == "cancel" ]]; then
        echo
        echo "Cancelled."
        return 1
    fi
    echo
    echo "✓ Model linked successfully"

    LLM_HF_REPO="$repo_path"
    LLM_HF_MODEL_NAME="$model_filename"
    NODE_NAME="✶ CUSTOM IMPORT: HuggingFace ${LLM_HF_REPO##*/}"

    return 0
}

import_local_model() {
    echo
    echo "2 : LOADING MODEL FROM CUSTOM LOCATION"
    echo
    echo "Define the path to the model in form of '~/Downloads/qwen2.5-3b-"
    echo "instruct-q4_k_m.gguf' (skip the quotes). For models with multiple "
    echo "files, define the first one, e.g. '~/Downloads/gpt-oss-120b-"
    echo "Q4_K_M-00001-of-00002.gguf'."
    echo "Type 'Cancel' to go back."
    read -p "Define the path: " model_path
    echo
    if [[ "$(echo "$model_path" | tr '[:upper:]' '[:lower:]')" == "cancel" ]]; then
        echo
        echo "Cancelled."
        return 1
    fi
    model_path="${model_path/#\~/$HOME}"

    if [[ ! -f "$model_path" ]]; then
        echo
        echo "✗ Cannot reach the defined path."
        return 1
    fi

    if [[ ! "$model_path" =~ \.gguf$ ]]; then
        echo
        echo "✕ Defined file is not in GGUF format. Currently only the GGUF model file format is supported."
        return 1
    fi
    echo
    echo "✓ Model found successfully"

    LLM_IS_LOCAL_PATH=true
    LLM_LOCAL_PATH="$model_path"
    NODE_NAME="✶ CUSTOM IMPORT: FROM CUSTOM LOCATION ${LLM_LOCAL_PATH##*/}"

    return 0
}

select_node_model() {
    echo
    animate_text "▒▓░ The Unique Strength of Your Node ░▓▒"
    echo
    animate_text "Choose how your node will contribute its unique strengths to the collective intelligence."
    echo
    auto_select_model
    echo
    animate_text "Use setup assist options [0-2] or pick an option from three model tiers [3-23]:"
    echo
    echo "╔═════════ SETUP ASSIST OPTIONS ════════════════════════════════════════════╗"
    echo "║ 0 ⏣ SETTINGS                                                              ║"
    echo "╠═══════════════════════════════════════════════════════════════════════════╣"
    echo "║ 1 ⌖ AUTO-SELECT - Optimal configuration                                   ║"
    echo "║     Let the system determine the best model for your hardware.            ║"
    echo "║     Balanced for performance and capabilities.                            ║"
    echo "╠═══════════════════════════════════════════════════════════════════════════╣"
    echo "║ 2 ✶ IMPORT CUSTOM - Advanced configuration                                ║"
    echo "╚═══════════════════════════════════════════════════════════════════════════╝"
    echo
    echo "╔═════════ EXTREME TIER | Models with very high memory requirements"
    animate_text_x2 "║ 3 ⬢ SUPERIOR GENERALIST"
    echo "║     65.9 GB ${MEMORY_TYPE} • GPT-oss 120B Q4"
    echo "║     Frontier-level multi-step answers across coding, math, science,"
    echo "║     general knowledge questions."
    echo "║   "
    animate_text_x2 "║ 4 ⬢ SUPERIOR GENERALIST"
    echo "║     76.5 GB ${MEMORY_TYPE} • GLM-4.5-Air Q4"
    echo "║     Deliberate multi-step reasoning in logic, math, and coding;"
    echo "║     excels at clear, long-form breakdowns of complex questions."
    echo "║   "
    animate_text_x2 "║ 5 ⬢ SUPERIOR GENERALIST"
    echo "║     31.7 GB ${MEMORY_TYPE} • Nemotron-Super-49B-v1.5 Q4"
    echo "║     High-precision multi-step reasoning in general domains, math and"
    echo "║     coding; produces clear step-by-step solutions to complex problems."
    echo "╚═════════ EXTREME TIER END"
    echo
    echo "╔═════════ HEAVY TIER | Dedicating all Compute to the Node"
    animate_text_x2 "║ 6 ⬢ ADVANCED REASONING"
    echo "║     19.5 GB ${MEMORY_TYPE} • Qwen3 30B A3B Thinking 2507 Q4"
    echo "║     Long-context reasoning at high efficiency, with steady logic,"
    echo "║     math, and coding across large inputs."
    echo "║     "
    animate_text_x2 "║ 7 ⬢ PROGRAMMING & ALGORITHMS"
    echo "║     19.5 GB ${MEMORY_TYPE} • Qwen3-Coder-30B-A3B-Instruct Q4"
    echo "║     Writes robust, well-structured code with step-by-step reasoning;"
    echo "║     handles large, multi-file tasks and refactors."
    echo "║     "
    animate_text_x2 "║ 8 ⬢ ADVANCED GENERALIST"
    echo "║     12.2 GB ${MEMORY_TYPE} • gpt-oss-20b Q4"
    echo "║     Fast, capable multi-domain reasoning;"
    echo "║     solid for day-to-day coding, math, and research."
    echo "║     "
    animate_text_x2 "║ 9 ⬢ MATH, SCIENCE & CODING"
    echo "║     20.9 GB ${MEMORY_TYPE} • OpenReasoning Nemotron 32B Q4"
    echo "║     Meticulous step-by-step logic in math, science and code;"
    echo "║     great for explainable solutions and error analysis."
    echo "║     "
    animate_text_x2 "║ 10 ⬢ ADVANCED GENERALIST"
    echo "║     20.3 GB ${MEMORY_TYPE} • EXAONE 4.0 32B Q4"
    echo "║     Strong science and world knowledge with dependable math and coding;"
    echo "║     clear, well-grounded explanations."
    echo "║     "
    animate_text_x2 "║ 11 ⬢ PROGRAMMING & ALGORITHMS"
    echo "║     20.9 GB ${MEMORY_TYPE} • OlympicCoder 32B Q4"
    echo "║     Excels at contest-style algorithms;"
    echo "║     produces correct, efficient code with clear step-by-step reasoning."
    echo "║     "
    animate_text_x2 "║ 12 ⬢ ADVANCED REASONING"
    echo "║     9.6 GB ${MEMORY_TYPE} • Apriel-Nemotron-15b-Thinker Q4"
    echo "║     Deliberate, reflective multi-step reasoning across mixed tasks;"
    echo "║     steady performance on logic, math, and coding."
    echo "╚═════════ HEAVY TIER END"
    echo
    echo "╔═════════ LIGHT TIER | Operating the Node in Background"
    animate_text_x2 "║ 13 ⬢ EVERYDAY GENERALIST"
    echo "║     9.6 GB ${MEMORY_TYPE} • Qwen3 14B Q4"
    echo "║     Balanced everyday reasoning with multilingual support;"
    echo "║     clear, reliable answers across common topics."
    echo "║     "
    animate_text_x2 "║ 14 ⬢ EVERYDAY GENERALIST"
    echo "║     5.4 GB ${MEMORY_TYPE} • Qwen3 8B Q4"
    echo "║     Smooth daily Q&A with concise reasoning;"
    echo "║     dependable on summaries, explanations, and light code."
    echo "║     "
    animate_text_x2 "║ 15 ⬢ MULTILINGUAL GENERALIST"
    echo "║     7.7 GB ${MEMORY_TYPE}  • Gemma-3 4B Q4"
    echo "║     Multilingual chat with long-context support;"
    echo "║     dependable everyday assistant with clear explanations."
    echo "║     "
    animate_text_x2 "║ 16 ⬢ PROGRAMMING & ALGORITHMS"
    echo "║     9.3 GB ${MEMORY_TYPE}  • DeepCoder 14B Q4"
    echo "║     Generates accurate code and understands complex programming logic;"
    echo "║     reliable for feature drafts and fixes."
    echo "║     "
    animate_text_x2 "║ 17 ⬢ PROGRAMMING & ALGORITHMS"
    echo "║     4.8 GB ${MEMORY_TYPE}  • OlympicCoder 7B Q4"
    echo "║     Balanced coding contest solver;"
    echo "║     step-by-step algorithmic reasoning and efficient code."
    echo "║     "
    animate_text_x2 "║ 18 ⬢ MATH & FORMAL LOGIC"
    echo "║     9.3 GB ${MEMORY_TYPE}  • OpenMath-Nemotron 14B Q4"
    echo "║     Excels at math questions and structured problem-solving;"
    echo "║     clear steps for academic and competition problems."
    echo "║     "
    animate_text_x2 "║ 19 ⬢ MATH & CODING"
    echo "║     4.9 GB ${MEMORY_TYPE}  • AceReason-Nemotron-1.1-7B Q4"
    echo "║     Handles math and logic puzzles with minimal resources;"
    echo "║     concise, step-by-step solutions."
    echo "║     "
    animate_text_x2 "║ 20 ⬢ THEOREM PROVER"
    echo "║     5.4 GB ${MEMORY_TYPE}  • Kimina Prover Distill 8B Q4"
    echo "║     Specialist in formal logic and proof steps;"
    echo "║     ideal for theorem-style tasks and verification."
    echo "║     "
    animate_text_x2 "║ 21 ⬢ RUST PROGRAMMING"
    echo "║     9 GB ${MEMORY_TYPE}  • Strand-Rust-Coder 14B Q4"
    echo "║     Built by Fortytwo:"
    echo "║     Rust specialist that outputs idiomatic, compile-ready code and"
    echo "║     handles fixes/refactors; state-of-the-art on Rust benchmarks."
    echo "║     "
    animate_text_x2 "║ 22 ⬢ MEDICAL EXPERT"
    echo "║     5.4 GB ${MEMORY_TYPE}  • II-Medical-8B Q5"
    echo "║     Works through clinical Q&A step by step;"
    echo "║     useful for study and drafting (non-diagnostic)."
    echo "║     "
    animate_text_x2 "║ 23 ⬢ LOW MEMORY MODEL"
    echo "║     1.3 GB ${MEMORY_TYPE}  • Qwen3 1.7B Q4"
    echo "║     Ultra-efficient for basic instructions and quick answers;"
    echo "║     suitable for nodes with tight memory."
    echo "╚═════════ LIGHT TIER END"
    while true; do
        echo
        echo "[0] Settings"
        echo "[1] Auto"
        echo "[2] Import"
        echo "[3-23] Specialized Model"
        read -r -p "Select your node's specialization option: " NODE_CLASS
        echo
        case $NODE_CLASS in
            0)
                show_settings
                select_node_model
                ;;
            1)
                animate_text "⌖ Analyzing system for optimal configuration:"
                auto_select_model
                ;;
            2)
                select_custom_model
                if [[ $? -eq 1 ]]; then
                    select_node_model
                fi
                ;;
            3)
                LLM_HF_REPO="unsloth/gpt-oss-120b-GGUF"
                LLM_HF_MODEL_NAME="Q4_K_M/gpt-oss-120b-Q4_K_M-00001-of-00002.gguf"
                NODE_NAME="⬢ SUPERIOR GENERALIST: gpt-oss-120b Q4"
                ;;
            4)
                LLM_HF_REPO="unsloth/GLM-4.5-Air-GGUF"
                LLM_HF_MODEL_NAME="Q4_K_M/GLM-4.5-Air-Q4_K_M-00001-of-00002.gguf"
                NODE_NAME="⬢ SUPERIOR GENERALIST: GLM-4.5-Air Q4"
                ;;
            5)
                LLM_HF_REPO="unsloth/Llama-3_3-Nemotron-Super-49B-v1_5-GGUF"
                LLM_HF_MODEL_NAME="Llama-3_3-Nemotron-Super-49B-v1_5-Q4_K_M.gguf"
                NODE_NAME="⬢ SUPERIOR GENERALIST: Nemotron-Super-49B-v1.5 Q4"
                ;;
            6)
                LLM_HF_REPO="unsloth/Qwen3-30B-A3B-Thinking-2507-GGUF"
                LLM_HF_MODEL_NAME="Qwen3-30B-A3B-Thinking-2507-Q4_K_M.gguf"
                NODE_NAME="⬢ ADVANCED REASONING: Qwen3 30B A3B Thinking 2507 Q4"
                ;;
            7)
                LLM_HF_REPO="unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF"
                LLM_HF_MODEL_NAME="Qwen3-Coder-30B-A3B-Instruct-Q4_K_M.gguf"
                NODE_NAME="⬢ PROGRAMMING & ALGORITHMS: Qwen3-Coder-30B-A3B-Instruct Q4"
                ;;
            8)
                LLM_HF_REPO="unsloth/gpt-oss-20b-GGUF"
                LLM_HF_MODEL_NAME="gpt-oss-20b-Q4_K_M.gguf"
                NODE_NAME="⬢ ADVANCED GENERALIST: gpt-oss-20b Q4"
                ;;
            9)
                LLM_HF_REPO="unsloth/OpenReasoning-Nemotron-32B-GGUF"
                LLM_HF_MODEL_NAME="OpenReasoning-Nemotron-32B-Q4_K_M.gguf"
                NODE_NAME="⬢ MATH, SCIENCE & CODING: OpenReasoning Nemotron 32B Q4"
                ;;
            10)
                LLM_HF_REPO="LGAI-EXAONE/EXAONE-4.0-32B-GGUF"
                LLM_HF_MODEL_NAME="LGAI-EXAONE_EXAONE-4.0-32B-Q4_K_M.gguf"
                NODE_NAME="⬢ ADVANCED GENERALIST: EXAONE 4.0 32B Q4"
                ;;
            11)
                LLM_HF_REPO="bartowski/open-r1_OlympicCoder-32B-GGUF"
                LLM_HF_MODEL_NAME="open-r1_OlympicCoder-32B-Q4_K_M.gguf"
                NODE_NAME="⬢ PROGRAMMING & ALGORITHMS: OlympicCoder 32B Q4"
                ;;
            12)
                LLM_HF_REPO="bartowski/ServiceNow-AI_Apriel-Nemotron-15b-Thinker-GGUF"
                LLM_HF_MODEL_NAME="ServiceNow-AI_Apriel-Nemotron-15b-Thinker-Q4_K_M.gguf"
                NODE_NAME="⬢ ADVANCED REASONING: Apriel-Nemotron-15b-Thinker Q4"
                ;;
            13)
                LLM_HF_REPO="unsloth/Qwen3-14B-GGUF"
                LLM_HF_MODEL_NAME="Qwen3-14B-Q4_K_M.gguf"
                NODE_NAME="⬢ EVERYDAY GENERALIST: Qwen3 14B Q4"
                ;;
            14)
                LLM_HF_REPO="unsloth/Qwen3-8B-GGUF"
                LLM_HF_MODEL_NAME="Qwen3-8B-Q4_K_M.gguf"
                NODE_NAME="⬢ EVERYDAY GENERALIST: Qwen3 8B Q4"
                ;;
            15)
                LLM_HF_REPO="unsloth/gemma-3-12b-it-GGUF"
                LLM_HF_MODEL_NAME="gemma-3-12b-it-Q4_K_M.gguf"
                NODE_NAME="⬢ MULTILINGUAL GENERALIST: Gemma-3 4B Q4"
                ;;
            16)
                LLM_HF_REPO="bartowski/agentica-org_DeepCoder-14B-Preview-GGUF"
                LLM_HF_MODEL_NAME="agentica-org_DeepCoder-14B-Preview-Q4_K_M.gguf"
                NODE_NAME="⬢ PROGRAMMING & ALGORITHMS: DeepCoder 14B Q4"
                ;;
            17)
                LLM_HF_REPO="bartowski/open-r1_OlympicCoder-7B-GGUF"
                LLM_HF_MODEL_NAME="open-r1_OlympicCoder-7B-Q4_K_M.gguf"
                NODE_NAME="⬢ PROGRAMMING & ALGORITHMS: OlympicCoder 7B Q4"
                ;;
            18)
                LLM_HF_REPO="bartowski/nvidia_OpenMath-Nemotron-14B-GGUF"
                LLM_HF_MODEL_NAME="nvidia_OpenMath-Nemotron-14B-Q4_K_M.gguf"
                NODE_NAME="⬢ MATH & FORMAL LOGIC: OpenMath-Nemotron 14B Q4"
                ;;
            19)
                LLM_HF_REPO="bartowski/nvidia_AceReason-Nemotron-1.1-7B-GGUF"
                LLM_HF_MODEL_NAME="nvidia_AceReason-Nemotron-1.1-7B-Q4_K_M.gguf"
                NODE_NAME="⬢ MATH & CODING: AceReason-Nemotron-1.1-7B Q4"
                ;;
            20)
                LLM_HF_REPO="mradermacher/Kimina-Prover-Distill-8B-GGUF"
                LLM_HF_MODEL_NAME="Kimina-Prover-Distill-8B.Q4_K_M.gguf"
                NODE_NAME="⬢ THEOREM PROVER: Kimina Prover Distill 8B Q4"
                ;;
            21)
                LLM_HF_REPO="Fortytwo-Network/Strand-Rust-Coder-14B-v1-GGUF"
                LLM_HF_MODEL_NAME="Fortytwo_Strand-Rust-Coder-14B-v1-Q4_K_M.gguf"
                NODE_NAME="⬢ RUST PROGRAMMING: Strand-Rust-Coder 14B Q4"
                ;;
            22)
                LLM_HF_REPO="Intelligent-Internet/II-Medical-8B-1706-GGUF"
                LLM_HF_MODEL_NAME="II-Medical-8B-1706.Q4_K_M.gguf"
                NODE_NAME="⬢ MEDICAL EXPERT: II-Medical-8B Q5"
                ;;
            23)
                LLM_HF_REPO="unsloth/Qwen3-1.7B-GGUF"
                LLM_HF_MODEL_NAME="Qwen3-1.7B-Q4_K_M.gguf"
                NODE_NAME="⬢ LOW MEMORY MODEL: Qwen3 1.7B Q4"
                ;;
            *)
                echo "✕ Incorrect input."
                continue
                ;;
        esac
        break
    done
    echo "You chose:"
    animate_text "${NODE_NAME}"
}

select_node_model
echo
if [[ "$LLM_IS_LOCAL_PATH" == false ]]; then
    animate_text "    ↳ Downloading the model and preparing the environment may take several minutes..."
    "$UTILS_EXEC" --hf-repo "$LLM_HF_REPO" --hf-model-name "$LLM_HF_MODEL_NAME" --model-cache "$PROJECT_MODEL_CACHE_DIR"
    echo
fi
animate_text "Setup completed. Ready to launch."
# clear
animate_text_x2 "$BANNER_FULLNAME"

startup() {
    animate_text "⎔ Starting Capsule..."

    CMD_ARGS=(
        --model-cache "$PROJECT_MODEL_CACHE_DIR"
        --kv-size-mode "$KV_CACHE_MODE"
    )

    if [[ "$LLM_IS_LOCAL_PATH" == "true" ]]; then
        CMD_ARGS+=(--llm-model-path "$LLM_LOCAL_PATH")
    else
        CMD_ARGS+=(--llm-hf-repo "$LLM_HF_REPO")
        CMD_ARGS+=(--llm-hf-model-name "$LLM_HF_MODEL_NAME")
    fi

    if [[ "$KV_CACHE_TOKENS" == "true" ]]; then
        CMD_ARGS+=(--kv-size-tokens "$KV_CACHE_TOKENS_SIZE")
    fi

    if [[ "$KV_CACHE_GB" == "true" ]]; then
        CMD_ARGS+=(--kv-size-gb "$KV_CACHE_GB_SIZE")
    fi

    "$CAPSULE_EXEC" "${CMD_ARGS[@]}" > "$CAPSULE_LOGS" 2>&1 &
    CAPSULE_PID=$!
    animate_text "Be patient, it may take some time."
    while true; do
        STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$CAPSULE_READY_URL")
        if [[ "$STATUS_CODE" == "200" ]]; then
            animate_text "Capsule is ready."
            break
        else
            # Capsule is not ready. Retrying in 5 seconds...
            sleep 5
        fi
        if ! kill -0 "$CAPSULE_PID" 2>/dev/null; then
            echo -e "\033[0;31mCapsule process exited (PID: $CAPSULE_PID)\033[0m"
            if [[ -f "$CAPSULE_LOGS" ]]; then
                tail -n 1 "$CAPSULE_LOGS"
        fi
            exit 1
        fi
    done
    animate_text "⏃ Starting Protocol..."
    echo
    animate_text "Joining ::||"
    echo
    "$PROTOCOL_EXEC" --account-private-key "$ACCOUNT_PRIVATE_KEY" &
    PROTOCOL_PID=$!
}

cleanup() {
    echo
    capsule_stopped=$(kill -0 "$CAPSULE_PID" 2>/dev/null && kill "$CAPSULE_PID" 2>/dev/null && echo true || echo false)
    [ "$capsule_stopped" = true ] && animate_text "⎔ Stopping capsule..."

    protocol_stopped=$(kill -0 "$PROTOCOL_PID" 2>/dev/null && kill "$PROTOCOL_PID" 2>/dev/null && echo true || echo false)
    [ "$protocol_stopped" = true ] && animate_text "⏃ Stopping protocol..."

    if [ "$capsule_stopped" = true ] || [ "$protocol_stopped" = true ]; then
        animate_text "Processes stopped"
        animate_text "Bye, Noderunner"
    fi
    exit 0
}

startup
trap cleanup SIGINT SIGTERM SIGHUP EXIT

while true; do
    IS_ALIVE="true"
    if ! ps -p "$CAPSULE_PID" > /dev/null; then
        wait "$CAPSULE_PID"
        CAPSULE_EXIT_CODE=$?
        animate_text "Capsule has stopped with exit code: $CAPSULE_EXIT_CODE"
        IS_ALIVE="false"
    fi

    if ! ps -p "$PROTOCOL_PID" > /dev/null; then
        wait "$PROTOCOL_PID"
        PROTOCOL_EXIT_CODE=$?
        animate_text "Node has stopped with exit code: $PROTOCOL_EXIT_CODE"
        if [ "$PROTOCOL_EXIT_CODE" -eq 20 ]; then
            animate_text "New protocol version is available!"
            PROTOCOL_VERSION=$(curl -s "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/protocol/latest")
            animate_text "⏃ Protocol Node — version $PROTOCOL_VERSION"
            DOWNLOAD_PROTOCOL_URL="https://fortytwo-network-public.s3.us-east-2.amazonaws.com/protocol/v$PROTOCOL_VERSION/FortytwoProtocolNode-linux-amd64"
            animate_text "    ↳ Updating..."
            curl -L -o "$PROTOCOL_EXEC" "$DOWNLOAD_PROTOCOL_URL"
            chmod +x "$PROTOCOL_EXEC"
            animate_text "    ✓ Successfully updated"
        fi
        IS_ALIVE="false"
    fi

    if [[ $IS_ALIVE == "false" ]]; then
        echo "Capsule or Protocol process has stopped. Restarting..."
        kill "$CAPSULE_PID" 2>/dev/null
        kill "$PROTOCOL_PID" 2>/dev/null
        startup
    fi

    sleep 5
done
