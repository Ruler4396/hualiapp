/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * 导入 ArkUI 提供的提示和路由模块。
 * promptAction: 用于显示提示信息。
 * router: 用于页面跳转。
 */
import { promptAction, router } from '@kit.ArkUI';
import {AxiosResponse} from '@ohos/axios'
/**
 * 导入自定义的通用常量模块。
 * CommonConstants: 包含应用程序中使用的常量，如输入长度、间距等。
 */
import {CommonConstants} from '../common/constants/CommonConstants';
import {login,sendCode} from '../http/Api';
/**
 * 为 TextInput 组件扩展样式。
 * 定义了占位符颜色、高度、字体大小、背景色、宽度、边距等。
 */
@Extend(TextInput)
function inputStyle() {
  .placeholderColor($r('app.color.placeholder_color')) // 设置占位符颜色
  .height($r('app.float.login_input_height'))         // 设置输入框高度
  .fontSize($r('app.float.big_text_size'))            // 设置字体大小
  .backgroundColor($r('app.color.background'))        // 设置背景颜色
  .width(CommonConstants.FULL_PARENT)                 // 设置宽度为父组件的100%
  .padding({ left: CommonConstants.INPUT_PADDING_LEFT }) // 设置左内边距
  .margin({ top: $r('app.float.input_margin_top') })  // 设置上外边距
}

/**
 * 为 Line 组件扩展样式。
 * 定义了宽度、高度和背景色。
 */
@Extend(Line)
function lineStyle() {
  .width(CommonConstants.FULL_PARENT)                // 设置宽度为父组件的100%
  .height($r('app.float.line_height'))               // 设置线条高度
  .backgroundColor($r('app.color.line_color'))       // 设置线条背景颜色
}

/**
 * 为 Text 组件扩展蓝色文本样式。
 * 定义了字体颜色、大小和粗细。
 */
@Extend(Text)
function blueTextStyle() {
  .fontColor($r('app.color.login_blue_text_color'))  // 设置字体颜色为蓝色
  .fontSize($r('app.float.small_text_size'))         // 设置字体大小
  .fontWeight(FontWeight.Medium)                     // 设置字体粗细为中等
}

/**
 * 登录页面组件。
 * 使用 @Entry 装饰器标记为入口组件。
 */
@Entry
@Component
struct LoginPage {
  /**
   * 状态变量：账户输入内容。
   */
  @State account: string = '';                        // 初始化账户为空字符串

  /**
   * 状态变量：密码输入内容。
   */
  @State password: string = '';                       // 初始化密码为空字符串

  /**
   * 状态变量：是否显示加载进度条。
   */
  @State isShowProgress: boolean = false;             // 初始化不显示加载进度条

  /**
   * 私有变量：定时器 ID，用于管理登录延迟。
   */
  private timeOutId: number = -1;                     // 初始化定时器 ID 为 -1，表示未设置
  @StorageLink('token') token: string =''
  /**
   * 构建器：创建圆形图片按钮。
   * @param src 图片资源。
   */
  @Builder
  imageButton(src: Resource) {
    Button({ type: ButtonType.Circle, stateEffect: true }) { // 创建圆形按钮，启用状态效果
      Image(src)                                       // 在按钮内显示图片
    }
    .height($r('app.float.other_login_image_size'))    // 设置按钮高度
    .width($r('app.float.other_login_image_size'))     // 设置按钮宽度
    .backgroundColor($r('app.color.background'))       // 设置按钮背景颜色
  }

  /**
   * 登录方法：处理登录逻辑。
   * 检查账户和密码是否为空，若不为空则显示加载进度条并模拟登录。
   */
  /*
  login(): void {
    if (this.account === '' || this.password === '') { // 如果账户或密码为空
      promptAction.showToast({                        // 显示提示信息
        message: $r('app.string.input_empty_tips')    // 提示内容为“输入为空”
      });
    } else {                                          // 如果账户和密码均不为空
      if (this.account === '123' && this.password === '123456') {        // 如果定时器未设置

        router.replaceUrl({ url: 'pages/MainPage' }); // 跳转到主页面

      }else{
        promptAction.showToast({                        // 显示提示信息
          message: $r('app.string.incorrect_account_or_password')    // 提示内容为“输入为空”
        });
      }
    }
  }
*/
  async login(): Promise<void> {
    if (this.account === '' || this.password === '') { // 如果账户或密码为空
      promptAction.showToast({ // 显示提示信息
        message: $r('app.string.input_empty_tips') // 提示内容为"输入为空"
      });
    } else { // 如果账户和密码均不为空
      //todo: 登录
      const response: AxiosResponse = await login(this.account, this.password)
      this.token = response.data.data
      console.log('打印token', this.token)
      router.replaceUrl({ url: 'pages/MainPage' }); // 跳转到主页面
    }
  }
  /**
   * 页面即将消失时调用，清除定时器。
   */
  aboutToDisappear() {
    clearTimeout(this.timeOutId);                     // 清除定时器
    this.timeOutId = -1;                              // 重置定时器 ID
  }

  /**
   * 构建页面 UI。
   */
  build() {
    Column() {                                        // 使用列布局组织页面元素
      // Logo 图片
      Image($r("app.media.logo"))                     // 显示应用程序 logo
        .width($r('app.float.logo_image_size'))       // 设置 logo 宽度
        .height($r('app.float.logo_image_size'))      // 设置 logo 高度
        .margin({ top: $r('app.float.logo_margin_top'), bottom: $r('app.float.logo_margin_bottom') }) // 设置上下外边距

      // 页面标题
      Text($r('app.string.huali_college'))               // 显示“登录”标题
        .fontSize($r('app.float.page_title_text_size')) // 设置标题字体大小
        .fontWeight(FontWeight.Medium)                // 设置标题字体粗细
        .fontColor($r('app.color.title_text_color'))  // 设置标题字体颜色

      // 副标题
      Text($r('app.string.login_more'))               // 显示副标题
        .fontSize($r('app.float.normal_text_size'))   // 设置副标题字体大小
        .fontColor($r('app.color.login_more_text_color')) // 设置副标题字体颜色
        .margin({ bottom: $r('app.float.login_more_margin_bottom'), top: $r('app.float.login_more_margin_top') }) // 设置上下外边距

      // 账户输入框
      TextInput({ placeholder: $r('app.string.account') }) // 创建账户输入框，占位符为“账户”
        .maxLength(CommonConstants.INPUT_ACCOUNT_LENGTH) // 设置最大输入长度
        .type(InputType.Number)                        // 设置输入类型为数字
        .inputStyle()                                  // 应用自定义输入框样式
        .onChange((value: string) => {                 // 监听输入变化
          this.account = value;                        // 更新账户状态变量
        })
      // 分割线
      Line().lineStyle()                               // 添加分割线并应用自定义样式

      // 密码输入框
      TextInput({ placeholder: $r('app.string.password'),text:this.password }) // 创建密码输入框，占位符为“密码”
        .maxLength(CommonConstants.INPUT_PASSWORD_LENGTH) // 设置最大输入长度
        .type(InputType.Password)                      // 设置输入类型为密码
        .inputStyle()                                  // 应用自定义输入框样式
        .onChange((value: string) => {                 // 监听输入变化
          this.password = value;                       // 更新密码状态变量
        })
      // 分割线
      Line().lineStyle()                               // 添加分割线并应用自定义样式

      // 短信登录和忘记密码文本
      Row() {                                          // 使用行布局排列两个文本
        Text($r('app.string.message_login')).blueTextStyle() // 显示“短信登录”并应用蓝色样式
          .onClick(async () => {
            //todo: 获取验证码
            const response: AxiosResponse = await sendCode(this.account);
            this.password = response.data.data;
          })

        Text($r('app.string.forgot_password')).blueTextStyle() // 显示“忘记密码”并应用蓝色样式
      }
      .justifyContent(FlexAlign.SpaceBetween)          // 设置两端对齐
      .width(CommonConstants.FULL_PARENT)              // 设置宽度为父组件的100%
      .margin({ top: $r('app.float.forgot_margin_top') }) // 设置上外边距

      // 登录按钮
      Button($r('app.string.login'), { type: ButtonType.Capsule }) // 创建“登录”按钮，胶囊形状
        .width(CommonConstants.BUTTON_WIDTH)           // 设置按钮宽度
        .height($r('app.float.login_button_height'))   // 设置按钮高度
        .fontSize($r('app.float.normal_text_size'))    // 设置按钮字体大小
        .fontWeight(FontWeight.Medium)                 // 设置按钮字体粗细
        .backgroundColor($r('app.color.login_button_color')) // 设置按钮背景颜色
        .margin({ top: $r('app.float.login_button_margin_top'), bottom: $r('app.float.login_button_margin_bottom') }) // 设置上下外边距
        .onClick(() => {                               // 绑定点击事件
          this.login();                                // 调用登录方法
        })

      // 注册账户文本
      Text($r('app.string.register_account'))          // 显示“注册账户”
        .fontColor($r('app.color.login_blue_text_color')) // 设置字体颜色为蓝色
        .fontSize($r('app.float.normal_text_size'))    // 设置字体大小
        .fontWeight(FontWeight.Medium)                 // 设置字体粗细

      // 如果 isShowProgress 为 true，显示加载进度条
      if (this.isShowProgress) {                       // 根据状态变量决定是否显示
        LoadingProgress()                              // 创建加载进度条
          .color($r('app.color.loading_color'))        // 设置进度条颜色
          .width($r('app.float.login_progress_size'))  // 设置进度条宽度
          .height($r('app.float.login_progress_size')) // 设置进度条高度
          .margin({ top: $r('app.float.login_progress_margin_top') }) // 设置上外边距
      }

      // 空白区域，填充剩余空间
      Blank()                                          // 添加空白组件，占据剩余空间

      // 其他登录方式文本
      Text($r('app.string.other_login_method'))        // 显示“其他登录方式”
        .fontColor($r('app.color.other_login_text_color')) // 设置字体颜色
        .fontSize($r('app.float.little_text_size'))    // 设置字体大小
        .fontWeight(FontWeight.Medium)                 // 设置字体粗细
        .margin({ top: $r('app.float.other_login_margin_top'), bottom: $r('app.float.other_login_margin_bottom') }) // 设置上下外边距

      // 其他登录方式的图片按钮
      Row({ space: CommonConstants.LOGIN_METHODS_SPACE }) { // 使用行布局排列三个图片按钮，设置间距
        this.imageButton($r('app.media.login_method1')) // 创建第一个图片按钮
        this.imageButton($r('app.media.login_method2')) // 创建第二个图片按钮
        this.imageButton($r('app.media.login_method3')) // 创建第三个图片按钮
      }
    }
    // 设置背景色
    .backgroundColor($r('app.color.background'))       // 设置整个页面的背景颜色
    // 设置高度和宽度占满父组件
    .height(CommonConstants.FULL_PARENT)               // 设置高度为父组件的100%
    .width(CommonConstants.FULL_PARENT)                // 设置宽度为父组件的100%
    // 设置内边距
    .padding({                                         // 设置页面内边距
      left: $r('app.float.page_padding_hor'),          // 左内边距
      right: $r('app.float.page_padding_hor'),         // 右内边距
      bottom: $r('app.float.login_page_padding_bottom') // 下内边距
    })
  }
}