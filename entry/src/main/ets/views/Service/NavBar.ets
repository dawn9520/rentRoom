import { PADDING } from '../../constants/size'
import { rvp } from '../../utils/responsive'

@Component
export default struct NavBar {
  @Prop fontColor: string
  @Prop bgColor: string

  build() {
    Row() {
      Row({ space: rvp(5) }) {
        Text('请选择地址').fontSize(rvp(16)).fontColor(this.fontColor)
        Image($r('app.media.arrow_down')).width(rvp(6)).height(rvp(6)).fillColor(this.fontColor)
      }

      Row({ space: rvp(28) }) {
        Column({ space: rvp(1) }) {
          Image($r('app.media.message')).width(rvp(20)).height(rvp(20)).fillColor(this.fontColor)
          Text('消息').fontSize(rvp(12)).fontColor(this.fontColor)
        }

        Column({ space: rvp(1) }) {
          Image($r('app.media.customer')).width(rvp(20)).height(rvp(20)).fillColor(this.fontColor)
          Text('行程').fontSize(rvp(12)).fontColor(this.fontColor)
        }
      }
    }
    .width('100%')
    .height(rvp(44))
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: rvp(PADDING), right: rvp(PADDING) })
    .backgroundColor(this.bgColor)
  }
}