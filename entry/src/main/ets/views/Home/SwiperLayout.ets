import type { IBannerItem } from '../../model/HomeData'

@Component
export default struct SwiperLayout {
  @Prop bannerList: IBannerItem[]

  build() {
    Swiper() {
      ForEach(this.bannerList, (banner: IBannerItem) => {
        Image(banner.imageURL).width('100%').height(175)
      }, (item: IBannerItem) => item.id + '')
    }
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