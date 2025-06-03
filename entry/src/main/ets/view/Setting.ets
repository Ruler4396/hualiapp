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
// 这段代码通过 ArkUI 框架构建了一个功能完整的设置页面，包含标题、账户信息、设置选项列表和操作按钮。
// 代码结构清晰，使用了组件化设计和数据绑定，使得页面内容易于管理和扩展。每个部分都通过布局组件（如 Row、Column、List）
// 和样式属性精心组织，提供了良好的用户体验。

import {CommonConstants} from '../common/constants/CommonConstants';
// 导入通用常量模块，包含应用程序中使用的常量值，例如宽度、高度、间距等。

import ItemData from '../viewmodel/ItemData';
// 导入数据模型 ItemData，用于定义设置项的数据结构，例如图标、标题等。

import mainViewModel from '../viewmodel/MainViewModel';
// 导入主视图模型 mainViewModel，提供设置页面所需的数据，例如设置项列表数据。
import { PersonalInformation } from '../pages/PersonalInformation';
/**
 * Setting tab content
 * 设置标签页内容
 */
@Component
  // 使用 @Component 装饰器，标记该结构体为一个 UI 组件。
export default struct Setting {
  // 定义并导出 Setting 组件，作为设置页面的主组件。

  @Provide('NavPathStack') pathStack: NavPathStack = new NavPathStack();
  @StorageLink('nikeName') nikeName: string = '昵称';
  @StorageLink('email') email: string = '123456@163.com';
  @StorageLink('picture') picture: string = '';
  @StorageLink('flag') flag : Boolean = false;

  @Builder
  PagesMap(name:string) {
    if (name === 'PersonalInformation') {
      PersonalInformation()
    }
  }
  @Builder settingCell(item: ItemData) {
    // 定义一个构建器方法 settingCell，用于创建设置项的 UI，参数 item 为单个设置项的数据。
    Row() {
      // 使用 Row 组件创建一个水平行布局，组织设置项的内容。
      Row({ space: CommonConstants.COMMON_SPACE }) {
        // 内部嵌套一个 Row 组件，设置子组件之间的间距为 COMMON_SPACE。
        Image(item.img)
          // 显示设置项的图标，图标来源为 item.img。
          .width($r('app.float.setting_size'))
            // 设置图标宽度为资源文件中定义的 setting_size。
          .height($r('app.float.setting_size'))
        // 设置图标高度为资源文件中定义的 setting_size。
        Text(item.title)
          // 显示设置项的标题，文本内容为 item.title。
          .fontSize($r('app.float.normal_text_size'))
        // 设置文本字体大小为资源文件中定义的 normal_text_size。
      }

      if (item.others === undefined) {
        // 判断 item.others 是否未定义（即没有额外信息）。
        Image($r('app.media.right_grey'))
          // 显示一个灰色右箭头图标，表示可跳转。
          .width($r('app.float.setting_jump_width'))
            // 设置箭头图标宽度为资源文件中定义的 setting_jump_width。
          .height($r('app.float.setting_jump_height'))
        // 设置箭头图标高度为资源文件中定义的 setting_jump_height。
      } else {
        // 如果 item.others 有值（例如开关状态）。
        Toggle({ type: ToggleType.Switch, isOn: false })
        // 显示一个开关控件，类型为 Switch，默认关闭。
      }
    }
    .justifyContent(FlexAlign.SpaceBetween)
    // 设置行内元素两端对齐（图标和文本在左侧，箭头或开关在右侧）。
    .width(CommonConstants.FULL_PARENT)
    // 设置行宽度为父组件的 100%。
    .padding({
      left: $r('app.float.setting_settingCell_left'),
      // 设置左侧内边距为资源文件中定义的 setting_settingCell_left。
      right: $r('app.float.setting_settingCell_right')
      // 设置右侧内边距为资源文件中定义的 setting_settingCell_right。
    })
  }

  build() {
    // 定义组件的构建方法，描述页面的整体 UI 结构。
    Navigation(this.pathStack){
    Scroll() {
      // 创建一个可滚动容器，包裹整个页面内容，支持上下滚动。
      Column({ space: CommonConstants.COMMON_SPACE }) {
        // 使用 Column 组件创建一个垂直列布局，子组件间距为 COMMON_SPACE。

        // 标题部分
        Column() {
          // 创建一个列布局，用于放置标题。
          Text($r('app.string.mainPage_tabTitles_mine'))
            // 显示“我的”标题，文本内容从资源文件中获取。
            .fontWeight(FontWeight.Medium)
              // 设置字体粗细为中等。
            .fontSize($r('app.float.page_title_text_size'))
              // 设置字体大小为资源文件中定义的 page_title_text_size。
            .margin({ top: $r('app.float.mainPage_tabTitles_margin') })
              // 设置上外边距为资源文件中定义的 mainPage_tabTitles_margin。
            .padding({ left: $r('app.float.mainPage_tabTitles_padding') })
          // 设置左侧内边距为资源文件中定义的 mainPage_tabTitles_padding。
        }
        .width(CommonConstants.FULL_PARENT)
        // 设置标题区域宽度为父组件的 100%。
        .alignItems(HorizontalAlign.Start)
        // 设置子组件（标题）水平左对齐。

        // 账户信息部分
        Row() {
          // 创建一个行布局，用于展示账户信息。
          Image($r('app.media.account'))
            // 显示用户头像，图标从资源文件中获取。
            .width($r('app.float.setting_account_size'))
              // 设置头像宽度为资源文件中定义的 setting_account_size。
            .height($r('app.float.setting_account_size'))
          // 设置头像高度为资源文件中定义的 setting_account_size。
          Column() {
            // 创建一个列布局，用于展示用户名和邮箱。
          //  Text($r('app.string.setting_account_name'))
              // 显示用户名，文本内容从资源文件中获取。
            Text(this.nikeName)
              .onClick(()=> {
                this.pathStack.pushPath({ name: 'PersonalInformation' });
              })

              .fontSize($r('app.float.setting_account_fontSize'))
            // 设置字体大小为资源文件中定义的 setting_account_fontSize。
           // Text($r('app.string.setting_account_email'))
              // 显示用户邮箱，文本内容从资源文件中获取。
            Text(this.email)
              .fontSize($r('app.float.little_text_size'))
                // 设置字体大小为资源文件中定义的 little_text_size。
              .margin({ top: $r('app.float.setting_name_margin') })
            // 设置上外边距为资源文件中定义的 setting_name_margin。
          }
          .alignItems(HorizontalAlign.Start)
          // 设置列内元素（用户名和邮箱）水平左对齐。
          .margin({ left: $r('app.float.setting_account_margin') })
          // 设置列的左侧外边距为资源文件中定义的 setting_account_margin。
        }
        .margin({ top: $r('app.float.setting_account_margin') })
        // 设置账户信息行的上外边距为资源文件中定义的 setting_account_margin。
        .alignItems(VerticalAlign.Center)
        // 设置行内元素（头像和文本）垂直居中对齐。
        .width(CommonConstants.FULL_PARENT)
        // 设置行宽度为父组件的 100%。
        .height($r('app.float.setting_account_height'))
        // 设置行高度为资源文件中定义的 setting_account_height。
        .backgroundColor(Color.White)
        // 设置背景颜色为白色。
        .padding({ left: $r('app.float.setting_account_padding') })
        // 设置左侧内边距为资源文件中定义的 setting_account_padding。
        .borderRadius($r('app.float.setting_account_borderRadius'))
        // 设置圆角半径为资源文件中定义的 setting_account_borderRadius。

        // 设置选项列表部分
        List() {
          // 创建一个 List 组件，用于展示设置选项列表。
          ForEach(mainViewModel.getSettingListData(), (item: ItemData) => {
            // 遍历 mainViewModel.getSettingListData() 返回的设置项数据。
            ListItem() {
              // 创建一个列表项。
              this.settingCell(item)
              // 调用 settingCell 构建器方法，创建设置项的 UI。
            }
            .height($r('app.float.setting_list_height'))
            // 设置列表项高度为资源文件中定义的 setting_list_height。
          }, (item: ItemData) => JSON.stringify(item))
          // 使用 JSON.stringify(item) 作为列表项的唯一标识符。
        }
        .scrollBar(BarState.Off)
        // 隐藏列表的滚动条。
        .backgroundColor(Color.White)
        // 设置列表背景颜色为白色。
        .width(CommonConstants.FULL_PARENT)
        // 设置列表宽度为父组件的 100%。
        .height(CommonConstants.SET_LIST_WIDTH)
        // 设置列表高度为常量 SET_LIST_WIDTH。
        .divider({
          strokeWidth: $r('app.float.setting_list_strokeWidth'),
          // 设置分隔线宽度为资源文件中定义的 setting_list_strokeWidth。
          color: Color.Grey,
          // 设置分隔线颜色为灰色。
          startMargin: $r('app.float.setting_list_startMargin'),
          // 设置分隔线左侧间距为资源文件中定义的 setting_list_startMargin。
          endMargin: $r('app.float.setting_list_endMargin')
          // 设置分隔线右侧间距为资源文件中定义的 setting_list_endMargin。
        })
        // 为列表项添加分隔线。
        .borderRadius($r('app.float.setting_list_borderRadius'))
        // 设置列表圆角半径为资源文件中定义的 setting_list_borderRadius。
        .padding({ top: $r('app.float.setting_list_padding'), bottom: $r('app.float.setting_list_padding') })
        // 设置列表上下内边距为资源文件中定义的 setting_list_padding。

        // 空白占位部分
        Blank()
        // 添加一个空白组件，占据剩余空间，使按钮固定在底部。

        // 操作按钮部分
        Button($r('app.string.setting_button'), { type: ButtonType.Capsule })
          // 创建一个胶囊形状的按钮，文本内容从资源文件中获取。
          .width(CommonConstants.BUTTON_WIDTH)
            // 设置按钮宽度为常量 BUTTON_WIDTH。
          .height($r('app.float.login_button_height'))
            // 设置按钮高度为资源文件中定义的 login_button_height。
          .fontSize($r('app.float.normal_text_size'))
            // 设置字体大小为资源文件中定义的 normal_text_size。
          .fontColor($r('app.color.setting_button_fontColor'))
            // 设置字体颜色为资源文件中定义的 setting_button_fontColor。
          .fontWeight(FontWeight.Medium)
            // 设置字体粗细为中等。
          .backgroundColor($r('app.color.setting_button_backgroundColor'))
            // 设置背景颜色为资源文件中定义的 setting_button_backgroundColor。
          .margin({ bottom: $r('app.float.setting_button_bottom') })
        // 设置下外边距为资源文件中定义的 setting_button_bottom。
      }
      .height(CommonConstants.FULL_PARENT)
      // 设置列高度为父组件的 100%，填充整个可滚动区域。
    }
  }
    .navDestination(this.PagesMap)
    .mode(NavigationMode.Stack)
    .hideToolBar(true)
    .expandSafeArea([SafeAreaType.SYSTEM],[SafeAreaEdge.TOP,SafeAreaEdge.BOTTOM])

  }
}