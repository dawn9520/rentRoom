import { rvp } from '../../utils/responsive'

import type { IDiscountsItem } from '../../models/RentRoomData'

@Component
export default struct DiscountsList {
  @Link discountsList: IDiscountsItem[]

  build() {
    Column({ space: rvp(16) }) {
      ForEach(this.discountsList, (item: IDiscountsItem) => {
        Row({ space: 8 }) {
          Image(item.image).height(rvp(20))
          Text(item.txt).fontSize(rvp(12)).fontColor($r('app.color.gray'))
          Blank()
          Image($r('app.media.arrow_right')).width(rvp(4)).fillColor($r('app.color.primary'))
        }.width('100%')
      }, (item: IDiscountsItem) => item.txt)
    }.margin({ top: rvp(13) })
  }
}