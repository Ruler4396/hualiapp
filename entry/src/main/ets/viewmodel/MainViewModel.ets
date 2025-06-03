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
 * 导入 ItemData 类。
 * ItemData: 定义列表项的数据结构，通常包括标题、图片等属性。
 */


import ItemData from './ItemData';

/**
 * MainViewModel 类：绑定数据到组件并提供接口。
 * 该类作为 ViewModel，提供方法来获取 UI 组件所需的数据。
 */
export class MainViewModel {

  /**
   * 获取轮播图图片数据。
   *
   * @return {Array<Resource>} 轮播图图片资源的数组。
   */
  getSwiperImages(): Array<Resource> {
    // 定义并初始化轮播图图片资源数组
    let swiperImages: Resource[] = [
      $r('app.media.fig1'),  // 引用 app.media.fig1 资源
      $r('app.media.fig2'),  // 引用 app.media.fig2 资源
      $r('app.media.fig3'),  // 引用 app.media.fig3 资源
      $r('app.media.fig4')   // 引用 app.media.fig4 资源
    ];
    return swiperImages;     // 返回轮播图图片资源数组
  }

  /**
   * 获取第一个网格的数据。
   *
   * @return {Array<ItemData>} 第一个网格的数据项数组。
   */
  getFirstGridData(): Array<ItemData> {
    // 定义并初始化第一个网格的数据项数组
    let firstGridData: ItemData[] = [
      new ItemData($r('app.string.my_love'), $r('app.media.love'),'love'),           // “我的喜爱”项
      new ItemData($r('app.string.history_record'), $r('app.media.record'),'record'),  // “历史记录”项
      new ItemData($r('app.string.message'), $r('app.media.message'),'message'),        // “消息”项
      new ItemData($r('app.string.shopping_cart'), $r('app.media.shopping'),'shopping'), // “购物车”项
      new ItemData($r('app.string.favorites'), $r('app.media.favorite'),'favorite'),//,'DrawCanvas'),
      new ItemData($r('app.string.group'), $r('app.media.circle'),'circle'),           // “群组”项
      new ItemData($r('app.string.EnglishTest'), $r('app.media.target'),'EnglishTest'),
      new ItemData($r('app.string.calculator'), $r('app.media.calculator'),'calculator'),     // “计算器”项
    ];
    return firstGridData;     // 返回第一个网格的数据项数组
  }

  /**
   * 获取第二个网格的数据。
   *
   * @return {Array<ItemData>} 第二个网格的数据项数组。
   */
  getSecondGridData(): Array<ItemData> {
    // 定义并初始化第二个网格的数据项数组
    let secondGridData: ItemData[] = [
      new ItemData($r('app.string.mainPage_top'), $r('app.media.top'), 'top',$r('app.string.mainPage_text_top')),     // “置顶”项
      new ItemData($r('app.string.mainPage_new'), $r('app.media.new'),'new',$r('app.string.mainPage_text_new')),     // “最新”项
      new ItemData($r('app.string.mainPage_brand'), $r('app.media.brand'), 'brand',$r('app.string.mainPage_text_brand')), // “品牌”项
      new ItemData($r('app.string.mainPage_found'), $r('app.media.found'),'found', $r('app.string.mainPage_text_found')) // “发现”项
    ];
    return secondGridData;    // 返回第二个网格的数据项数组
  }

  /**
   * 获取设置列表的数据。
   *
   * @return {Array<ItemData>} 设置列表的数据项数组。
   */
  getSettingListData(): Array<ItemData> {
    // 定义并初始化设置列表的数据项数组
    let settingListData: ItemData[] = [
      new ItemData($r('app.string.setting_list_news'), $r('app.media.news'), 'news',$r("app.string.setting_toggle")), // “新闻”项，包含切换开关
      new ItemData($r('app.string.setting_list_data'), $r('app.media.data'),'media'),     // “数据”项
      new ItemData($r('app.string.setting_list_menu'), $r('app.media.menu'),'menu'),     // “菜单”项
      new ItemData($r('app.string.setting_list_about'), $r('app.media.about'),'about'),   // “关于”项
      new ItemData($r('app.string.setting_list_storage'), $r('app.media.storage'),'storage'), // “存储”项
      new ItemData($r('app.string.setting_list_privacy'), $r('app.media.privacy'),'privacy')  // “隐私”项
    ];
    return settingListData;   // 返回设置列表的数据项数组
  }
}

/**
 * 导出 MainViewModel 的单例实例。
 * 这样在应用程序中可以直接使用这个实例来访问数据方法。
 */
export default new MainViewModel();