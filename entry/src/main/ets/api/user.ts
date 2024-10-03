import { http } from '../utils/http';

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
