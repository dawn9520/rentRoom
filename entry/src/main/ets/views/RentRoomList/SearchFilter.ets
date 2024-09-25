import { getCityListApi, getDistrictListApi, getProvinceListApi } from '../../api/rentRoom'
import { BORDER_RADIUS_S } from '../../constants/size'
import {
  ICityItem,
  ICityList,
  IDistrictItem,
  IDistrictList,
  IProvinceItem,
  IProvinceList
} from '../../models/RentRoomData'
import { rvp } from '../../utils/responsive'

import { globalEmitter } from '../../utils/emitter'


@Component
export default struct SearchFilter {
  @State searchTypeList: string[] = ['地区', '租金', '付款方式', '排序']
  @State currentSearchType: string = ''
  @State provinceList: IProvinceList = [] // 省
  @State cityList: ICityList = [] // 市
  @State districtList: IDistrictList = [] // 区
  @State provinceCode: string = '' // 省code
  @State cityCode: string = '' // 市code
  @State districtCode: string = '' // 区code

  // 3. 地区数据
  chooseSearchType(searchType: string) {
    console.log(searchType)
    this.currentSearchType = searchType
    if (searchType === '地区') {
      // 发送请求，获取数据展示
      this.getProvinceList()
    }
  }

  // 获取省市区
  async getProvinceList() {
    const provinceList = await getProvinceListApi()
    this.provinceList = provinceList
    this.provinceCode = this.provinceCode || provinceList[0].code;
    this.getCityList()
  }

  async getCityList() {
    const cityList = await getCityListApi(this.provinceCode)
    this.cityList = cityList;
    this.cityCode = cityList[0].code || this.cityCode;
    this.getDistrictList()
  }

  async getDistrictList() {
    const districtList = await getDistrictListApi(this.cityCode)
    this.districtList = districtList
    this.districtCode = districtList[0].code || this.districtCode;
  }

  // 重置地区
  resetLocation = () => {
    this.provinceCode = this.provinceList[0].code;
    this.cityCode = '';
    this.districtCode = '';
    this.getCityList()
  }
  hidden = () => {
    this.currentSearchType = '';
  }



  locationSearch() {
    globalEmitter.emit('searchOptionsChange', {
      provinceCode: this.provinceCode,
      cityCode: this.cityCode,
      districtCode: this.districtCode,
    })
    this.currentSearchType = ''
    // this.locationClose()
  }

  // locationClose() {
  //   this.currentSearchType = ''
  //   if (this.locationData.isSearch) {
  //     this.locationData.searchProvinceCode = this.locationData.provinceCode
  //     this.locationData.searchCityCode = this.locationData.cityCode
  //     this.locationData.searchDistrictCode = this.locationData.districtCode
  //     this.locationData.searchDistrictName =
  //       this.locationData.districtList.find(item => item.code === this.locationData.districtCode)?.name || ''
  //   } else {
  //     this.locationData.provinceCode = this.locationData.searchProvinceCode
  //     this.locationData.cityCode = this.locationData.searchCityCode
  //     this.locationData.districtCode = this.locationData.searchDistrictCode
  //   }
  // }

  @Builder
  LocationRender() {
    Row() {
      List() {
        ForEach(this.provinceList, (item: IProvinceItem) => {
          ListItem() {
            Row() {
              Text(item.name)
                .fontSize(rvp(12))
                .fontColor(item.code === this.provinceCode ? $r('app.color.primary') :
                $r('app.color.black'))
            }
            .width('100%')
            .padding({
              left: rvp(16),
              right: rvp(16),
              top: rvp(6),
              bottom: rvp(6)
            })
          }.onClick(() => {
            this.provinceCode = item.code;
            this.getCityList()
          })
        }, (item: IProvinceItem) => item.code)
      }.width(rvp(120)).height('100%').backgroundColor($r('app.color.bg_gray')).scrollBar(BarState.Off)

      List() {
        ForEach(this.cityList, (item: ICityItem) => {
          ListItem() {
            Row() {
              Text(item.name)
                .fontSize(rvp(12))
                .fontColor(item.code === this.cityCode ? $r('app.color.primary') : $r('app.color.black'))
            }
            .width('100%')
            .padding({
              left: rvp(16),
              right: rvp(16),
              top: rvp(6),
              bottom: rvp(6)
            })
          }.onClick(() => {
            this.cityCode = item.code;
            this.getDistrictList()
          })
        }, (item: ICityItem) => item.code)
      }.width(rvp(120)).height('100%').backgroundColor('#EBEBEB').scrollBar(BarState.Off)

      List() {
        ForEach(this.districtList, (item: IDistrictItem) => {
          ListItem() {
            Row() {
              Text(item.name)
                .fontSize(rvp(12))
                .fontColor(item.code === this.districtCode ? $r('app.color.primary') :
                $r('app.color.black'))
            }
            .width('100%')
            .padding({
              left: rvp(16),
              right: rvp(16),
              top: rvp(6),
              bottom: rvp(6)
            })
          }.onClick(() => {
            this.districtCode = item.code;
          })
        }, (item: IDistrictItem) => item.code)
      }.width(rvp(120)).height('100%').backgroundColor('#E6E6E6').scrollBar(BarState.Off)
    }.height(rvp(240)).width('100%').backgroundColor($r('app.color.white'))

    Row({ space: rvp(22) }) {
      Button('重置')
        .buttonStyles(rvp(95), '#F0F0F0', $r('app.color.gray_second'))
        .onClick(this.resetLocation)
      Button('查看房源')
        .buttonStyles(rvp(211), '#67C0A8', $r('app.color.white'))
        .onClick(this.locationSearch.bind(this))
    }.height(rvp(58)).width('100%').backgroundColor($r('app.color.white')).justifyContent(FlexAlign.Center)

    Row() {
    }.width('100%').layoutWeight(1).backgroundColor('rgba(0, 0, 0, 0.7)').onClick(this.hidden)
  }

  @Builder
  RentPriceRender() {
    Text('RentPriceRender')
  }

  @Builder
  PaymentTypeRender() {
    Text('PaymentTypeRender')
  }

  @Builder
  SortRender() {
    Text('SortRender')
  }

  build() {
    Column() {
      Row() {
        ForEach(this.searchTypeList, (item: string) => {
          Row({ space: rvp(6) }) {
            Text(item)
              .fontSize(rvp(12))
              .fontColor(this.currentSearchType === item ? '#67C0A8' : $r('app.color.black'))
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .constraintSize({
                maxWidth: rvp(60),
              })

            if (this.currentSearchType === item) {
              Image($r('app.media.arrow_down_3_active'))
                .width(rvp(12)).height(rvp(12)).objectFit(ImageFit.Fill)
            } else {
              Image($r('app.media.arrow_down_3'))
                .width(rvp(6)).height(rvp(3)).objectFit(ImageFit.Fill)
            }
          }.width('25%').height('100%').justifyContent(FlexAlign.Center).onClick(() => {
            this.chooseSearchType(item)
          })
        }, (item: string) => item)
      }.width('100%').height(rvp(44)).justifyContent(FlexAlign.SpaceBetween)

      if (this.currentSearchType === '地区') {
        this.LocationRender()
      }
      if (this.currentSearchType === '租金') {
        this.RentPriceRender()
      }
      if (this.currentSearchType === '付款方式') {
        this.PaymentTypeRender()
      }
      if (this.currentSearchType === '排序') {
        this.SortRender()
      }
    }
  }
}


@Extend(Button)
function buttonStyles(width: number, bgColor: string | Resource, fontColor: string | Resource) {
  .type(ButtonType.Normal)
  .width(width)
  .height(rvp(26))
  .borderRadius(rvp(BORDER_RADIUS_S))
  .fontSize(rvp(12))
  .backgroundColor(bgColor)
  .fontColor(fontColor)
}