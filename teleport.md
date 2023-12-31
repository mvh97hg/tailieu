## Teleport
Teleport là một công cụ mã nguồn mở để cung cấp quyền truy cập không tin cậy vào các máy chủ và ứng dụng đám mây bằng SSH, Kubernetes và HTTPS. Nó có thể loại bỏ nhu cầu về VPN bằng cách cung cấp một cổng duy nhất để truy cập cơ sở hạ tầng máy tính thông qua SSH, cụm Kubernetes và ứng dụng đám mây thông qua proxy tích hợp.

## Cách Teleport hoạt động
Teleport cung cấp quyền truy cập an toàn vào SSH hoặc máy chủ Windows, máy tính để bàn Windows, cụm Kubernetes, cơ sở dữ liệu và ứng dụng web. Teleport được thiết lập dưới dạng daemon Linux hoặc trong Pod Kubernetes.

Về cơ bản Teleport là cơ quan cấp chứng chỉ và proxy truy cập đa giao thức, nhận dạng danh tính, triển khai các giao thức như SSH, RDP, HTTPS, Kubernetes API và nhiều cơ sở dữ liệu SQL và NoSQL. Nó hoàn toàn trong suốt đối với các công cụ phía máy khách.

### Kiến trúc của Teleport
<img src="image/teleport.png">

- Quản lý người dùng truy cập vào nhiều ứng dụng, Server.
- Định nghĩa, định danh và phân quyền ở cấp độ cluster.
- Tất cả truy cập đến bất kỳ node nào phải luôn thông qua một proxy (SSH bastion).
- Tất cả người dùng và máy chủ phải tham gia cùng một cụm trước khi có thể cấp quyền truy cập.
- Để tham gia một cụm, cả người dùng và máy chủ phải xác thực và nhận chứng chỉ.
- Teleport Auth Service là CA của cụm, cấp chứng chỉ cho cả người dùng và máy chủ với tất cả các giao thức được hỗ trợ.

Mô hình này ngăn chặn, giảm thiểu các cuộc tấn công từ bên ngoài vào các server và loại bỏ vấn đề tin cậy khi sử dụng lần đầu. Điều này cũng cho phép người dùng liệt kê tất cả các máy chủ và các tài nguyên khác hiện có.

### Bảo mật
Một số phương thức bảo mật có sẵn với phiên bản Teleport Community Edition
- Xác thực đa yếu tố
- Có thể đăng nhập vào máy chủ, cụm Kubernetes, cơ sở dữ liệu, ứng dụng web và máy tính Windows desktop thông qua nhà cung cấp Đăng nhập một lần (SSO) như GitHub
- Kiểm soát truy cập các server, ứng dụng dựa theo vai trò(RBAC). Teleport cung cấp quyền kiểm soát chi tiết về việc ai có thể truy cập tài nguyên trong cơ sở hạ tầng cũng như cách họ có thể truy cập các tài nguyên đó.
- Kết hợp Firewall giới hạn truy cập đến Teleport. ```jump.vinahost.vn hiện tại đang dùng Uncomplicated Firewall (ufw) trên Ubuntu```


## Quản trị
Khi bắt đầu với Teleport Cluster mới sẽ có 3 role cho user admin là 
  - access: Có thể truy cập tất cả server được kết nối từ Teleport
  - auditor: Có thể xem log và Session Recordings.
  - editor: Có quyền quản trị Teleport

Các user được phân quyền truy cập vào các server dựa trên các role, các role này sẽ cấp quyền truy cập cho user dựa  theo các label(nhãn) được gắn trên các server.

Thêm role:
  - Truy cập Management > User Roles > CREATE NEW ROLE để tạo role mới. 
  - Ví dụ về một role có tên `role_247` cấp quyền truy cập SSH vào các server được gắn nhãn `"role: 247"`
  ```
  kind: role
  metadata:
    # insert the name of your role here:
    name: role_247
  spec:
    allow:
      logins: ['{{internal.logins}}',root]
      node_labels:
        'role': '247'
      windows_desktop_labels:
        'role': '247'
      # Windows logins a user is allowed to use for desktop sessions.
      windows_desktop_logins:
      - '{{internal.windows_logins}}'
      - administrator

      rules:
      - resources:
        - event
        verbs:
        - list
        - read
      - resources:
        - session
        verbs:
        - read
        - list
        where: contains(session.participants, user.metadata.name)
    deny:
      logins: ['guest']

    options:
        max_session_ttl: 8h0m0s
  version: v7
  ```

Thêm User: 
  - Truy cập Management > User > CREATE NEW USER, nhập tên user và chọn role.
  
  <img src="image/teleport_create_user.png">

  - Sau khi tạo xong user sẽ nhận được một đường link tạo mật khẩu tồn tại trong 60 phút, gửi link này cho người dùng để tạo mật khẩu.
  
  <img src="image/teleport_user_link.png">

  - Có thể tạo lại link reset password để tạo mật khẩu mới khi quên mật khẩu hoặc link cũ hết hạn

  <img src="image/teleport_reset_pass.png">

Các user được cấp `role_247` này sẽ thấy nhìn thấy danh sách các server được phép truy cập và user được phép sử dụng để login SSH

<img src="image/teleport_role_247.png">

### Session Recordings

Sau khi kết thúc môt session SSH Teleport sé ghi lại các thao tác trong session SSH đó và có thể xem lại tại Management > Session Recordings

### Audit Log
Audit Log Sẽ ghi lại các hoạt động trên Teleport như tạo thêm user, bắt đầu một session SSH, Certificate Issued,...

### Session & Identity Locks
Vô hiệu hóa người dùng teleport bị xâm nhập hoặc Ngăn chặn truy cập trong quá trình bảo trì cụm.

Khi vô hiệu hoá, Teleport sẽ từ chối các yêu cầu API mới và chấm dứt hoạt động kết nối với các phiên SSH, cơ sở dữ liệu và Kubernetes


### Cách sử dụng Teleport để kết nối đến server

Tải Teleport Client tại [https://goteleport.com/download/](https://goteleport.com/download/)

- tsh client: kết nối bằng command line
    - Đăng nhập vào teleport
        ```
        tsh login --proxy jump.vinahost.vn --user user_name 
        ```
    - Hiển thị danh sách các server
      ```
      tsh ls
      tsh ls --search=node # Kết hợp tìm kiếm
      ```
    - Kết nối ssh bằng username được cho phép và hostname hoặc `Node Name` của server cần kết nối.
        ```
        tsh ssh username@host_name
        ```
    - Chuyển file tới một máy chủ
      ```
      tsh scp .\CHANGELOG.md root@proxy-247-cus:/root
      ```
    - Hiển thị danh sách các record sessions, mặc định hiển thị 50.
      ```
      tsh recordings ls
      tsh recordings ls --from-utc 2023-10-01 --to-utc 2023-12-01 --limit 1000 # Hiển thị 1000 record từ 2023-10-01 đến 2023-12-01 theo giờ utc
      ```
    - MFA
      ```
      tsh mfa ls  # Hiển thị danh sách các thiết bị MFA đã đăng ký.
      tsh mfa add # Thêm thiết bị MFA mới.
      tsh mfa rm  # Xoá thiết bị MFA.
      ```

    - Tham khảo thêm các lệnh khác với `tsh -h` hoặc [tsh Command Line Tool](https://goteleport.com/docs/connect-your-client/tsh/)

- [Teleport Connect:](https://goteleport.com/docs/connect-your-client/teleport-connect/) Ứng dụng hố trợ kết nối của Teleport

<img src="image/teleport_connect.png">

- [Web UI:](https://jump.vinahost.vn/) đăng nhập vào Teleport thông qua giao diện web và thực hiện các kết nối

<img src="image/teleport_web_ui.png">

  - Tham khảo các sử dụng web UI https://goteleport.com/docs/connect-your-client/web-ui/


### Update agent tự động
Cài đặt crontab kiểm tra version và cập nhật tự động trên centos 7

```
curl -Ls https://raw.githubusercontent.com/mvh97hg/linux/main/scripts/update_teleport.sh | bash
```

Script

```
#!/bin/bash

if ! command -v yq &> /dev/null; then
    echo "Cài đặt yq..."
    wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/local/bin/yq && chmod +x /usr/local/bin/yq
    
else
    echo "yq đã được cài đặt."
fi


##Script kiểm tra và update `/scripts/update_teleport.sh`

mkdir -p /scripts
cat <<'EOF'> /scripts/update_teleport.sh
#!/bin/bash

# Lấy thông tin phiên bản từ máy chủ
PROXY=$(cat /etc/teleport.yaml | yq '.teleport | .auth_servers[0] // .proxy_server')
VERSION=$(curl -s https://${PROXY}/webapi/ping | yq -r .server_version)

# Lấy phiên bản hiện tại
LOCAL_VERSION=$(teleport version | awk '{print $2}' | cut -d'v' -f2)

# So sánh phiên bản
if [[ $LOCAL_VERSION < $VERSION ]]; then
    echo "Phiên bản hiện tại ($LOCAL_VERSION) nhỏ hơn phiên bản của máy chủ ($VERSION). Đang tiến hành cập nhật..."
    
    ## update trên centos 7
    yum update teleport -y

    ## update trên debian/ubuntu

    #apt-get update 2>&1 > /dev/null
    #apt --only-upgrade install -y teleport=${VERSION}

    systemctl restart teleport

    echo "Cập nhật hoàn tất."
else
   echo "Phiên bản hiện tại ($LOCAL_VERSION) không cần cập nhật."

fi
EOF

chmod +x /scripts/update_teleport.sh

## Cron job

if ! crontab -l &> /dev/null; then
    (echo "0 1 * * * /scripts/update_teleport.sh > /dev/null 2>&1") | crontab -
    
else
    # Check if the cron job already exists
    if ! crontab -l | grep -q "/scripts/update_teleport.sh"; then

        (crontab -l ; echo "0 1 * * * /scripts/update_teleport.sh > /dev/null 2>&1") | crontab -
    else
        echo "Cron job đã tồn tại."
    fi
fi

