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

- Xác thực đa yếu tố
- Có thể đăng nhập vào máy chủ, cụm Kubernetes, cơ sở dữ liệu, ứng dụng web và máy tính Windows desktop thông qua nhà cung cấp Đăng nhập một lần (SSO) như: Azure Active Directory (AD),GitHub,...
- Kiểm soát truy cập các server, ứng dụng dựa theo vai trò(RBAC). Teleport cung cấp quyền kiểm soát chi tiết về việc ai có thể truy cập tài nguyên trong cơ sở hạ tầng cũng như cách họ có thể truy cập các tài nguyên đó.

### Phân quyền
Các user được phân quyền truy cập vào các server được thêm vào Teleport Cluster dựa trên các label(nhãn) 

Ví dụ về một role cấp quyền truy cập SSH vào các server được gắn nhãn `"role: 247"` 
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
Với role trên các user được cấp role này sẽ thấy các server được truy cập và user được phép sử dụng để login vào server

<img src="image/teleport_role_247.png">

### Cách truy cập

Tải Client tại [https://goteleport.com/download/](https://goteleport.com/download/)

- tsh client: kết nối bằng command line
    - Đăng nhập vào teleport
        ```
        tsh login --proxy=jump.vinahost.vn --user=user_name 
        ```
    - Kết nối ssh bằng username được cho phép và hostname của server cần kết nối.
        ```
        tsh ssh username@host_name
        ```
    - Tham khảo thêm cách sử dụng [tsh Command Line Tool](https://goteleport.com/docs/connect-your-client/tsh/)
- Teleport Connect: Ứng dụng hố trợ kết nối của Teleport

<img src="image/teleport_connect.png">
- Sử dụng giao diện web, đăng nhập vào Teleport thông qua giao diện web và thực hiện kết nối

<img src="image/teleport_web_ui.png">

