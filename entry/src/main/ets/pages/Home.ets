import SwiperLayout from '../views/Home/SwiperLayout';

import { getHomeDataApi } from '../api/home';
import type { IBannerList, INavList, IPlanList, ITileList } from '../model/HomeData';

@Component
export default struct Home {
  // 首页数据
  @State bannerList: IBannerList = [];
  @State navList: INavList = [];
  @State tileList: ITileList = [];
  @State planList: IPlanList = [];
  @State adPicture: string = '';

  // 组件生命周期
  aboutToAppear() {
    this.getHomeData()
  }

  async getHomeData() {
    const homeData = await getHomeDataApi()
    this.bannerList = homeData.bannerList;
    this.navList = homeData.navList;
    this.tileList = homeData.tileList;
    this.planList = homeData.planList;
    this.adPicture = homeData.adPicture;
  }

  build() {
    Column() {
      SwiperLayout({ bannerList: this.bannerList })
    }.height('100%')
  }
}