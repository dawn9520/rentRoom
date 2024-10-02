import router from '@ohos.router'

import NavBar from '../../views/RentRoomDetail/NavBar'
import ScrollContainer from '../../components/ScrollContainer'
import NavSwiper from '../../views/RentRoomDetail/NavSwiper'
import RentPrice from '../../views/RentRoomDetail/RentPrice'
import DiscountsList from '../../views/RentRoomDetail/DiscountsList'
import MetaInfo from '../../views/RentRoomDetail/MetaInfo'
import TagList from '../../views/RentRoomDetail/TagList'
import RentTerm from '../../views/RentRoomDetail/RentTerm'

import { getRentRoomDetailApi } from '../../api/rentRoom'
import type {
  IDiscountsList,
  IDistanceInfo,
  IMetaInfoList,
  IRentRoomDetail,
  IRentRoomDetailParams,
  IRoomName,
  IRentTerm
} from '../../models/RentRoomData'
import { ITagList } from '../../models/RoomRecommendDataSource'
import { rvp } from '../../utils/responsive'
import { PADDING } from '../../constants/size'

@Entry
@Component
export default struct RentRoomDetail {
  @State room: Partial<IRentRoomDetail> = {}
  @State roomNameList: IRoomName[] | undefined = [] // 房间区域名列表
  @State roomPictureList: string[] | undefined = [] // 区域名图片列表
  @State discountsList: IDiscountsList = [] //
  @State metaInfoList: IMetaInfoList = []
  @State distanceInfo: Partial<IDistanceInfo> = {}
  @State tagList: ITagList = []
  @State rentTerm: Partial<IRentTerm> = {}

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
    this.discountsList = this.room.discounts || []
    this.metaInfoList = this.room.metaInfo || []
    this.distanceInfo = this.room.distance_info || {}
    this.tagList = this.room.tags || []
    this.rentTerm = this.room.rentTerm || {}
  }

  @Builder
  NavBarRender() {
    NavBar({ title: this.room.houseTitle })
  }

  @Builder
  ContentRender() {
    NavSwiper({ roomNameList: this.roomNameList, roomPictureList: this.roomPictureList })
    Column() {
      RentPrice({ rentPriceUnitListing: this.room.rentPriceUnitListing, rentPriceUnit: this.room.rentPriceUnit })
      DiscountsList({ discountsList: this.discountsList })
      MetaInfo({ metaInfoList: this.metaInfoList, distanceInfo: this.distanceInfo })
      TagList({ tagList: this.tagList })
      RentTerm({ rentTerm: this.rentTerm })
    }.padding({ left: rvp(PADDING), right: rvp(PADDING) })
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