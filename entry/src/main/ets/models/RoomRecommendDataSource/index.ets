export interface ITagItem {
  "name": string
}

export type ITagList = ITagItem[]


export interface IRoomRecommendItem {
  "id": string
  "housePicture": string
  "tags": ITagList
  "houseTitle": string
  "address": string
  "rentArea": string
  "rentPriceUnit": string
  "rentPriceListing": string
}


export type IRoomRecommendList = IRoomRecommendItem[]


export class RoomRecommendDataSource implements IDataSource {
  roomRecommendList: IRoomRecommendList = []

  constructor(roomRecommendList: IRoomRecommendList) { // 外部传入的数据
    this.roomRecommendList = roomRecommendList;
  }

  getData(index: number) {
    return this.roomRecommendList[index];
  }

  totalCount() {
    return this.roomRecommendList.length;
  }

  registerDataChangeListener() {
  }

  unregisterDataChangeListener() {
  }
}