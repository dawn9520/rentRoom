import router from '@ohos.router'

import NavBar from '../../views/RentRoomDetail/NavBar'
import ScrollContainer from '../../components/ScrollContainer'
import NavSwiper from '../../views/RentRoomDetail/NavSwiper'


import { getRentRoomDetailApi } from '../../api/rentRoom'
import type { IRentRoomDetail, IRentRoomDetailParams, IRoomName } from '../../models/RentRoomData'

@Entry
@Component
export default struct RentRoomDetail {
  @State room: Partial<IRentRoomDetail> = {}
  @State roomNameList: IRoomName[] | undefined = []
  @State roomPictureList: string[] | undefined = []

  aboutToAppear() {
    this.getRentRoomDetail()
  }

  async getRentRoomDetail() {
    const id = (router.getParams() as IRentRoomDetailParams).id
    this.room = await getRentRoomDetailApi(id)
    this.roomNameList = this.room.housePicture?.map(item => {
      const roomName: IRoomName = {
        spaceName: item.spaceName,
        total: item.picList.length
      }
      return roomName
    })
    this.roomPictureList = this.room.housePicture?.reduce((p: string[], c) => {
      return p.concat(c.picList)
    }, []) // 注意这里的[]

  }

  @Builder
  NavBarRender() {
    NavBar({ title: this.room.houseTitle })
  }

  @Builder
  ContentRender() {
    NavSwiper({roomNameList: this.roomNameList, roomPictureList: this.roomPictureList})
  }

  build() {
    Column() {
      ScrollContainer({
        navBuilder: () => {
          this.NavBarRender()
        },
        contentBuilder: () => {
          this.ContentRender()
        },
      })
    }.height('100%')
  }
}