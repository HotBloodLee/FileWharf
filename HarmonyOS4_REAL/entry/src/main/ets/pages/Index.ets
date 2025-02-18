import { CommonConstants } from '../common/constants/CommonConstants'
import { MainContent } from '../entity/MainContent'
import Header from '../view/common/Header'
import FileIndex from '../view/file/FileIndex'
import DeviceIndex from '../view/device/DeviceIndex'
import HomeIndex from '../view/home/HomeIndex'

@Entry
@Component
struct Index {
  @State curIndex: number = 0
  @State isPageShow: boolean = false
  @State activePage: string = 'fileIndex';

  @State net_text: string = 'none';

  @Provide activeFileType: string = '所有'; // 初始状态为 'all'
  @Provide activeDevice: string = '所有'; // 初始状态为 'all'
  @Provide activeDeviceIdx: number = 0;

  @Provide deviceList: Array<SelectOption> = [
    { value: '所有' },
    { value: 'device1' },
    { value: 'device2' },
    { value: 'mac' }
  ]

  @Provide mainContentArr: MainContent[] = [ // 定义状态变量 mainContentArr，并初始化为一个包含 MainContent 对象的数组
    new MainContent("test.txt", 'app.media.bianji', "来自设备1", '/test.txt', 'txt', 'device1'),
    new MainContent("test1.png", 'app.media.bianji', "来自设备2", '/test1.png', 'png', 'device2'),
    new MainContent("test2.txt", 'app.media.bianji', "来自设备1", '/test2.txt', 'txt', 'device1'),
    new MainContent("test2.mp3", 'app.media.bianji', "来自设备1", '/test2.mp3', 'mp3', 'mac'),
    new MainContent("test2.mp4", 'app.media.bianji', "来自设备1", '/test2.mp4', 'mp4', 'device1'),
    new MainContent("test2.zip", 'app.media.bianji', "来自设备1", '/test2.zip', 'zip', 'device2'),
  ]

  onPageShow(): void {
    this.isPageShow = true
  }

  onPageHide(): void {
    this.isPageShow = false
  }

  @Builder TabBarBuilder(title: ResourceStr, index: number) {
    Column({space: CommonConstants.SPACE_8}) {
      Image(title)
        .width(40)
        .fillColor(this.curIndex === index ? $r('app.color.primary_color') : $r('app.color.gray'))
    }
  }


  build() {
    Column() {
      Header()
        .height('12%')
        // .backgroundColor(Color.Brown)
      Tabs({ barPosition: BarPosition.End }) {
        TabContent() {
          FileIndex()
        }
        .tabBar(this.TabBarBuilder($r('app.media.wenjian'), 0))

        TabContent() {
          DeviceIndex()
        }
        .tabBar(this.TabBarBuilder($r('app.media.shebeiguanli'), 1))

        TabContent() {
          HomeIndex()
        }
        .tabBar(this.TabBarBuilder($r('app.media.ic_user_portrait'), 2))
      }
      .height('88%')
      .onChange(index => this.curIndex = index)
      .barHeight(90)
    }
  }
}