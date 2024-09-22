import { PADDING } from '../../constants/size'
import { rvp } from '../../utils/responsive'

@Component
export default struct NavBar {
  @Prop bgColor: string = ''

  build() {
    Row() {
      Text('家庭服务').fontSize(rvp(18)).fontWeight(700).fontColor($r('app.color.black'))
      Image($r('app.media.userbac')).width(rvp(30)).height(rvp(30)).fillColor($r('app.color.black'))
    }
    .width('100%')
    .height(rvp(44))
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: rvp(PADDING), right: rvp(PADDING) })
    .backgroundColor(this.bgColor)
  }
}