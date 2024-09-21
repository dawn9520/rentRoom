import ScrollContainer from '../components//ScrollContainer'

import { PADDING } from '../constants/size'
import { rvp } from '../utils/responsive'

@Component
export default struct See {
  @Builder
  navBuilder() {
  }

  @Builder
  contentBuilder() {
    Column() {
    }.width('100%').height('100%').padding({ left: rvp(PADDING), right: rvp(PADDING) }).linearGradient({
      angle: 180, // 线性渐变的起始角度。0点方向顺时针旋转为正向角度 默认值：180
      direction: GradientDirection.Top,
      colors: [
        ['#DEFBE5', 0],
        ['#ffffff', 0.3],
        ['#ffffff', 1],
      ],
      repeating: false, // 是否重复
    })
  }

  build() {
    ScrollContainer({
      navBuilder: this.navBuilder,
      contentBuilder: this.contentBuilder
    })

  }
}