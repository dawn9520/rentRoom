import { getDiscoverDataApi } from '../api/discover'
import { IColor } from '../models/HomeData'

import ScrollContainer from '../components/ScrollContainer'
import NavBar from '../views/Discover/NavBar'

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
    Text('content').width('100%')
  }

  build() {
    ScrollContainer({
      contentBuilder: this.contentBuilder,
      navBuilder: this.navBuilder,
    })
  }
}