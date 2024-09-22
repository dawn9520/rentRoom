import Card from '../../components/Card'
import type { IBenefits, IBenefitsItem } from '../../models/DiscoverData'

import { rvp } from '../../utils/responsive'

@Component
export default struct Welfare {
  @Prop benefits: IBenefits

  build() {
    Column({ space: rvp(10) }) {
      ForEach(this.benefits, (item: IBenefitsItem) => {
        Card({ cardPadding: rvp(12) }) {
          Text("小谷粒福利")
            .width(rvp(80))
            .height(rvp(24))
            .borderRadius(rvp(23))
            .backgroundColor('#CDFFD9')
            .fontSize(rvp(12))
            .fontColor('#1F632F')
            .textAlign(TextAlign.Center)
          Text(item.title)
            .fontSize(26)
            .fontColor('#FF000000')
            .fontWeight(700)
            .margin({ top: rvp(18), left: rvp(4) })
          Image(item.img)
            .width('100%')
            .height(rvp(143))
            .objectFit(ImageFit.Fill)
            .margin({ top: rvp(9), left: rvp(4), bottom: rvp(6) })
        }
      })
    }.margin({ top: rvp(10) })
  }
}