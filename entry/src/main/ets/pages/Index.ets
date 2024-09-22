import Home from './Home';
import See from './See';
import Service from './Service';
import Discover from './Discover';
import My from './My';
import { getWindowBottomHeight, rvp } from '../utils/responsive';
import type { IColors } from '../models/ColorsData'
import { setWindowStatusColor } from '../utils/method';

@Entry
@Component
struct Index {
  @StorageLink('navBarBgColor') navBarFontColor: string = ''
  @StorageLink('navBarFontColor') navBarBgColor: string = ''

  // 当前 tab 高亮的下标
  @State currentIndex: number = 3;
  colors: IColors = []

  // 生成 tab 的函数
  @Builder TabBuilder(index: number, text: string, icon: Resource, activeIcon: Resource) {
    Column() {
      // 项目中常用的颜色、大小等会定义成常量，将来方便复用和统一调整。而不常用的大小颜色就不需要定义了，直接写死即可。
      Image(this.currentIndex === index ? activeIcon : icon).width(rvp(28))
      Text(text).fontSize(rvp(10)).fontColor(this.currentIndex === index ? $r('app.color.black') : '#a0a0a0').height(rvp(15))
    }.width('100%').height('100%').justifyContent(FlexAlign.Center)
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End, index: this.currentIndex }) {
        TabContent() {
          Home()
        }.tabBar(this.TabBuilder(0, '首页', $r('app.media.tabbar_home'), $r('app.media.tabbar_home_active')))

        TabContent() {
          See()
        }.tabBar(this.TabBuilder(1, '想看', $r('app.media.tabbar_see'), $r('app.media.tabbar_see_active')))

        TabContent() {
          Service()
        }.tabBar(this.TabBuilder(2, '服务', $r('app.media.tabbar_service'), $r('app.media.tabbar_service_active')))

        TabContent() {
          Discover()
        }.tabBar(this.TabBuilder(3, '发现', $r('app.media.tabbar_discover'), $r('app.media.tabbar_discover_active')))

        TabContent() {
          My()
        }.tabBar(this.TabBuilder(4, '我的', $r('app.media.tabbar_my'), $r('app.media.tabbar_my_active')))
      }
      .vertical(false) // 设置tab位置在竖直方向
      .barMode(BarMode.Fixed) // 用于控制导航栏是否可以滚动，默认值为BarMode.Fixed
      .onChange((index: number) => {

        // 将上个页面color存储起来
        this.colors[this.currentIndex] = {
          navBarBgColor: this.navBarBgColor,
          navBarFontColor: this.navBarFontColor
        }
        // 将当前页面的color赋值上去
        this.navBarFontColor = this.colors[index]?.navBarFontColor || '#FFFFFF'
        this.navBarBgColor = this.colors[index]?.navBarBgColor || 'rgba(255, 255, 255, 0)'

        // 想看页面的状态栏颜色为特殊颜色，这里单独设置
        if (index == 1 || index == 3) {
          setWindowStatusColor('#636363')
        } else {
          setWindowStatusColor(this.navBarFontColor)
        }
        this.currentIndex = index
      })
      .barHeight(rvp(50) + getWindowBottomHeight()) // 设置 tab 导航栏的高度，默认 56, getWindowBottomHeight如果手机设备底部有距离，这里会进行添加
      .scrollable(false) // 禁止左右滑动切换
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.white'))
    }.height('100%')
  }
}