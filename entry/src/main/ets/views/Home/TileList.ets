import type { ITileItem, ITileList } from '../../models/HomeData';
import { BORDER_RADIUS } from '../../constants/size';

@Component
export default struct TileList {
  @Prop tileList: ITileList;

  build() {
    Row() {
      ForEach(this.tileList, (tile: ITileItem) => {
        Column({ space: 8 }) {
          Image(tile.imageURL).width('100%').height(57).borderRadius(BORDER_RADIUS)
          Row({ space: 5 }) {
            Text(tile.title).fontSize(12)
            Text(tile.sub_title).fontSize(10).fontColor($r('app.color.gray'))
          }.justifyContent(FlexAlign.Start).width('100%')
        }.width(148)
      }, (tile: ITileItem) => tile.id + '')
    }.width('100%').height(79).margin({ top: 10 }).justifyContent(FlexAlign.SpaceBetween)
  }
}