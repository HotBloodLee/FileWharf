@Component
struct Header {
  @Link net_text: string;

  build() {
    Column() { // 创建一个列容器
      Row() { // 创建一个行容器

        Image($r('app.media.bianji')) // 创建一个图片组件，并加载资源 'app.media.bianji'
          .width(32) // 设置图片的宽度为 32
          .height(32) // 设置图片的高度为 32
        // .margin({ left: 26 }) // 设置图片的外边距
        Text('设备名称:' + this.net_text) // 创建一个文本组件，内容为 'CodeGenie'
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
  }
}

export default Header;