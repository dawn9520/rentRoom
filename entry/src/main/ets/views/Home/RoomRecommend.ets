import { IRoomRecommendItem, ITagItem, RoomRecommendDataSource } from '../../models/RoomRecommendDataSource'
import { getRoomRecommendListApi } from '../../api/home'

import { BORDER_RADIUS, PADDING } from '../../constants/size'

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

  // 头部导航
  @Builder
  RoomNav() {
    Row() {
      Text() {
        Span('周边房源')
        Span('推荐').fontColor($r('app.color.primary'))
      }.fontSize(18)

      Row({ space: 6 }) {
        Text('更多推荐').fontColor($r('app.color.gray_second')).fontSize(12)
        Image($r('app.media.arrow_right')).width(4).height(8)
      }
    }
    .width('100%')
    .height(67)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor($r('app.color.white'))
    .padding({ left: PADDING, right: PADDING, top: 23 })
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
                Image(room.housePicture).width('100%').height(120).objectFit(ImageFit.Fill).borderRadius({
                  topLeft: BORDER_RADIUS,
                  topRight: BORDER_RADIUS
                })
                // 房间信息内容
                Column() {
                  Row() {
                    Text() {
                      Span(room.rentPriceListing).fontSize(16).fontColor('#E03810')
                      Span(room.rentPriceUnit).fontSize(14).fontColor('#E03810')
                    }.height(22)

                    Text(room.rentArea + '㎡').fontSize(12).fontColor($r('app.color.gray'))
                  }.width('100%').justifyContent(FlexAlign.SpaceBetween)

                  Text(room.houseTitle)
                    .fontSize(14)
                    .margin({ top: 1 })
                    .height(19)
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                  Row({ space: 6 }) {
                    ForEach(room.tags.slice(0, 2), (tag: ITagItem, index) => {
                      Text(tag.name)
                        .padding({
                          top: 1,
                          bottom: 1,
                          left: 6,
                          right: 6
                        })
                        .fontColor(index === 0 ? $r('app.color.white') : '#B3B3B3')
                        .backgroundColor(index === 0 ? $r('app.color.primary') : $r('app.color.bg_gray'))
                        .fontSize(12)
                    }, (tag: ITagItem) => tag.name)
                  }.width('100%').margin({ top: 9 })
                }.padding(12).alignItems(HorizontalAlign.Start).height(91)
              }.width('100%')
              // 图片灰色遮罩图片
              Image($r('app.media.room_text_bg')).width('100%').height(120)
              // 位置信息
              Row({ space: 6 }) {
                Image($r('app.media.location')).width(12).height(14)
                Text(room.address).fontSize(12).fontColor($r('app.color.white'))
              }.margin({ left: 8, top: 99 })
            }.alignContent(Alignment.TopStart).backgroundColor($r('app.color.white'))
          }.height(210)
        }, (room: IRoomRecommendItem) => room.id)
      }
      .columnsTemplate('1fr 1fr') // 竖直方向两列排布
      .columnsGap(8) // 竖直方向间隙
      .rowsGap(8) // 水平方向间隙
      .width('100%')
      .padding({
        left: PADDING,
        right: PADDING,
        top: 8,
        bottom: 8
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