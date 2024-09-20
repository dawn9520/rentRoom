import SwiperLayout from '../views/Home/SwiperLayout';
import SearchBar from '../views/Home/SearchBar';
import NavList from '../views/Home/NavList';
import TileList from '../views/Home/TileList';
import PlanList from '../views/Home/PlanList';
import Ad from '../views/Home/Ad';
import RoomRecommend from '../views/Home/RoomRecommend';
import ScrollContainer from '../components/ScrollContainer';

import { getHomeDataApi } from '../api/home';
import { BannerListDataSource, INavList, ITileList, IPlanList, IColor } from '../models/HomeData';
import { PADDING } from '../constants/size'

@Component
export default struct Home {
  // 首页数据
  @State bannerList: BannerListDataSource = new BannerListDataSource()
  @State navList: INavList = [];
  @State tileList: ITileList = [];
  @State planList: IPlanList = [];
  @State adPicture: string = '';
  scrollY: number = 0; // 存储滚动距离
  @State bgColor: string = 'rgba(255, 255, 255, 0)'
  @State fontColor: string = 'rgb(255, 255, 255)'

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

  @Builder
  contentBuilder() {
    SwiperLayout({ bannerList: this.bannerList })
    Column() {
      NavList({ navList: this.navList })
      TileList({ tileList: this.tileList })
      PlanList({ planList: this.planList })
      Ad({ adPicture: this.adPicture })
    }.padding({ left: PADDING, right: PADDING })

    RoomRecommend()
  }

  @Builder
  navBuilder($$: IColor) {
    SearchBar({ bgColor: $$.bgColor, fontColor: $$.fontColor });
  }


  build() {
    ScrollContainer({
      contentBuilder: () => { // 这里用箭头函数包裹是因为contentBuilder中需要使用this
        this.contentBuilder()
      },
      navBuilder: this.navBuilder
    })
  }
}