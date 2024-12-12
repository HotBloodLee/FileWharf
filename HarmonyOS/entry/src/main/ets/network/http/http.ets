import { http } from '@kit.NetworkKit';

class HttpTool {
  private httpRequest: http.HttpRequest;

  constructor() {
    this.httpRequest = http.createHttp()
  }

  sendPOST(data: string): Promise<string> {
    let rs: string = 'none';
    return new Promise((resolve, reject) => {
      this.httpRequest.request('http://127.0.0.1:10001/post', {
        method: http.RequestMethod.POST,
        header: { 'Content-Type': 'application/json' },
        extraData: JSON.stringify(data),
        connectTimeout: 60000,
        readTimeout: 60000
      }, (err, data) => {
        if (!err) {
          rs = JSON.stringify(data.result);
          console.info('Result: ' + data.result);
          return rs;
        } else {
          console.error('Error:', err.message);
          return rs;
        }
      });
    });

  }
}

export default new HttpTool() as HttpTool;

