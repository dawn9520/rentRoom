import { getWindowTopHeight, rvp } from '../../utils/responsive'

import NavBar from '../../components/NavBar'
import SearchFilter from '../../views/RentRoomList/SearchFilter'
import WaterfallFlow from '../../views/RentRoomList/WaterfallFlow'

@Entry
@Component
struct RentRoomList {
  build() {
    Column() {
      Stack() {
        Column() {
          NavBar({ title: '租房列表' })
          SearchFilter()
        }.padding({ top: getWindowTopHeight() })
      }.alignContent(Alignment.TopStart)
      WaterfallFlow()
    }.width('100%').height('100%')
  }
}