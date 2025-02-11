import Header from './Header';
import Footer from './Footer';
import Divid from './Divid';
import FileIndex from './FileIndex';
import HomeIndex from './HomeIndex';
import DeviceIndex from './DeviceIndex';
import { MainContent } from '../entity/MainContent';

@Entry
@Component
struct Index {
  @State net_text: string = 'none';

  @State activePage: string = 'fileIndex';

  @State activeFileType: string = '所有'; // 初始状态为 'all'
  @State activeDevice: string = '所有'; // 初始状态为 'all'
  @State activeDeviceIdx: number = 0;
  @State deviceList: Array<SelectOption> = [
    { value: '所有' },
    { value: 'device1' },
    { value: 'device2' },
    { value: 'mac' }
  ]

  @State mainContentArr: MainContent[] = [ // 定义状态变量 mainContentArr，并初始化为一个包含 MainContent 对象的数组
    new MainContent("test.txt", 'app.media.bianji', "来自设备1", '/test.txt', 'txt', 'device1'),
    new MainContent("test1.png", 'app.media.bianji', "来自设备2", '/test1.png', 'png', 'device2'),
    new MainContent("test2.txt", 'app.media.bianji', "来自设备1", '/test2.txt', 'txt', 'device1'),
    new MainContent("test2.mp3", 'app.media.bianji', "来自设备1", '/test2.mp3', 'mp3', 'mac'),
    new MainContent("test2.mp4", 'app.media.bianji', "来自设备1", '/test2.mp4', 'mp4', 'device1'),
    new MainContent("test2.zip", 'app.media.bianji', "来自设备1", '/test2.zip', 'zip', 'device2'),
  ]

  build() {
    Column() {

      Header({
        net_text: this.net_text
      })

      Divid()

      if (this.activePage === 'fileIndex') {
        FileIndex({
          activeFileType: this.activeFileType,
          activeDevice: this.activeDevice,
          mainContentArr: this.mainContentArr,
          deviceList: this.deviceList,
          activeDeviceIdx: this.activeDeviceIdx
        })
      }else if (this.activePage === 'homeIndex') {
        HomeIndex()
      }else {
        DeviceIndex({
          activeFileType: this.activeFileType,
          activeDevice: this.activeDevice,
          mainContentArr: this.mainContentArr,
          deviceList: this.deviceList,
          activeDeviceIdx: this.activeDeviceIdx
        })
      }

      Divid()

      Footer({
        activePage: this.activePage
      })
    }
    .width('100%') // 设置列容器的宽度为 100%
    .height('100%') // 设置列容器的高度为 100%
  }
}