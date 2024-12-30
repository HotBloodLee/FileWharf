import { MainContent } from '../entity/MainContent';
import { curves } from '@kit.ArkUI';

import HttpTool from '../network/http/http';

interface Person {
  name: string;
  age: number;
  city: string;
}
let data = {"name": "Johsn", "age": 30, "city": "ChongQing"} as Person;

async function fetchData() {
  try {
    let rs: Promise<string> = HttpTool.sendPOST(JSON.stringify(data));
    let result: string = await rs;
    console.info('Result 2: ' + result);
  } catch (error) {
    console.error('Error:', error);
  }
}

async function fetchData2() {
  try {
    let rs: Promise<string> = HttpTool.sendGET("test111");
    let result: string = await rs;
    console.info('Result 2: ' + result);
  } catch (error) {
    console.error('Error:', error);
  }
}

@Component
struct FileIndex {

  @Link activeFileType: string; // 初始状态为 'all'
  @Link activeDevice: string; // 初始状态为 'all'
  @Link activeDeviceIdx: number;
  @Link deviceList: Array<SelectOption>;


  @Link mainContentArr: MainContent[];

  build() {

    Column() {
      Row() { // 创建一个行容器
        Text('当前查看设备:')
          .width('40%')
          .fontSize(15)
          .textAlign(TextAlign.Start)
        Select(this.deviceList)
          .selected(this.activeDeviceIdx)
          .value(this.activeDevice)
          .onSelect((index: number, value: string) => {
            this.activeDeviceIdx = index
            this.activeDevice = value
          })
          .width('60%')
          .animation({
            curve: curves.springMotion(),
            duration: 100,
          })
      }
      .width('80%')
      .height('5%')
      .margin({top: 5})

      Row() { // 创建一个行容器，用于水平布局
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
              fetchData();
              fetchData2();
              HttpTool.listenPort()
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
        // .transition(0.3)


        List({ space: 12, initialIndex: 0 }) { // 列表组件
          ForEach(this.mainContentArr, (item: MainContent) => { // 遍历 mainContentArr 数组
            if ((item.device === this.activeDevice || this.activeDevice === '所有') && (item.fileType === this.activeFileType || this.activeFileType === '所有')){
              ListItem() { // 创建一个列表项组件
                Column() { // 列表项的列容器
                  Row() {
                    Text(item.title) // 创建一个文本组件，内容为列表项标题
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

                  if (item.fileType === 'png' || item.fileType === 'mp4' || item.fileType === 'mp3') {
                    Image($r(item.image)) // 创建一个图片组件，并加载列表项的图片资源
                      .width(200) // 设置图片的宽度为 100%
                      .height(200) // 设置图片的高度为 176
                      .objectFit(ImageFit.Auto) // 设置图片填充方式为填充
                  }

                  Text('来自设备: ' + item.device) // 创建一个文本组件，内容为列表项描述
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

          }, (item: MainContent) => JSON.stringify(item)) // 对每个列表项进行唯一性校验
        }
        .listDirection(Axis.Vertical) // 设置列表的滚动方向为垂直
        .scrollBar(BarState.On) // 隐藏滚动条
        .friction(0.6) // 设置滚动摩擦系数
        .width('100%') // 设置列表容器的宽度为80%（可以根据需要调整，与导航栏宽度之和应为100%）
        .height('100%') // 设置列表容器的高度为100%
        .padding({top: 16, bottom: 16})
        .edgeEffect(EdgeEffect.Spring) // 设置滚动到边缘时的效果为弹簧效果

      }
      .width('100%') // 设置行容器的宽度为100%
      .height('95%') // 设置行容器的高度为100%
    }
    .height('85%')
    .width('100%')
  }
}

export default FileIndex;