import http from '@ohos.net.http' // 导入 http 模块，用于发送网络请求
import { ChatResponse } from '../models/chats' // 导入 ChatResponse 类型，用于定义相关网络的默认级别


// 创建一个 HTTP 对象，用于创建起始网络请求
const req = http.createHttp()

// 定义一个跨界函数 requestMessage，用于发送消息与最近聊天请求
export async function requestMessage(content: string) {
  try {
    // 响应请求 URL 包含 appId userid 和 spoken 参数，其中 spoken 参数的值为传入的 content 参数经过 encoded时[Component 循环]得到
    const res = await req.request(`https://api.sizhi.com/chat?appid=4dce5bf34b7c4d7d9eb25ab35d896dbe&userid=AZ79801&spoken=${encodeURIComponent(content)}`)
    // 响应请求的 result 时间时间为 JSON，请求时间为 ChatResponse 类型
    const result = JSON.parse(res.result as string) as ChatResponse

    // 返回帧时的消息
    return result
  } catch (error) {
    // 如果发生错误，造成一个新的消息 Promise，包含错误信息
    return Promise.reject(error)
  }
}