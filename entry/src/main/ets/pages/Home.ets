import SwiperLayout from '../views/Home/SwiperLayout'

@Component
export default struct Home {
  build() {
    Column() {
      SwiperLayout()
    }.height('100%')
  }
}