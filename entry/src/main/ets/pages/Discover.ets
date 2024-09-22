import { getDiscoverDataApi } from '../api/discover'
import { IColor } from '../models/HomeData'

import ScrollContainer from '../components/ScrollContainer'
import NavBar from '../views/Discover/NavBar'
import Bg from '../views/Discover/Bg'

@Component
export default struct Discover {
  aboutToAppear(): void {
    this.getDiscoverData()
  }

  async getDiscoverData() {
    const discoverData = await getDiscoverDataApi()
  }

  @Builder
  navBuilder($$: IColor) {
    NavBar({ bgColor: $$.bgColor })
  }

  @Builder
  contentBuilder() {
    Stack() {
      Bg()
    }
  }

  build() {
    ScrollContainer({
      contentBuilder: this.contentBuilder,
      navBuilder: this.navBuilder,
    })
  }
}