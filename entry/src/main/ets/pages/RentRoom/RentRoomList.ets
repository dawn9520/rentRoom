import { getWindowTopHeight } from '../../utils/responsive'

import NavBar from '../../components/NavBar'
import SearchFilter from '../../views/RentRoomList/SearchFilter'

@Entry
@Component
struct RentRoomList {
  build() {
    Stack() {
      Column() {
        NavBar({ title: '租房列表' })
        SearchFilter()
      }.height('100%').padding({ top: getWindowTopHeight() })
    }.height('100%').alignContent(Alignment.TopStart)
  }
}