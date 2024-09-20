import { BannerListDataSource, IBannerItem } from '../../models/HomeData';
import { getWindowTopHeight } from '../../utils/responsive';
import { rvp } from '../../utils/responsive'

@Component
export default struct SwiperLayout {
  // 这里使用@ObjectLink配合BannerListDataSource
  @ObjectLink bannerList: BannerListDataSource;
  @StorageProp('windowTopHeight') windowTopHeight: number = 0;

  build() {
    Swiper() {
      LazyForEach(this.bannerList, (banner: IBannerItem) => {
        Image(banner.imageURL).width('100%').height('100%').objectFit(ImageFit.Fill)
      }, (banner: IBannerItem) => banner.id + '')
    }
    .width('100%')
    .height(rvp(175) + getWindowTopHeight()) // 暂时减去状态栏高度
    .loop(true) // 设置循环:即最后一张图滑动后衔接第一张图
    // .autoPlay(true) // 设置自动轮播
    // .interval(1000) // 轮播时间
    .indicator(
      Indicator.dot()// 设置圆形导航点样式
        .color('#CCCBCB')
        .selectedColor($r('app.color.primary'))
    )
  }
}