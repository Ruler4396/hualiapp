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
export  class CommonConstants {
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
  static readonly CONNECT_TITLE='微信';
  //static readonly wei_chat_TITLE = '微信';
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
  static readonly MINE_TAB_INDEX = 2;
  static readonly CONNECT_TAB_INDEX=1;
  static readonly FULL_PERCENT: string = '100%';
  /**
   * 运算符集合
   */
  static readonly OPERATORS: string = '+-*÷';
  /**
   * 具有高优先级的运算符
   */
  static readonly OPERATORS_PRIORITY: string = '*÷';
  /**
   * 加法
   */
  static readonly ADD: string = '+';
  /**
   * 减法
   */
  static readonly MIN: string = '-';
  /**
   * 乘法
   */
  static readonly MUL: string = '*';
  /**
   * 除法
   */
  static readonly DIV: string = '÷';

  static readonly PERCENT_SIGN: string = '%';

  /**
   * 小数点
   */
  static readonly DOTS: string = '.';

  /**
   * 数字 2
   */
  static readonly TWO: number = 2;

  /**
   * 数字 10
   */
  static readonly TEN: number = 10;

  /**
   * 数字 100
   */
  static readonly ONE_HUNDRED: string = '100';

  /**
   * 最大输入长度
   */
  static readonly INPUT_LENGTH_MAX: number = 9;

  /**
   * 数字最大长度
   */
  static readonly NUM_MAX_LEN: number = 16;

  /**
   * 字母 e（科学计数法）
   */
  static readonly E: string = 'e';

  /**
   * 字符串 0
   */
  static readonly ZERO: string = '0';

  /**
   * 0.0 格式
   */
  static readonly ZERO_DOTS: string = '0.';
  static readonly ZEROhb: number = 0;

  /**
   * One.
   */
  static readonly ONE: number = 1;

  /**
   * Negative one.
   */
  static readonly NEGATIVE_ONE: number = -1;

  /**
   * Three.
   */
  static readonly THREE: number = 3;

  /**
   * Ten.
   */
  static readonly TENhb: number = 10;

  /**
   * Twenty-one.
   */
  static readonly TWENTY_ONE: number = 21;

  /**
   * Canvas width.
   */
  static readonly CANVAS_WIDTH: number = 750;

  /**
   * One hundred.
   */
  static readonly ONE_HUNDREDhb: number = 100;

  /**
   * String empty.
   */
  static readonly COLOR_STRING: string = '';

  /**
   * Percent sign.
   */
  static readonly SIGN: string = '%';

  /**
   * Basic color.
   */
  static readonly BLACK: string = 'black';

  /**
   * One hundred percent.
   */
  static readonly ONE_HUNDRED_PERCENT: string = '100%';

  /**
   * Arr color.
   */
  static readonly COLOR_ARR: string[] = ['#E90808', '#63B959', '#0A59F7', '#E56224', '#F6C800', '#5445EF', '#A946F1',
    '#000000']

  /**
   * White.
   */
  static readonly WHITE: string = '#ffffff';

  /**
   * Detents.
   */
  static readonly DETENTS: [Length, Length] = [550, 600];
}

// 计算器符号
export enum Symbol {
  ADD = 'add',
  MIN = 'min',
  MUL = 'mul',
  DIV = 'div',
  CLEAN = 'clean',
  DEL = 'del',
  EQU = 'equ'
}

// 运算符优先级
export enum Priority {
  HIGH = 2,   // 乘除运算
  MEDIUM = 1, // 加减运算
  LOW = 0     // 其他
}

// 枚举加减乘除
export enum SymbolicEnumeration {
  ADD = '+',
  MIN = '-',
  MUL = '*',
  DIV = '÷'
}