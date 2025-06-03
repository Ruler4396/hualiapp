// 导入 router 模块，用于页面导航（如返回上一页、获取路由参数）
import { router } from '@kit.ArkUI';
// 导入 MessageInfoModel 类，用于表示消息数据结构
import { MessageInfo,MessageInfoModel } from '../../models/message';
// 导入 UserInfo 类型，用于表示用户信息
import { currentUser,UserInfo } from '../../models/user';
// 导入 BottomInputs 组件，用于实现聊天输入栏（支持文本和语音输入）
import BottomInputs from './Components/BottomInputs';
// 导入 Message 组件，用于显示单条消息
import { Message } from './Components/Message';
import {StoreClass} from '../../utils/store';
import {requestMessage} from  '../../utils/request';

// 标记 ChatDetail 为主入口组件，表示这是页面级的主组件
@Entry
  // 声明 ChatDetail 是一个 UI 组件
@Component
struct ChatDetail {
  // 定义状态变量 talker，存储聊天对象的信息，初始化为空对象（类型断言为 UserInfo）
  @State
  talker: UserInfo = {} as UserInfo;

  // 定义状态变量 messageList，存储消息列表，初始化为空数组
  @State
  messageList: MessageInfoModel[] = [];

  // 定义状态变量 talkingInputIng，表示对方是否正在输入，初始化为 false
  @State
  talkingInputIng: boolean = false;

  // 创建 Scroller 实例，用于控制消息列表的滚动行为
  scroller: Scroller = new Scroller();

  // 生命周期方法，在组件即将显示时调用
  aboutToAppear(): void {
    // 从路由参数中获取聊天对象信息，并赋值给 talker
    // router.getParams() 返回路由传递的参数，类型断言为 UserInfo
    this.talker = router.getParams() as UserInfo;
    // 如果聊天对象存在且有用户 ID，则从本地存储中获取与该用户的聊天记录
    if (this.talker && this.talker.user_id) {
      this.messageList = StoreClass.getChatMessage(this.talker.user_id);
    }
  }

  // 定义删除消息的方法，接收消息 ID 作为参数
  delMessage(messageId: string) {
    // 在 messageList 中查找指定 messageId 的消息索引
    let index = this.messageList.findIndex(item => item.id === messageId);
    // 从 messageList 中删除索引对应的消息（移除 1 项）
    this.messageList.splice(index, 1);
  }

  // 构建组件的 UI 结构
  build() {
    // 创建垂直布局（Column）作为页面主容器
    Column() {
      // 创建相对布局容器（RelativeContainer），用于顶部导航栏
      RelativeContainer() {
        // 显示返回箭头图标
        Image($r('app.media.ic_public_arrow_left'))// 设置图标宽度为 30 像素
          .width(30)// 设置图标高度为 30 像素
          .height(30)// 设置相对布局规则，使图标垂直居中子容器
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
          })// 设置左外边距为 10 像素
          .margin({ left: 10 })// 确定点击事件，点击时间用 router.back() 返回上一页
          .onClick(() => {
            router.back();
          });

        // 显示聊天对象用户名或"对方正在输入..."提示
        Text(this.talkingInputIng ? '对方正在输入...' :
        this.talker.username)// 设置文本的 ID 为 'ChatDetailHelloWorld'，便于调试或测试
          .id('ChatDetailHelloWorld')// 设置字体大小为 16 像素
          .fontSize(16)// 设置字体加粗
          .fontWeight(FontWeight.Bold)// 设置相对布局规则，使文本水平和垂直居中子容器
          .alignRules({
            middle: { anchor: '__container__', align: HorizontalAlign.Center },
            center: { anchor: '__container__', align: VerticalAlign.Center },
          });
      }
          // 设置导航栏高度为 50 像素
        .height(50)
          // 设置导航栏宽度为 100%，充满父容器
        .width('100%');

      // 创建消息列表（List），设置列表项间距为 20 像素，并绑定 scroller 控制滚动
      List({ space: 20, scroller: this.scroller }) {
        // 使用 ForEach 遍历 messageList，动态生成消息列表项
        ForEach(this.messageList, (item: MessageInfoModel) => {
          // 创建单个列表项（ListItem）
          ListItem() {
            // 渲染 Message 组件，显示单条消息
            Message({
              // 传入当前消息数据
              currentMessage: item,
              // 传入删除消息的回调函数，调用父组件的 deLMessage 方法
              delMessage: (messageId) => {
                this.delMessage(messageId);
              },
            });
          }
        });
      }
      // 设置消息列表背景颜色，使用资源定义的背景色
      .backgroundColor($r('app.color.back_color'))
      // 设置消息列表占用剩余空间（权重为 1）
      .layoutWeight(1)
      // 设置消息列表宽度为 100%，充满父容器
      .width('100%')
      // 设置消息列表上下内边距为 10 像素
      .padding({
        top: 10,
        bottom: 10,
      });

      // 渲染 BottomInputs 组件，作为聊天输入栏
      BottomInputs({
        // 传入聊天对象信息
        talker: this.talker,
        //定义sendTextMessage 回调函数，处理用户输入的文本消息
        sendTextMessage: (content:string) => {
            this.sendTextMessage(content);
        },

      });
    }
    // 设置主 Column 高度为 100%，充满父容器
    .height('100%')
    // 设置主 Column 宽度为 100%，充满父容器
    .width('100%');
  }

  // 定义异步方法 sendTextMessage。处理文本消息的发送逻辑
  async sendTextMessage(content: string) {
    // 创建新消息对象。使用 MessageInfoModel 构造函数
    // 设置消息内容（content）、接收者（connectUser）、发送者（sendUser），其他字段由 MessageInfoModel 默认填充
    let message = new MessageInfoModel({
      messageContent: content,
      connectUser: this.talker,
      sendUser: currentUser
    } as MessageInfo);
    // 将新消息添加到 messageList 状态。触发 UI 更新以显示消息
    this.messageList.push(message);
    // 调用 StoreClass 的 addChatMessage 方法，将消息持久化存储到指定用户的网络存储
    await StoreClass.addChatMessage(this.talker.user_id, message);
    // 将消息列表滚动到底部。显示最新消息
    this.scroller.scrollEdge(Edge.Bottom);

    //请求聊天机器人的相应消息
    this.getResponseMessage(content)
  }

  // 获取聊天机器人的响应消息的方法
  async getResponseMessage(content: string) {
    // 设置对方正在输入的状态为 true，显示"对方正在输入..."的提示
    this.talkingInputIng = true;

    // 调用 requestMessage 函数向聊天机器人发送请求，并获取响应结果
    const result = await requestMessage(content);

    // 根据响应结果创建一个新的消息模型实例，表示聊天机器人的回复
    let message = new MessageInfoModel({
      sendUser: this.talker,
      messageContent: result.data?.info?.text,
      connectUser: currentUser,
    } as MessageInfo);

    // 将聊天机器人的回复添加到消息列表中
    this.messageList.push(message);

    // 将聊天机器人的回复保存到本地存储中
    await StoreClass.addChatMessage(this.talker.user_id, message);

    // 滚动到聊天列表的底部，确保新消息可见
    this.scroller.scrollEdge(Edge.Bottom);

    // 设置对方正在输入的状态为 false，隐藏"对方正在输入..."的提示
    this.talkingInputIng = false;
  }
}