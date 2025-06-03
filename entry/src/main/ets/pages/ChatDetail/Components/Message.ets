// 导入消息相关的数据模型 MessageInfo 和 MessageInfoModel
import { MessageInfo, MessageInfoModel } from '../../../models/message';
// 导入当前用户信息 currentUser
import { currentUser } from '../../../models/user';

// 标记组件为预览模式，用于开发工具中的实时预览
@Preview
  // 声明 Message 是一个 UI 组件
@Component
export struct Message {
  // 定义必需的属性 currentMessage，表示当前消息的数据模型，默认为空消息对象
  @Prop
  @Require
  currentMessage: MessageInfoModel = new MessageInfoModel({} as MessageInfo);
  // 定义状态变量 showPopup，控制是否显示浮层（弹出菜单），默认为 false
  @State
  showPopup: boolean = false;

  // 定义删除消息的回调函数，接收消息 ID 作为参数，默认为空实现
  delMessage: (messageId: string) => void = () => {};

  // 判断消息是否由当前用户发送
  isSelf(): boolean {
    // 比较当前用户的 user_id 与消息发送者的 user_id，返回 true 表示自己发送
    return currentUser.user_id == this.currentMessage.sendUser.user_id;
  }

  // 定义组件的 UI 构建方法
  @Builder
  build() {
    // 创建水平布局 (Row) 作为消息容器
    Row() {
      // 显示发送者头像
      Image(this.currentMessage.sendUser.avatar)
        // 设置头像宽度为 40 像素
        .width(40)
          // 设置头像高度为 40 像素
        .height(40)
          // 设置头像圆角半径为 6 像素
        .borderRadius(6);

      // 创建内层水平布局 (Row)，用于显示消息内容
      Row() {
        // 创建垂直布局 (Column)，用于包裹消息文本
        Column() {
          // 显示消息内容
          Text(this.currentMessage.messageContent)// 根据是否为当前用户发送，设置不同背景颜色（自己发送的用主色，别人发送的白色）
            .backgroundColor(this.isSelf() ? $r('app.color.second_primary') : $r('app.color.white'))
              // 设置文本颜色为主文本颜色
            .fontColor($r('app.color.text_primary'))// 设置内边距为 10 像素
            .padding(10)
              // 设置行高为 24 像素
            .lineHeight(24)
              // 设置左右外边距离为 10 像素
            .margin({
              left: 10,
              right: 10,
            })
              // 设置文本框圆角半径为 5 像素
            .borderRadius(5);
        }

        // 为 Column 添加长按手势，触发时显示浮层
        .gesture(
          LongPressGesture().onAction(event => {
            this.showPopup = true; // 显示浮层
          })
        );
      }
        // 设置内层 Row 的布局权重为 6，占据大部分空间
        .layoutWeight(6)
          // 根据是否为当前用户发送，设置内容对齐方式（自己发送靠右，别人发送靠左）
          .justifyContent(this.isSelf() ? FlexAlign.End : FlexAlign.Start);

        // 占位 Text 组件，权重为 1，用于填充剩余空间
        Text().layoutWeight(1);
      }
      // 设置外层 Row 宽度为 100%（充满父容器）
      .width('100%')
      // 设置外层 Row 的内边距，左右各 20 像素
      .padding({
        left: 20,
        right: 20,
      })
      // 设置垂直对齐方式为顶部对齐
      .alignItems(VerticalAlign.Top)
      // 根据是否为当前用户发送，设置布局方向（自己发送从右到左，别人发送从左到右）
      .direction(this.isSelf() ? Direction.Rtl : Direction.Ltr);
    }
  }
