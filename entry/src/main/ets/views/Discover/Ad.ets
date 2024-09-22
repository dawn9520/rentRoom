import { BORDER_RADIUS } from '../../constants/size';
import type { IContentBlockItem, IPostZone } from '../../models/DiscoverData';
import { rvp } from '../../utils/responsive';
import Card from '../../components/Card';

@Component
export default struct Ad {
  @Prop postZone: IPostZone

  build() {
    Row({ space: rvp(14) }) {
      Column() {
        Card({ cardPadding: rvp(12) }) {
          Text(`${this.postZone.mainPost.followerNum}位小谷粒`)
            .fontSize(rvp(10))
            .fontColor($r('app.color.gray_second'))
            .margin({ top: rvp(4), left: rvp(4) })
          Text(this.postZone.mainPost.title).fontSize(rvp(26)).fontWeight(700).margin({ top: rvp(20), left: rvp(4) })
          Column({ space: rvp(10) }) {
            Row({ space: rvp(8) }) {
              Image(this.postZone.mainPost.userAvatar).width(rvp(28)).height(rvp(28)).objectFit(ImageFit.Fill)
              Text(this.postZone.mainPost.userName).fontSize(rvp(12)).fontColor('#636363')
            }

            Text(this.postZone.mainPost.postContent)
              .fontSize(rvp(12))
              .fontColor('#636363')
              .maxLines(4)
              .textOverflow({
                overflow: TextOverflow.Ellipsis
              })
          }
          .width('100%')
          .height(rvp(120))
          .padding(rvp(12))
          .backgroundColor('#F9F9F9')
          .borderRadius(rvp(BORDER_RADIUS))
          .alignItems(HorizontalAlign.Start)
          .margin({ top: rvp(7) })
        }
      }.width(rvp(192)).height('100%')

      Column({ space: rvp(9) }) {
        ForEach(this.postZone.contentBlockList, (item: IContentBlockItem) => {
          Image(item.img).width('100%').height(rvp(67)).objectFit(ImageFit.Fill)
        })
      }.width(rvp(122)).height('100%')
    }.width('100%').margin({ top: rvp(19) }).height(rvp(218))
  }
}