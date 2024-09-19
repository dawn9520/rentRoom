export interface IHomeData {
  "bannerList": IBannerList
  "navList": INavList
  "tileList": ITileList
  "planList": IPlanList
  "adPicture": string
}

// 计划列表类型
export interface IPlanItem {
  "id": number
  "imageURL": string
}

export type IPlanList = IPlanItem[]

// 瓷片列表类型
export interface ITileItem {
  "id": number
  "imageURL": string
  "title": string
  "sub_title": string
}

export type ITileList = ITileItem[]

// 导航列表类型
export interface INavItem {
  "id": number
  "title": string
  "imageURL": string
}

export type INavList = INavItem[]

// 轮播图类型
export interface IBannerItem {
  "id": number
  "name": string
  "imageURL": string
}

export type IBannerList = IBannerItem[]