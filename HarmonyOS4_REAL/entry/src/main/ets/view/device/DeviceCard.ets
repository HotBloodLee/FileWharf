@Component
export default struct DeviceCard {

  @Prop item: SelectOption

  build() {
    Column() { // 列表项的列容器

      Text('设备: ' + this.item.value) // 创建一个文本组件，内容为列表项描述
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