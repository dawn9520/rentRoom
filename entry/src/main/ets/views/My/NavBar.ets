import { PADDING } from '../../constants/size'
import { rvp } from '../../utils/responsive'

@Component
export default struct NavBar {
  @Prop bgColor: string
  @Prop fontColor: string

  build() {
    Row() {
      Row() {
        Image($r('app.media.switch')).width(rvp(16))
        Text('业主版').fontSize(rvp(12))
      }
      .borderRadius(rvp(31))
      .backgroundColor('rgba(255, 255, 255, 0.65)')
      .width(rvp(79))
      .height(rvp(26))
      .justifyContent(FlexAlign.Center)

      Row({ space: 16 }) {
        Image($r('app.media.customer')).width(rvp(20)).height(rvp(20)).fillColor(this.fontColor)
        Image($r('app.media.message')).width(rvp(20)).height(rvp(20)).fillColor(this.fontColor)
        Image($r('app.media.setting')).width(rvp(20)).height(rvp(20)).fillColor(this.fontColor)
      }
    }
    .width('100%')
    .height(rvp(44))
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: rvp(PADDING), right: rvp(PADDING) })
    .backgroundColor(this.bgColor)
  }
}