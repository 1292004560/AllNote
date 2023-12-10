## 创建套接字函数:socketpair()

```C
#include <sys/types.h>
#include <sys/socket.h>
int socketpair(int domain, int type, int protocol, int sv[2]);
```

**socketpair()函数用于创建一对无名的、相互连接的套接子。 
如果函数成功，则返回0，创建好的套接字分别是sv[0]和sv[1]；否则返回-1，错误码保存于errno中。**

### 参数说明

1. **domain : ** 指定协议族，通常是 `AF_UNIX`，表示使用 Unix 域协议（Unix Domain Socket）。Unix 域套接字只在本地计算机上有效，而不通过网络传输数据
2. **type : ** 指定 socket 的类型，可以是 `SOCK_STREAM`（面向连接的流 socket）、`SOCK_DGRAM`（无连接的数据报 socket）等。在 `socketpair` 中通常使用 `SOCK_STREAM`。
3. **protocol : ** 指定具体的协议。在 `socketpair` 中通常设置为 0，表示让系统自动选择合适的协议。
4. **sv[2] : ** 套节字柄对，该两个句柄作用相同，均能进行读写双向操作
5. 返回结果 : 0为创建成功，-1为创建失败，并且errno来表明特定的错误号，具体错误号如下所述

```txt
EAFNOSUPPORT:本机上不支持指定的address。

EFAULT： 地址sv无法指向有效的进程地址空间内。

EMFILE： 已经达到了系统限制文件描述符，或者该进程使用过量的描述符。

EOPNOTSUPP：指定的协议不支持创建套接字对。

EPROTONOSUPPORT：本机不支持指定的协议。
```

### 基本用法

1. **这对套接字可以用于全双工通信，每一个套接字既可以读也可以写。例如，可以往sv[0]中写，从sv[1]中读；或者从sv[1]中写，从sv[0]中读;**
2. **如果往一个套接字(如sv[0])中写入后，再从该套接字读时会阻塞，只能在另一个套接字中(sv[1])上读成功;**
3. **读、写操作可以位于同一个进程，也可以分别位于不同的进程，如父子进程。如果是父子进程时，一般会功能分离，一个进程用来读，一个用来写。因为文件描述符sv[0]和sv[1]是进程共享的，所以读的进程要关闭写描述符, 反之，写的进程关闭读描述符。**

### 代码示例

**读写操作位于同一进程**

```C
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <errno.h>
#include <sys/socket.h>
#include <stdlib.h>

const char * str = "SOCKET PAIR TEST";

int main(int argc, char * argv[])
{
    char buf[128] = {0};
    int socket_pair[2];
    pid_t pid;

    if (socketpair(AF_UNIX, SOCK_STREAM, 0, socket_pair) == -1){
        
        printf("Error, socketpair create fialed, errno(%d) : %s\n", errno,strerror(errno));
        return EXIT_FAILURE;
    }

    int size = write(socket_pair[0], str, strlen(str));

    read(socket_pair[1], buf, size);

    printf("Read result : %s\n", buf);
    return EXIT_SUCCESS;
}
```

**读写操作父子进程**

```C
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
int main()
{
    int sv[2];
    int ret = socketpair(AF_UNIX, SOCK_STREAM, 0, sv);
    if (ret < 0){
        printf("socketpair error ,errno : %d\n", errno);
        return -1;
    }

    pid_t cpid = fork();

    if (-1 == cpid) {
        printf("fork error \n");
        return -1;
    }else if (0 == cpid){
        close(sv[0]);

        char * msg = "hello";
        size_t len = strlen(msg);
        ret = send(sv[1], msg, len + 1, 0);
        if (ret < 0){
            printf("send error , errno = %d\n", errno);
            return -1;
        }
        printf("           send ret = %d\n", ret);
        printf("           pid : %d, send : %s\n", getpid(), msg);
    }else {
        pid_t ppid = fork();
        if (-1 == ppid){
            printf("fork error \n");
            return -1;
        }else if (0 == ppid){
            close(sv[1]);
            sv[1] = -1;
            
            usleep(10 * 100);

            char buf[1024] = {0};

            ret = recv(sv[0], buf, sizeof(buf)-1, 0);
            if (ret < 0) {
                printf(" recv error , errno : %d \n", errno);
                return -1;
            }
            printf("         recv ret : %d\n", ret);
            printf("       pid : %d, received : %s\n", getpid(), buf);
        }else {
            sleep(2);
        }

    }
    return 0;
}
```

## 发送数据函数:sendmsg()

```C
#include <sys/types.h>  
#include <sys/socket.h>
int sendmsg(int s, const strcut msghdr *msg, unsigned int flags);
```

### 参数说明

- `s`：套接字描述符，表示要发送消息的套接字。

- `msg`：一个指向 `struct msghdr` 结构体的指针，其中包含了消息的详细信息。`struct msghdr` 的定义如下：

  ```C
  struct msghdr {
      void         *msg_name;       /* 指定目标套接字的地址信息，可以为 NULL */
      socklen_t     msg_namelen;    /* 指定 msg_name 的长度 */
      struct iovec *msg_iov;        /* 指定消息的数据缓冲区。是一个指向 struct iovec 数组的指针 */
      size_t        msg_iovlen;     /* 指定 msg_iov 数组的元素个数 */
      void         *msg_control;    /* 用于传递辅助数据（控制信息）的缓冲区，通常为 NULL */
      socklen_t     msg_controllen; /* 指定 msg_control 的长度 */
      int           msg_flags;      /* 用于指定函数的行为，可以是以下标志的按位或组合 */
  };
  /*
  MSG_DONTROUTE：不查找路由，直接使用本地接口发送。
  MSG_DONTWAIT：非阻塞操作，如果数据不能立即发送，函数将立即返回而不等待。
  MSG_EOR：表示这是消息的结束部分。
  MSG_MORE：表示还有更多数据要发送。
  */
  ```

- `struct iovec` 的定义如下:

  ```C
  struct iovec {
      void  *iov_base; /* Starting address of the buffer */
      size_t iov_len;  /* Size of the buffer */
  };
  ```

- 函数返回值为成功发送的字节数，如果出错则返回 -1，错误信息存储在 `errno` 中。

### 代码示例

```C
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <netinet/in.h>

int main() {
    // 创建一个 UDP 套接字
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd == -1) {
        perror("socket");
        return 1;
    }

    // 准备消息
    struct iovec iov[1];
    char buffer[20] = "Hello, sendmsg!";
    iov[0].iov_base = buffer;
    iov[0].iov_len = strlen(buffer);

    // 准备消息头部
    struct msghdr msg;
    memset(&msg, 0, sizeof(struct msghdr));

    // 设置目标地址信息
    struct sockaddr_in dest_addr;
    memset(&dest_addr, 0, sizeof(struct sockaddr_in));
    dest_addr.sin_family = AF_INET;
    dest_addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK); // 本地回环地址
    dest_addr.sin_port = htons(12345); // 你的目标端口

    msg.msg_name = &dest_addr;
    msg.msg_namelen = sizeof(struct sockaddr_in);
    msg.msg_iov = iov;
    msg.msg_iovlen = 1;

    // 发送消息
    ssize_t bytes_sent = sendmsg(sockfd, &msg, 0);
    if (bytes_sent == -1) {
        perror("sendmsg");
        close(sockfd);
        return 1;
    }

    printf("Sent %zd bytes: %s\n", bytes_sent, buffer);

    // 关闭套接字
    close(sockfd);

    return 0;
}

```

## 从套接字接收消息:recvmsg()

```C
#include <sys/types.h>  
#include <sys/socket.h>
int recvmsg(int s, struct msghdr *msg, unsigned int flags);
```

### 参数说明

* `s` : 为已建立好连线的socket, 如果利用UDP 协议则不需经过连线操作
* `msg` : 指向欲连线的数据结构内容
* `flags `: 一般设0, 详细描述请参考send()
* 返回值 : 成功则返回接收到的字符数, 失败则返回-1, 错误原因存于errno 中

### 代码示例

```C
/** server **/
#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <string.h>
#include <netinet/in.h>

int main() {

    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd == -1){
        perror("socket failed ");
        return 1;
    }

    struct sockaddr_in server_addr;
    memset(&server_addr, 0, sizeof(struct sockaddr_in));
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = htonl(INADDR_ANY);
    server_addr.sin_port = htons(12345);

    if (bind(sockfd, (struct sockaddr*)&server_addr, sizeof(struct sockaddr_in)) == -1) {
        perror("bind failed");
        close(sockfd);
        return 1;
    }

    char buffer[256];
    struct iovec iov[1];
    iov[0].iov_base = buffer;
    iov[0].iov_len = sizeof(buffer);

    struct msghdr msg;

    memset(&msg, 0, sizeof(struct msghdr));

    msg.msg_iov = iov;
    msg.msg_iovlen = 1;

    ssize_t bytes_received = recvmsg(sockfd, &msg, 0);

    if (bytes_received == -1){
        perror("recvmsg failed");
        close(sockfd);
        return 1;
    }

    // 打印接收到的消息
    printf("%s\n", (char *)iov[0].iov_base);

    // 关闭套接字
    close(sockfd);

    return 0;
}
```

```C
/** client **/
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <string.h>
#include <netinet/in.h>
#include <stdio.h>

int main()
{
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd == -1){
        perror("socket failed");
        _exit(1);
    }

    struct sockaddr_in server_addr;
    memset(&server_addr, 0, sizeof(struct sockaddr_in));
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK); // 回环地址 (127.0.0.1)

    server_addr.sin_port = htons(12345);

    char buffer[256] = "hello world";

    ssize_t bytes_sent = sendto(sockfd, buffer, strlen(buffer), 0 , (struct sockaddr*)&server_addr, sizeof(struct sockaddr_in));

    if (bytes_sent == -1) {
        perror("sendto failed");
        close(sockfd);
        return 1;
    }

    // 关闭套接字
    close(sockfd);
}
```

## 将地址绑定到socket:bind()

```C
#include <sys/types.h>         
#include <sys/socket.h>
int bind(int sockfd, const struct sockaddr *addr,socklen_t addrlen);
```

### 参数说明

* `sockfd` : 需要绑定的socket
* `addr` : 存放了服务端用于通信的地址和端口
* `addrlen` : 表示 addr 结构体的大小
* 返回值：成功则返回0 ，失败返回-1，错误原因存于 errno 中。如果绑定的地址错误，或者端口已被占用，bind 函数一定会报错，否则一般不会返回错误

### 代码示例

```C
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <netdb.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
int main(int argc, char *argv[])
{
    if (argc != 2)
    {
        printf("Using:./server port\nExample:./server 5005\n\n");
        return -1;
    }

    // 第1步：创建服务端的socket。
    int listenfd;
    if ((listenfd = socket(AF_INET, SOCK_STREAM, 0)) == -1)
    {
        perror("socket");
        return -1;
    }

    // 第2步：把服务端用于通信的地址和端口绑定到socket上。
    struct sockaddr_in servaddr; // 服务端地址信息的数据结构。
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;                // 协议族，在socket编程中只能是AF_INET。
    servaddr.sin_addr.s_addr = htonl(INADDR_ANY); // 任意ip地址。
    
    // servaddr.sin_addr.s_addr = inet_addr("192.168.190.134"); // 指定ip地址。
    servaddr.sin_port = htons(atoi(argv[1])); // 指定通信端口。
    if (bind(listenfd, (struct sockaddr *)&servaddr, sizeof(servaddr)) != 0)
    {
        perror("bind");
        close(listenfd);
        return -1;
    }
    // 第3步：把socket设置为监听模式。
    if (listen(listenfd, 5) != 0)
    {
        perror("listen");
        close(listenfd);
        return -1;
    }
    // 第4步：接受客户端的连接。
    int clientfd;                             // 客户端的socket。
    int socklen = sizeof(struct sockaddr_in); // struct sockaddr_in的大小
    struct sockaddr_in clientaddr;            // 客户端的地址信息。
    
    clientfd = accept(listenfd, (struct sockaddr *)&clientaddr, (socklen_t *)&socklen);
    printf("客户端（%s）已连接。\n", inet_ntoa(clientaddr.sin_addr));

    // 第5步：与客户端通信，接收客户端发过来的报文后，回复ok。
    char buffer[1024];
    while (1)
    {
        int iret;
        memset(buffer, 0, sizeof(buffer));
        if ((iret = recv(clientfd, buffer, sizeof(buffer), 0)) <= 0) // 接收客户端的请求报文。
        {
            printf("iret=%d\n", iret);
            break;
        }
        printf("接收：%s\n", buffer);
        strcpy(buffer, "ok");
        if ((iret = send(clientfd, buffer, strlen(buffer), 0)) <= 0) // 向客户端发送响应结果。
        {
            perror("send");
            break;
        }
        printf("发送：%s\n", buffer);
    }
    // 第6步：关闭socket，释放资源。
    close(listenfd);
    close(clientfd);
}
```

