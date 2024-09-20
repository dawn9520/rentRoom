import { IColor } from '../models/HomeData';

@Component
export default struct ScrollContainer {
  @BuilderParam contentBuilder: () => void = this.defaultBuilder
  @BuilderParam navBuilder: ($$: IColor) => void = this.defaultBuilder
  scrollY: number = 0;
  @State bgColor: string = 'rgba(255, 255, 255, 0)'
  @State fontColor: string = 'rgb(255, 255, 255)'

  @Builder
  defaultBuilder() {
  }

  // 处理滚动
  handleScroll = (scrollX: number, scrollY: number) => {
    // 更新并修正 scrollY 的值
    this.scrollY += scrollY;
    if (this.scrollY < 0) {
      this.scrollY = 0
    }
    this.calcColor();
  }
  // 计算颜色
  calcColor = () => {
    if (this.scrollY > 10) {
      this.bgColor = 'rgba(255, 255, 255, 1)'
      this.fontColor = 'rgb(0, 0, 0)'
    } else {
      this.bgColor = 'rgba(255, 255, 255, 0)'
      this.fontColor = 'rgb(255, 255, 255)'
    }
  }

  build() {
    Stack() {
      Scroll() { // 滚动组件
        Column() {
          // 渲染内容
          this.contentBuilder()
        }.align(Alignment.TopStart)
      }
      .height('100%')
      .scrollBar(BarState.Off) // 设置滚动条不显示 Off不显示 On常驻显示 Auto按需显示(触摸时显示，2s后消失)
      .align(Alignment.TopStart)
      .backgroundColor($r('app.color.bg_gray_second'))
      .padding({ bottom: 10 })
      .onDidScroll(this.handleScroll)

      Column() {
        // 渲染头部导航
        this.navBuilder({ fontColor: this.fontColor, bgColor: this.bgColor })
      }.backgroundColor(this.bgColor)

    }.height('100%').alignContent(Alignment.TopStart)
  }
}