// 定义 ChatResponse 接口，用于描述聊天机器人返回的响应数据结构
export interface ChatResponse {
  // 消息提示信息，通常用于指示请求的成功或失败状态
  message: string,

  // 聊天数据对象，包含更详细的聊天内容和相关信息
  data: ChatData
}

// 定义 ChatData 接口，用于描述聊天数据的详细结构
export interface ChatData {
  // 聊天消息的类型，通常是一个数值，用于区分不同类型的消息（如文本、图片等）
  type: number,

  // 聊天消息的详细信息对象，包含具体的聊天内容
  info: ChatInfo

}

// 定义 ChatInfo 接口，用于描述聊天消息的详细信息结构
export interface ChatInfo{
  // 聊天消息的文本内容，即实际显示给用户的聊天内容
  text: string
}