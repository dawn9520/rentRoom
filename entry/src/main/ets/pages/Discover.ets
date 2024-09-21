import { getDiscoverDataApi } from '../api/discover'

@Component
export default struct Discover {
  aboutToAppear(): void {
    this.getDiscoverData()
  }

  async getDiscoverData() {
    const discoverData = await getDiscoverDataApi()
    console.info('----discoverData', JSON.stringify(discoverData))
  }

  build() {
    Column() {
      Text("Discover");
    }
  }
}