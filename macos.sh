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

    TOTAL_BYTES=$(sysctl -n hw.memsize)
    TOTAL_MEM=$(( TOTAL_BYTES / 1024 / 1024 / 1024 ))

    # Page size
    PAGESIZE=$(sysctl -n hw.pagesize)

    # Available (htop-style) = total - (active + wired)
    AVAILABLE_MEM=$(vm_stat | awk -v P="$PAGESIZE" -v T="$TOTAL_BYTES" '
        /Pages active/ {a=$NF}
        /Pages wired/  {w=$NF}
        END{
          gsub(/[^0-9]/,"",a); gsub(/[^0-9]/,"",w);
          usedb=(a+w)*P;
          availb=T-usedb; if (availb < 0) availb=0;
          # floor to GiB for selection thresholds
          printf "%d", int(availb/1024/1024/1024);
        }')

    # Fallback if vm_stat parsing fails
    if [[ -z "$AVAILABLE_MEM" || "$AVAILABLE_MEM" -le 0 ]]; then
        AVAILABLE_MEM=$TOTAL_MEM
    fi

    animate_text "    ↳ System analysis:"
    animate_text "    ↳ ${TOTAL_MEM} GB ${MEMORY_TYPE} total, ${AVAILABLE_MEM} GB ${MEMORY_TYPE} available"

    if [ $AVAILABLE_MEM -ge 30 ]; then
        animate_text "    🜲 Recommending: ⬢ 6 Qwen3 for problem solving & coding"
        LLM_HF_REPO="unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF"
        LLM_HF_MODEL_NAME="Qwen3-Coder-30B-A3B-Instruct-Q4_K_M.gguf"
        NODE_NAME="Qwen3 Coder 30B A3B Instruct Q4"
    elif [ $AVAILABLE_MEM -ge 22 ]; then
        animate_text "    🜲 Recommending: ⬢ 12 Qwen3 14B for high-precision logical analysis"
        LLM_HF_REPO="unsloth/Qwen3-14B-GGUF"
        LLM_HF_MODEL_NAME="Qwen3-14B-Q4_K_M.gguf"
        NODE_NAME="Qwen3 14B Q4"
    elif [ $AVAILABLE_MEM -ge 15 ]; then
        animate_text "    🜲 Recommending: ⬢ 13 Qwen3 8B for balanced capability"
        LLM_HF_REPO="unsloth/Qwen3-8B-GGUF"
        LLM_HF_MODEL_NAME="Qwen3-8B-Q4_K_M.gguf"
        NODE_NAME="Qwen3 8B Q4"
    else
        animate_text "    🜲 Recommending: ⬢ 22 Qwen3 1.7B optimized for efficiency"
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
if [ "$(uname -m)" != "arm64" ]; then
    echo "    ✕ ERROR: Unsupported Mac architecture detected. This node application requires a Mac with Apple Silicon (M1 chip or later). Intel-based Macs are not supported. Please refer to our hardware requirements for more details: https://docs.fortytwo.network/docs/hardware-requirements"
    exit 1
fi
if [ $(( $(sysctl -n hw.memsize) / 1024 / 1024 / 1024 )) -lt 7 ]; then
    echo "    ✕ ERROR: Insufficient memory. Your system's available Unified Memory does not meet the minimum requirements to run this node. Please check the hardware requirements in our documentation: https://docs.fortytwo.network/docs/hardware-requirements"
    exit 1
fi
MEMORY_TYPE="RAM"
PROJECT_DIR="./FortytwoNode"
PROJECT_DEBUG_DIR="$PROJECT_DIR/debug"
PROJECT_MODEL_CACHE_DIR="$PROJECT_DIR/model_cache"

CAPSULE_EXEC="$PROJECT_DIR/FortytwoCapsule"
CAPSULE_LOGS="$PROJECT_DEBUG_DIR/FortytwoCapsule.logs"
CAPSULE_READY_URL="http://0.0.0.0:42442/ready"

PROTOCOL_EXEC="$PROJECT_DIR/FortytwoProtocol"

ACCOUNT_PRIVATE_KEY_FILE="$PROJECT_DIR/.account_private_key"

UTILS_EXEC="$PROJECT_DIR/FortytwoUtils"

animate_text "Preparing your node environment..."

if [[ ! -d "$PROJECT_DEBUG_DIR" || ! -d "$PROJECT_MODEL_CACHE_DIR" ]]; then
    mkdir -p "$PROJECT_DEBUG_DIR" "$PROJECT_MODEL_CACHE_DIR"
    echo
    # animate_text "Project directory created: $PROJECT_DIR"
else
    echo
    # animate_text "Project directory already exists: $PROJECT_DIR"
fi

if ! command -v curl &> /dev/null; then
    echo "    ↳ Curl is not installed. Please install curl using 'brew install curl' and re-run the script."
    exit 1
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
INSTALLER_UPDATE_URL="https://raw.githubusercontent.com/Fortytwo-Network/fortytwo-console-app/main/macos.sh"
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
DOWNLOAD_CAPSULE_URL="https://fortytwo-network-public.s3.us-east-2.amazonaws.com/capsule/v$CAPSULE_VERSION/FortytwoCapsule-darwin"
if [[ -f "$CAPSULE_EXEC" ]]; then
    CURRENT_CAPSULE_VERSION_OUTPUT=$("$CAPSULE_EXEC" --version 2>/dev/null)
    if [[ "$CURRENT_CAPSULE_VERSION_OUTPUT" == *"$CAPSULE_VERSION"* ]]; then
        animate_text "    ✓ Up to date"
    else
        animate_text "    ↳ Updating..."
        curl -L -o "$CAPSULE_EXEC" "$DOWNLOAD_CAPSULE_URL"
        chmod +x "$CAPSULE_EXEC"
        animate_text "    ✓ Successfully updated"
    fi
else
    animate_text "    ↳ Downloading..."
    curl -L -o "$CAPSULE_EXEC" "$DOWNLOAD_CAPSULE_URL"
    chmod +x "$CAPSULE_EXEC"
    animate_text "    ✓ Installed to: $CAPSULE_EXEC"
fi
PROTOCOL_VERSION=$(curl -s "https://fortytwo-network-public.s3.us-east-2.amazonaws.com/protocol/latest")
animate_text "⏃ Protocol Node — version $PROTOCOL_VERSION"
DOWNLOAD_PROTOCOL_URL="https://fortytwo-network-public.s3.us-east-2.amazonaws.com/protocol/v$PROTOCOL_VERSION/FortytwoProtocolNode-darwin"
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
DOWNLOAD_UTILS_URL="https://fortytwo-network-public.s3.us-east-2.amazonaws.com/utilities/v$UTILS_VERSION/FortytwoUtilsDarwin"
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
            read -r -p "Enter your identity recovery phrase (12, 18, or 24 words), then press Enter: " ACCOUNT_SEED_PHRASE
            echo
            if ! ACCOUNT_PRIVATE_KEY=$("$UTILS_EXEC" --phrase "$ACCOUNT_SEED_PHRASE"); then
                echo "˙◠˙ Error: Please check the recovery phrase and try again."
                continue
            else
                echo "$ACCOUNT_PRIVATE_KEY" > "$ACCOUNT_PRIVATE_KEY_FILE"
                animate_text "˙ᵕ˙ The identity successfully restored!"
                animate_text "    ↳ Private key saved to $PROJECT_DIR/.account_private_key."
                animate_text "    ⚠ Keep the key secure. Do not share with anybody."
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
            if [ "$user_input" = "I wrote down my recovery phrase" ]; then
                break
            fi
            echo "Incorrect input. Please type 'I wrote down my recovery phrase' to continue."
        done
    fi
fi
echo
animate_text "▒▓░ The Unique Strength of Your Node ░▓▒"
echo
animate_text "Choose how your node will contribute its unique strengths to the collective intelligence."
echo
auto_select_model
echo
animate_text "Use setup assist options [0-1] or pick an option from three model tiers [2-22]:"
echo
echo "╔═══════════════════════════════════════════════════════════════════════════╗"
animate_text_x2 "║ 0 ⌖ AUTO-SELECT - Optimal configuration                                   ║"
echo "║     Let the system determine the best model for your hardware.            ║"
echo "║     Balanced for performance and capabilities.                            ║"
echo "╠═══════════════════════════════════════════════════════════════════════════╣"
animate_text_x2 "║ 1 ✶ IMPORT CUSTOM - Advanced configuration                                ║"
echo "╚═══════════════════════════════════════════════════════════════════════════╝"
echo
echo "╔═════════ EXTREME TIER | Models with very high memory requirements"
animate_text_x2 "║ 2 ⬢ SUPERIOR GENERALIST"
echo "║     65.9 GB ${MEMORY_TYPE} • GPT-oss 120B Q4"
echo "║     Frontier-level multi-step answers across coding, math, science,"
echo "║     general knowledge questions."
echo "║   "
animate_text_x2 "║ 3 ⬢ SUPERIOR GENERALIST"
echo "║     76.5 GB ${MEMORY_TYPE} • GLM-4.5-Air Q4"
echo "║     Deliberate multi-step reasoning in logic, math, and coding;"
echo "║     excels at clear, long-form breakdowns of complex questions."
echo "║   "
animate_text_x2 "║ 4 ⬢ SUPERIOR GENERALIST"
echo "║     31.7 GB ${MEMORY_TYPE} • Nemotron-Super-49B-v1.5 Q4"
echo "║     High-precision multi-step reasoning in general domains, math and"
echo "║     coding; produces clear step-by-step solutions to complex problems."
echo "╚═════════ EXTREME TIER END"
echo
echo "╔═════════ HEAVY TIER | Dedicating all Compute to the Node"
animate_text_x2 "║ 5 ⬢ ADVANCED REASONING"
echo "║     19.5 GB ${MEMORY_TYPE} • Qwen3 30B A3B Thinking 2507 Q4"
echo "║     Long-context reasoning at high efficiency, with steady logic,"
echo "║     math, and coding across large inputs."
echo "║     "
animate_text_x2 "║ 6 ⬢ PROGRAMMING & ALGORITHMS"
echo "║     19.5 GB ${MEMORY_TYPE} • Qwen3-Coder-30B-A3B-Instruct Q4"
echo "║     Writes robust, well-structured code with step-by-step reasoning;"
echo "║     handles large, multi-file tasks and refactors."
echo "║     "
animate_text_x2 "║ 7 ⬢ ADVANCED GENERALIST"
echo "║     12.2 GB ${MEMORY_TYPE} • gpt-oss-20b Q4"
echo "║     Fast, capable multi-domain reasoning;"
echo "║     solid for day-to-day coding, math, and research."
echo "║     "
animate_text_x2 "║ 8 ⬢ MATH, SCIENCE & CODING"
echo "║     20.9 GB ${MEMORY_TYPE} • OpenReasoning Nemotron 32B Q4"
echo "║     Meticulous step-by-step logic in math, science and code;"
echo "║     great for explainable solutions and error analysis."
echo "║     "
animate_text_x2 "║ 9 ⬢ ADVANCED GENERALIST"
echo "║     20.3 GB ${MEMORY_TYPE} • EXAONE 4.0 32B Q4"
echo "║     Strong science and world knowledge with dependable math and coding;"
echo "║     clear, well-grounded explanations."
echo "║     "
animate_text_x2 "║ 10 ⬢ PROGRAMMING & ALGORITHMS"
echo "║     20.9 GB ${MEMORY_TYPE} • OlympicCoder 32B Q4"
echo "║     Excels at contest-style algorithms;"
echo "║     produces correct, efficient code with clear step-by-step reasoning."
echo "║     "
animate_text_x2 "║ 11 ⬢ ADVANCED REASONING"
echo "║     9.6 GB ${MEMORY_TYPE} • Apriel-Nemotron-15b-Thinker Q4"
echo "║     Deliberate, reflective multi-step reasoning across mixed tasks;"
echo "║     steady performance on logic, math, and coding."
echo "╚═════════ HEAVY TIER END"
echo
echo "╔═════════ LIGHT TIER | Operating the Node in Background"
animate_text_x2 "║ 12 ⬢ EVERYDAY GENERALIST"
echo "║     9.6 GB ${MEMORY_TYPE} • Qwen3 14B Q4"
echo "║     Balanced everyday reasoning with multilingual support;"
echo "║     clear, reliable answers across common topics."
echo "║     "
animate_text_x2 "║ 13 ⬢ EVERYDAY GENERALIST"
echo "║     5.4 GB ${MEMORY_TYPE} • Qwen3 8B Q4"
echo "║     Smooth daily Q&A with concise reasoning;"
echo "║     dependable on summaries, explanations, and light code."
echo "║     "
animate_text_x2 "║ 14 ⬢ MULTILINGUAL GENERALIST"
echo "║     7.7 GB ${MEMORY_TYPE}  • Gemma-3 4B Q4"
echo "║     Multilingual chat with long-context support;"
echo "║     dependable everyday assistant with clear explanations."
echo "║     "
animate_text_x2 "║ 15 ⬢ PROGRAMMING & ALGORITHMS"
echo "║     9.3 GB ${MEMORY_TYPE}  • DeepCoder 14B Q4"
echo "║     Generates accurate code and understands complex programming logic;"
echo "║     reliable for feature drafts and fixes."
echo "║     "
animate_text_x2 "║ 16 ⬢ PROGRAMMING & ALGORITHMS"
echo "║     4.8 GB ${MEMORY_TYPE}  • OlympicCoder 7B Q4"
echo "║     Balanced coding contest solver;"
echo "║     step-by-step algorithmic reasoning and efficient code."
echo "║     "
animate_text_x2 "║ 17 ⬢ MATH & FORMAL LOGIC"
echo "║     9.3 GB ${MEMORY_TYPE}  • OpenMath-Nemotron 14B Q4"
echo "║     Excels at math questions and structured problem-solving;"
echo "║     clear steps for academic and competition problems."
echo "║     "
animate_text_x2 "║ 18 ⬢ MATH & CODING"
echo "║     4.9 GB ${MEMORY_TYPE}  • AceReason-Nemotron-1.1-7B Q4"
echo "║     Handles math and logic puzzles with minimal resources;"
echo "║     concise, step-by-step solutions."
echo "║     "
animate_text_x2 "║ 19 ⬢ THEOREM PROVER"
echo "║     5.4 GB ${MEMORY_TYPE}  • Kimina Prover Distill 8B Q4"
echo "║     Specialist in formal logic and proof steps;"
echo "║     ideal for theorem-style tasks and verification."
echo "║     "
animate_text_x2 "║ 20 ⬢ RUST PROGRAMMING"
echo "║     4.9 GB ${MEMORY_TYPE}  • Tessa-Rust-T1 7B Q4"
echo "║     Focused on Rust programming; produces idiomatic Rust and"
echo "║     helps with code generation, fixes and refactors."
echo "║     "
animate_text_x2 "║ 21 ⬢ MEDICAL EXPERT"
echo "║     5.4 GB ${MEMORY_TYPE}  • II-Medical-8B Q5"
echo "║     Works through clinical Q&A step by step;"
echo "║     useful for study and drafting (non-diagnostic)."
echo "║     "
animate_text_x2 "║ 22 ⬢ LOW MEMORY MODEL"
echo "║     1.3 GB ${MEMORY_TYPE}  • Qwen3 1.7B Q4"
echo "║     Ultra-efficient for basic instructions and quick answers;"
echo "║     suitable for nodes with tight memory."
echo "╚═════════ LIGHT TIER END"
echo
echo "[0] Auto, [1] Import, [2-22] Specialized Model"

read -r -p "Select your node's specialization option: " NODE_CLASS

case $NODE_CLASS in
    0)
        animate_text "⌖ Analyzing system for optimal configuration:"
        auto_select_model
        ;;
    1)
        echo
        echo "══════════════════ CUSTOM MODEL IMPORT ════════════════════"
        echo "     Intended for users familiar with language models."
        echo
        read -r -p "Enter HuggingFace repository (e.g., Qwen/Qwen2.5-3B-Instruct-GGUF): " LLM_HF_REPO
        read -r -p "Enter model filename (e.g., qwen2.5-3b-instruct-q4_k_m.gguf): " LLM_HF_MODEL_NAME
        NODE_NAME="✶ CUSTOM IMPORT: HuggingFace ${LLM_HF_REPO##*/}"
        ;;
    2)
        LLM_HF_REPO="unsloth/gpt-oss-120b-GGUF"
        LLM_HF_MODEL_NAME="Q4_K_M/gpt-oss-120b-Q4_K_M-00001-of-00002.gguf"
        NODE_NAME="⬢ SUPERIOR GENERALIST: gpt-oss-120b Q4"
        ;;
    3)
        LLM_HF_REPO="unsloth/GLM-4.5-Air-GGUF"
        LLM_HF_MODEL_NAME="Q4_K_M/GLM-4.5-Air-Q4_K_M-00001-of-00002.gguf"
        NODE_NAME="⬢ SUPERIOR GENERALIST: GLM-4.5-Air Q4"
        ;;
    4)
        LLM_HF_REPO="unsloth/Llama-3_3-Nemotron-Super-49B-v1_5-GGUF"
        LLM_HF_MODEL_NAME="Llama-3_3-Nemotron-Super-49B-v1_5-Q4_K_M.gguf"
        NODE_NAME="⬢ SUPERIOR GENERALIST: Nemotron-Super-49B-v1.5 Q4"
        ;;
    5)
        LLM_HF_REPO="unsloth/Qwen3-30B-A3B-Thinking-2507-GGUF"
        LLM_HF_MODEL_NAME="Qwen3-30B-A3B-Thinking-2507-Q4_K_M.gguf"
        NODE_NAME="⬢ ADVANCED REASONING: Qwen3 30B A3B Thinking 2507 Q4"
        ;;
    6)
        LLM_HF_REPO="unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF"
        LLM_HF_MODEL_NAME="Qwen3-Coder-30B-A3B-Instruct-Q4_K_M.gguf"
        NODE_NAME="⬢ PROGRAMMING & ALGORITHMS: Qwen3-Coder-30B-A3B-Instruct Q4"
        ;;
    7)
        LLM_HF_REPO="unsloth/gpt-oss-20b-GGUF"
        LLM_HF_MODEL_NAME="gpt-oss-20b-Q4_K_M.gguf"
        NODE_NAME="⬢ ADVANCED GENERALIST: gpt-oss-20b Q4"
        ;;
    8)
        LLM_HF_REPO="unsloth/OpenReasoning-Nemotron-32B-GGUF"
        LLM_HF_MODEL_NAME="OpenReasoning-Nemotron-32B-Q4_K_M.gguf"
        NODE_NAME="⬢ MATH, SCIENCE & CODING: OpenReasoning Nemotron 32B Q4"
        ;;
    9)
        LLM_HF_REPO="LGAI-EXAONE/EXAONE-4.0-32B-GGUF"
        LLM_HF_MODEL_NAME="LGAI-EXAONE_EXAONE-4.0-32B-Q4_K_M.gguf"
        NODE_NAME="⬢ ADVANCED GENERALIST: EXAONE 4.0 32B Q4"
        ;;
    10)
        LLM_HF_REPO="bartowski/open-r1_OlympicCoder-32B-GGUF"
        LLM_HF_MODEL_NAME="open-r1_OlympicCoder-32B-Q4_K_M.gguf"
        NODE_NAME="⬢ PROGRAMMING & ALGORITHMS: OlympicCoder 32B Q4"
        ;;
    11)
        LLM_HF_REPO="bartowski/ServiceNow-AI_Apriel-Nemotron-15b-Thinker-GGUF"
        LLM_HF_MODEL_NAME="ServiceNow-AI_Apriel-Nemotron-15b-Thinker-Q4_K_M.gguf"
        NODE_NAME="⬢ ADVANCED REASONING: Apriel-Nemotron-15b-Thinker Q4"
        ;;
    12)
        LLM_HF_REPO="unsloth/Qwen3-14B-GGUF"
        LLM_HF_MODEL_NAME="Qwen3-14B-Q4_K_M.gguf"
        NODE_NAME="⬢ EVERYDAY GENERALIST: Qwen3 14B Q4"
        ;;
    13)
        LLM_HF_REPO="unsloth/Qwen3-8B-GGUF"
        LLM_HF_MODEL_NAME="Qwen3-8B-Q4_K_M.gguf"
        NODE_NAME="⬢ EVERYDAY GENERALIST: Qwen3 8B Q4"
        ;;
    14)
        LLM_HF_REPO="unsloth/gemma-3-12b-it-GGUF"
        LLM_HF_MODEL_NAME="gemma-3-12b-it-Q4_K_M.gguf"
        NODE_NAME="⬢ MULTILINGUAL GENERALIST: Gemma-3 4B Q4"
        ;;
    15)
        LLM_HF_REPO="bartowski/agentica-org_DeepCoder-14B-Preview-GGUF"
        LLM_HF_MODEL_NAME="agentica-org_DeepCoder-14B-Preview-Q4_K_M.gguf"
        NODE_NAME="⬢ PROGRAMMING & ALGORITHMS: DeepCoder 14B Q4"
        ;;
    16)
        LLM_HF_REPO="bartowski/open-r1_OlympicCoder-7B-GGUF"
        LLM_HF_MODEL_NAME="open-r1_OlympicCoder-7B-Q4_K_M.gguf"
        NODE_NAME="⬢ PROGRAMMING & ALGORITHMS: OlympicCoder 7B Q4"
        ;;
    17)
        LLM_HF_REPO="bartowski/nvidia_OpenMath-Nemotron-14B-GGUF"
        LLM_HF_MODEL_NAME="nvidia_OpenMath-Nemotron-14B-Q4_K_M.gguf"
        NODE_NAME="⬢ MATH & FORMAL LOGIC: OpenMath-Nemotron 14B Q4"
        ;;
    18)
        LLM_HF_REPO="bartowski/nvidia_AceReason-Nemotron-1.1-7B-GGUF"
        LLM_HF_MODEL_NAME="nvidia_AceReason-Nemotron-1.1-7B-Q4_K_M.gguf"
        NODE_NAME="⬢ MATH & CODING: AceReason-Nemotron-1.1-7B Q4"
        ;;
    19)
        LLM_HF_REPO="mradermacher/Kimina-Prover-Distill-8B-GGUF"
        LLM_HF_MODEL_NAME="Kimina-Prover-Distill-8B.Q4_K_M.gguf"
        NODE_NAME="⬢ THEOREM PROVER: Kimina Prover Distill 8B Q4"
        ;;
    20)
        LLM_HF_REPO="bartowski/Tesslate_Tessa-Rust-T1-7B-GGUF"
        LLM_HF_MODEL_NAME="Tesslate_Tessa-Rust-T1-7B-Q4_K_M.gguf"
        NODE_NAME="⬢ RUST PROGRAMMING: Tessa-Rust-T1 7B Q4"
        ;;
    21)
        LLM_HF_REPO="Intelligent-Internet/II-Medical-8B-1706-GGUF"
        LLM_HF_MODEL_NAME="II-Medical-8B-1706.Q4_K_M.gguf"
        NODE_NAME="⬢ MEDICAL EXPERT: II-Medical-8B Q5"
        ;;
    22)
        LLM_HF_REPO="unsloth/Qwen3-1.7B-GGUF"
        LLM_HF_MODEL_NAME="Qwen3-1.7B-Q4_K_M.gguf"
        NODE_NAME="⬢ LOW MEMORY MODEL: Qwen3 1.7B Q4"
        ;;
    *)
        animate_text "No selection made. Continuing with [0] ⌖ AUTO-SELECT..."
        auto_select_model
        ;;
esac
echo
echo "You chose:"
animate_text "${NODE_NAME}"
echo
animate_text "    ↳ Downloading the model and preparing the environment may take several minutes..."
"$UTILS_EXEC" --hf-repo "$LLM_HF_REPO" --hf-model-name "$LLM_HF_MODEL_NAME" --model-cache "$PROJECT_MODEL_CACHE_DIR"
echo
animate_text "Setup completed. Ready to launch."
# clear
animate_text_x2 "$BANNER_FULLNAME"

startup() {
    animate_text "⎔ Starting Capsule..."
    "$CAPSULE_EXEC" --llm-hf-repo "$LLM_HF_REPO" --llm-hf-model-name "$LLM_HF_MODEL_NAME" --model-cache "$PROJECT_MODEL_CACHE_DIR" > "$CAPSULE_LOGS" 2>&1 &
    CAPSULE_PID=$!
    animate_text "Be patient, it may take some time."
    while true; do
        STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$CAPSULE_READY_URL")
        if [[ "$STATUS_CODE" == "200" ]]; then
            animate_text "Capsule is ready!"
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
trap cleanup SIGINT SIGTERM EXIT

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
            DOWNLOAD_PROTOCOL_URL="https://fortytwo-network-public.s3.us-east-2.amazonaws.com/protocol/v$PROTOCOL_VERSION/FortytwoProtocolNode-darwin"
            animate_text "    ↳ Updating..."
            curl -L -o "$PROTOCOL_EXEC" "$DOWNLOAD_PROTOCOL_URL"
            chmod +x "$PROTOCOL_EXEC"
            animate_text "    ✓ Successfully updated"
        fi
        IS_ALIVE="false"
    fi

    if [[ $IS_ALIVE == "false" ]]; then
        animate_text "Capsule or Protocol process has stopped. Restarting..."
        kill "$CAPSULE_PID" 2>/dev/null
        kill "$PROTOCOL_PID" 2>/dev/null
        startup
    fi

    sleep 5
done
