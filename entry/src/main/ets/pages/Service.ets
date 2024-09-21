import { getServiceDataApi } from '../api/service';
import { IColor } from '../models/HomeData';
import { IVipServiceList, IHomeServiceList, IServiceActivity, ICleaningServiceInfoList } from '../models/ServiceData';
import { getWindowTopHeight, rvp } from '../utils/responsive';
import { PADDING } from '../constants/size';

import Bg from '../views/Service/Bg';
import ScrollContainer from '../components/ScrollContainer';
import NavBar from '../views/Service/NavBar';
import VIP from '../views/Service/VIP';
import DomesticService from '../views/Service/DomesticService'
import ServiceCalendar from '../views/Service/ServiceCalendar';
import ServiceTabs from '../views/Service/ServiceTabs';

@Component
export default struct Service {
  @State vipServiceList: IVipServiceList = [];
  @State homeServiceList: IHomeServiceList = [];
  @State serviceActivity: IServiceActivity = { name: '', img: '', title: '', subTitle: '' };
  @State serviceTabImage: string = ''
  @State cleaningServiceInfo: ICleaningServiceInfoList = []

  aboutToAppear() {
    this.getServiceData()
  }

  async getServiceData() {
    const serviceData = await getServiceDataApi();
    this.vipServiceList = serviceData.vipServiceList;
    this.homeServiceList = serviceData.homeServiceList;
    this.serviceActivity = serviceData.serviceActivity;
    this.serviceTabImage = serviceData.newcomerZone.img;
    this.cleaningServiceInfo = serviceData.cleaningServiceInfo;
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
        ServiceCalendar({ serviceActivity: this.serviceActivity })
        ServiceTabs({ serviceTabImage: this.serviceTabImage, cleaningServiceInfo: this.cleaningServiceInfo })
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