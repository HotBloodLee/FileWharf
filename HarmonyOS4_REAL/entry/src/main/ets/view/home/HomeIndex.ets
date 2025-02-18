@Component
struct HomeIndex {

  build() {
    Column() { // 创建一个行容器，用于水平布局
      Row() { // 创建一个行容器
        Image($r('app.media.bianji')) // 创建一个图片组件，并加载列表项的图片资源
          .width('100%') // 设置图片的宽度为 100%
          .height('100%') // 设置图片的高度为 176
          .objectFit(ImageFit.Contain)
      }
      .backgroundColor('#F2F2F2')
      .borderRadius(15)
      .width('90%')
      .height(170)
      .margin({ bottom: 10, top: 10}) // 设置列表项的外边距


      Row() { // 创建一个行容器
        Text('主题') // 创建一个文本组件，内容为列表项描述
          .width('60%') // 设置文本组件的宽度为 100%
          .height(48) // 设置文本组件的高度为 48
          .fontSize(20) // 设置字体大小
          .fontColor('#182431') // 设置文本颜色
          .fontWeight(400) // 设置字体粗细
          .margin({ left: 26 }) // 设置文本的外边距
          .textAlign(TextAlign.Start) // 设置文本对齐方式为开始对齐
        Text('>') // 创建一个文本组件，内容为列表项描述
          .width('25%') // 设置文本组件的宽度为 100%
          .height(48) // 设置文本组件的高度为 48
          .fontSize(20) // 设置字体大小
          .fontColor('#182431') // 设置文本颜色
          .fontWeight(400) // 设置字体粗细
          .margin({ right: 36 }) // 设置文本的外边距
          .textAlign(TextAlign.End) // 设置文本对齐方式为开始对齐
      }
      .backgroundColor('#F2F2F2')
      .borderRadius(15)
      .height(60)
      .width('90%')
      .margin({ bottom: 10}) // 设置列表项的外边距

      Row() { // 创建一个行容器
        Text('帮助') // 创建一个文本组件，内容为列表项描述
          .width('60%') // 设置文本组件的宽度为 100%
          .height(48) // 设置文本组件的高度为 48
          .fontSize(20) // 设置字体大小
          .fontColor('#182431') // 设置文本颜色
          .fontWeight(400) // 设置字体粗细
          .margin({ left: 26 }) // 设置文本的外边距
          .textAlign(TextAlign.Start) // 设置文本对齐方式为开始对齐
        Text('>') // 创建一个文本组件，内容为列表项描述
          .width('25%') // 设置文本组件的宽度为 100%
          .height(48) // 设置文本组件的高度为 48
          .fontSize(20) // 设置字体大小
          .fontColor('#182431') // 设置文本颜色
          .fontWeight(400) // 设置字体粗细
          .margin({ right: 36 }) // 设置文本的外边距
          .textAlign(TextAlign.End) // 设置文本对齐方式为开始对齐

      }
      .backgroundColor('#F2F2F2')
      .borderRadius(15)
      .height(60)
      .width('90%')
      .margin({ bottom: 10}) // 设置列表项的外边距

      Row() { // 创建一个行容器
        Text('关于我们') // 创建一个文本组件，内容为列表项描述
          .width('60%') // 设置文本组件的宽度为 100%
          .height(48) // 设置文本组件的高度为 48
          .fontSize(20) // 设置字体大小
          .fontColor('#182431') // 设置文本颜色
          .fontWeight(400) // 设置字体粗细
          .margin({ left: 26 }) // 设置文本的外边距
          .textAlign(TextAlign.Start) // 设置文本对齐方式为开始对齐
        Text('>') // 创建一个文本组件，内容为列表项描述
          .width('25%') // 设置文本组件的宽度为 100%
          .height(48) // 设置文本组件的高度为 48
          .fontSize(20) // 设置字体大小
          .fontColor('#182431') // 设置文本颜色
          .fontWeight(400) // 设置字体粗细
          .margin({ right: 36 }) // 设置文本的外边距
          .textAlign(TextAlign.End) // 设置文本对齐方式为开始对齐
      }
      .backgroundColor('#F2F2F2')
      .borderRadius(15)
      .height(60)
      .width('90%')
      .margin({ bottom: 10}) // 设置列表项的外边距
      .justifyContent(FlexAlign.SpaceAround)

    }
    .width('100%') // 设置行容器的宽度为100%
    .height('100%') // 设置行容器的高度为100%
    .justifyContent(FlexAlign.Start)

  }
}

export default HomeIndex;