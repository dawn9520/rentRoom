import { http } from '../utils/http';

import { IUserInfo } from '../models/UserData';

// 发送验证码
export const sendSMSCodeApi = (phone: string): Promise<string> => {
  return http.post<string>('/sendSMSCode', { phone })
}

interface RresData {
  token: string
}

// 登录
export const loginApi = (phone: string, code: string): Promise<RresData> => {
  return http.post<RresData>('/login', { phone, code })
}

// 获取用户数据
export const getUserInfoApi = (): Promise<IUserInfo> => {
  return http.get<IUserInfo>('/auth/user/userInfo')
}