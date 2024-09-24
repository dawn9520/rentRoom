import { getWindowTopHeight, rvp } from '../../utils/responsive'

import NavBar from '../../components/NavBar'
import SearchFilter from '../../views/RentRoomList/SearchFilter'
import WaterfallFlow from '../../views/RentRoomList/WaterfallFlow'

@Entry
@Component
struct RentRoomList {
  build() {
    Stack() {
      Column() {
        WaterfallFlow()
      }.padding({ top: getWindowTopHeight() + rvp(88) })

      Column() {
        NavBar({ title: '租房列表' })
        SearchFilter()
      }.height('100%').padding({ top: getWindowTopHeight() })
    }.height('100%').alignContent(Alignment.TopStart)
  }
}