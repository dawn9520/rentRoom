import type { IRoomRecommendItem } from '../RoomRecommendDataSource'

export type IPaymentType = "月付" | "季付" | "半年付" | "年付"

export type IOrderBy = "面积" | "价格"

export type IOrderType = "asc" | "desc"

export interface IGetRentRoomListParams {
  "page": number
  "limit": number
  "provinceId"?: string
  "cityId"?: string
  "districtId"?: string
  "minRent"?: string
  "maxRent"?: string
  "paymentType"?: IPaymentType
  "orderBy"?: IOrderBy,
  "orderType"?: IOrderType
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
  private listeners: DataChangeListener[] = [];
  data: IRentRoomList = [];

  constructor(list: IRentRoomList) {
    this.data = list;
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
    this.notifyDataAdd(this.data.length - 1)
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