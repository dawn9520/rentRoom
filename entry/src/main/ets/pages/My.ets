import { IColor } from '../models/HomeData'
import { getWindowTopHeight, rvp } from '../utils/responsive'
import { PADDING } from '../constants/size'


import ScrollContainer from '../components/ScrollContainer'
import Bg from '../views/My/Bg'
import NavBar from '../views/My/NavBar'
import UserInfo from '../views/My/UserInfo'
import TimePlan from '../views/My/TimePlan'

@Component
export default struct My {
  @Builder
  navBuilder($$: IColor) {
    NavBar($$)
  }

  @Builder
  contentBuilder() {
    Stack() {
      Bg()
      Column() {
        UserInfo()
        TimePlan()
      }.padding({ left: rvp(PADDING), right: rvp(PADDING), top: rvp(44) + getWindowTopHeight() })
    }.width('100%').align(Alignment.TopStart)
  }

  build() {
    ScrollContainer({
      contentBuilder: this.contentBuilder,
      navBuilder: this.navBuilder,
    })
  }
}