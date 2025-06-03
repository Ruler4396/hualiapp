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
 * 导入自定义的通用常量模块。
 * CommonConstants: 包含应用程序中使用的常量，如标签页索引、间距等。
 */
import {CommonConstants} from '../common/constants/CommonConstants';

/**
 * 导入首页和设置页面的视图组件。
 * Home: 首页组件。
 * Setting: 设置页面组件。
 */
import Home from "../view/Home"
import Setting from "../view/Setting"
import Connect from "./Connect";
import { Anniversary } from './Anniversary';

import App from '@system.app';

/**
 * 主页面组件。
 * 使用 @Entry 装饰器标记为入口组件。
 */
@Entry
@Component
struct MainPage {
  /**
   * 状态变量：当前选中的标签页索引。
   * 初始化为首页的索引。
   */
  @State currentIndex: number = CommonConstants.HOME_TAB_INDEX;

  /**
   * 私有变量：TabsController 实例，用于控制标签页的切换。
   */
  private tabsController: TabsController = new TabsController();

  /**
   * 构建器：创建自定义的标签栏。
   * @param title 标签标题。
   * @param index 标签索引。
   * @param selectedImg 选中状态的图标。
   * @param normalImg 正常状态的图标。
   */
  @Builder
  TabBuilder(title: string, index: number, selectedImg: Resource, normalImg: Resource) {
    Column() {                                        // 使用列布局组织图标和文本
      // 显示图标：根据当前索引决定显示选中或正常状态的图标
      Image(this.currentIndex === index ? selectedImg : normalImg)
        .width($r('app.float.mainPage_baseTab_size')) // 设置图标宽度
        .height($r('app.float.mainPage_baseTab_size')) // 设置图标高度

      // 显示标题文本
      Text(title)
        .margin({ top: $r('app.float.mainPage_baseTab_top') }) // 设置文本上外边距
        .fontSize($r('app.float.main_tab_fontSize'))   // 设置字体大小
          // 根据当前索引设置文本颜色：选中时为选中颜色，否则为正常颜色
        .fontColor(this.currentIndex === index ? $r('app.color.mainPage_selected') : $r('app.color.mainPage_normal'))
    }
    .justifyContent(FlexAlign.Center)                  // 居中对齐列内元素
    .height($r('app.float.mainPage_barHeight'))        // 设置列高度
    .width(CommonConstants.FULL_PARENT)                // 设置列宽度为父组件的100%
    .onClick(() => {                                   // 绑定点击事件
      this.currentIndex = index;                       // 更新当前选中的索引
      this.tabsController.changeIndex(this.currentIndex); // 切换到选中的标签页
    })
  }

  /**
   * 构建页面 UI。
   */
  build() {
    Tabs({                                             // 创建 Tabs 组件
      barPosition: BarPosition.End,                    // 设置标签栏位置在底部
      controller: this.tabsController                  // 使用控制器管理标签页切换
    }) {
      // 第一个标签页：首页
      TabContent() {                                   // 创建标签页内容
        Home()                                         // 渲染首页组件
      }
      .padding({ left: $r('app.float.mainPage_padding'), right: $r('app.float.mainPage_padding') }) // 设置左右内边距
      .backgroundColor($r('app.color.mainPage_backgroundColor')) // 设置背景颜色
      // 设置自定义标签栏：传入标题、索引和图标资源
      .tabBar(this.TabBuilder(CommonConstants.HOME_TITLE, CommonConstants.HOME_TAB_INDEX,
        $r('app.media.home_selected'), $r('app.media.home_normal')))
     // 第二个标签微信
      TabContent() {                                   // 创建标签页内容
        Connect()                                 // 渲染设置页面组件
      }
      .padding({ left: $r('app.float.mainPage_padding'), right: $r('app.float.mainPage_padding') }) // 设置左右内边距
      .backgroundColor($r('app.color.mainPage_backgroundColor')) // 设置背景颜色
      // 设置自定义标签栏：传入标题、索引和图标资源
      .tabBar(this.TabBuilder(CommonConstants.CONNECT_TITLE,CommonConstants.CONNECT_TAB_INDEX,
        $r('app.media.ic_public_message_filled'), $r('app.media.ic_public_message')))

      // 第三个标签页：纪念日
      TabContent() {                                   // 创建标签页内容
        Anniversary()                                 // 渲染纪念日组件
      }
      .padding({ left: $r('app.float.mainPage_padding'), right: $r('app.float.mainPage_padding') }) // 设置左右内边距
      .backgroundColor($r('app.color.mainPage_backgroundColor')) // 设置背景颜色
      // 设置自定义标签栏：传入标题、索引和图标资源
      .tabBar(this.TabBuilder('纪念日', 2,
        $r('app.media.ic_public_message_filled'), $r('app.media.ic_public_message')))

      // 第四个标签页：我的
      TabContent() {                                   // 创建标签页内容
        Setting()                                      // 渲染设置页面组件
      }
      .padding({ left: $r('app.float.mainPage_padding'), right: $r('app.float.mainPage_padding') }) // 设置左右内边距
      .backgroundColor($r('app.color.mainPage_backgroundColor')) // 设置背景颜色
      // 设置自定义标签栏：传入标题、索引和图标资源
      .tabBar(this.TabBuilder(CommonConstants.MINE_TITLE, CommonConstants.MINE_TAB_INDEX,
        $r('app.media.mine_selected'), $r('app.media.mine_selected')))
    }
    .width(CommonConstants.FULL_PARENT)                // 设置 Tabs 组件宽度为父组件的100%
    .backgroundColor(Color.White)                      // 设置 Tabs 组件背景颜色为白色
    .barHeight($r('app.float.mainPage_barHeight'))     // 设置标签栏高度
    .barMode(BarMode.Fixed)                            // 设置标签栏模式为固定
    .onChange((index: number) => {                     // 绑定标签页切换事件
      this.currentIndex = index;                       // 更新当前选中的索引
    })
  }
}