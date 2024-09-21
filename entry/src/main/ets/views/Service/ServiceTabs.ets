import Card from '../../components/Card';
import { ICleaningServiceInfoItem, ICleaningServiceInfoList } from '../../models/ServiceData';
import { rvp } from '../../utils/responsive';

@Component
export default struct ServiceTabs {
  @Prop serviceTabImage: string
  @Link cleaningServiceInfo: ICleaningServiceInfoList
  @State currentIndex: number = 0

  // tab导航栏
  @Builder
  TabBuilder(index: number, name: string, subName: string) {
    Column({ space: rvp(2) }) {
      Text(name).fontSize(this.currentIndex === index ? rvp(18) : rvp(14)).fontWeight(700)
      Text(subName).fontSize(rvp(12)).fontColor($r('app.color.gray_second'))
      if (this.currentIndex === index) {
        Divider() // 高亮下标
          .strokeWidth(rvp(4)) // 在这里是设置提示标的高度部分
          .width(rvp(20))
          .color('#51BB9E')
      }
    }.width('100%')
  }

  // tab内容区
  @Builder
  Content() {
    Column({ space: rvp(8) }) {
      this.NewArea()
      this.CleanRoom()
    }
  }

  // 新人专区
  @Builder
  NewArea() {
    Card({ cardPadding: rvp(8) }) {
      Text() {
        Span('新人').fontSize(rvp(16)).fontColor($r('app.color.primary'))
        Span('专区').fontSize(rvp(16))
      }

      Image(this.serviceTabImage).width('100%').height(rvp(90)).objectFit(ImageFit.Fill).margin({ top: rvp(8) })
    }
  }

  // 洁净家
  @Builder
  CleanRoom() {
    Card({ cardPadding: rvp(8) }) {
      Text('洁净家').fontSize(rvp(16))
      Row({ space: rvp(8) }) {
        ForEach(this.cleaningServiceInfo, (item: ICleaningServiceInfoItem) => {
          Column() {
            Image(item.img).width('100%').height(rvp(115)).objectFit(ImageFit.Fill)
            Text(item.title).fontSize(rvp(14)).fontWeight(700).margin({ top: rvp(8) })
            Text(item.subTitle).fontSize(rvp(10)).fontColor($r('app.color.gray_second')).margin({ top: rvp(7) })
            Row() {
              Text('到手价').fontSize(rvp(10)).fontColor($r('app.color.gray_second'))
              Text('￥' + item.priceAfterDiscounts).fontSize(rvp(16)).fontColor('#D9351A').margin({ left: rvp(6) })
              Text('￥' + item.originalPrice)
                .fontSize(rvp(10))
                .fontColor($r('app.color.gray_second'))
                .decoration({ type: TextDecorationType.LineThrough, color: $r('app.color.gray_second') })
                .margin({ left: rvp(4) })
            }.margin({ top: rvp(8) })
          }.layoutWeight(1).alignItems(HorizontalAlign.Start)
        }, (item: ICleaningServiceInfoItem) => item.title)
      }.margin({ top: rvp(8) })
    }
  }

  build() {
    Tabs({ barPosition: BarPosition.Start }) { // 设置tab在顶部位置
      TabContent() {
        this.Content()
      }.tabBar(this.TabBuilder(0, '会员精选', '专业服务'))

      TabContent() {
        this.Content()
      }.tabBar(this.TabBuilder(1, '居家保洁', '解放双手'))

      TabContent() {
        this.Content()
      }.tabBar(this.TabBuilder(2, '深层清洁', '高温蒸洗'))

      TabContent() {
        this.Content()
      }.tabBar(this.TabBuilder(3, '新居乔迁', '一站搬家'))
    }
    .vertical(false)
    .barMode(BarMode.Fixed)
    .barWidth('100%')
    .barHeight(rvp(53))
    .onChange((index: number) => {
      this.currentIndex = index
    })
    .width('100%')
    .height(rvp(423))
    .margin({ top: rvp(18) })
  }
}