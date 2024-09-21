import { getServiceDataApi } from '../api/service';
import { IColor } from '../models/HomeData';

import Bg from '../views/Service/Bg';
import ScrollContainer from '../components/ScrollContainer';
import NavBar from '../views/Service/NavBar';

@Component
export default struct Service {
  aboutToAppear(): void {
    this.getServiceData()
  }

  async getServiceData() {
    const serviceData = await getServiceDataApi();
  }

  @Builder
  navBuilder($$: IColor) {
    NavBar($$)
  }

  @Builder
  contentBuilder() {
    Bg()
  }

  build() {
    ScrollContainer({
      navBuilder: this.navBuilder,
      contentBuilder: this.contentBuilder
    })
  }
}