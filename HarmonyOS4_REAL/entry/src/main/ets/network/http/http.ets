
import http from '@ohos.net.http';
import socket from '@ohos.net.socket';


class SocketInfo {
  message: ArrayBuffer = new ArrayBuffer(1);
  remoteInfo: socket.SocketRemoteInfo = {} as socket.SocketRemoteInfo;
}

class HttpTool {
  private httpRequest: http.HttpRequest;

  constructor() {
    this.httpRequest = http.createHttp()
  }

  sendPOST(data: string): Promise<string> {
    let rs: string = 'none';
    return new Promise((resolve, reject) => {
      this.httpRequest.request('http://192.168.137.83:10001/post', {
        method: http.RequestMethod.POST,
        header: { 'Content-Type': 'application/json' },
        extraData: JSON.stringify(data),
        connectTimeout: 60000,
        readTimeout: 60000
      }, (err, data) => {
        if (!err) {
          rs = JSON.stringify(data.result);
          console.info('Result: ' + data);
          return 'err';
        } else {
          console.error('Error:', err.message);
          return 'err';
        }
      });
    });
  }

  sendGET(query: string): Promise<string> {
    let rs: string = 'none';
    return new Promise((resolve, reject) => {
      this.httpRequest.request('http://192.168.137.83:10001/get?query=' + query, {
        method: http.RequestMethod.GET,
        header: { 'Content-Type': 'application/json' },
        connectTimeout: 60000,
        readTimeout: 60000
      }, (err, data) => {
        if (!err) {
          rs = JSON.stringify(data.result);
          console.info('Result: ' + data);
          return 'err';
        } else {
          console.error('Error:', err.message);
          return 'err';
        }
      });
    });
  }

  // socket: https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/socket-connection-V5#应用-tcpudp-协议进行通信

  listenPort(): void {
    let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();

    tcp.on('message', (value: SocketInfo) => {
      console.log("on message");
      let buffer = value.message;
      let dataView = new DataView(buffer);
      let str = "";
      for (let i = 0; i < dataView.byteLength; ++i) {
        str += String.fromCharCode(dataView.getUint8(i));
      }
      console.log("on connect received:" + str);
    });
    tcp.on('connect', () => {
      console.log("on connect");
    });
    tcp.on('close', () => {
      console.log("on close");
    });


    // 绑定本地IP地址和端口。
    let ipAddress : socket.NetAddress = {} as socket.NetAddress;
    ipAddress.address = "127.0.0.1";
    ipAddress.port = 10016;
    tcp.bind(ipAddress, (err: Error) => {
      if (err) {
        console.log('bind fail');
        return;
      }
      console.log('bind success');

      // 连接到指定的IP地址和端口。
      ipAddress.address = "127.0.0.1";
      ipAddress.port = 10016;

      let tcpConnect : socket.TCPConnectOptions = {} as socket.TCPConnectOptions;
      tcpConnect.address = ipAddress;
      tcpConnect.timeout = 6000;

      tcp.connect(tcpConnect).then(() => {
        console.log('connect success');
        let tcpSendOptions: socket.TCPSendOptions = {
          data: 'Hello, server!'
        }
        tcp.send(tcpSendOptions).then(() => {
          console.log('send success');
        }).catch((err: Error) => {
          console.log('send fail');
        });
      }).catch((err: Error) => {
        console.log('connect fail');
      });
    });

    // 连接使用完毕后，主动关闭。取消相关事件的订阅。
    setTimeout(() => {
      tcp.close().then(() => {
        console.log('close success');
      }).catch((err: Error) => {
        console.log('close fail');
      });
      tcp.off('message');
      tcp.off('connect');
      tcp.off('close');
    }, 30 * 1000);

  }
}

export default new HttpTool() as HttpTool;

