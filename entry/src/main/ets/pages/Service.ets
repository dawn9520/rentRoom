import { getServiceDataApi } from '../api/service';
import { IColor } from '../models/HomeData';
import { IVipServiceList, IHomeServiceList } from '../models/ServiceData';
import { getWindowTopHeight, rvp } from '../utils/responsive';
import { PADDING } from '../constants/size';

import Bg from '../views/Service/Bg';
import ScrollContainer from '../components/ScrollContainer';
import NavBar from '../views/Service/NavBar';
import VIP from '../views/Service/VIP';
import DomesticService from '../views/Service/DomesticService'

@Component
export default struct Service {
  @State vipServiceList: IVipServiceList = [];
  @State homeServiceList: IHomeServiceList = [];

  aboutToAppear() {
    this.getServiceData()
  }

  async getServiceData() {
    const serviceData = await getServiceDataApi();
    this.vipServiceList = serviceData.vipServiceList;
    this.homeServiceList = serviceData.homeServiceList;
  }

  @Builder
  navBuilder($$: IColor) {
    NavBar($$) // $$语法：内置组件双向同步
  }

  @Builder
  contentBuilder() {
    Stack() {
      Bg()
      Column() {
        VIP({ vipServiceList: this.vipServiceList })
        DomesticService({ homeServiceList: this.homeServiceList })
      }.padding({ left: rvp(PADDING), right: rvp(PADDING), top: getWindowTopHeight() })
    }.alignContent(Alignment.TopStart)
  }

  build() {
    ScrollContainer({
      navBuilder: this.navBuilder,
      contentBuilder: () => {
        this.contentBuilder()
      }
    })
  }
}