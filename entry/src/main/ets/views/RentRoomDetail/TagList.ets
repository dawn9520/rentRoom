import { rvp } from '../../utils/responsive';
import { ITagItem } from '../../models/RoomRecommendDataSource';

@Component
export default struct TagList {
  @Link tagList: ITagItem[]

  build() {
    Row({ space: rvp(14) }) {
      ForEach(this.tagList.slice(0, 4), (item: ITagItem) => {
        Text(item.name)
          .fontSize(rvp(10))
          .backgroundColor('#F8F9FC')
          .padding({
            top: rvp(4),
            bottom: rvp(4),
            left: rvp(8),
            right: rvp(8)
          })
      }, (item: ITagItem) => item.name)
    }.width('100%').margin({ top: rvp(8) })
  }
}