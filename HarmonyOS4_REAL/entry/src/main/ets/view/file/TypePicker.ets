import curves from '@ohos.curves'

@Component
export default struct TypePicker {

  @Consume activeFileType: string

  build() {
    Column() { // 导航栏的列容器
      Text('所有') // 创建一个文本组件，内容为 '文本'
        .fontSize(16) // 设置字体大小
        .fontWeight(500) // 设置字体粗细
        .height(60)
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(this.activeFileType === '所有' ? Color.Gray : '#F2F2F2')
        .fontColor(this.activeFileType === '所有' ? Color.White :'#182431') // 设置文本颜色
        .borderRadius(15)
        .animation({
          duration: 100,
          curve: curves.springMotion(),
        })
        .onClick(() => { // 设置点击事件
          this.activeFileType = '所有';
          // fetchData();
          // fetchData2();
          // HttpTool.listenPort()
        })

      Text('文本') // 创建一个文本组件，内容为 '文本'
        .fontSize(16) // 设置字体大小
        .fontWeight(500) // 设置字体粗细
        .height(60)
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(this.activeFileType === 'txt' ? Color.Gray : '#F2F2F2')
        .fontColor(this.activeFileType === 'txt' ? Color.White :'#182431') // 设置文本颜色
        .borderRadius(15)
        .animation({
          duration: 100,
          curve: curves.springMotion(),
        })
        .onClick(() => { // 设置点击事件
          this.activeFileType = 'txt';
        })

      Text('图片') // 创建一个文本组件，内容为 '图片'
        .fontSize(16) // 设置字体大小
        .fontWeight(500) // 设置字体粗细
        .height(60)
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(this.activeFileType === 'png' ? Color.Gray : '#F2F2F2')
        .fontColor(this.activeFileType === 'png' ? Color.White :'#182431') // 设置文本颜色
        .borderRadius(15)
        .animation({
          duration: 100,
          curve: curves.springMotion(),
        })
        .onClick(() => { // 设置点击事件
          this.activeFileType = 'png';
        })

      Text('音频') // 创建一个文本组件，内容为 '音频'
        .fontSize(16) // 设置字体大小
        .fontWeight(500) // 设置字体粗细
        .height(60)
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(this.activeFileType === 'mp3' ? Color.Gray : '#F2F2F2')
        .fontColor(this.activeFileType === 'mp3' ? Color.White :'#182431') // 设置文本颜色
        .borderRadius(15)
        .animation({
          duration: 100,
          curve: curves.springMotion(),
        })
        .onClick(() => { // 设置点击事件
          this.activeFileType = 'mp3';
        })

      Text('视频') // 创建一个文本组件，内容为 '视频'
        .fontSize(16) // 设置字体大小
        .fontWeight(500) // 设置字体粗细
        .height(60)
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(this.activeFileType === 'mp4' ? Color.Gray : '#F2F2F2')
        .fontColor(this.activeFileType === 'mp4' ? Color.White :'#182431') // 设置文本颜色
        .borderRadius(15)
        .animation({
          duration: 100,
          curve: curves.springMotion(),
        })
        .onClick(() => { // 设置点击事件
          this.activeFileType = 'mp4';
        })

      Text('其他') // 创建一个文本组件，内容为 '其他'
        .fontSize(16) // 设置字体大小
        .fontWeight(500) // 设置字体粗细
        .height(60)
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(this.activeFileType === 'zip' ? Color.Gray : '#F2F2F2')
        .fontColor(this.activeFileType === 'zip' ? Color.White :'#182431') // 设置文本颜色
        .borderRadius(15)
        .animation({
          duration: 100,
          curve: curves.springMotion(),
        })
        .onClick(() => { // 设置点击事件
          this.activeFileType = 'zip';
        })
    }
    .width('20%') // 设置导航栏列容器的宽度为20%（可以根据需要调整）
    .justifyContent(FlexAlign.SpaceBetween) // 设置子组件的对齐方式为开始对齐
    .backgroundColor('#F2F2F2')
    .height(360)
    .borderRadius(15)
  }
}