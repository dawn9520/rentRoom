import { getWindowTopHeight, rvp } from '../../utils/responsive'

@Component
export default struct Bg {
  build() {
    Image($r('app.media.discover_bg'))
      .width('100%')
      .height(rvp(322 - 36) + getWindowTopHeight())
      .objectFit(ImageFit.Fill)
  }
}