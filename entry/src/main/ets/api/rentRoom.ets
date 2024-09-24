import { http } from '../utils/http';
import type { IGetRentRoomListParams, IGetRentRoomListResponse } from '../models/RentRoomData';

// 获取租房列表数据
export const getRentRoomListApi = (params: IGetRentRoomListParams): Promise<IGetRentRoomListResponse> => {
  return http.get<IGetRentRoomListResponse>('/house/search', params)
}