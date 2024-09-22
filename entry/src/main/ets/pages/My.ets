import { IColor } from '../models/HomeData'

import ScrollContainer from '../components/ScrollContainer'
import Bg from '../views/My/Bg'
import NavBar from '../views/My/NavBar'

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
    }.width('100%')
  }

  build() {
    ScrollContainer({
      contentBuilder: this.contentBuilder,
      navBuilder: this.navBuilder,
    })
  }
}