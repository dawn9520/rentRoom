import router from '@ohos.router'

import NavBar from '../../views/RentRoomDetail/NavBar'
import ScrollContainer from '../../components/ScrollContainer'
import NavSwiper from '../../views/RentRoomDetail/NavSwiper'
import RentPrice from '../../views/RentRoomDetail/RentPrice'
import DiscountsList from '../../views/RentRoomDetail/DiscountsList'
import MetaInfo from '../../views/RentRoomDetail/MetaInfo'
import TagList from '../../views/RentRoomDetail/TagList'
import RentTerm from '../../views/RentRoomDetail/RentTerm'
import RentInfo from '../../views/RentRoomDetail/RentInfo'
import SupportList from '../../views/RentRoomDetail/SupportList'
import HouseholdItem from '../../views/RentRoomDetail/HouseholdItem'
import Book from '../../views/RentRoomDetail/Book'
import BookRentRoom from '../../views/RentRoomDetail/BookRentRoom'

import { getRentRoomDetailApi } from '../../api/rentRoom'
import type {
  IDiscountsList,
  IDistanceInfo,
  IHouseholdList,
  IMetaInfoList,
  IRentInfoList,
  IRentRoomDetail,
  IRentRoomDetailParams,
  IRentTerm,
  IRoomName,
  ISupportList
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
  @State rentInfoList: IRentInfoList = []
  @State supportList: ISupportList = []
  @State householdList: IHouseholdList = []
  @State show: boolean = false
  @State roomId: string = ''

  aboutToAppear() {
    this.getRentRoomDetail()
  }

  async getRentRoomDetail() {
    this.roomId = (router.getParams() as IRentRoomDetailParams).id
    this.room = await getRentRoomDetailApi(this.roomId)
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
    this.rentInfoList = this.room.rentInfo || []
    this.supportList = this.room.support || []
    this.householdList = this.room.householdItem || []
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
      RentInfo({ rentInfoList: this.rentInfoList })
      HouseholdItem({ householdList: this.householdList })
      SupportList({ supportList: this.supportList })
      Button('查看全部内容')
        .type(ButtonType.Normal)
        .width('100%')
        .height(rvp(44))
        .fontSize(rvp(12))
        .fontColor('#ABA9AC')
        .margin({ top: rvp(25) })
        .backgroundColor($r('app.color.white'))
        .border({ width: 1, color: '#F5F5F5', radius: rvp(4) })
    }.padding({ left: rvp(PADDING), right: rvp(PADDING) })
  }

  build() {
    Stack() {
      ScrollContainer({
        navBuilder: () => {
          this.NavBarRender()
        },
        contentBuilder: () => {
          this.ContentRender()
        },
      })

      Book({ show: this.show })
      BookRentRoom({ show: this.show, roomId: this.roomId })
    }.height('100%').alignContent(Alignment.Bottom)
  }
}