// 导入 UserInfo 类型，用于表示用户信息
import { UserInfo } from './user';
// 导入 util 模块，来自 ArkTS 工具包，提供实用功能（如生成 UUID）
import { util } from '@kit.ArkTS';

// 定义消息类型的枚举，表示不同类型的消息
export enum MessageTypeEnum {
  TEXT, // 文本消息
  IMAGE, // 图片消息
  AUDIO, // 音频消息
  VIDEO, // 视频消息
  LOCATION, // 定位消息
  LINK, // 链接消息
}
  // 定义消息信息的接口，描述消息的结构
  export interface MessageInfo {
    id: string; // 消息的唯一标识
    sendUser: UserInfo; // 消息的发送者信息
    connectUser: UserInfo; // 消息的归属者信息（可能指接收者或关联用户）
    messageContent: string; // 消息内容，例如文本内容、“[图片]”或“[7秒语音]”
    sendTime: number; // 消息发送时间（时间戳）
    messageType: MessageTypeEnum; // 消息类型，引用 MessageTypeEnum 枚举
    sourceFilePath: string; // 音频、视频或图片的文件路径
    sourceDuration: number; // 音频或视频的时长，单位为秒
  }
  // 定义 MessageInfoModel 类，实现 MessageInfo 接口。用于创建和管理消息对象
  export class MessageInfoModel implements MessageInfo {
  // 初始化消息 ID，默认为空字符串
  id: string = '';
  // 初始化发送者信息，默认为空对象（类型断言为 UserInfo）
  sendUser: UserInfo = {} as UserInfo;
  // 初始化归属者信息，默认为空对象（类型断言为 UserInfo）
  connectUser: UserInfo = {} as UserInfo;
  // 初始化消息内容，默认为空字符串
  messageContent: string = '';
  // 初始化发送时间，默认为 0
  sendTime: number = 0;
  // 初始化消息类型，默认为 TEXT 类型
  messageType: MessageTypeEnum = MessageTypeEnum.TEXT;
  // 初始化文件路径，默认为空字符串
  sourceFilePath: string = '';
  // 初始化音视频时长，默认为 0
  sourceDuration: number = 0;

  // 构造函数，接收一个 MessageInfo 对象来初始化实例
  constructor(model: MessageInfo) {
    // 设置消息 ID，如果传入的 model.id 存在则使用，否则生成随机 UUID
   this.id = model.id || util.generateRandomUUID();
    // 设置发送者信息，直接使用传入的 sendUser
    this.sendUser = model.sendUser;
     // 设置归属者信息，直接使用传入的 connectUser
    this.connectUser = model.connectUser;
    // 设置消息内容，直接使用传入的 messageContent
    this.messageContent = model.messageContent;
    // 设置发送时间，如果传入的 model.sendTime 存在则使用，否则使用当前时间戳
    this.sendTime = model.sendTime || Date.now();
    // 设置消息类型，如果传入的 model.messageType 存在则使用，否则默认为 TEXT
    this.messageType = model.messageType || MessageTypeEnum.TEXT;
    // 设置文件路径，直接使用传入的 sourceFilePath
    this.sourceFilePath = model.sourceFilePath;
    // 设置音视频时长，直接使用传入的 sourceDuration
    this.sourceDuration = model.sourceDuration;
  }
}