#!/bin/bash

animate_text() {
    local text="$1"
    for ((i=0; i<${#text}; i++)); do
        echo -n "${text:$i:1}"
        sleep 0.01
    done
    echo
}

auto_select_model() {
    AVAILABLE_MEM=$(( $(sysctl -n hw.memsize) / 1024 / 1024 / 1024 ))
    animate_text "System analysis: ${AVAILABLE_MEM}GB RAM detected"
    if [ $AVAILABLE_MEM -ge 16 ]; then
        animate_text "Recommended: SENTINEL for high-performance systems"
        LLM_HF_REPO="bartowski/INTELLECT-1-Instruct-GGUF"
        LLM_HF_MODEL_NAME="INTELLECT-1-Instruct-Q4_K_M.gguf"
        NODE_NAME="Sentinel"
    elif [ $AVAILABLE_MEM -ge 8 ]; then
        animate_text "Recommended: NEXUS for balanced capability"
        LLM_HF_REPO="bartowski/Llama-3.2-3B-Instruct-GGUF"
        LLM_HF_MODEL_NAME="Llama-3.2-3B-Instruct-Q4_K_M.gguf"
        NODE_NAME="Nexus"
    else
        animate_text "Recommended: NEXUS optimized for efficiency"
        LLM_HF_REPO="Qwen/Qwen2.5-1.5B-Instruct-GGUF"
        LLM_HF_MODEL_NAME="qwen2.5-1.5b-instruct-q4_k_m.gguf"
        NODE_NAME="Nexus-Compact"
    fi
}

BANNER="
███████╗ ██████╗ ██████╗ ████████╗██╗   ██╗████████╗██╗    ██╗ ██████╗
██╔════╝██╔═══██╗██╔══██╗╚══██╔══╝╚██╗ ██╔╝╚══██╔══╝██║    ██║██╔═══██╗
█████╗  ██║   ██║██████╔╝   ██║    ╚████╔╝    ██║   ██║ █╗ ██║██║   ██║
██╔══╝  ██║   ██║██╔══██╗   ██║     ╚██╔╝     ██║   ██║███╗██║██║   ██║
██║     ╚██████╔╝██║  ██║   ██║      ██║      ██║   ╚███╔███╔╝╚██████╔╝
╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝      ╚═╝      ╚═╝    ╚══╝╚══╝  ╚═════╝

███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝
██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗
██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
"
echo "$BANNER"
animate_text "Welcome to the FortytwoNode Network - Join the Decentralized AI Revolution!"
echo
PROJECT_DIR="./FortytwoNode"
PROJECT_DEBUG_DIR="$PROJECT_DIR/debug"

CAPSULE_EXEC="$PROJECT_DIR/FortytwoCapsule"
CAPSULE_LOGS="$PROJECT_DEBUG_DIR/FortytwoCapsule.logs"
CAPSULE_READY_URL="http://0.0.0.0:42442/ready"

PROTOCOL_EXEC="$PROJECT_DIR/FortytwoProtocol"
PROTOCOL_DB_DIR="$PROJECT_DEBUG_DIR/internal_db"

ACCOUNT_PRIVATE_KEY_FILE="$PROJECT_DIR/.account_private_key"

DOWNLOAD_UTILS_URL="https://fortytwo-network-public.s3.us-east-2.amazonaws.com/utilities/FortytwoUtilsDarwin"
UTILS_EXEC="$PROJECT_DIR/FortytwoUtils"

animate_text "Preparing your node environment..."

if [[ ! -d "$PROJECT_DEBUG_DIR" ]]; then
    mkdir -p "$PROJECT_DEBUG_DIR"
    animate_text "Project directory created: $PROJECT_DIR"
else
    animate_text "Project directory already exists: $PROJECT_DIR"
fi

if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Please install curl using 'brew install curl' and re-run the script."
    exit 1
fi

animate_text "Checking for the latest software versions..."

PROTOCOL_VERSION=$(curl -s "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/protocol/latest")
animate_text "Latest protocol version is $PROTOCOL_VERSION"
DOWNLOAD_PROTOCOL_URL="https://fortytwo-network-public.s3.us-east-2.amazonaws.com/protocol/v$PROTOCOL_VERSION/FortytwoProtocolNode-darwin"

CAPSULE_VERSION=$(curl -s "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/latest")
animate_text "Latest capsule version is $CAPSULE_VERSION"
DOWNLOAD_CAPSULE_URL="https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/v$CAPSULE_VERSION/FortytwoCapsule-darwin"

animate_text "Downloading and configuring core components..."

if [[ -f "$CAPSULE_EXEC" ]]; then
    CURRENT_CAPSULE_VERSION_OUTPUT=$("$CAPSULE_EXEC" --version 2>/dev/null)
    if [[ "$CURRENT_CAPSULE_VERSION_OUTPUT" == *"$CAPSULE_VERSION"* ]]; then
        animate_text "Capsule is already up to date (version found: $CURRENT_CAPSULE_VERSION_OUTPUT). Skipping download."
    else
        curl -L -o "$CAPSULE_EXEC" "$DOWNLOAD_CAPSULE_URL"
        chmod +x "$CAPSULE_EXEC"
        animate_text "Capsule downloaded to: $CAPSULE_EXEC"
    fi
else
    curl -L -o "$CAPSULE_EXEC" "$DOWNLOAD_CAPSULE_URL"
    chmod +x "$CAPSULE_EXEC"
    animate_text "Capsule downloaded to: $CAPSULE_EXEC"
fi

if [[ -f "$PROTOCOL_EXEC" ]]; then
    CURRENT_PROTOCOL_VERSION_OUTPUT=$("$PROTOCOL_EXEC" --version 2>/dev/null)
    if [[ "$CURRENT_PROTOCOL_VERSION_OUTPUT" == *"$PROTOCOL_VERSION"* ]]; then
        animate_text "Node is already up to date (version found: $CURRENT_PROTOCOL_VERSION_OUTPUT). Skipping download."
    else
        animate_text "Node is outdated (found version: $CURRENT_PROTOCOL_VERSION_OUTPUT, expected: $PROTOCOL_VERSION). Downloading new version..."
        curl -L -o "$PROTOCOL_EXEC" "$DOWNLOAD_PROTOCOL_URL"
        chmod +x "$PROTOCOL_EXEC"
        animate_text "Node downloaded to: $PROTOCOL_EXEC"
    fi
else
    curl -L -o "$PROTOCOL_EXEC" "$DOWNLOAD_PROTOCOL_URL"
    chmod +x "$PROTOCOL_EXEC"
    animate_text "Node downloaded to: $PROTOCOL_EXEC"
fi
if [[ ! -f "$UTILS_EXEC" ]]; then
    curl -L -o "$UTILS_EXEC" "$DOWNLOAD_UTILS_URL"
    chmod +x "$UTILS_EXEC"
fi
echo
animate_text "Time to choose your node's specialization!"
echo
echo "Every AI node in the Fortytwo Network has unique strengths."
echo "Choose how your node will contribute to the collective intelligence:"
echo
echo "╔═══════════════════════════════════════════════════════════════════════════╗"
echo "║ 0. ⦿  AUTO-SELECT - Optimal Configuration                                 ║"
echo "║    Let the system determine the best model for your hardware.             ║"
echo "║    Balanced for performance and capabilities.                             ║"
echo "╠═══════════════════════════════════════════════════════════════════════════╣"
echo "║ 1. ◉  NOUMENAL PYLON - General Knowledge                                  ║"
echo "║    Versatile multi-domain intelligence core with balanced capabilities.   ║"
echo "║    Model: Llama-3.2-3B-Instruct (2.2GB VRAM)                              ║"
echo "╠═══════════════════════════════════════════════════════════════════════════╣"
echo "║ 2. ⬢  TELEOLOGY PYLON - Advanced Reasoning                                ║"
echo "║    High-precision logical analysis matrix optimized for problem-solving.  ║"
echo "║    Model: INTELLECT-1-Instruct (6.5GB VRAM)                               ║"
echo "╠═══════════════════════════════════════════════════════════════════════════╣"
echo "║ 3. ⌬  MACHINIC PYLON - Programming & Technical                            ║"
echo "║    Specialized system for code synthesis and framework construction.      ║"
echo "║    Model: Qwen2.5-Coder-7B-Instruct (4.8GB VRAM)                          ║"
echo "╠═══════════════════════════════════════════════════════════════════════════╣"
echo "║ 4. ⎔  SCHOLASTIC PYLON - Academic Knowledge                               ║"
echo "║    Advanced data integration and research synthesis protocol.             ║"
echo "║    Model: Ministral-8B-Instruct-2410 (5.2GB VRAM)                         ║"
echo "╠═══════════════════════════════════════════════════════════════════════════╣"
echo "║ 5. ⌖  LOGOTOPOLOGY PYLON - Language & Writing                             ║"
echo "║    Enhanced natural language and communication protocol interface.        ║"
echo "║    Model: Qwen2.5-7B-Instruct (4.8GB VRAM)                                ║"
echo "╠═══════════════════════════════════════════════════════════════════════════╣"
echo "║ 6. ⎋  CUSTOM - Advanced Configuration                                     ║"
echo "╚═══════════════════════════════════════════════════════════════════════════╝"
echo

read -r -p "Select your node's specialization [0-6] (0 for auto-select): " NODE_CLASS

case $NODE_CLASS in
    0)
        animate_text "Analyzing system for optimal configuration..."
        auto_select_model
        ;;
    1)
        LLM_HF_REPO="bartowski/Llama-3.2-3B-Instruct-GGUF"
        LLM_HF_MODEL_NAME="Llama-3.2-3B-Instruct-Q4_K_M.gguf"
        NODE_NAME="NOUMENAL PYLON"
        ;;
    2)
        LLM_HF_REPO="bartowski/INTELLECT-1-Instruct-GGUF"
        LLM_HF_MODEL_NAME="INTELLECT-1-Instruct-Q4_K_M.gguf"
        NODE_NAME="TELEOLOGY PYLON"
        ;;
    3)
        LLM_HF_REPO="Qwen/Qwen2.5-Coder-7B-Instruct-GGUF"
        LLM_HF_MODEL_NAME="qwen2.5-coder-7b-instruct-q4_k_m-00001-of-00002.gguf"
        NODE_NAME="MACHINIC PYLON"
        ;;
    4)
        LLM_HF_REPO="bartowski/Ministral-8B-Instruct-2410-GGUF"
        LLM_HF_MODEL_NAME="Ministral-8B-Instruct-2410-Q4_K_M.gguf"
        NODE_NAME="SCHOLASTIC PYLON"
        ;;
    5)
        LLM_HF_REPO="Qwen/Qwen2.5-7B-Instruct-GGUF"
        LLM_HF_MODEL_NAME="qwen2.5-7b-instruct-q4_k_m-00001-of-00002.gguf"
        NODE_NAME="LOGOTOPOLOGY PYLON"
        ;;
    6)
        echo
        echo "═════════════════════ ADVANCED SETUP ═════════════════════"
        echo "This option is for users familiar with language models"
        echo

        read -r -p "Enter HuggingFace repository (e.g., Qwen/Qwen2.5-3B-Instruct-GGUF): " LLM_HF_REPO
        read -r -p "Enter model filename (e.g., qwen2.5-3b-instruct-q4_k_m.gguf): " LLM_HF_MODEL_NAME
        NODE_NAME="Custom (HF: ${LLM_HF_REPO##*/})"
        ;;
    *)
        animate_text "No selection made. Proceeding with auto-select..."
        auto_select_model
        ;;
esac
animate_text "${NODE_NAME} is selected"
animate_text "Downloading model and preparing the environment (this may take several minutes)..."
"$UTILS_EXEC" --hf-repo "$LLM_HF_REPO" --hf-model-name "$LLM_HF_MODEL_NAME"

if [[ -f "$ACCOUNT_PRIVATE_KEY_FILE" ]]; then
    ACCOUNT_PRIVATE_KEY=$(cat "$ACCOUNT_PRIVATE_KEY_FILE")
    animate_text "Using saved account private key."
else
    while true; do
        read -r -p "Enter your account recovery phrase (12, 18, or 24 words), then press Enter: " ACCOUNT_SEED_PHRASE
        echo
        if ! ACCOUNT_PRIVATE_KEY=$("$UTILS_EXEC" --phrase "$ACCOUNT_SEED_PHRASE"); then
            echo "Error: Please check the recovery phrase and try again."
            continue
        else
            echo "$ACCOUNT_PRIVATE_KEY" > "$ACCOUNT_PRIVATE_KEY_FILE"
            echo "Private key saved."
            break
        fi
    done
fi

animate_text "Setup completed."
clear
echo "$BANNER"
animate_text "Starting Capsule.."
"$CAPSULE_EXEC" --llm-hf-repo "$LLM_HF_REPO" --llm-hf-model-name "$LLM_HF_MODEL_NAME" > "$CAPSULE_LOGS" 2>&1 &
CAPSULE_PID=$!
animate_text "Be patient during the first launch of the capsule; it will take some time."
while true; do
    STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$CAPSULE_READY_URL")
    if [[ "$STATUS_CODE" == "200" ]]; then
        animate_text "Capsule is ready!"
        break
    else
        # Capsule is not ready. Retrying in 5 seconds...
        sleep 5
    fi
done

animate_text "Starting Protocol.."
"$PROTOCOL_EXEC" --account-private-key "$ACCOUNT_PRIVATE_KEY" --db-folder "$PROTOCOL_DB_DIR" &
PROTOCOL_PID=$!

cleanup() {
    animate_text "Stopping capsule..."
    kill "$CAPSULE_PID"
    animate_text "Stopping protocol..."
    kill "$PROTOCOL_PID"
    animate_text "Processes stopped. Exiting."
    exit 0
}

trap cleanup SIGINT SIGTERM EXIT

while true; do
    if ! ps -p "$CAPSULE_PID" > /dev/null; then
        animate_text "Capsule has stopped."
        exit 1
    fi

    if ! ps -p "$PROTOCOL_PID" > /dev/null; then
        animate_text "Node has stopped."
        exit 1
    fi

    sleep 5
done
