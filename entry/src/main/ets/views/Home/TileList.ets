import type { ITileItem, ITileList } from '../../models/HomeData';
import { BORDER_RADIUS } from '../../constants/size';
import { rvp } from '../../utils/responsive'

@Component
export default struct TileList {
  @Prop tileList: ITileList;

  build() {
    Row() {
      ForEach(this.tileList, (tile: ITileItem) => {
        Column({ space: rvp(8) }) {
          Image(tile.imageURL).width('100%').height(rvp(57)).borderRadius(BORDER_RADIUS)
          Row({ space: rvp(5) }) {
            Text(tile.title).fontSize(rvp(12))
            Text(tile.sub_title).fontSize(rvp(10)).fontColor($r('app.color.gray'))
          }.justifyContent(FlexAlign.Start).width('100%')
        }.width(rvp(148))
      }, (tile: ITileItem) => tile.id + '')
    }.width('100%').height(rvp(79)).margin({ top: rvp(10) }).justifyContent(FlexAlign.SpaceBetween)
  }
}