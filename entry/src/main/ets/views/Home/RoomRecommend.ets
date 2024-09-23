import { IRoomRecommendItem, ITagItem, RoomRecommendDataSource } from '../../models/RoomRecommendDataSource'
import { getRoomRecommendListApi } from '../../api/home'

import { BORDER_RADIUS, PADDING } from '../../constants/size'
import { rvp } from '../../utils/responsive'

import router from '@ohos.router'

@Component
export default struct RoomRecommend {
  // 获取推荐房源列表
  @State roomRecommendDataSource: RoomRecommendDataSource = new RoomRecommendDataSource([])

  aboutToAppear() {
    this.getRoomRecommendList();
  }

  async getRoomRecommendList() {
    const roomRecommendList = await getRoomRecommendListApi();
    this.roomRecommendDataSource = new RoomRecommendDataSource(roomRecommendList)
  }

  goRentRoomList = () => {
    router.pushUrl({ url: 'pages/RentRoom/RentRoomList' })
  }

  // 头部导航
  @Builder
  RoomNav() {
    Row() {
      Text() {
        Span('周边房源')
        Span('推荐').fontColor($r('app.color.primary'))
      }.fontSize(rvp(18))

      Row({ space: rvp(6) }) {
        Text('更多推荐').fontColor($r('app.color.gray_second')).fontSize(rvp(12))
        Image($r('app.media.arrow_right')).width(rvp(4)).height(rvp(8))
      }.onClick(this.goRentRoomList)
    }
    .width('100%')
    .height(rvp(67))
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor($r('app.color.white'))
    .padding({ left: rvp(PADDING), right: rvp(PADDING), top: rvp(23) })
  }

  // 房源列表
  @Builder
  RoomList() {
    if (this.roomRecommendDataSource.roomRecommendList.length) {
      Grid() {
        LazyForEach(this.roomRecommendDataSource, (room: IRoomRecommendItem) => {
          GridItem() {
            Stack() {
              Column() {
                // 房间图片内容
                Image(room.housePicture).width('100%').height(rvp(120)).objectFit(ImageFit.Fill).borderRadius({
                  topLeft: rvp(BORDER_RADIUS),
                  topRight: rvp(BORDER_RADIUS)
                })
                // 房间信息内容
                Column() {
                  Row() {
                    Text() {
                      Span(room.rentPriceListing).fontSize(rvp(16)).fontColor('#E03810')
                      Span(room.rentPriceUnit).fontSize(rvp(14)).fontColor('#E03810')
                    }.height(rvp(22))

                    Text(room.rentArea + '㎡').fontSize(rvp(12)).fontColor($r('app.color.gray'))
                  }.width('100%').justifyContent(FlexAlign.SpaceBetween)

                  Text(room.houseTitle)
                    .fontSize(rvp(14))
                    .margin({ top: rvp(1) })
                    .height(rvp(19))
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                  Row({ space: rvp(6) }) {
                    ForEach(room.tags.slice(0, 2), (tag: ITagItem, index) => {
                      Text(tag.name)
                        .padding({
                          top: rvp(1),
                          bottom: rvp(1),
                          left: rvp(6),
                          right: rvp(6)
                        })
                        .fontColor(index === 0 ? $r('app.color.white') : '#B3B3B3')
                        .backgroundColor(index === 0 ? $r('app.color.primary') : $r('app.color.bg_gray'))
                        .fontSize(rvp(12))
                    }, (tag: ITagItem) => tag.name)
                  }.width('100%').margin({ top: rvp(9) })
                }.padding(rvp(12)).alignItems(HorizontalAlign.Start).height(rvp(91))
              }.width('100%')
              // 图片灰色遮罩图片
              Image($r('app.media.room_text_bg')).width('100%').height(rvp(120))
              // 位置信息
              Row({ space: rvp(6) }) {
                Image($r('app.media.location')).width(rvp(12)).height(rvp(14))
                Text(room.address).fontSize(rvp(12)).fontColor($r('app.color.white'))
              }.margin({ left: rvp(8), top: rvp(99) })
            }.alignContent(Alignment.TopStart).backgroundColor($r('app.color.white'))
          }.height(rvp(210))
        }, (room: IRoomRecommendItem) => room.id)
      }
      .columnsTemplate('1fr 1fr') // 竖直方向两列排布
      .columnsGap(rvp(8)) // 竖直方向间隙
      .rowsGap(rvp(8)) // 水平方向间隙
      .width('100%')
      .padding({
        left: PADDING,
        right: PADDING,
        top: rvp(8),
        bottom: rvp(8)
      })
      .backgroundColor($r('app.color.bg_gray'))
      .borderRadius(BORDER_RADIUS)
    }
  }

  build() {
    Column() {
      this.RoomNav()
      this.RoomList()
    }.width('100%')
  }
}