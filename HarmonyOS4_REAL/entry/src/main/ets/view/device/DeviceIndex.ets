import { MainContent } from '../../entity/MainContent';
import DeviceCard from './DeviceCard';

@Component
export default struct DeviceIndex {

  @Consume deviceList: Array<SelectOption>;

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
                DeviceCard({
                  item: item,
                })
              }
            }

          }, (item: MainContent) => JSON.stringify(item)) // 对每个列表项进行唯一性校验
        }
        .listDirection(Axis.Vertical) // 设置列表的滚动方向为垂直
        .scrollBar(BarState.Auto) // 隐藏滚动条
        .width('100%') // 设置列表容器的宽度为80%（可以根据需要调整，与导航栏宽度之和应为100%）
        .height('100%') // 设置列表容器的高度为100%
        .padding({bottom: 16})
        .edgeEffect(EdgeEffect.Spring) // 设置滚动到边缘时的效果为弹簧效果

      }
      .width('100%') // 设置行容器的宽度为100%
      .height('95%') // 设置行容器的高度为100%

    }
    .width('100%') // 设置行容器的宽度为100%
    .height('100%') // 设置行容器的高度为100%
    .justifyContent(FlexAlign.Start)

  }
}