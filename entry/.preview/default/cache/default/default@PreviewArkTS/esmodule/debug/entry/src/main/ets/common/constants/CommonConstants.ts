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
 * 通用常量类，用于定义应用程序中所有功能的公共配置和设置。
 * 这个类提供了一组静态只读常量，确保应用程序在不同模块中使用一致的配置值，便于管理和维护。
 */
export default class CommonConstants {
    /**
     * 账户输入的长度，设置为 11 位。
     * 用于验证用户输入的账户长度是否符合要求。
     */
    static readonly INPUT_ACCOUNT_LENGTH = 11;
    /**
     * 密码输入的长度，设置为 8 位。
     * 用于验证用户输入的密码长度是否符合要求。
     */
    static readonly INPUT_PASSWORD_LENGTH = 8;
    /**
     * 输入框的左侧边距，设置为 0。
     * 用于控制输入框在布局中的左边距。
     */
    static readonly INPUT_PADDING_LEFT = 0;
    /**
     * 模拟登录的延迟时间，设置为 2000 毫秒（2 秒）。
     * 用于设置登录操作的等待时间，例如模拟网络请求延迟。
     */
    static readonly LOGIN_DELAY_TIME = 2000;
    /**
     * 组件之间的通用间距，设置为 12 单位。
     * 用于在布局中统一组件之间的间隔。
     */
    static readonly COMMON_SPACE = 12;
    /**
     * 首页的标题文本，设置为“首页”。
     * 用于显示首页的标题内容。
     */
    static readonly HOME_TITLE = '首页';
    /**
     * “我的”页面的标题文本，设置为“我的”。
     * 用于显示“我的”页面的标题内容。
     */
    static readonly MINE_TITLE = '我的';
    /**
     * 其他登录方式之间的间距，设置为 44 单位。
     * 用于在登录页面中设置不同登录选项之间的间隔。
     */
    static readonly LOGIN_METHODS_SPACE = 44;
    /**
     * 组件宽度或高度占满父组件的比例，设置为“100%”。
     * 用于设置组件的宽度或高度完全填充父组件。
     */
    static readonly FULL_PARENT = '100%';
    /**
     * 按钮的宽度，设置为父组件的 90%。
     * 用于统一按钮的宽度样式。
     */
    static readonly BUTTON_WIDTH = '90%';
    /**
     * 设置列表的宽度，设置为父组件的 45%。
     * 用于控制设置页面中列表的宽度。
     */
    static readonly SET_LIST_WIDTH = '45%';
    /**
     * 首页标签的索引，设置为 0。
     * 用于标识首页在导航标签中的位置。
     */
    static readonly HOME_TAB_INDEX = 0;
    /**
     * “我的”标签的索引，设置为 1。
     * 用于标识“我的”页面在导航标签中的位置。
     */
    static readonly MINE_TAB_INDEX = 1;
}
