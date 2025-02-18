@Component
export default struct FileHeader {

  @Consume deviceList: Array<SelectOption>
  @Consume activeDevice: string
  @Consume activeDeviceIdx: number

  build() {
    Row() { // 创建一个行容器
      Text('当前查看设备:')
        .fontSize(18)
        .textAlign(TextAlign.Start)
        .width(120)

      Select(this.deviceList)
        .selected(this.activeDeviceIdx)
        .value(this.activeDevice)
        .onSelect((index: number, value: string) => {
          this.activeDeviceIdx = index
          this.activeDevice = value
        })
        .selectedOptionBgColor($r('app.color.lightest_gray'))
        .selectedOptionFontColor($r('app.color.primary_color'))
    }
    .width('80%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}