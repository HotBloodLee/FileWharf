export class MainContent {
  title: string = ''
  image: string = 'app.media.background'
  description: string = ''
  filePath: string = ''; // 新增属性来存储文件路径
  fileType: string = ''; // 新增属性来存储文件格式
  device: string = ''; // 新增属性来存储设备

  constructor(title: string, image: string, description: string, filePath: string, fileType: string, device: string) {
    this.title = title;
    this.image = image;
    this.description = description;
    this.filePath = filePath;
    this.fileType = fileType;
    this.device = device;
  }
}
