# EPOW Miner - Hướng Dẫn Cài Đặt và Sử Dụng

## Yêu Cầu Hệ Thống
- Docker
- Docker Compose

## Cài Đặt

### 1. Clone Repository
Clone repository này về máy của bạn.

### 2. Chuẩn Bị Môi Trường
Đảm bảo Docker và Docker Compose đã được cài đặt trên hệ thống của bạn.

Kiểm tra Docker:
```bash
docker --version
```

Kiểm tra Docker Compose:
```bash
docker compose version
```

## Chạy Ứng Dụng

### 1. Khởi Động Container
```bash
docker compose up -d
```

### 2. Kiểm Tra Trạng Thái
Để xem container đang chạy:
```bash
docker ps
```

### 3. Xem Logs
Để theo dõi logs của miner:
```bash
docker logs -f epow-miner
```

## Cấu Trúc Thư Mục

- `docker-compose.yml`: File cấu hình Docker Compose
- `run_vi.sh`: Script tự động tạo ví Solana và khởi động miner
- `epow-keys/`: Thư mục chứa các khóa và cấu hình
  - `solana/`: Chứa cấu hình và khóa Solana

## Cài Đặt Scripts Hỗ Trợ

Các file script được cung cấp để dễ dàng thao tác với miner. Đầu tiên, cấp quyền thực thi cho các scripts:

```bash
chmod +x *.sh
```

## Lưu Ý Quan Trọng

1. Khi chạy lần đầu tiên, container sẽ tạo ví Solana mới và lưu:
   - Private key tại: `/root/.config/solana/id.json` trong container - /root/epow/epow-keys/solana trên máy host
   - Public key tại: `./keys/solana_public_key.txt` trên máy host

2. Do chưa có tiền trong ví, container sẽ tự động restart liên tục. Đây là bình thường.
   - Kiểm tra địa chỉ ví của bạn trong file `./keys/solana_public_key.txt`
   - Nạp 0.005 $ETH vào địa chỉ ví trên Eclipse
   - Sau khi nạp tiền xong, khởi động lại container:
     ```bash
     docker compose restart
     ```

3. Container được cấu hình tự động khởi động lại khi gặp lỗi (trừ khi bị dừng thủ công)

4. Để kiểm tra logs và tình trạng của container:
   ```bash
   docker logs -f epow-miner
   ```

## Các Lệnh Hữu Ích

1. Nhận Bitz đã đào:
   ```bash
   ./claim.sh
   ```

2. Kiểm tra số dư:
   ```bash
   ./balance.sh
   ```

3. Cấu hình số lõi CPU (cần thực hiện trước khi chạy container):
   ```bash
   ./configure-cores.sh 8  # Thay đổi số 8 để điều chỉnh số lõi
   ```
   Sau khi cấu hình, khởi động lại container để áp dụng thay đổi:
   ```bash
   docker compose down && docker compose up -d
   ```

4. Xem tất cả các lệnh có sẵn:
   ```bash
   ./help.sh
   ```

## Chi Tiết Các Script

- `claim.sh`: Script nhận Bitz đã đào
- `balance.sh`: Script kiểm tra số dư tài khoản
- `configure-cores.sh`: Script điều chỉnh số lõi CPU trong file cấu hình (cần chạy trước khi khởi động container)
- `help.sh`: Script hiển thị tất cả các lệnh có sẵn

Lưu ý: Các script này thực thi lệnh bên trong container, nên bạn cần đảm bảo container đang chạy trước khi sử dụng.

## Dừng Ứng Dụng

Để dừng miner:
```bash
docker compose down
```

## Xử Lý Sự Cố

1. Nếu container không khởi động:
   ```bash
   docker logs epow-miner
   ```
   Kiểm tra logs để xem lỗi cụ thể

2. Nếu cần khởi động lại:
   ```bash
   docker compose restart
   ```

3. Nếu cần xóa và tạo lại container:
   ```bash
   docker compose down
   docker compose up -d
