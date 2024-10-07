export interface IBookRentRoomItem {
  "id": number
  "userId": number
  "houseId": string
  "date": string
  "name": string
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