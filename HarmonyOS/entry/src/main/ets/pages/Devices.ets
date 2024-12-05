import { MainContent } from '../entity/MainContent';
import { curves } from '@kit.ArkUI';


@Entry // 标记此组件为应用的入口组件
@Component // 标记此为一个组件
struct Index {
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
    new MainContent("test.txt", $r('app.media.bianji'), "来自设备1", '/test.txt', 'txt', 'device1'),
    new MainContent("test1.png", $r('app.media.bianji'), "来自设备2", '/test1.png', 'png', 'device2'),
    new MainContent("test2.txt", $r('app.media.bianji'), "来自设备1", '/test2.txt', 'txt', 'device1'),
    new MainContent("test2.mp3", $r('app.media.bianji'), "来自设备1", '/test2.mp3', 'mp3', 'mac'),
    new MainContent("test2.mp4", $r('app.media.bianji'), "来自设备1", '/test2.mp4', 'mp4', 'device1'),
    new MainContent("test2.zip", $r('app.media.bianji'), "来自设备1", '/test2.zip', 'zip', 'device2'),
  ]

  build() {


    Column() { // 创建一个列容器

      Column() { // 创建一个列容器
        Row() { // 创建一个行容器

          Image($r('app.media.bianji')) // 创建一个图片组件，并加载资源 'app.media.bianji'
            .width(32) // 设置图片的宽度为 32
            .height(32) // 设置图片的高度为 32
          // .margin({ left: 26 }) // 设置图片的外边距
          Text('设备名称') // 创建一个文本组件，内容为 'CodeGenie'
            .fontColor('#182431') // 设置文本颜色
            .fontSize(30) // 设置字体大小
            .fontWeight(700) // 设置字体粗细
          Image($r('app.media.tianjia')) // 创建一个图片组件，并加载资源 'app.media.bianji'
            .width(32) // 设置图片的宽度为 32
            .height(32) // 设置图片的高度为 32
          // .margin({ right: 26 }) // 设置图片的外边距
        }
        .width('100%') // 设置行容器的宽度为 100%
        .height('50%') // 设置行容器的高度为 56
        .justifyContent(FlexAlign.SpaceAround) // 设置子组件的对齐方式为开始对齐

        Row() { // 创建一个行容器
          Text('组: XXX ✅') // 创建一个文本组件，内容为 'CodeGenie'
            .fontColor('#182431') // 设置文本颜色
            .fontSize(15) // 设置字体大小
            .fontWeight(300) // 设置字体粗细
            .width('35%')
            .textAlign(TextAlign.Start) // 设置文本的对齐方式为开始对齐
          Text('活跃设备: 2') // 创建一个文本组件，内容为 'CodeGenie'
            .fontColor('#182431') // 设置文本颜色
            .fontSize(15) // 设置字体大小
            .width('35%')
            .fontWeight(300) // 设置字体粗细
            .textAlign(TextAlign.End)
        }
        .width('100%') // 设置行容器的宽度为 100%
        .height('50%') // 设置行容器的高度为 56
        .justifyContent(FlexAlign.SpaceAround) // 设置子组件的对齐方式为开始对齐
      }
      .width('100%') // 设置行容器的宽度为 100%
      .height('10%') // 设置行容器的高度为 56



      Divider() // 创建一个分割线组件
        .width('90%') // 设置分割线的宽度为 100%
        .strokeWidth(1) // 设置分割线的粗细为 1
        .color('#33182431') // 设置分割线的颜色
      // .margin({ left: 16, right: 16 }) // 设置分割线的外边距

      Row() { // 创建一个行容器
        Text('组内设备列表')
          .width('100%')
          .fontSize(20)
          .textAlign(TextAlign.Center)
      }
      .width('90%')
      .height('5%')
      .margin({top: 5})


      Row() { // 创建一个行容器，用于水平布局
        List({ space: 12, initialIndex: 0 }) { // 列表组件
          ForEach(this.deviceList, (item: SelectOption) => { // 遍历 mainContentArr 数组
            if (!(item.value === '所有')){
              ListItem() { // 创建一个列表项组件
                Column() { // 列表项的列容器

                  Text('设备: ' + item.value) // 创建一个文本组件，内容为列表项描述
                    .width('100%') // 设置文本组件的宽度为 100%
                    .height(48) // 设置文本组件的高度为 48
                    .fontSize(16) // 设置字体大小
                    .fontColor('#182431') // 设置文本颜色
                    .fontWeight(400) // 设置字体粗细
                    .margin({ left: 26 }) // 设置文本的外边距
                    .textAlign(TextAlign.Start) // 设置文本对齐方式为开始对齐
                }
                .backgroundColor('#F2F2F2')
                .borderRadius(15)
                .width('90%')
                .margin({ left: '5%'}) // 设置列表项的外边距

              }
            }

          }, (item: MainContent) => JSON.stringify(item)) // 对每个列表项进行唯一性校验
        }
        .listDirection(Axis.Vertical) // 设置列表的滚动方向为垂直
        .scrollBar(BarState.Auto) // 隐藏滚动条
        .friction(0.6) // 设置滚动摩擦系数
        .width('100%') // 设置列表容器的宽度为80%（可以根据需要调整，与导航栏宽度之和应为100%）
        .height('100%') // 设置列表容器的高度为100%
        .padding({bottom: 16})
        .edgeEffect(EdgeEffect.Spring) // 设置滚动到边缘时的效果为弹簧效果

      }
      .width('100%') // 设置行容器的宽度为100%
      .height('80%') // 设置行容器的高度为100%


      Divider() // 创建一个分割线组件
        .width('90%') // 设置分割线的宽度为 100%
        .strokeWidth(1) // 设置分割线的粗细为 1
        .color('#33182431') // 设置分割线的颜色
      // .margin({ left: 16, right: 16 }) // 设置分割线的外边距

      Row() { // 创建一个行容器
        Image($r('app.media.wenjian')) // 创建一个图片组件，并加载资源 'app.media.wenjian'
          .width(32) // 设置图片的宽度为 32
          .height('100%') // 设置图片的高度为 32
          .margin({ top: '7%' }) // 设置图片的外边距
        Image($r('app.media.shebeiguanli')) // 创建一个图片组件，并加载资源 'app.media.wenjian'
          .width(32) // 设置图片的宽度为 32
          .height('100%') // 设置图片的高度为 32
          .margin({ top: '7%' }) // 设置图片的外边距
        Image($r('app.media.wode')) // 创建一个图片组件，并加载资源 'app.media.wenjian'
          .width(32) // 设置图片的宽度为 32
          .height('100%') // 设置图片的高度为 32
          .margin({ top: '7%' }) // 设置图片的外边距
      }
      .width('100%') // 设置行容器的宽度为 100%
      .height('5%') // 设置行容器的高度为 48
      .justifyContent(FlexAlign.SpaceAround) // 设置子组件的对齐方式为开始对齐
    }
    .width('100%') // 设置列容器的宽度为 100%
    .height('100%') // 设置列容器的高度为 100%
  }
}
