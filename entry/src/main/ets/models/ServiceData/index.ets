export type IVipServiceList = IVipServiceItem[]

export interface IVipServiceItem {
  "name": string
  "content": number
}

export interface IHomeServiceItem {
  "icon": string
  "title": string
}

export type IHomeServiceList = IHomeServiceItem[]

export interface IServiceActivity {
  "name": string
  "img": string
  "title": string
  "subTitle": string
}

export interface ICleaningServiceInfoItem {
  "img": string
  "title": string
  "subTitle": string
  "originalPrice": string
  "priceAfterDiscounts": string
}

export type ICleaningServiceInfoList = ICleaningServiceInfoItem[]


export interface INewcomerZone {
  "img": string
}

export interface IServiceData {
  "vipServiceList": IVipServiceList
  "homeServiceList": IHomeServiceList
  "serviceActivity": IServiceActivity
  "newcomerZone": INewcomerZone
  "cleaningServiceInfo": ICleaningServiceInfoList
}