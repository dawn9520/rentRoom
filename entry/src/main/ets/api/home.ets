import { http } from '../utils/http';
import type { IHomeData } from '../model/HomeData';

// 获取首页数据
export const getHomeDataApi = (): Promise<IHomeData> => {
  return http.get<IHomeData>('/home/info');
}