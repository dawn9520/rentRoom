import { getWindowTopHeight } from '../../utils/responsive'

import NavBar from '../../components/NavBar'
import SearchFilter from '../../views/RentRoomList/SearchFilter'
import WaterfallFlow from '../../views/RentRoomList/WaterfallFlow'

@Entry
@Component
struct RentRoomList {
  build() {
    Stack() {
      WaterfallFlow()
      SearchFilter()
      NavBar({ title: '租房列表' })
    }
    .width('100%')
    .height('100%')
    .padding({ top: getWindowTopHeight() })
    .alignContent(Alignment.TopStart)
  }
}