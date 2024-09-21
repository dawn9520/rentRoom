import { IVipServiceItem, IVipServiceList } from '../../models/ServiceData';
import { rvp } from '../../utils/responsive';

@Component
export default struct VIP {
  @Prop vipServiceList: IVipServiceList;

  getUnit(name: string): string {
    console.log(name)
    switch (name) {
      case '余额':
        return ' 元';
      case '优惠券':
        return ' 张';
      case '会员特权':
        return ' 项';
      case '会员福利':
        return ' 个';
      default:
        return '';
    }
  }

  build() {
    Stack() {
      Image($r('app.media.vip_bg')).width('100%').height('100%').objectFit(ImageFit.Fill)
      Column({ space: rvp(16) }) {
        Row({ space: rvp(5) }) {
          Image($r('app.media.crown')).width(rvp(18)).height(rvp(18))
          Text('开通谷粒卡享特权').fontSize(rvp(18)).fontColor($r('app.color.white'))
          Blank() // 开发者期望将父容器的剩余空间全部分配给某空白区域时，也可以通过Blank组件实现。注意仅当父组件为Row\Column\Flex组件时，Blank组件才会生效。
          Image($r('app.media.vip')).width(rvp(43)).height(rvp(19)).objectFit(ImageFit.Fill)
        }.width('100%').padding({ left: rvp(39), right: rvp(41) })

        Row() {
          ForEach(this.vipServiceList, (vip: IVipServiceItem) => {
            Column({ space: rvp(5) }) {
              Text(vip.name).fontColor($r('app.color.white')).fontSize(rvp(14))
              Text() {
                Span(vip.content + '').fontSize(rvp(18)).fontWeight(700).fontColor($r('app.color.white'))
                Span(this.getUnit(vip.name)).fontSize(rvp(12)).fontColor($r('app.color.white'))
              }
            }
          }, (vip: IVipServiceItem) => vip.name)
        }.padding({ left: rvp(35), right: rvp(41) }).justifyContent(FlexAlign.SpaceBetween).width('100%')
      }.padding({ top: rvp(12) }).height('100%')
    }.margin({ top: rvp(5 + 44) }).height(rvp(99))
  }
}