import type { IServiceActivity } from '../../models/ServiceData';
import Calendar from '../../utils/calendar';
import { rvp } from '../../utils/responsive';
import Card from '../../components/Card';
import { BORDER_RADIUS, BORDER_RADIUS_S } from '../../constants/size';

@Component
export default struct ServiceCalendar {
  @Prop serviceActivity: IServiceActivity
  @State calendarList: string[] = []

  aboutToAppear() {
    const calendar = new Calendar();
    this.calendarList = calendar.generatorCalendarList();
  }

  @Builder
  renderBuilder() {
    // 导航
    Row() {
      Text('服务日历').fontSize(rvp(16)).fontWeight(700)
      Row({ space: rvp(10) }) {
        Text('全部服务').fontSize(rvp(12)).fontColor($r('app.color.gray'))
        Image($r('app.media.arrow_right')).width(rvp(4))
      }
    }.justifyContent(FlexAlign.SpaceBetween).width('100%').padding({ top: rvp(8), left: rvp(8), right: rvp(8) })

    // 日历
    Row() {
      ForEach(this.calendarList, (item: string, index) => {
        Row() {
          Text(item).fontSize(rvp(16)).fontWeight(700).width(rvp(20))
          Text('月').fontSize(rvp(12)).fontColor($r('app.color.gray_second')).lineHeight(18)
        }
        .backgroundColor(index === 2 ? '#CDFFD9' : '#FFF')
        .padding(index === 2 ? rvp(6) : 0)
        .borderRadius(rvp(BORDER_RADIUS_S))
      }, (item: string) => item)
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .margin({ top: rvp(9) })
    .padding({ left: rvp(8), right: rvp(8) })

    // 活动礼包
    Column({ space: rvp(7) }) {
      Text(this.serviceActivity.name).fontSize(rvp(14)).fontWeight(700)
      Row({ space: rvp(10) }) {
        Image(this.serviceActivity.img)
          .width(rvp(100))
          .height(rvp(100))
          .objectFit(ImageFit.Fill)
          .borderRadius(rvp(BORDER_RADIUS_S))
        Column() {
          Text(this.serviceActivity.title).fontSize(rvp(14)).margin({ top: rvp(7) })
          Text(this.serviceActivity.subTitle).fontSize(rvp(12)).margin({ top: rvp(7) })
          Row() {
            Text('立即参与')
              .borderRadius(rvp(BORDER_RADIUS_S))
              .fontSize(rvp(12))
              .fontColor('#1F632F')
              .backgroundColor('#CDFFD9')
              .width(rvp(70))
              .height(rvp(24))
              .textAlign(TextAlign.Center)
          }.margin({ top: rvp(22) }).padding({ right: rvp(8) }).width('100%').justifyContent(FlexAlign.End)
        }.height(rvp(100)).alignItems(HorizontalAlign.Start).layoutWeight(1)
      }.width('100%').height(rvp(100))
    }
    .width('100%')
    .height(rvp(140))
    .padding(rvp(8))
    .borderRadius(rvp(BORDER_RADIUS))
    .margin({ top: rvp(12) })
    .linearGradient({ // 使用渐变
      angle: 210, // 从右上角开始
      colors: [['#D0FFDB', 0], ['rgba(255, 255, 255, 1)', 0.29], ['rgba(255, 255, 255, 0)', 1]],
      repeating: false
    })
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      Card({
        cardPadding: 0, renderBuilder: () => {
          this.renderBuilder()
        }
      })
    }.margin({ top: rvp(8) })
  }
}