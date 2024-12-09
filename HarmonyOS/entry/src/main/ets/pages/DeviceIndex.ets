import { MainContent } from '../entity/MainContent';

@Component
struct DeviceIndex {

  @Link activeFileType: string; // 初始状态为 'all'
  @Link activeDevice: string; // 初始状态为 'all'
  @Link activeDeviceIdx: number;
  @Link deviceList: Array<SelectOption>;


  @Link mainContentArr: MainContent[];

  build() {
    Column() { // 创建一个行容器，用于水平布局
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
      .height('95%') // 设置行容器的高度为100%

    }
    .width('100%') // 设置行容器的宽度为100%
    .height('85%') // 设置行容器的高度为100%
    .justifyContent(FlexAlign.Start)

  }
}

export default DeviceIndex;