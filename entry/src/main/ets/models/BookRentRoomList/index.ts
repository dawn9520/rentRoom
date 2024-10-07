export interface IBookRentRoomItem {
  "id": string
  "date": string
  "houseId": string
  "img": string
  "title": string
  "subTitle": string
  "distanceInfo": null | string,
  "rentPrice": string,
  "comment": string
}

export type IBookRentRoomList = IBookRentRoomItem[]

export interface IBookInfo {
  "name": string
  "date": string
  "houseId": string
  "phone": string
  "comment": string
}