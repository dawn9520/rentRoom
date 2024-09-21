import { getServiceDataApi } from '../api/service';

@Component
export default struct Service {

  aboutToAppear(): void {
    this.getServiceData()
  }

  async getServiceData() {
    const serviceData = await getServiceDataApi();
    console.info('----serviceData', JSON.stringify(serviceData))
  }

  build() {
    Column() {
      Text("Service");
    }
  }
}