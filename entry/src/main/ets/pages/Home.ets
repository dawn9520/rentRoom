import SwiperLayout from '../views/Home/SwiperLayout';
import SearchBar from '../views/Home/SearchBar';
import NavList from '../views/Home/NavList';
import TileList from '../views/Home/TileList';
import PlanList from '../views/Home/PlanList';
import Ad from '../views/Home/Ad';

import { getHomeDataApi } from '../api/home';
import { BannerListDataSource, INavList, ITileList, IPlanList } from '../models/HomeData';
import { PADDING } from '../constants/size'

@Component
export default struct Home {
  // 首页数据
  @State bannerList: BannerListDataSource = new BannerListDataSource()
  @State navList: INavList = [];
  @State tileList: ITileList = [];
  @State planList: IPlanList = [];
  @State adPicture: string = '';

  // 获取首页数据函数
  getHomeData = async () => {
    const homeData = await getHomeDataApi()
    this.bannerList.setList(homeData.bannerList);
    this.navList = homeData.navList;
    this.tileList = homeData.tileList;
    this.planList = homeData.planList;
    this.adPicture = homeData.adPicture;
  }

  // 生命周期函数：初始化渲染时触发
  aboutToAppear(): void {
    this.getHomeData()
  }

  build() {
    Stack() {
      Scroll() { // 滚动组件 暂时不知道为啥要在这里使用这个组件？
        Column() {
          SwiperLayout({ bannerList: this.bannerList })
          Column() {
            NavList({ navList: this.navList })
            TileList({ tileList: this.tileList })
            PlanList({ planList: this.planList })
            Ad({ adPicture: this.adPicture })
          }.padding({ left: PADDING, right: PADDING })
        }
        .justifyContent(FlexAlign.Start)
      }
      .height('100%')
      .align(Alignment.TopStart)

      SearchBar()
    }
    .height('100%')
    .alignContent(Alignment.Top)
  }
}