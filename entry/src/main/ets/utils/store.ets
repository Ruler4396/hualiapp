// 导入 Context 类型，用于提供应用上下文
import { Context } from '@kit.AbilityKit';
// 导入 preferences 模块，用于实现数据的持久化存储
import preferences from '@ohos.data.preferences';
// 导入 MessageInfoModel 类，用于表示消息数据结构
import { MessageInfoModel } from '../models/message';
// 导入 DefaultUserList，表示默认用户列表
import { DefaultUserList } from '../models/user';
// 导入 emitter 模块，用于事件通知
import emitter from '@ohos.events.emitter';

// 定义 StoreClass 类，用于管理聊天消息的存储和操作
export class StoreClass {
  // 静态属性 context。存储应用上下文，用于编译存储操作
  static context: Context;
  // 静态属性 wechat_key，定义偏好存储的标识前缀，值为 "WECHAT_CHAT"
  static wechat_key: string = "WECHAT_CHAT";

  // 初始化方法，设置应用的上下文
  static init(context: Context) {
    // 将传入的 context 赋值给静态属性 context
    StoreClass.context = context;
  }

  // 获取指定用户的聊天消息存储实例
  static getUserStore(userId: string) {
    // 使用 preferences.getPreferencesSync 创建或获取用户的偏好存储
    // 存储在称为 wechat_key 和 userId 的路径，格式为 "WECHAT_CHAT_<userId>"
    return preferences.getPreferencesSync(StoreClass.context, { name: `${StoreClass.wechat_key}.${userId}` });
  }

  // 向指定用户的存储中添加一条消息
  static async addChatMessage(userId: string, message: MessageInfoModel) {
    // 获取指定用户的偏好存储实例
    const store = StoreClass.getUserStore(userId);
    // 使用消息 ID 作为地址，将消息对象序列化为 JSON 字符串并存储
    store.putSync(message.id, JSON.stringify(message));
    // 触发 WECHAT_CHAT 事件，通知其他组件消息已更新
    emitter.emit(StoreClass.wechat_key);
    // 异步刷新存储，确保数据持久化
    await store.flush();
  }

  // 获取指定用户的所有聊天消息
  static getChatMessage(userId: string) {
    // 获取指定用户的偏好存储实例
    const store = StoreClass.getUserStore(userId);
    // 获取存储中的所有通信对象，作为对象返回
    const all = store.getAllSync() as object;
    // 检查是否存在消息数据
    if (all) {
      // 将所有值（JSON 字符串）解析为 MessageInfoModel 对象，生成消息列表
      const list = Object.values(all).map((item: string) => JSON.parse(item) as MessageInfoModel);
      // 按发送时间排序（时间间隔显示）
      list.sort((a, b) => a.sendTime - b.sendTime);
      // 返回排序后的消息列表
      return list;
    }
    // 如果没有消息数据，返回空数组
    return [];
  }

  // 删除指定用户的一条消息
  static async removeChatMessage(userId: string, messageId: string) {
    // 获取指定用户的偏好存储实例
    const store = StoreClass.getUserStore(userId);
    // 删除指定消息 ID 对应的消息
    store.deleteSync(messageId);
    // 触发 WECHAT_CHAT 事件，通知其他组件消息已删除
    emitter.emit(StoreClass.wechat_key);
    // 异步刷新存储，确保数据变更持久化
    await store.flush();
  }

  // 删除指定用户的所有消息
  static async removeChatAllMessage(userId: string) {
    // 删除指定用户的整个偏好存储
    preferences.deletePreferences(StoreClass.context, { name: `${StoreClass.wechat_key}.${userId}` });
    // 触发 WECHAT_CHAT 事件，通知其他组件消息已清除
    emitter.emit(StoreClass.wechat_key);
  }

  // 获取所有用户的最后一条消息
  static getAllChatLastMessage() {
    // 创建空数组。用于存储每个用户的最后一条消息
    const lastList: MessageInfoModel[] = [];
    // 遍历 DefaultUserList 中的每个用户
    DefaultUserList.forEach(user => {
      // 获取当前用户的消息列表
      const chatList = StoreClass.getChatMessage(user.user_id);
      // 如果消息列表卡空，取最后一条消息（最新的消息）
      if (chatList.length) {
        lastList.push(chatList[chatList.length - 1]);
      }
    });
    // 按发送时间开启并执行消息列表
    lastList.sort((a, b) => a.sendTime - b.sendTime);
    // 返回排序后的最后消息列表
    return lastList;
  }
}