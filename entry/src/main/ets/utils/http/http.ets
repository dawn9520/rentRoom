import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';

const request = axios.create({
  baseURL: 'http://172.17.0.195:6060', // 通过 ipconfig 查询当前电脑的 ip，使用自己电脑的 ip 地址
  timeout: 20000,
})

// 请求前的一些配置
request.interceptors.request.use(
  (config: InternalAxiosRequestConfig) => {
    // 未来需要添加 token
    // config.headers.token = token;
    return config;
  }
)

// 接口返回结果处理
request.interceptors.response.use(
  (response: AxiosResponse) => {
    if (response.data.code === 200) {
      return response.data.data;
    } else {
      return Promise.reject(response.data.message);
    }
  },
  (error: AxiosError) => {
    return Promise.reject(error.message);
  }
)

// 请求类型定义
export default class Http {
  get<T>(url: string, params?: Object) {
    return request.get<null, T>(url, {
      params
    })
  }

  post<T>(url: string, data?: Object) {
    return request.post<null, T>(url, data)
  }

  put<T>(url: string, data?: Object) {
    return request.put<null, T>(url, data)
  }

  delete<T>(url: string, params?: Object) {
    return request.delete<null, T>(url, {
      params
    })
  }
};