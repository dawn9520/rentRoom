export interface IDanMuItem {
  "avatar": string
  "content": string
}

export type IDanMuList = IDanMuItem[]

export interface IMainPost {
  "followerNum": number
  "title": string
  "userAvatar": string
  "userName": string
  "postContent": string
}

export interface IContentBlockItem {
  img: string
}

export type IContentBlockList = IContentBlockItem[]

export interface IPostZone {
  "mainPost": IMainPost
  "contentBlockList": IContentBlockList
}

export interface IBenefitsItem {
  "title": string
  "img": string
}

export type IBenefits = IBenefitsItem[]

export interface IDiscoverData {
  "danMuList1": IDanMuList,
  "danMuList2": IDanMuList,
  "postZone": IPostZone,
  "benefits": IBenefits
}