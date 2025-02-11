@Component
struct Divid {

  build() {
    Divider() // 创建一个分割线组件
      .width('90%') // 设置分割线的宽度为 100%
      .strokeWidth(1) // 设置分割线的粗细为 1
      .color('#33182431') // 设置分割线的颜色
  }
}

export default Divid;