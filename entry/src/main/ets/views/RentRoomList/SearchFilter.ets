import { getCityListApi, getDistrictListApi, getProvinceListApi } from '../../api/rentRoom'
import { BORDER_RADIUS_S, PADDING } from '../../constants/size'
import {
    ICityItem,
    ICityList,
    IDistrictItem,
    IDistrictList,
    IProvinceItem,
    IProvinceList,
    IRentPriceItem,
    ISortItem
} from '../../models/RentRoomData'
import { PaymentTypeDataAny, RentPriceDataAny, SortDataAny } from '../../models/RentRoomData/dataAny'
import { rvp } from '../../utils/responsive'

import { globalEmitter } from '../../utils/emitter'


@Component
export default struct SearchFilter {
  @State searchTypeList: string[] = ['地区', '租金', '付款方式', '排序']
  // 地区数据设置
  @State currentSearchType: string = ''
  @State provinceList: IProvinceList = [] // 省
  @State cityList: ICityList = [] // 市
  @State districtList: IDistrictList = [] // 区
  @State provinceCode: string = '' // 省code
  @State cityCode: string = '' // 市code
  @State districtCode: string = '' // 区code
  @State searchDistrictName: string = '' // 当前选择地区的名字
  // 租金数据设置
  @State rentPriceData: RentPriceDataAny = {
    rentPriceList: [
      {
        id: 1,
        minRent: '0',
        maxRent: '0',
        text: '不限'
      },
      {
        id: 2,
        minRent: '0',
        maxRent: '1500',
        text: '1500元以下'
      },
      {
        id: 3,
        minRent: '1500',
        maxRent: '2500',
        text: '1500-2500元'
      },
      {
        id: 4,
        minRent: '2500',
        maxRent: '3500',
        text: '2500-3500元'
      },
      {
        id: 5,
        minRent: '3500',
        maxRent: '4500',
        text: '3500-4500元'
      },
      {
        id: 6,
        minRent: '4500',
        maxRent: '6000',
        text: '4500-6000元'
      },
      {
        id: 7,
        minRent: '6000',
        maxRent: '8000',
        text: '6000-8000元'
      },
      {
        id: 8,
        minRent: '8000',
        maxRent: '10000',
        text: '8000-10000元'
      },
      {
        id: 9,
        minRent: '10000',
        maxRent: '0',
        text: '10000元以上'
      }
    ],
    rentPrice: {},
    isSearch: false,
    searchRentPrice: {}
  }
  // 付款方式数据设置
  @State paymentTypeData: PaymentTypeDataAny = {
    paymentTypeList: ['月付', '季付', '半年付', '年付'],
    isSearch: false,
    paymentType: '',
    searchPaymentType: ''
  }
  // 排序数据设置
  @State sortData: SortDataAny = {
    sortList: [
      {
        id: 1,
        icon: $r('app.media.sort'),
        text: '综合排序',
        orderBy: '',
        orderType: ''
      },
      {
        id: 2,
        icon: $r('app.media.rent'),
        text: '价格从低到高',
        orderBy: 'price',
        orderType: 'asc'
      },
      {
        id: 3,
        icon: $r('app.media.rent'),
        text: '价格从高到低',
        orderBy: 'price',
        orderType: 'desc'
      },
      {
        id: 4,
        icon: $r('app.media.area'),
        text: '面积从大到小',
        orderBy: 'area',
        orderType: 'desc'
      },
      {
        id: 5,
        icon: $r('app.media.area'),
        text: '面积从小到大',
        orderBy: 'area',
        orderType: 'asc'
      },
    ],
    sort: {
      id: 1,
      icon: $r('app.media.sort'),
      text: '综合排序',
      orderBy: '',
      orderType: ''
    },
  }

  // 搜索条件显示
  getSearchTypeName(item: string): string {
    switch (item) {
      case '地区':
        return this.searchDistrictName || item
      case '租金':
        return this.rentPriceData.searchRentPrice.text || item
      case '付款方式':
        return this.paymentTypeData.paymentType || item
      case '排序':
        return this.sortData.sort.text || item
      default:
        return item
    }
  }

  // -------------地区搜索 方法
  // 地区数据 操作
  chooseSearchType(searchType: string) {
    console.log(searchType)
    this.currentSearchType = searchType
    if (searchType === '地区') {
      // 发送请求，获取数据展示
      this.getProvinceList()
    }
  }

  // 以下3个方法为获取 省/市/区 操作
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
    this.searchDistrictName = '';
    this.getCityList()
  }
  // 关闭搜索
  hidden = () => {
    this.currentSearchType = '';
  }

  // 触发房源数据查询，关闭地区搜索 组件
  locationSearch() {
    globalEmitter.emit('searchOptionsChange', {
      provinceCode: this.provinceCode,
      cityCode: this.cityCode,
      districtCode: this.districtCode,
    })
    // this.searchDistrictName = this.districtList?.find(item => item?.code === this.districtCode)?.name || ''
    this.hidden()
  }

  // -------------租金搜索 方法
  // 租金价格更改
  handleRentPriceChange(rentPrice: IRentPriceItem) {
    this.rentPriceData.rentPrice = rentPrice
  }

  // 租金价格搜索
  rentPriceSearch() {
    globalEmitter.emit('searchOptionsChange', {
      minRent: this.rentPriceData.rentPrice.minRent,
      maxRent: this.rentPriceData.rentPrice.maxRent,
    })
    this.rentPriceData.isSearch = true;
    this.rentPriceClose()
  }

  // 租金价格关闭
  rentPriceClose() {
    this.hidden()
    if (this.rentPriceData.isSearch) {
      this.rentPriceData.searchRentPrice = this.rentPriceData.rentPrice
    } else {
      this.rentPriceData.rentPrice = this.rentPriceData.searchRentPrice
    }
  }

  // 租金价格重置
  rentPriceReset() {
    this.rentPriceData.rentPrice = {}
  }

  // -------------付款方式搜索 方法
  // 付款类型更改
  handlePaymentTypeChange(paymentType: string) {
    this.paymentTypeData.paymentType = paymentType
  }

  // 付款类型搜索
  paymentTypeSearch() {
    globalEmitter.emit('searchOptionsChange', {
      paymentType: this.paymentTypeData.searchPaymentType
    })
    this.paymentTypeData.isSearch = true;
    this.paymentTypeClose()
  }

  // 付款类型搜索关闭
  paymentTypeClose() {
    this.hidden()
    if (this.paymentTypeData.isSearch) {
      this.paymentTypeData.searchPaymentType = this.paymentTypeData.paymentType
    } else {
      this.paymentTypeData.paymentType = this.paymentTypeData.searchPaymentType
    }
  }

  // 付款类型重置
  paymentTypeReset() {
    this.paymentTypeData.paymentType = ''
  }

  // -------------付款方式搜索 方法
  handleSortChange(sort: ISortItem) {
    this.sortData.sort = sort
    this.sortSearch()
  }

  sortSearch() {
    globalEmitter.emit('searchOptionsChange', {
      orderBy: this.sortData.sort.orderBy,
      orderType: this.sortData.sort.orderType,
    })
    this.sortClose()
  }

  sortClose() {
    this.currentSearchType = ''
  }

  sortReset() {
    this.sortData.sort = {
      id: 1,
      icon: $r('app.media.sort'),
      text: '综合排序',
      orderBy: '',
      orderType: ''
    }
  }

  // 地区搜索 组件
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

  // 租金搜索 组件
  @Builder
  RentPriceRender() {
    Column() {
      Grid() {
        ForEach(this.rentPriceData.rentPriceList, (rentPrice: IRentPriceItem) => {
          GridItem() {
            Text(rentPrice.text)
              .textStyles(this.rentPriceData.rentPrice.id === rentPrice.id)
              .onClick(this.handleRentPriceChange.bind(this, rentPrice))
          }
        }, (rentPrice: IRentPriceItem) => rentPrice.id + '')
      }
      .columnsTemplate('1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr')
      .height(rvp(194 - 58))

      Row({ space: rvp(22) }) {
        Button('重置')
          .buttonStyles(rvp(95), '#F0F0F0', $r('app.color.gray_second'))
          .onClick(this.rentPriceReset.bind(this))
        Button('查看房源')
          .buttonStyles(rvp(211), '#67C0A8', $r('app.color.white'))
          .onClick(this.rentPriceSearch.bind(this))
      }.height(rvp(58)).width('100%').backgroundColor($r('app.color.white')).justifyContent(FlexAlign.Center)
    }
    .height(rvp(202))
    .width('100%')
    .backgroundColor($r('app.color.white'))
    .padding({ left: rvp(PADDING), right: rvp(PADDING) })

    Row() {
    }.width('100%').layoutWeight(1).backgroundColor('rgba(0, 0, 0, 0.7)').onClick(this.hidden)
  }

  // 付款方式搜索 组件
  @Builder
  PaymentTypeRender() {
    Column() {
      Grid() {
        ForEach(this.paymentTypeData.paymentTypeList, (paymentType: string) => {
          GridItem() {
            Text(paymentType)
              .textStyles(this.paymentTypeData.paymentType === paymentType)
              .onClick(this.handlePaymentTypeChange.bind(this, paymentType))
          }
        }, (paymentType: string) => paymentType)
      }
      .columnsTemplate('1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr')
      .height(rvp(100))

      Row({ space: rvp(22) }) {
        Button('重置')
          .buttonStyles(rvp(95), '#F0F0F0', $r('app.color.gray_second'))
          .onClick(this.paymentTypeReset.bind(this))
        Button('查看房源')
          .buttonStyles(rvp(211), '#67C0A8', $r('app.color.white'))
          .onClick(this.paymentTypeSearch.bind(this))
      }.height(rvp(58)).width('100%').backgroundColor($r('app.color.white')).justifyContent(FlexAlign.Center)
    }
    .height(rvp(158))
    .width('100%')
    .backgroundColor($r('app.color.white'))
    .padding({ left: rvp(PADDING), right: rvp(PADDING) })

    Row() {
    }.width('100%').layoutWeight(1).backgroundColor('rgba(0, 0, 0, 0.7)').onClick(this.paymentTypeClose.bind(this))
  }

  // 排序搜索 组件
  @Builder
  SortRender() {
    Column() {
      Column() {
        ForEach(this.sortData.sortList, (sort: ISortItem) => {
          Row({ space: rvp(8) }) {
            Image(sort.icon).width(rvp(16))
            Text(sort.text)
              .fontSize(rvp(12))
              .fontColor(this.sortData.sort.id === sort.id ? '#67C0A8' : $r('app.color.gray_second'))
          }.height(rvp(34)).onClick(this.handleSortChange.bind(this, sort))
        }, (sort: ISortItem) => sort.id + '')
      }.padding({ left: rvp(20), top: rvp(8), bottom: rvp(16) }).alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .backgroundColor($r('app.color.white'))
    .padding({ left: rvp(PADDING), right: rvp(PADDING) })
    .alignItems(HorizontalAlign.Start)


    Row() {
    }.width('100%').layoutWeight(1).backgroundColor('rgba(0, 0, 0, 0.7)').onClick(this.sortClose.bind(this))
  }

  build() {
    Column() {
      Row() {
        ForEach(this.searchTypeList, (item: string) => {
          Row({ space: rvp(6) }) {
            Text(this.getSearchTypeName(item))
              .fontSize(rvp(12))
              .fontColor(this.currentSearchType === item ? '#67C0A8' : $r('app.color.black'))
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .constraintSize({
                maxWidth: rvp(60),
              })

            if (this.currentSearchType === item) {
              Image($r('app.media.arrow_down_3_active'))
                .imageStyles()
            } else {
              Image($r('app.media.arrow_down_3'))
                .imageStyles()
            }
          }.width('25%').height('100%').justifyContent(FlexAlign.Center).onClick(() => {
            this.chooseSearchType(item)
          })
        }, (item: string) => item)
      }
      .width('100%')
      .height(rvp(44))
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: rvp(44) })

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

@Extend(Image)
function imageStyles() {
  .width(rvp(12)).height(rvp(12)).objectFit(ImageFit.Fill)
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

@Extend(Text)
function textStyles(active: boolean) {
  .fontSize(rvp(12))
  .fontColor(active ? $r('app.color.white') : $r('app.color.gray_second'))
  .width(rvp(94))
  .height(rvp(26))
  .backgroundColor(active ? '#67C0A8' : $r('app.color.bg_gray'))
  .borderRadius(rvp(BORDER_RADIUS_S))
  .textAlign(TextAlign.Center)
}