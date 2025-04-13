#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage: ./configure-cores.sh <number_of_cores>"
    echo "Example: ./configure-cores.sh 8"
    exit 1
fi

# Sử dụng sed để thay thế số cores trong run_vi.sh
sed -i "s/bitz collect --cores [0-9]*/bitz collect --cores $1/" run_vi.sh
echo "Đã cấu hình số cores thành $1"
echo "Khởi động lại container để áp dụng thay đổi:"
echo "docker compose down && docker compose up -d"
