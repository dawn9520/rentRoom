import { getWindowTopHeight, rvp } from '../../utils/responsive'

@Component
export default struct Bg {
  build() {
    Column() {
    }.width('100%').height(rvp(211 - 36) + getWindowTopHeight()).linearGradient({
      angle: 180,
      colors: [
        ['#6DC782', 0],
        ['#8FE1A2', 0.43],
        ['#8FE1A2', 1],
      ]
    })
  }
}