import NavBar from '../../views/RentRoomDetail/NavBar'
import ScrollContainer from '../../components/ScrollContainer'

@Entry
@Component
export default struct RentRoomDetail {
  @Builder
  NavBarRender() {
    NavBar()
  }

  @Builder
  ContentRender() {
  }

  build() {
    Column() {
      ScrollContainer({
        navBuilder: this.NavBarRender.bind(this),
        contentBuilder: this.ContentRender.bind(this),
      })
    }.height('100%')
  }
}