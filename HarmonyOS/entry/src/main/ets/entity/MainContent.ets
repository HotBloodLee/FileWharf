import {fileIo as fs, ReadOptions, WriteOptions} from '@kit.CoreFileKit';
import {common} from '@kit.AbilityKit';

export class MainContent {
  title: Resource | string =''
  image: Resource = $r('app.media.background')
  description: Resource | string =''
  filePath: string = ''; // 新增属性来存储文件路径
  fileType: string = ''; // 新增属性来存储文件格式
  device: string = ''; // 新增属性来存储设备

  constructor(title: Resource | string, image: Resource, description: Resource | string, filePath: string, fileType: string, device: string) {
    this.title = title;
    this.image = image;
    this.description = description;
    this.filePath = filePath;
    this.fileType = fileType;
    this.device = device;
  }

  // 新增方法来读取文件内容
  async readWriteFileWithStream(): Promise<void> {
    let context = getContext(this) as common.UIAbilityContext;
    let rootDir = context.filesDir;

    // 打开文件流
    let inputStream = fs.createStreamSync(rootDir + this.filePath, 'r+');

    try {
      // 以流的形式读取源文件内容并写入目的文件
      let bufSize = 4096;
      let readSize = 0;
      let buf = new ArrayBuffer(bufSize);
      let readOptions: ReadOptions = {
        offset: readSize,
        length: bufSize
      };
      let readLen = await inputStream.read(buf, readOptions);
      readSize += readLen;
      while (readLen > 0) {
        const writeBuf = readLen < bufSize ? buf.slice(0, readLen) : buf;

        // TODO: 创建一个输出流，用于传输文件

        readOptions.offset = readSize;
        readLen = await inputStream.read(buf, readOptions);
        readSize += readLen;
      }
    } catch (err) {
      console.error(`Failed to read file: ${err.message}`);
      throw new Error(`Failed to read file: ${err.message}`);
    } finally {
      // 关闭文件流
      inputStream.closeSync();
    }
  }

  // 新增方法来写入文件内容（分段写入）
  async appendFileContent(data: ArrayBuffer): Promise<void> {
    // 创建或打开文件流，使用 'a+' 模式表示追加模式
    let outputStream = fs.createStreamSync(this.filePath, 'a+');
    try {
      let writeOptions: WriteOptions = {
        offset: 0,
        length: data.byteLength
      };
      await outputStream.write(data, writeOptions);
      outputStream.closeSync();
    } catch (err) {
      console.error(`Failed to append file: ${err.message}`);
      throw new Error(`Failed to append file: ${err.message}`);
    }finally {
      // 关闭文件流
      outputStream.closeSync();
    }
  }
}
