import { MainContent } from '../../entity/MainContent'
import FileCard from './FileCard';

@Component
export default struct FileList {

  @Consume activeFileType: string; // 初始状态为 'all'
  @Consume activeDevice: string; // 初始状态为 'all'
  @Consume mainContentArr: MainContent[]

  build() {
    List({ space: 12, initialIndex: 0 }) { // 列表组件
      ForEach(this.mainContentArr, (item: MainContent) => { // 遍历 mainContentArr 数组
        if ((item.device === this.activeDevice || this.activeDevice === '所有') && (item.fileType === this.activeFileType || this.activeFileType === '所有')){
          ListItem() { // 创建一个列表项组件
            FileCard({
              item: item
            })
          }
        }
      }, (item: MainContent) => JSON.stringify(item)) // 对每个列表项进行唯一性校验
    }
    .listDirection(Axis.Vertical) // 设置列表的滚动方向为垂直
    .scrollBar(BarState.On) // 隐藏滚动条
    .width('100%') // 设置列表容器的宽度为80%（可以根据需要调整，与导航栏宽度之和应为100%）
    .height('100%') // 设置列表容器的高度为100%
    .padding({bottom: 46})
    .edgeEffect(EdgeEffect.Spring) // 设置滚动到边缘时的效果为弹簧效果
  }
}