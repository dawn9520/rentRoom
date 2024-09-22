import { rvp } from '../../utils/responsive';

import type { IDanMuItem, IDanMuList } from '../../models/DiscoverData';

@Component
export default struct BannerScroll {
  @Prop bannerList: IDanMuList;

  build() {
    List() {
      ForEach(this.bannerList, (banner: IDanMuItem) => {
        ListItem() {
          Row({ space: rvp(6) }) {
            Image(banner.avatar).width(rvp(24)).height(rvp(24)).objectFit(ImageFit.Fill).borderRadius(rvp(24))
            Text(banner.content).fontSize(rvp(14))
          }
          .padding({
            top: rvp(6),
            left: rvp(6),
            bottom: rvp(6),
            right: rvp(10)
          })
          .borderRadius(rvp(42))
          .backgroundColor('#CDFFD9')
          .margin({ left: rvp(10) })
        }
      }, (banner: IDanMuItem, index) => JSON.stringify(banner) + index)
    }
    .listDirection(Axis.Horizontal) // 排列方向
    .edgeEffect(EdgeEffect.None) // 滑动到边缘无效果
    .width('100%')
    .scrollBar(BarState.Off)
  }
}