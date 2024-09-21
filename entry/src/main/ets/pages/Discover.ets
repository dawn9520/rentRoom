import { getDiscoverDataApi } from '../api/discover'
import ScrollContainer from '../components/ScrollContainer'

@Component
export default struct Discover {
  aboutToAppear(): void {
    this.getDiscoverData()
  }

  async getDiscoverData() {
    const discoverData = await getDiscoverDataApi()
  }

  @Builder
  navBuilder() {
    Text('navBar')
  }

  @Builder
  contentBuilder() {
    Text('content')
  }

  build() {
    ScrollContainer({
      contentBuilder: this.contentBuilder,
      navBuilder: this.navBuilder,
    })
  }
}