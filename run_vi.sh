#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m' # Không màu

KEY_DIR="/keys"
KEYPAIR_PATH="/root/.config/solana/id.json"
PUBKEY_PATH="${KEY_DIR}/solana_public_key.txt"

# 1. Tạo ví Solana nếu chưa có
if [ ! -f "$KEYPAIR_PATH" ]; then
    echo -e "${GREEN}Đang tạo ví Solana mới tại $KEYPAIR_PATH...${NC}"
    solana-keygen new --no-passphrase
else
    echo -e "${GREEN}Ví Solana đã tồn tại tại $KEYPAIR_PATH.${NC}"
solana address -k "$KEYPAIR_PATH" > "$PUBKEY_PATH"
fi
# 4. Bắt đầu khai thác trực tiếp
echo -e "${GREEN}Bắt đầu khai thác ngay...${NC}"
# exec bitz -h

solana config set --url https://eclipse.helius-rpc.com

bitz collect --cores 8