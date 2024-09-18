export interface IBannerItem {
  "id": number
  "name": string
  "imageURL": string
}

export type IBannerList = IBannerItem[]

export const bannerInfo: IBannerList = [
  {
    "id": 1,
    "name": "banner1",
    "imageURL": "app.media.banner1"
  },
  {
    "id": 2,
    "name": "banner2",
    "imageURL": "app.media.banner1"
  },
  {
    "id": 3,
    "name": "banner3",
    "imageURL": "app.media.banner1"
  },
  {
    "id": 4,
    "name": "banner4",
    "imageURL": "app.media.banner1"
  }
];

