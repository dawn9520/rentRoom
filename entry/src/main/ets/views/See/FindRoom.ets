import { BORDER_RADIUS_S, SHADOW_RADIUS } from '../../constants/size'
import { rvp } from '../../utils/responsive'

@Component
export default struct FindRoom {
  build() {
    Column() {
      Image($r('app.media.find_room')).width(rvp(58)).height(rvp(23))
      Text('发现你想看的房子').fontSize(rvp(14)).margin({ top: rvp(20) })
      Column({ space: rvp(10) }) {
        Image($r('app.media.blank')).width(rvp(234)).height(rvp(221)).objectFit(ImageFit.Fill)
        Text('暂无想看房源，试试如下找房方式').fontSize(rvp(18))
      }.margin({ top: rvp(6) }).width('100%')

      Row() {
        Row({ space: rvp(5) }) {
          Image($r('app.media.bus')).width(rvp(34)).height(rvp(34)).objectFit(ImageFit.Fill)
          Column({ space: rvp(5) }) {
            Text('通勤找房').fontSize(rvp(16))
            Text('按公司通勤时长找房').fontSize(rvp(12)).fontColor($r('app.color.gray'))
          }.alignItems(HorizontalAlign.Start)
        }

        Row({ space: rvp(5) }) {
          Image($r('app.media.map')).width(rvp(34)).height(rvp(34)).objectFit(ImageFit.Fill)
          Column({ space: rvp(5) }) {
            Text('地图找房').fontSize(rvp(16))
            Text('在你想住的地方找房').fontSize(rvp(12)).fontColor($r('app.color.gray'))
          }.alignItems(HorizontalAlign.Start)
        }
      }
      .width('100%')
      .margin({ top: rvp(20) })
      .padding(rvp(24))
      .justifyContent(FlexAlign.SpaceBetween)
      .borderRadius(BORDER_RADIUS_S)
      .shadow({
        radius: SHADOW_RADIUS,
        color: $r('app.color.shadow'),
        offsetX: 0,
        offsetY: 0
      })
    }.margin({ top: rvp(49) }).alignItems(HorizontalAlign.Start).width('100%')
  }
}