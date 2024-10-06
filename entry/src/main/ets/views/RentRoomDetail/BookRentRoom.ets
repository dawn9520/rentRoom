import Drawer from '../../components/Drawer';
import { BORDER_RADIUS, BORDER_RADIUS_S, PADDING } from '../../constants/size';
import { rvp } from '../../utils/responsive';
import createDateList, { IDateItem, IDateList } from '../../utils/createDateList';

@Component
export default struct BookInfo {
  @Link show: boolean
  @State dateList: IDateList = createDateList()
  @State currentDateIndex: number = 0
  @State isCollapseDateList: boolean = true

  setCurrentDateIndex(index: number) {
    this.currentDateIndex = index
  }

  expandDateList() {
    this.isCollapseDateList = !this.isCollapseDateList
  }

  build() {
    Drawer({ show: this.show }) {
      Column({ space: rvp(16) }) {
        Text('预约信息').fontSize(rvp(18)).fontWeight(700)
        Column({ space: rvp(20) }) {
          Row({ space: rvp(18) }) {
            Text('姓名').width(rvp(56)).fontSize(rvp(14))
            TextInput({ placeholder: '请输入姓名' }).textInputStyles()
          }.width('100%')

          Row({ space: rvp(18) }) {
            Text('手机号').width(rvp(56)).fontSize(rvp(14))
            TextInput({ placeholder: '请输入手机号' }).type(InputType.PhoneNumber).maxLength(11).textInputStyles()
          }.width('100%')

          Row({ space: rvp(18) }) {
            Text('预约日期').width(rvp(56)).fontSize(rvp(14))
            Column({ space: rvp(20) }) {
              Row() {
                Text(`${this.dateList[this.currentDateIndex].date}（${this.dateList[this.currentDateIndex].week}）`)
                  .fontSize(rvp(14))
                  .fontColor($r('app.color.gray'))
                Image($r('app.media.arrow_down_2')).width(rvp(10)).fillColor($r('app.color.gray'))
              }.width('100%').justifyContent(FlexAlign.SpaceBetween).onClick(this.expandDateList.bind(this))

              if (!this.isCollapseDateList) {
                Grid() {
                  ForEach(this.dateList, (item: IDateItem, index) => {
                    GridItem() {
                      Column() {
                        Text(`(${item.week})`)
                          .fontSize(rvp(12))
                          .fontColor(this.currentDateIndex === index ? '#1C916D' : $r('app.color.gray'))
                        Text(item.date)
                          .fontSize(rvp(12))
                          .fontColor(this.currentDateIndex === index ? '#1C916D' : $r('app.color.gray'))
                      }.width(rvp(70)).height(rvp(32)).border({
                        width: 1,
                        radius: rvp(BORDER_RADIUS_S),
                        color: this.currentDateIndex === index ? '#24A17B' : '#E4E4E4'
                      }).justifyContent(FlexAlign.Center)
                    }.onClick(this.setCurrentDateIndex.bind(this, index))
                  }, (item: IDateItem) => item.date)
                }.columnsTemplate('1fr 1fr 1fr')
                .columnsGap(rvp(6))
                .rowsGap(rvp(10))
                .height(rvp(3 * 32 + 20))
              }
            }.layoutWeight(1)
          }.width('100%').alignItems(VerticalAlign.Top)

          Row({ space: rvp(18) }) {
            Text('备注信息').width(rvp(56)).fontSize(rvp(14))
            TextArea({ placeholder: '请输入备注信息' }).textAreaStyles()
          }.width('100%').alignItems(VerticalAlign.Top)
        }
        .alignItems(HorizontalAlign.Start)
        .backgroundColor($r('app.color.white'))
        .padding(rvp(PADDING))

        Button('预约看房')
          .type(ButtonType.Normal)
          .width('100%')
          .height(rvp(42))
          .padding(rvp(13))
          .fontColor($r('app.color.white'))
          .fontSize(rvp(14))
          .backgroundColor('#24A17B')
          .borderRadius(rvp(2))
      }.alignItems(HorizontalAlign.Start).padding({ bottom: rvp(PADDING) })
    }
  }
}

@Styles
function pressedStyles() {
  .backgroundColor('#F6F6F6')
}

@Extend(TextInput)
function textInputStyles() {
  .layoutWeight(1)
  .backgroundColor(Color.Transparent)
  .placeholderColor($r('app.color.gray'))
  .placeholderFont({ size: rvp(14) })
  .caretColor($r('app.color.gray'))
  .fontSize(rvp(14))
  .borderRadius(rvp(BORDER_RADIUS_S))
  .stateStyles({
    pressed: pressedStyles,
  })
  .padding(0)
}

@Extend(TextArea)
function textAreaStyles() {
  .layoutWeight(1)
  .backgroundColor('#F6F6F6')
  .placeholderColor($r('app.color.gray'))
  .placeholderFont({ size: rvp(14) })
  .caretColor($r('app.color.gray'))
  .fontSize(rvp(14))
  .borderRadius(rvp(BORDER_RADIUS))
  .stateStyles({
    pressed: pressedStyles,
  })
  .padding(rvp(10))
  .height(rvp(60))
}