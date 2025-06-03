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
 * CommonConstants: 包含应用程序中使用的常量，如间距、尺寸等。
 */
import {CommonConstants} from '../common/constants/CommonConstants';
import {Calculator} from '../pages/Calculator';

import {EnglishTest} from '../pages/EnglishTest';
/**
 * 导入主视图模型。
 * mainViewModel: 提供首页所需的数据，如轮播图图片和网格数据。
 */
import mainViewModel from '../viewmodel/MainViewModel';

/**
 * 导入数据模型。
 * ItemData: 定义网格项的数据结构。
 */
import ItemData from '../viewmodel/ItemData';


/**
 * 首页标签页内容组件。
 * @Component 装饰器表示这是一个 HarmonyOS 的 UI 组件。
 */
@Component
export default struct Home {
  /**
   * 私有变量：SwiperController 实例，用于控制轮播图的切换。
   */
  private swiperController: SwiperController = new SwiperController();
  @Provide('NavPathStack') NavPathStack : NavPathStack = new NavPathStack();

  /**
   * 构建页面 UI。
   * build() 方法定义了组件的布局和内容。
   */
  /**
   * 页面映射构建器，根据名称创建对应的页面组件。
   * @param name 页面名称
   */
  @Builder
  PagesMap(name: string) {
    if (name === 'Calculator') {
      Calculator()
    }
    else if(name ==='EnglishTest') {
      EnglishTest()
    }
    else {                  // 默认的兜底逻辑
      Text('Page not found: ' + name)
        .fontSize(20)
        .fontColor(Color.Red)
    }
  }

  build() {
    Navigation(this.NavPathStack) {
      Scroll() { // 创建可滚动容器，用于包裹整个页面内容
        Column({ space: CommonConstants.COMMON_SPACE }) { // 使用列布局，设置子组件之间的间距
          // 标题部分
          Column() {
            Text($r('app.string.mainPage_tabTitles_home'))// 显示首页标题文本，引用资源文件中的字符串
              .fontWeight(FontWeight.Medium)// 设置字体粗细为中等
              .fontSize($r('app.float.page_title_text_size'))// 设置字体大小，引用资源值
              .margin({ top: $r('app.float.mainPage_tabTitles_margin') })// 设置上外边距
              .padding({ left: $r('app.float.mainPage_tabTitles_padding') }) // 设置左内边距
          }
          .width(CommonConstants.FULL_PARENT) // 设置宽度为父组件的100%
          .alignItems(HorizontalAlign.Start) // 设置子组件左对齐

          // 轮播图部分
          Swiper(this.swiperController) { // 创建轮播图组件，传入控制器实例
            ForEach(mainViewModel.getSwiperImages(), (img: Resource) => { // 遍历轮播图图片数据
              Image(img)// 显示每张轮播图图片
                .borderRadius($r('app.float.home_swiper_borderRadius')) // 设置图片圆角
            }, (img: Resource) => JSON.stringify(img.id)) // 使用图片 ID 的 JSON 字符串作为唯一键
          }
          .margin({ top: $r('app.float.home_swiper_margin') }) // 设置轮播图的上外边距
          .autoPlay(true) // 启用轮播图自动播放

          // 第一个网格：功能或分类展示
          Grid() { // 创建网格组件，用于展示功能或分类
            ForEach(mainViewModel.getFirstGridData(), (item: ItemData) => { // 遍历第一组网格数据
              GridItem() { // 创建单个网格项
                Column() { // 使用列布局排列图片和文本
                  Image(item.img)// 显示网格项的图片
                    .width($r('app.float.home_homeCell_size'))// 设置图片宽度
                    .height($r('app.float.home_homeCell_size')) // 设置图片高度

                  Text(item.title)
                    .onClick(() => {
                      // 点击“计算器”跳转
                      if (item.key ==='calculator' ){
                        this.NavPathStack.pushPath({ name: 'Calculator' });
                      }
                      // 点击“收藏”跳转

                      if (item.key ==='EnglishTest') {

                        this.NavPathStack.pushPath({ name: 'EnglishTest' })
                      }
                    })
                    .fontSize($r('app.float.little_text_size'))// 设置标题字体大小
                    .margin({ top: $r('app.float.home_homeCell_margin') }) // 设置标题的上外边距
                }
              }
            }, (item: ItemData) => JSON.stringify(item)) // 使用网格项的 JSON 字符串作为唯一键
          }
          .columnsTemplate('1fr 1fr 1fr 1fr') // 设置网格列模板为四列，每列等宽
          .rowsTemplate('1fr 1fr') // 设置网格行模板为两行，每行等高
          .columnsGap($r('app.float.home_grid_columnsGap')) // 设置列间距
          .rowsGap($r('app.float.home_grid_rowGap')) // 设置行间距
          .padding({ top: $r('app.float.home_grid_padding'), bottom: $r('app.float.home_grid_padding') }) // 设置上下内边距
          .height($r('app.float.home_grid_height')) // 设置网格高度
          .backgroundColor(Color.White) // 设置背景颜色为白色
          .borderRadius($r('app.float.home_grid_borderRadius')) // 设置网格圆角

          // 文本：列表标题
          Text($r('app.string.home_list'))// 显示列表标题文本，引用资源文件中的字符串
            .fontSize($r('app.float.normal_text_size'))// 设置字体大小
            .fontWeight(FontWeight.Medium)// 设置字体粗细为中等
            .width(CommonConstants.FULL_PARENT)// 设置宽度为父组件的100%
            .margin({ top: $r('app.float.home_text_margin') }) // 设置上外边距

          // 第二个网格：列表或推荐内容展示
          Grid() { // 创建网格组件，用于展示列表或推荐内容
            ForEach(mainViewModel.getSecondGridData(), (secondItem: ItemData) => { // 遍历第二组网格数据
              GridItem() { // 创建单个网格项
                Column() { // 使用列布局排列标题和其他信息
                  Text(secondItem.title)// 显示网格项的标题
                    .fontSize($r('app.float.normal_text_size'))// 设置标题字体大小
                    .fontWeight(FontWeight.Medium) // 设置标题字体粗细为中等
                  Text(secondItem.others)// 显示网格项的其他信息
                    .margin({ top: $r('app.float.home_list_margin') })// 设置上外边距
                    .fontSize($r('app.float.little_text_size'))// 设置字体大小
                    .fontColor($r('app.color.home_grid_fontColor')) // 设置字体颜色
                }
                .alignItems(HorizontalAlign.Start) // 设置子组件左对齐
              }
              .padding({ top: $r('app.float.home_list_padding'), left: $r('app.float.home_list_padding') }) // 设置上和左内边距
              .borderRadius($r('app.float.home_backgroundImage_borderRadius')) // 设置网格项圆角
              .align(Alignment.TopStart) // 对齐到左上角
              .backgroundImage(secondItem.img) // 设置网格项的背景图片
              .backgroundImageSize(ImageSize.Cover) // 设置背景图片覆盖整个网格项
              .width(CommonConstants.FULL_PARENT) // 设置网格项宽度为父组件的100%
              .height(CommonConstants.FULL_PARENT) // 设置网格项高度为父组件的100%
            }, (secondItem: ItemData) => JSON.stringify(secondItem)) // 使用网格项的 JSON 字符串作为唯一键
          }
          .width(CommonConstants.FULL_PARENT) // 设置网格宽度为父组件的100%
          .height($r('app.float.home_secondGrid_height')) // 设置网格高度
          .columnsTemplate('1fr 1fr') // 设置网格列模板为两列，每列等宽
          .rowsTemplate('1fr 1fr') // 设置网格行模板为两行，每行等高
          .columnsGap($r('app.float.home_grid_columnsGap')) // 设置列间距
          .rowsGap($r('app.float.home_grid_rowGap')) // 设置行间距
          .margin({ bottom: $r('app.float.setting_button_bottom') }) // 设置下外边距
        }
      }
      .scrollBar(BarState.Off) // 隐藏滚动条
      .height(CommonConstants.FULL_PARENT) // 设置滚动容器高度为父组件的100
    }
    .navDestination(this.PagesMap)
    .mode(NavigationMode.Stack)
    .hideToolBar(true)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}