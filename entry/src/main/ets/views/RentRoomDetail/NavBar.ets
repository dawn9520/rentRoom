import router from '@ohos.router'
import { PADDING } from '../../constants/size'
import { rvp } from '../../utils/responsive'

@Component
export default struct NavBar {
  @StorageProp('navBarBgColor') navBarBgColor: string = ''
  @StorageProp('navBarFontColor') navBarFontColor: string = ''
  @Prop title: string

  build() {
    Row() {
      Row({ space: rvp(8) }) {
        Image($r('app.media.back')).width(rvp(24)).onClick(() => {
          router.back()
        })
        Text(this.title).fontSize(rvp(12))
      }

      Image($r('app.media.share')).width(rvp(20)).height(rvp(20)).fillColor($r('app.color.black'))
    }
    .width('100%')
    .height(rvp(44))
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: rvp(PADDING), right: rvp(PADDING) })
    .backgroundColor($r('app.color.white'))
  }
}