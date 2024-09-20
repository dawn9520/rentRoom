import type { INavItem, INavList } from '../../models/HomeData'
import { rvp } from '../../utils/responsive'

@Component
export default struct NavList {
  @Link navList: INavList

  build() {
    Grid() {
      ForEach(this.navList, (nav: INavItem) => {
        GridItem() {
          Column({ space: rvp(8) }) {
            Image(nav.imageURL).width('100%').height(rvp(56)).objectFit(ImageFit.Fill)
            Text(nav.title).fontSize(rvp(12))
          }
        }.width(rvp(58))
      }, (nav: INavItem) => nav.id + '')
    }
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .rowsTemplate('1fr 1fr')
    .rowsGap(rvp(14))
    .columnsGap(rvp(33))
    .height(rvp(170))
    .margin({
      top: rvp(24)
    })
  }
}