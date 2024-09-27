import type { IRoomRecommendItem } from '../RoomRecommendDataSource'

export type IPaymentType = "月付" | "季付" | "半年付" | "年付"

export type IOrderBy = "面积" | "价格"

export type IOrderType = "asc" | "desc"

export interface IGetRentRoomListParams {
  "page": number
  "limit": number
  "provinceCode"?: string
  "cityCode"?: string
  "districtCode"?: string
  "minRent"?: string
  "maxRent"?: string
  "paymentType"?: string
  "orderBy"?: string,
  "orderType"?: string
}

export interface IGetRentRoomListResponse {
  records: IRentRoomList
  total: number
}

export interface IActivity {
  "title": string
  "textColor": string
  "textBackGroundColor": string
  "#text": string
  "icon": string
}

export interface IRentRoomItem extends IRoomRecommendItem {
  "activity"?: IActivity
}

export type IRentRoomList = IRentRoomItem[]


export class RentRoomListDataSource implements IDataSource {
  data: IRentRoomList = [];
  private listeners: DataChangeListener[] = [];

  constructor(list: IRentRoomList) {
    this.pushDataList(list);
  }

  public totalCount(): number {
    return this.data.length;
  }

  public getData(index: number) {
    return this.data[index];
  }

  // 增加数据
  public pushData(item: IRentRoomItem) {
    this.data.push(item);
    this.notifyDataAdd(this.data.length - 1);
  }

  // 增加数据列表
  public pushDataList(list: IRentRoomList) {
    list.forEach(item => {
      this.pushData(item);
    })
  }

  // 重新加载数据
  public reloadDataList(list: IRentRoomList): void {
    this.data = list
    this.notifyDataReload()
  }

  // 该方法为框架侧调用，为LazyForEach组件向其数据源处添加listener监听
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener);
    }
  }

  // 该方法为框架侧调用，为对应的LazyForEach组件在数据源处去除listener监听
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      this.listeners.splice(pos, 1);
    }
  }

  // 通知LazyForEach组件需要重载所有子组件
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded();
    })
  }

  // 通知LazyForEach组件需要在index对应索引处添加子组件
  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index);
    })
  }

  // 通知LazyForEach组件在index对应索引处数据有变化，需要重建该子组件
  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index);
    })
  }

  // 通知LazyForEach组件需要在index对应索引处删除该子组件
  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index);
    })
  }
}

export interface IProvinceItem {
  code: string;
  name: string;
}

export type IProvinceList = IProvinceItem[]

export interface ICityItem {
  "code": string
  "name": string
  "provinceCode": string
}

export type ICityList = ICityItem[]

export interface IDistrictItem {
  "code": string
  "name": string
  "cityCode": string
  "provinceCode": string
}

export type IDistrictList = IDistrictItem[]

export interface GetCityListParams {
  provinceCode: string
}

export interface GetDistrictListParams {
  cityCode: string
}

export interface IRentPriceItem {
  id: number;
  minRent: string;
  maxRent: string;
  text: string;
}

export interface IRentPriceList {
  rentPriceList: IRentPriceItem[]
  rentPrice: object
  isSearch: boolean
  searchRentPrice: object
}

export interface ISortItem {
  id: number;
  icon: Resource;
  text: string;
  orderBy: IOrderBy;
  orderType: IOrderType;
}

export type ISortList = ISortItem[]


// 详情数据type
export interface IHousePictureItem {
  "spaceName": string
  "picList": string[]
}

export type IHousePictureList = IHousePictureItem[]

export interface IDistanceInfo {
  "distance": string
  "line": string
  "name": string
}

export interface IRentTerm {
  "checkInTime": string
  "term": string
  "kitchen": string
  "lift": string
  "seeTime": string
  "year": string
  "renovation": string
  "grounding": string
  "heating": string
  "green": string
  "protection": string
  "house": string
}

export interface IMetaInfoItem {
  "name": string
  "desc": string
}

export type IMetaInfoList = IMetaInfoItem[]

export interface IDiscountsItem {
  "tagTxtBgAroundColor": string
  "image": string
  "txt": string
  "tagTxt": string
  "tagTxtColor": string
}

export type IDiscountsList = IDiscountsItem[]

export interface IDiscountsItemListItem {
  "icon": string
  "value": string
}

export interface IHouseholdItem {
  "name": string
  "itemList": IDiscountsItemListItem[]
}

export type IHouseholdList = IHouseholdItem[]

export interface ISupportItem {
  "image": string
  "title": string
  "subTitle": string
}

export type ISupportList = ISupportItem[]

export interface IRentInfoItem {
  "image": string
  "title": string
  "userTag": string
}

export type IRentInfoList = IRentInfoItem[]

export interface IRentRoomDetail extends Omit<IRentRoomItem, 'housePicture'> {
  "housePicture": IHousePictureList
  "distance_info": IDistanceInfo
  "rentTerm": IRentTerm
  "metaInfo": IMetaInfoList
  "discounts": IDiscountsList
  "householdItem": IHouseholdList
  "support": ISupportList
  "rentInfo": IRentInfoList
  "houseTitle": string
  "address": string
  "rentPriceUnit": string

}

export interface IRentRoomDetailParams {
  id: string
}
