import router from '@ohos.router';
import { rvp } from '../../utils/responsive';

@Component
export default struct Book {
  @Link show: boolean
  @StorageProp('token') token: string = '';

  build() {
    Row() {
      Column({ space: rvp(4) }) {
        Image($r('app.media.my_icon_1')).width(rvp(18))
        Text('99+').fontSize(rvp(10)).fontColor($r('app.color.gray'))
      }

      Column({ space: rvp(4) }) {
        Image($r('app.media.message')).width(rvp(18)).fillColor($r('app.color.black'))
        Text('咨询').fontSize(rvp(10)).fontColor($r('app.color.gray'))
      }

      Button('立即预定', { type: ButtonType.Normal })
        .borderRadius(rvp(2))
        .backgroundColor('#24A17B')
        .padding({ left: rvp(30), right: rvp(30) })
        .height(rvp(34))
        .onClick(() => {
          if (!this.token) {
            router.pushUrl({ url: 'pages/Login/LoginPhone' })
            return
          }
          this.show = true
        })
      Button('去看房', { type: ButtonType.Normal })
        .borderRadius(rvp(2))
        .backgroundColor('#6BE3BE')
        .padding({ left: rvp(30), right: rvp(30) })
        .height(rvp(34))
    }.backgroundColor($r('app.color.white')).height(rvp(50)).justifyContent(FlexAlign.SpaceEvenly).width('100%')
  }
}