import { rvp } from '../../utils/responsive'
import { PADDING } from '../../constants/size'

@Component
export default struct NavBar {
  build() {
    Row() {
      Row({ space: rvp(6) }) {
        Image($r('app.media.bag')).width(rvp(16)).height(rvp(16))
        Text('填写通勤地址').fontSize(rvp(14))
      }

      Row({ space: rvp(28) }) {
        Column({ space: rvp(1) }) {
          Image($r('app.media.message')).width(rvp(20)).height(rvp(20)).fillColor($r('app.color.black'))
          Text('消息').fontSize(rvp(12))
        }

        Column({ space: rvp(1) }) {
          Image($r('app.media.journey')).width(rvp(20)).height(rvp(20)).fillColor($r('app.color.black'))
          Text('行程').fontSize(rvp(12))
        }
      }
    }
    .width('100%')
    .height(rvp(44))
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: rvp(PADDING), right: rvp(PADDING) })
  }
}