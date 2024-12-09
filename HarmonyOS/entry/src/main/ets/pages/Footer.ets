@Component
struct Footer {

  @Link activePage: string;

  build() {
    Row() { // 创建一个行容器
      Image($r('app.media.wenjian')) // 创建一个图片组件，并加载资源 'app.media.wenjian'
        .width(32) // 设置图片的宽度为 32
        .height('100%') // 设置图片的高度为 32
        .margin({ top: '7%' }) // 设置图片的外边距
        .onClick(() => { // 设置图片的点击事件
          this.activePage = 'fileIndex';
        })
      Image($r('app.media.shebeiguanli')) // 创建一个图片组件，并加载资源 'app.media.wenjian'
        .width(32) // 设置图片的宽度为 32
        .height('100%') // 设置图片的高度为 32
        .margin({ top: '7%' }) // 设置图片的外边距
        .onClick(() => { // 设置图片的点击事件
          this.activePage = 'deviceIndex';
        })
      Image($r('app.media.wode')) // 创建一个图片组件，并加载资源 'app.media.wenjian'
        .width(32) // 设置图片的宽度为 32
        .height('100%') // 设置图片的高度为 32
        .margin({ top: '7%' }) // 设置图片的外边距
        .onClick(() => { // 设置图片的点击事件
          this.activePage = 'homeIndex';
        })
    }
    .width('100%') // 设置行容器的宽度为 100%
    .height('5%') // 设置行容器的高度为 48
    .justifyContent(FlexAlign.SpaceAround) // 设置子组件的对齐方式为开始对齐
  }
}

export default Footer;