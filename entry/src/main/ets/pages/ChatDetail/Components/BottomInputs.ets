// 导入 display 模块，用于获取屏幕尺寸信息
import display from '@ohos.display';
// 导入 UserInfo 类型，用于表示用户信息
import { UserInfo } from '../../../models/user';
// 导入 promptAction 模块，用于显示提示或弹窗（在本代码中未直接使用）
import { promptAction } from '@kit.ArkUI';

// 标记组件为预览模式，用于开发工具中的实时预览
@Preview

  // 声明 BottomInputs 是一个 UI 组件
@Component
struct BottomInputs {
  // 定义状态变量 showVoice，控制是否显示语音输入模式，默认为 false（文本输入模式）
  @State
  showVoice: boolean = false; // 是否发送语音
  // 定义状态变量 content，存储用户输入的文本内容，默认为空字符串
  @State
  content: string = ""; // 输入内容

  //------
  sendTextMessage: (content: string) =>void =() => {
  }//发送信息

  // 定义状态变量 showVoiceCom，控制语音组件的显示，默认为 false
  @State
  showVoiceCom: boolean = false;
  // 定义使用者变量 (@Provide)，允许子组件访问。但在本代码中未明确使用
  @Provide
  // voiceState: VoiceRecordEnum = VoiceRecordEnum.Recording; // 当前录音状态（被注释，未使用）
  // 定义屏幕宽度，初始值为 0
  screenWidth: number = 0; // 记录整体宽度
  // 定义屏幕高度，初始值为 0
  screenHeight: number = 0; // 记录整体高度
  // 定义临时录音文件路径，默认为空字符串
  tempAudioPath: string = ""; // 临时录音变量
  // 定义录音时长，初始值为 0
  duration: number = 0;
  // 定义定时器标记，初始值为 -1
  timer: number = -1; // 定时器标记

  // 定义必需的属性 `talker`，类型为 `UserInfo`。表示聊天对象
  @Require
  @Prop
  talker: UserInfo;

  // 生命周期方法，在组件即将显示时调用
  aboutToAppear(): void {
    // 获取默认屏幕的宽度（像素），并转换为虚拟像素（VP）单位
    this.screenWidth = px2vp(display.getDefaultDisplaySync().width);
    // 获取默认屏幕的高度（像素），并转换为虚拟像素（VP）单位
    this.screenHeight = px2vp(display.getDefaultDisplaySync().height);
  }

  // 生命周期方法，在组件即将消失时调用（此处为空实现）
  aboutToDisappear(): void {}

  // 构建组件的 `UI` 结构
  build() {
    // 创建垂直布局（Column）
    Column() {
      // 创建水平布局（Row），子组件间距为 10
      Row({ space: 10 }) {
      // 显示切换图标，根据 showVoice 状态显示键盘或语音图标
      Image(this.showVoice ? $r('app.media.ic_public_keyboard') : $r('app.media.ic_public_sound'))
        // 设置图标宽度为 25 像素
        .width(25)
          // 设置图标高度为 25 像素
        .height(25)
          // 绑定点击事件，切换 showVoice 状态（文本/语音模式）
        .onClick(() => {
          this.showVoice = !this.showVoice;
        });

      // 根据 showVoice 状态动态渲染语音按钮或文本输入框
      if (this.showVoice) {
        // 语音模式：显示"按住 说话"按钮
        Button("按住 说话", { type: ButtonType.Normal })
          // 设置按钮高度为 35 像素
          .height(35)
            // 设置按钮占用剩余空间（权重为 1）
          .layoutWeight(1)
            // 设置按钮圆角半径为 2
          .borderRadius(2)
            // 设置按钮背景颜色为白色
          .backgroundColor(Color.White)
            // 设置按钮文字颜色，使用资源定义的主文本颜色
          .fontColor($r('app.color.text_primary'))
            // 设置按钮内容居中对齐
          .align(Alignment.Center);
      } else {
        // 文本模式：显示文本输入框
        TextInput({ text: $$this.content })
          // 设置输入框高度为 35 像素
          .height(35)
            // 设置输入框占用剩余空间（权重为 1）
          .layoutWeight(1)
            // 设置输入框圆角半径为 2
          .borderRadius(2)
            // 设置输入框背景颜色为白色
          .backgroundColor(Color.White)
            // 设置输入框可聚焦
          .focusable(true)
            // 设置输入框默认获取焦点
          .defaultFocus(true)
            // 设置输入框的 ID 为 "input"
          .id("input")
          .onSubmit(() => {
            if (this.content) {
              this.sendTextMessage(this.content) //调用send，传递输入内容
              this.content = "" //清空输入框内容
              focusControl.requestFocus("input") //重新聚焦输入框
            }
          })
      }

        // 显示"添加"图标（可能用于附加功能，如发送图片）
        Image($r('app.media.ic_public_add_norm'))
          // 设置图标宽度为 25 像素
          .width(25)
            // 设置图标高度为 25 像素
          .height(25);
      }
      // 设置 Row 的内边距，左右各 10 像素
      .padding({
        left: 10,
        right: 10,
      })
      // 设置 Row 高度为 60 像素
      .height(60)
      // 设置 Row 宽度为 100%（充满父容器）
      .width('100%');
    }
    // 设置 Column 的背景颜色，使用资源定义的次要背景颜色
    .backgroundColor($r('app.color.second_back_color'));
  }
}
// 导出 BottomInput 组件作为默认导出
 export default BottomInputs;

