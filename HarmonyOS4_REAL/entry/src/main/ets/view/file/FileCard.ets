import { MainContent } from '../../entity/MainContent'

@Component
export default struct FileCard {

  @Prop item: MainContent

  build() {
    Column() { // 列表项的列容器
      Row() {
        Text(this.item.title) // 创建一个文本组件，内容为列表项标题
          .width('50%') // 设置文本组件的宽度为 100%
          .fontSize(16) // 设置字体大小
          .fontColor('#182431') // 设置文本颜色
          .fontWeight(500) // 设置字体粗细
          .margin({ left: 16 }) // 设置文本的外边距
          .textAlign(TextAlign.Start) // 设置文本对齐方式为开始对齐
        Text("20:00") // 创建一个文本组件，内容为列表项标题
          .width('40%') // 设置文本组件的宽度为 100%
          .fontSize(16) // 设置字体大小
          .fontColor('#182431') // 设置文本颜色
          .fontWeight(300) // 设置字体粗细
          .margin({ right: 16 }) // 设置文本的外边距
          .textAlign(TextAlign.End) // 设置文本对齐方式为开始对齐
      }
      .width('100%') // 设置文本组件的宽度为 100%
      .height(28) // 设置文本组件的高度为 48
      .justifyContent(FlexAlign.SpaceAround)

      if (this.item.fileType === 'png' || this.item.fileType === 'mp4' || this.item.fileType === 'mp3') {
        Image($r(this.item.image)) // 创建一个图片组件，并加载列表项的图片资源
          .width(200) // 设置图片的宽度为 100%
          .height(200) // 设置图片的高度为 176
          .objectFit(ImageFit.Auto) // 设置图片填充方式为填充
      }

      Text('来自设备: ' + this.item.device) // 创建一个文本组件，内容为列表项描述
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
    .width('72%')
    .margin({ left: '4%'}) // 设置列表项的外边距
  }
}