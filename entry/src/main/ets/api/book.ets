import { http } from '../utils/http';
import type { IGetRentRoomListParams, IGetRentRoomListResponse } from '../models/RentRoomData';

import type { IBookRentRoomList } from '../models/BookRentRoomList';

// 获取预约租房列表
export const getBookRentRoomListApi = (): Promise<IBookRentRoomList> => {
  return http.get<IBookRentRoomList>('/auth/house/history')
}

// 获取租房列表数据
export const getRentRoomListApi = (params: IGetRentRoomListParams): Promise<IGetRentRoomListResponse> => {
  return http.get<IGetRentRoomListResponse>('/house/search', params)
}

