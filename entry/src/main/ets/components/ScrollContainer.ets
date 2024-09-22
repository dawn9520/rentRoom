import { IColor } from '../models/HomeData';
import { getWindowTopHeight, rvp } from '../utils/responsive';
import { setWindowStatusColor } from '../utils/method';

@Component
export default struct ScrollContainer {
  @Prop noDiscoloration?: boolean
  @BuilderParam contentBuilder: () => void = this.defaultBuilder
  @BuilderParam navBuilder: ($$: IColor) => void = this.defaultBuilder
  scrollY: number = 0;

  // 这里使用StorageLink，和indexa中的颜色双向绑定，使得tab切换时状态栏颜色和页面需要的颜色对应
  @StorageLink('navBarFontColor') bgColor: string = 'rgba(255, 255, 255, 0)'
  @StorageLink('navBarBgColor') fontColor: string = '#FFFFFF'

  aboutToAppear(): void {
    setWindowStatusColor(this.fontColor)
  }

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
    setWindowStatusColor(this.fontColor);
  }
  // 计算颜色
  calcColor = () => {
    if (this.scrollY > 10) {
      this.bgColor = 'rgba(255, 255, 255, 1)'
      this.fontColor = this.noDiscoloration ? '#636363' : '#000000'
    } else {
      this.bgColor = 'rgba(255, 255, 255, 0)'
      this.fontColor = this.noDiscoloration ? '#636363' : '#FFFFFF'
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
      .padding({ bottom: rvp(10) })
      .onDidScroll(this.handleScroll)

      Column() {
        // 渲染头部导航
        this.navBuilder({ fontColor: this.fontColor, bgColor: this.bgColor })
      }
      .backgroundColor(this.bgColor)
      .padding({ top: getWindowTopHeight() }) // 设置顶部状态栏距离，避免搜索部分的内容被状态栏遮住

    }.height('100%').alignContent(Alignment.TopStart)
  }
}