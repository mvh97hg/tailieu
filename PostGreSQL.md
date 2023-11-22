## PostgreSQL là gì?

Là một hệ thống quản trị cơ sở dữ liệu quan hệ - đối tượng(object-relational database management system). Nó được thiết kế để xử lý một loạt các khối lượng công việc lớn, từ máy tính cá nhân đến kho dữ liệu hay dịch vụ Web có nhiều người dùng đồng thời.
- PostgreSQL được phát triển bởi PostgreSQL Global Development Group, Phát hành lần đầu: 08/07/1996.
- PostgreSQL linh động có thể chạy được trên nhiều nền tảng khác nhau như Mac OS X, Solaris và Windows.
- PostgreSQL là một open source miễn phí, bởi vậy PostgreSQL có thể được dùng để sửa đổi và phổ biến bởi bất kỳ ai cho bất kỳ mục đích nào. PostgreSQL có tính ổn định cao.
- PostgreSQL là hệ thống quản lý cơ sở dữ liệu đầu tiên triển khai tính năng kiểm soát đồng thời nhiều phiên bản(MVCC).

PostgreSQL hỗ trợ các loại dữ liệu nâng cao và tối ưu hóa hiệu suất nâng cao, các tính năng chỉ có sẵn trong cơ sở dữ liệu thương mại đắt tiền, như Oracle và SQL Server.

## Các tính năng có trong PostgreSQL

- Kiểu dữ liệu
    - Nguyên thủy: Số nguyên, số, chuỗi, boolean
    - Cấu trúc: Ngày / giờ, Mảng, Phạm vi / Đa phạm vi, UUID
    - Tài liệu: JSON/JSONB, XML, Khóa-giá trị (Hstore)
    - Hình học: Point, Line, Circle, Polygon
    - Tùy chỉnh: Tổng hợp, Loại tùy chỉnh
- Tính toàn vẹn dữ liệu
    - DUY NHẤT, KHÔNG NULL (UNIQUE, NOT NULL)
    - Khóa chính (Primary Keys)
    - Khóa ngoại (Foreign Keys)
    - Ràng buộc loại trừ (Exclusion Constraints)
    - Khóa rõ ràng, Khóa tư vấn (Explicit Locks, Advisory Locks)
- Tính đồng thời, Hiệu suất
    - Lập chỉ mục: B-tree, Multicolumn, Expressions, Partial
    - Lập chỉ mục nâng cao: GiST, SP-Gist, KNN Gist, GIN, BRIN, Chỉ số bao gồm, Bộ lọc Bloom
    - Trình lập kế hoạch / tối ưu hóa truy vấn phức tạp, chỉ quét chỉ chỉ mục, thống kê nhiều cột
    - Giao dịch, Giao dịch lồng nhau (thông qua điểm lưu)
    - Điều khiển đồng thời nhiều phiên bản (MVCC)
    - Song song hóa các truy vấn đọc và xây dựng chỉ mục cây B
    - Phân vùng bảng
    - Tất cả các cấp độ cách ly giao dịch được xác định trong tiêu chuẩn SQL, bao gồm Serializable
    - Just-in-time (JIT) biên soạn các biểu thức
- Độ tin cậy, Phục hồi sau thảm họa
    - Ghi nhật ký trước (WAL)
    - Nhân rộng (Replication): không đồng bộ, đồng bộ, logic
    - Phục hồi theo thời điểm (PITR), chế độ chờ hoạt động
    - Không gian bảng
- Bảo mật
    - Xác thực: GSSAPI, SSPI, LDAP, SCRAM-SHA-256, Chứng chỉ, v.v.
    Hệ thống kiểm soát truy cập mạnh mẽ
    - Bảo mật cấp cột và hàng
    - Xác thực đa yếu tố với chứng chỉ và một phương pháp bổ sung
- Khả năng mở rộng
    - Các chức năng và thủ tục được lưu trữ
    - Ngôn ngữ thủ tục: PL / pgSQL, Perl, Python và Tcl. Có các ngôn ngữ khác có sẵn thông qua các tiện ích mở rộng, ví dụ: Java, JavaScript (V8), R, Lua và Rust
    - Các hàm tạo SQL / JSON và biểu thức đường dẫn
    - Trình bao bọc dữ liệu nước ngoài: kết nối với các cơ sở dữ liệu hoặc luồng khác bằng giao diện SQL tiêu chuẩn
    - Giao diện lưu trữ có thể tùy chỉnh cho các bảng
    - Nhiều tiện ích mở rộng cung cấp chức năng bổ sung, bao gồm PostGIS
- Quốc tế hóa, Tìm kiếm Văn bản
    - Hỗ trợ cho các bộ ký tự quốc tế, ví dụ: thông qua đối chiếu ICU
    - Đối chiếu không phân biệt chữ hoa chữ thường và không phân biệt giọng
    - Tìm kiếm toàn văn bản

PostgreSQL đã được chứng minh là có khả năng mở rộng cao cả về số lượng dữ liệu tuyệt đối mà nó có thể quản lý và số lượng người dùng đồng thời mà nó có thể đáp ứng. Có các cụm PostgreSQL đang hoạt động trong môi trường sản xuất quản lý nhiều terabyte dữ liệu và các hệ thống chuyên dụng quản lý petabyte.

### Kích thước dữ liệu
PostgreSQL có thể xử lý một lượng lớn dữ liệu
| Giới hạn                             | Giá trị                           |
|--------------------------------------|-----------------------------------|
| Kích thước tối đa của cơ sở dữ liệu  | Không giới hạn                    |
| Kích thước tối đa của table          | 32 TB                             |
| Kích thước tối đa của hàng (row)     | 1.6 TB                            |
| Kích thước tối đa của trường (field) | 1 GB                              |
| Số hàng tối đa trên mỗi bảng         | Không giới hạn                    |
| Số cột tối đa trên mỗi bảng          | 250 - 1600 phụ thuộc vào kiểu cột |
| Số lượng index tối đa trên mỗi bảng  | Không giới hạn                    |

So sánh, MySQL và MariaDB  được biết đến với giới hạn kích thước dòng là 65,535 byte. Firebird cũng chỉ có kích thước tối đa cho một dòng là 64KB. Thông thường kích thước dữ liệu được giới hạn bởi giới hạn kích thước file của hệ điều hành. Bởi vì PostgreSQL có thể lưu trữ bảng dữ liệu trong nhiều file nhỏ hơn, nên nó có thể khắc phục được hạn chế này, điều quan trọng cần lưu ý là quá nhiều file có thể tác động hiệu năng


## Kiến trúc của PostgreSQL
<image src="image/kien_truc_postgresql.png">



## Cấu trúc database
<image src="image/cau_truc_database_psql.png">

### Database cluster
Là đơn vị lưu trữ lớn nhất của một PostgreSQL database server. Database cluster được tạo ra bởi câu lệnh initdb(), bao gồm các files config (postgresql.conf, pg_hba.conf, ...), và tất cả các đối tượng lưu trữ đều nằm trong database cluster.

### Databases
Là đơn vị lớn sau Database cluster. Để thực hiện được câu truy vấn, bạn phải truy cập vào một database nào đó. Khi initdb() thực thi, mặc định PostgreSQL sẽ tạo ra 3 csdl là template0, template1 và postgres.

### template0
Là cơ sở dữ liệu mẫu. Không thể truy nhập và chỉnh sửa các đối tượng trong đó. Người dùng có thể tạo database mới dựa trên template0 này bằng cách chỉ định TEMPLATE trong câu lệnh CREATE DATABASE

### template1
Là cơ sở dữ liệu mẫu. Người dùng có thể truy nhập và chỉnh sửa các đối tượng trong đó. Khi thực hiện câu lệnh "CREATE DATABASE", PostgreSQL sẽ copy template1 này để tạo database mới.

### postgres
Cơ sở dữ liệu mặc định của PostgreSQL khi tạo database cluster.

### Tablespace
Là đơn vị lưu trữ dữ liệu về phương diện vật lý bên dưới database. Thông thường dữ liệu vật lý được lưu trữ tại thư mục dữ liệu (nơi ta chỉ định lúc ta tạo database cluster). Nhưng có một phương pháp lưu trữ dữ liệu ngoài phân vùng này, nhờ sử dụng chức năng TABLESPACE. Khi tạo một TABLESPACE tức là ta đã tạo ra một vùng lưu trữ dữ liệu mới độc lập với dữ liệu bên dưới thư mục dữ liệu. Điều này giảm thiểu được disk I/O cho phân vùng thư mục dữ liệu (nếu trong các hệ thống cấu hình RAID, hay hệ thống có 1 đĩa cứng thì không có hiệu quả).


### Schema
Là đơn vị lưu trữ bên dưới database, quản lý dữ liệu dưới dạng logic. Mặc định trong mỗi database có một schema cho người sử dụng, đó là schema public. Ta có thể tạo schema bằng câu lệnh CREATE SCHEMA. Đặc điểm của 1 schema như sau:

Có thể sử dụng tên trùng với schema ở database khác nhưng không trùng tên trên cùng database.
Ngoài TABLESPACE và user ra, schema có thể chứa hầu hết các đối tượng còn lại (như table, index, sequence, constraint...) để truy cập schema ta có thể thêm tên schema vào phía trước đối tượng muốn truy cập hoặc sử dụng tham số search_path để thay đổi schema truy cập hiện tại.
Schema có thể sử dụng với các mục đích như tăng cường bảo mật, quản lý dữ liệu dễ dàng hơn.
### Bảng(table)
Bảng là đối tượng lưu trữ dữ liệu từ người dùng. Một bảng bao gồm 0 hoặc nhiều cột (column) tương ứng với từng kiểu dữ liệu khác nhau của PostgreSQL. Tổng quan có 3 kiểu tables mà PostgreSQL hỗ trợ, đó là:

- **unlogged table**: là kiểu table mà các thao tác đối với bảng dữ liệu này không được lưu trữ vào WAL. Tức là không có khả năng phục hồi nếu bị corrupt.
- **temporary table**: là kiểu table chỉ được tạo trong phiên làm việc đó. Khi connection bị ngắt, nó sẽ tự động mất đi.
- **table thông thường**: Khác với 2 kiểu table trên, là loại table thông thường để lưu trữ dữ liệu. Có khả năng phục hồi khi bị corrupt và tồn tại vĩnh viễn nếu không có thao tác xóa bỏ nào.

### Cấu trúc thư mục
PostgreSQL có thể được cài đặt trên cả 3 môi trường: Linux, Unix và Windows.

Trên Linux và Unix, PostgreSQL được cài tại thư mục `/usr/local/pgsql` hoặc `/var/lib/pgsql`, còn trên môi trường Windows, là thư mục `C:\Program Files\PostgreSQL\<version number>`. Các file cấu hình và database được tổ chức ngay trong thư mục data, thể hiện qua biến môi trường `$PGDATA`.

<image src="image/directory_psql.png">

ý nghĩa của các file:

|  |  |  |
|---|---|---|
|  |  |  |
|  |  |  |
|  |  |  |
| Item | Nội dung  |  |
| PG_VERSION | File chứa phiên bản hiện tại của PostgreSQL.  |  |
| base | Thư mục con chứa cơ sở dữ liệu, trong thư mục này chứa các thư mục con nữa cho mỗi database.  |  |
| current_logfiles | File ghi các file log được ghi bởi logging collector.  |  |
| global | Thư mục con chứa các bảng nội bộ, chẳng hạn như pg_database.  |  |
| pg_commit_ts | Thư mục con chứa thông tin về trạng thái commit của dữ liệu timestamp.  |  |
| pg_dynshmem | Thư mục con chứa các file sử dụng dynamic shared memory.  |  |
| pg_logical | Thư mục con chứa trạng thái dữ liệu sử dụng trong chức năng logical decoding.  |  |
| pg_multixact | Thư mục con chứa dữ liệu trạng thái multitransaction (sử dụng cho locks mức độ dòng dữ liệu).  |  |
| pg_notify | Thư mục con chứa dữ liệu về chức năng LISTEN/NOTIFY.  |  |
| pg_replslot | Thư mục con chứa dữ liệu về replication slot.  |  |
| pg_serial | Thư mục con chứa thông tin về các transaction commited ở mức độ phân li serializable.  |  |
| pg_snapshots | Thư mục con chứa thông tin về các snapshots đã xuất.  |  |
| pg_stat | Thư mục con chứa các files thông tin thống kê về PostgreSQL đang được sử dụng hiện tại.  |  |
| pg_stat_tmp | Thư mục con chứa các files thông tin thống kê về PostgreSQL tạm thời.  |  |
| pg_subtrans | Thư mục con chứa dữ liệu về các subtransaction.  |  |
| pg_tblspc | Thư mục con chứa thông tin symbolic links tới các tablespaces.  |  |
| pg_twophase | Thư mục con chứa các tập tin trạng thái cho các prepared transactions.  |  |
| pg_wal | Thư mục con chứa các file WAL (Write Ahead Log).  |  |
| pg_xact | Thư mục con chứa thông tin về trạng thái commit của dữ liệu.  |  |
| postgresql.auto.conf | File lưu trữ các thông số cấu hình được thiết lập bởi ALTER SYSTEM  |  |
| postmaster.opts | File này chứa thông tin về các tuỳ chọn lần cuối của lệnh khởi động PostgreSQL.  |  |
| postmaster.pid | File này tạo ra khi khởi động PostgreSQL và mất đi khi shutdown PostgreSQL. File chứa thông tin về PID của postmaster process, đường dẫn thư mục dữ liệu, thời gian khởi động, số hiệu port, đường dẫn Unix-domain socket (là trống trên môi trường Windows), giá trị hiệu lực đầu tiên chỉ định trong tham số listen_address và segment ID shared memory (tạo lúc khởi động PostgreSQL).  |  |


### Vacuum 
Vacuum là gì ? Tại sao PostgreSQL lại cần có Vacuum ?
- Khác với các RDBMS khác (như MySQL), khi người dùng chạy lệnh DELETE hay UPDATE, PostgreSQL không xoá dữ liệu cũ đi luôn mà chỉ đánh dấu "đó là dữ liệu đã bị xoá". Nên nếu liên tục INSERT/DELETE hoặc UPDATE dữ liệu mà không có cơ chế xoá dữ liệu dư thừa thì dung lượng ổ cứng tăng dẫn đến full.

- PostgreSQL sử dụng 32 bit Transaction ID (XID) để quản lý transaction(1). Mỗi một record dữ liệu đều có thông tin về XID. Khi dữ liệu được tham chiếu PostgreSQL sử dụng thông tin XID này so sánh với XID hiện tại để đánh giá dữ liệu này có hữu hiệu không. Dữ liệu đang tham chiếu có XID lớn hơn XID hiện tại là dữ liệu không hữu hiệu. Khi sử dụng hết 32 bit XID (khoảng 4 tỷ transactions), để sử dụng tiếp XID sẽ được reset về ban đầu (0). Nếu không có cơ chế chỉnh lại XID trong data thì mỗi lần reset XID, dữ liệu hiện tại sẽ trống trơn (dữ liệu hiện tại luôn có XID lớn hơn XID đã reset (0)).

Như vậy Vacuum ra đời để giải quyết những vấn đề:

- **Lấy lại dữ liệu dư thừa để tái sử dụng**
- **Cập nhật thông tin thống kê (statistics)**
- **Giải quyết vấn đề dữ liệu bị vô hiệu khi Wraparound Transaction ID**

### Lấy lại dữ liệu thừa 

Như trên, PostgreSQL chưa xoá dữ liệu cũ khi thực hiện thao tác DELETE/UPDATE. Khi VACUUM, những dữ liệu dư thừa đó sẽ được lấy lại và vị trí dư thừa sẽ được cập nhật lại trong bảng vị trí trống (Free Space Map(FSM)). Ngoài ra những block dữ liệu đã được VACUUM sẽ được đánh dấu là đã VACUUM trên bảng khả thị (Visibility Map(VM)), khi UPDATE/DELETE dữ bảng khả thị sẽ cập nhật lại trạng thái là cần VACUUM.

    Free Space Map(FSM): Mỗi bảng dữ liệu (hoặc index) tồn tại tương ứng một FSM. FSM chứa thông tin các vị trí trống trong file dữ liệu. Khi dữ liệu mới được ghi PostgreSQL sẽ nhìn vị trí trống từ FSM trước, việc này giảm thiểu truy cập trực tiếp (sinh I/O disk) vào file dữ liệu. File FSM nằm cùng vị trí với file dữ liệu và có tên = file_dữ_liệu_fsm (như ví dụ dưới).

    Visibility Map(VM): Mỗi bảng dữ liệu tồn tại tương ứng một visibility map (VM). Một block dữ liệu tương ứng với 1 bit trên VM. VACUUM xem trước thông tin VM của bảng dữ liệu, và chỉ thực hiện trên những block cần được VACUUM. File VM nằm cùng vị trí với file dữ liệu và có tên = file_dữ_liệu_vm (như ví dụ dưới).

```
testdb=# create table testtbl(id integer);
CREATE TABLE
testdb=# insert into testtbl select generate_series(1,100);
INSERT 0 100
testdb=# delete from testtbl where id < 90;
DELETE 89
testdb=# checkpoint;
CHECKPOINT
testdb=# \! ls -l $PGDATA/base/16384/24576*
-rw------- 1 bocap staff 8192 Jun 24 18:19 /Users/bocap/Downloads/pg94/data/base/16384/24576
-rw------- 1 bocap staff 24576 Jun 24 18:19 /Users/bocap/Downloads/pg94/data/base/16384/24576_fsm
-rw------- 1 bocap staff 8192 Jun 24 18:19 /Users/bocap/Downloads/pg94/data/base/16384/24576_vm

```

## Ưu điểm của PostgreSQL
Với những tính năng trên thì PostgreSQL có các ưu điểm nổi trội sau:
- PostgreSQL có thể chạy các trang web và ứng dụng web động với LAMP.
- Ghi nhật ký viết trước của PostgreSQL làm cho nó trở thành một cơ sở dữ liệu có khả năng chịu lỗi cao
- Mã nguồn PostgreSQL có sẵn miễn phí theo giấy phép nguồn mở. Điều này cho phép bạn tự do sử dụng, sửa đổi và triển khai nó theo nhu cầu kinh doanh của bạn.
- PostgreSQL hỗ trợ các đối tượng địa lý để bạn có thể sử dụng nó cho các dịch vụ dựa trên vị trí và hệ thống thông tin địa lý.
- PostgreSQL hỗ trợ các đối tượng địa lý để nó có thể được sử dụng làm kho lưu trữ dữ liệu không gian địa lý cho các dịch vụ dựa trên vị trí và hệ thống thông tin địa lý.
- Dễ sử dụng
- Hạn chế việc bảo trì hệ thống

## Nhược điểm của PostgreSQL

Bên cạnh những điểm mạnh thì PostgreSQL cũng có những điểm yếu:

- Postgres không thuộc sở hữu của một tổ chức. Vì vậy, nó đã gặp khó khăn khi đưa tên của mình ra khỏi đó mặc dù có đầy đủ tính năng và có thể so sánh với các hệ thống DBMS khác
- Những thay đổi được thực hiện để cải thiện tốc độ đòi hỏi nhiều công việc hơn MySQL vì PostgreSQL tập trung vào khả năng tương thích.
- Nhiều ứng dụng nguồn mở hỗ trợ MySQL, nhưng có thể không hỗ trợ PostgreSQL
- Về số liệu hiệu suất, nó chậm hơn MySQL.


### Một số điểm khác biệt giữa PostgreSQL và MySQL

|                          | MySQL                                                                                                          | PostgreSQL                                                                                                                                                              |
|--------------------------|----------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Công nghệ cơ sở dữ liệu  | MySQL đơn thuần là một hệ thống quản lý cơ sở dữ liệu quan hệ.                                                 | PostgreSQL là một hệ thống quản lý cơ sở dữ liệu quan hệ đối tượng.                                                                                                     |
| Tính năng                | MySQL hỗ trợ số ít các tính năng cơ sở dữ liệu như chế độ xem, điều kiện kích hoạt và quy trình.               | PostgreSQL hỗ trợ hầu hết các tính năng cơ sở dữ liệu nâng cao như chế độ xem cụ thể hóa, điều kiện kích hoạt INSTEAD OF và quy trình được lưu trữ bằng nhiều ngôn ngữ. |
| Loại dữ liệu             | MySQL hỗ trợ các loại dữ liệu số, ký tự, ngày và giờ, không gian và JSON.                                      | PostgreSQL hỗ trợ tất cả các loại dữ liệu MySQL cùng với các loại dữ liệu hình học, liệt kê, địa chỉ mạng, mảng, phạm vi, XML, hstore và kết hợp.                       |
| Tuân thủ ACID            | MySQL chỉ tuân thủ ACID với công cụ lưu trữ InnoDB và NDB Cluster.                                             | PostgreSQL luôn tuân thủ ACID.                                                                                                                                          |
| Chỉ mục                  | MySQL hỗ trợ chỉ mục B-tree và R-tree.                                                                         | PostgreSQL hỗ trợ nhiều loại chỉ mục như chỉ mục biểu thức, chỉ mục một phần và chỉ mục băm cùng với dạng cây.                                                          |
| Hỗ trợ người mới bắt đầu | MySQL dễ hơn khi bắt đầu sử dụng. MySQL có một bộ công cụ đa dạng hơn cho người dùng không chuyên về kỹ thuật. | PostgreSQL phức tạp hơn khi bắt đầu sử dụng. PostgreSQL có một bộ công cụ hạn chế cho người dùng không chuyên về kỹ thuật.                                              |
| Hiệu năng ghi            | MySQL sử dụng tính năng khóa ghi để có khả năng mang lại tính đồng thời thực sự. Ví dụ: nếu một người dùng đang chỉnh sửa bảng, một người dùng khác có thể phải đợi cho đến khi thao tác kết thúc thì mới có thể thay đổi bảng. | PostgreSQL đã tích hợp sẵn tính năng kiểm soát đồng thời nhiều phiên bản (MVCC) mà không khóa đọc-ghi. Bằng cách này, cơ sở dữ liệu PostgreSQL có hiệu năng cao hơn trong trường hợp sử dụng các thao tác ghi thường xuyên và đồng thời. |
| Hiệu năng đọc            | MySQL sử dụng một quy trình duy nhất cho nhiều người dùng. Do đó, cơ sở dữ liệu MySQL có hiệu năng cao hơn PostgreSQL đối với các ứng dụng chủ yếu đọc và hiển thị dữ liệu cho người dùng.                                      | PostgreSQL tạo ra một quy trình hệ thống mới với dung lượng phân bổ bộ nhớ đáng kể (khoảng 10 MB) cho mọi người dùng kết nối đến cơ sở dữ liệu. PostgreSQL đòi hỏi tài nguyên thiên về bộ nhớ để điều chỉnh quy mô cho nhiều người dùng. |

PostgreSQL phù hợp hơn cho các ứng dụng cấp doanh nghiệp với các thao tác ghi thường xuyên và truy vấn phức tạp.

MySQL phù hợp với các ứng dụng nội bộ với ít người dùng, hoặc tạo ra một công cụ lưu trữ thông tin với nhiều thao tác đọc hơn và cập nhật dữ liệu không thường xuyên.

