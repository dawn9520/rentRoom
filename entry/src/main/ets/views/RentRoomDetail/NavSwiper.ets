import { rvp } from '../../utils/responsive'
import type { IRoomName } from '../../models/RentRoomData'


@Component
export default struct NavSwiper {
  @Prop roomNameList: IRoomName[] | undefined // 房间区域名列表
  @Prop roomPictureList: string[] | undefined // 区域名图片列表
  @State currentTabIndex: number = 0
  @State isScr0ll: boolean = false // 是否在点击顶部tab后的滚动状态
  scrollerForRoomPicture: Scroller = new Scroller()

  setCurrentTabIndex(index: number) {
    if (this.isScr0ll) {
      return;
    } // 滚动时不可再次点击，防抖

    this.currentTabIndex = index;
    // 跳转图片的下标为前面下标图片的总和数
    const total = this.roomNameList?.reduce((p: number, c, i) => i < index ? p + c.total : p, 0)
    this.scrollerForRoomPicture.scrollToIndex(total, true) // 第二个参数作用：是否动画过度

    this.isScr0ll = true

    setTimeout(() => {
      this.isScr0ll = false
    }, 700)
  }

  @Builder
  NavBar() {
    List({ space: rvp(16) }) {
      ListItem() // 站位
      ForEach(this.roomNameList, (pic: IRoomName, index: number) => {
        ListItem() {
          Column({ space: rvp(4) }) {
            Text(pic.spaceName + `(${pic.total})`)
              .fontSize(rvp(14))
              .fontColor(this.currentTabIndex === index ? $r('app.color.black') : $r('app.color.gray_second'))
            if (this.currentTabIndex === index) {
              Divider().width(rvp(16)).height(rvp(2)).color($r('app.color.primary'))
            }
          }
        }.onClick(this.setCurrentTabIndex.bind(this, index))
      }, (pic: IRoomName) => pic.spaceName)
      ListItem() // 站位
    }
    .listDirection(Axis.Horizontal)
    .width('100%')
    .scrollBar(BarState.Off) // 关闭滚动条
    .edgeEffect(EdgeEffect.None) // 关闭回弹效果
  }

  @Builder
  PicList() {
    List({ scroller: this.scrollerForRoomPicture }) {
      ForEach(this.roomPictureList, (rentRoomPic: string) => {
        ListItem() {
          Image(rentRoomPic).width(rvp(318)).height(rvp(192))
        }.margin({ left: rvp(16) })
      })
      ListItem() {
      }.width(rvp(16))
    }
    .width('100%')
    .listDirection(Axis.Horizontal)
    .scrollBar(BarState.Off) // 关闭滚动条
    .edgeEffect(EdgeEffect.None) // 关闭回弹效果
    .onScrollIndex((start: number, end: number) => { // 图片滑动时会给到当前图片的下标
      if (this.isScr0ll) {
        return;
      }
      this.currentTabIndex = this.roomNameList?.findIndex((item) => {
        if (start < item.total) {
          return true
        } else {
          start -= item.total
          return false
        }
      }) || 0
    })
  }

  build() {
    Column({ space: rvp(16) }) {
      this.NavBar()
      this.PicList()
    }.margin({ top: rvp(44 + 16) }).width('100%')
  }
}