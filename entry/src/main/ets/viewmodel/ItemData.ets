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
 * 列表项数据实体。
 * 这个类用于封装页面中列表项的数据，包括标题、图片和其他可选资源。
 */
export default class PageResource {
  /**
   * 列表项的文本标题。
   * 使用 Resource 类型，允许从资源文件中获取本地化字符串。
   */
  title: Resource;

  /**
   * 列表项的图片。
   * 使用 Resource 类型，允许从资源文件中获取图片。
   */
  img: Resource;

   key: string;
  /**
   * 列表项的其他资源（可选）。
   * 可以是额外的文本、图片或其他资源，用于扩展列表项的信息。
   */
  others?: Resource;

  /**
   * 构造函数。
   * @param title 列表项的标题资源。
   * @param img 列表项的图片资源。
   * @param others 列表项的其他资源（可选）。
   */
  constructor(title: Resource,img: Resource,key:string, others?: Resource) {
    this.title = title;   // 初始化标题
    this.img = img; // 初始化图片
    this.key= key;
    this.others = others; // 初始化其他资源（如果提供）
  }
}