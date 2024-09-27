import router from '@ohos.router'

import NavBar from '../../views/RentRoomDetail/NavBar'
import ScrollContainer from '../../components/ScrollContainer'

import { getRentRoomDetailApi } from '../../api/rentRoom'
import type { IRentRoomDetail, IRentRoomDetailParams } from '../../models/RentRoomData'


@Entry
@Component
export default struct RentRoomDetail {
  @State room: Partial<IRentRoomDetail> = {}

  aboutToAppear() {
    this.getRentRoomDetail()
  }

  async getRentRoomDetail() {
    const id = (router.getParams() as IRentRoomDetailParams).id
    this.room = await getRentRoomDetailApi(id)
    console.log('----this.room', JSON.stringify(this.room))
  }

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
        navBuilder: this.NavBarRender,
        contentBuilder: this.ContentRender,
      })
    }.height('100%')
  }
}