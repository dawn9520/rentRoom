import type { INavItem, INavList } from '../../models/HomeData'

@Component
export default struct NavList {
  @Link navList: INavList

  build() {
    Grid() {
      ForEach(this.navList, (nav: INavItem) => {
        GridItem() {
          Column({ space: 8 }) {
            Image(nav.imageURL).width('100%').height(56).objectFit(ImageFit.Fill)
            Text(nav.title).fontSize(12)
          }
        }.width(58)
      }, (nav: INavItem) => nav.id + '')
    }
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .rowsTemplate('1fr 1fr')
    .rowsGap(14)
    .columnsGap(33)
    .height(170)
    .margin({
      top: 24
    })
  }
}