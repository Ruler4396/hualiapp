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
 * 导入 Ability 相关的模块。
 * AbilityConstant: Ability 的常量定义。
 * UIAbility: Ability 的基类，提供生命周期管理。
 * Want: 表示启动 Ability 的意图，包含参数信息。
 * 这段代码定义了一个名为 entryAbility 的类，继承自 UIAbility，用于管理 HarmonyOS 应用程序中 Ability 的生命周期。Ability 是 HarmonyOS 中的核心组件，
 * 类似于 Android 中的 Activity，负责处理用户界面和业务逻辑。代码实现了 Ability 的多个生命周期方法，并在每个方法中记录日志以便调试和监控状态变化。
 */
import { AbilityConstant,ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';

/**
 * 导入窗口管理模块。
 * window: 用于操作窗口舞台。
 */
import { window } from '@kit.ArkUI';

/**
 * 导入日志工具模块。
 * hilog: 用于记录调试信息。
 */
import { hilog } from '@kit.PerformanceAnalysisKit';
import  { StoreClass } from '../utils/store' ;
const DOMAIN = 0x0000;
/**
 * Ability 的生命周期管理类。
 * 这个类继承自 UIAbility，负责管理应用程序的入口 Ability。
 */
export default class entryAbility extends UIAbility {

  /**
   * Ability 创建时调用，用于初始化。
   * @param want 启动 Ability 的意图对象，包含启动参数。
   * @param launchParam 启动参数，定义了 Ability 的启动模式等。
   */
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    // 检查是否可以记录 INFO 级别的日志
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    // 记录 Ability 创建的日志
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    // 记录 want 参数的 JSON 字符串
    hilog.info(0x0000, 'testTag', '%{public}s', 'want param:' + JSON.stringify(want) ?? '');
    // 记录 launchParam 的 JSON 字符串
    hilog.info(0x0000, 'testTag', '%{public}s', 'launchParam:' + JSON.stringify(launchParam) ?? '');
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onCreate');
  }

  /**
   * Ability 销毁时调用，用于清理资源。
   * 可以返回 Promise 以支持异步操作。
   */
  onDestroy(): void | Promise<void> {
    // 检查是否可以记录 INFO 级别的日志
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    // 记录 Ability 销毁的日志
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  /**
   * 窗口舞台创建时调用，用于设置主窗口内容。
   * @param windowStage 窗口舞台对象，用于管理窗口。
   */
  onWindowStageCreate(windowStage: window.WindowStage): void {
    // 检查是否可以记录 INFO 级别的日志
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    // 记录窗口创建的日志
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    // 加载名为 'pages/LoginPage' 的页面作为主窗口内容
    windowStage.loadContent('pages/LoginPage', (err, data) => {
      if (err.code) {
        // 如果加载失败，记录错误日志
        hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.ERROR);
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      // 如果加载成功，记录成功日志并输出加载数据
      StoreClass.init(this.context)
      hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  /**
   * 窗口舞台销毁时调用，用于释放 UI 相关资源。
   */
  onWindowStageDestroy(): void {
    // 检查是否可以记录 INFO 级别的日志
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    // 记录窗口销毁的日志
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  /**
   * Ability 进入前台（可见状态）时调用。
   */
  onForeground(): void {
    // 检查是否可以记录 INFO 级别的日志
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    // 记录进入前台的日志
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  /**
   * Ability 进入后台（不可见状态）时调用。
   */
  onBackground(): void {
    // 检查是否可以记录 INFO 级别的日志
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    // 记录进入后台的日志
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}

