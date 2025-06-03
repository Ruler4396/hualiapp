import { PressKeysBean } from './PressKeysItem';

/**
 * PressKeysBeanViewModel 类用于管理计算器按键的排版数据。
 * 其主要功能是提供一个二维数组，每个元素为一行按键。
 * 每个按键由 PressKeysBean 对象描述，包含按键类型、尺寸、显示内容及可选图标。
 */
export class PressKeysBeanViewModel {
  /**
   * 获取计算器按键的一维数组数据，每个子数组代表一行按键。
   * @returns Array<Array<PressKeysBean>> - 返回一个二维数组，包含所有计算器按键。
   */
  getPressKeys(): Array<Array<PressKeysBean>> {
    return [
      [
      // 第一行按键：功能键 'clean' 和普通键 '7', '4', '1', '%'
        new PressKeysBean(
          0,              // flag: 0 表示功能键
          '32vp',         // width: 按键宽度为 '32vp'
          '32vp',         // height: 按键高度为 '32vp'
          'clean',        // value: 按键显示的文本或标识 'clean'
          $r("app.media.ic_clean") // source: 功能键图标资源
        ),
        new PressKeysBean(
          1,              // flag: 1 表示普通数字或符号键
          '19vp',        // width: 按键宽度为 '19vp'
          '43vp',        // height: 按键高度为 '43vp'
          '7'            // value: 按键显示的数字 '7'
          // source 参数未传入，默认为 undefined
        ),
        new PressKeysBean(
          1,              // flag: 1 表示普通键
          '19vp',        // width: 按键宽度为 '19vp'
          '43vp',        // height: 按键高度为 '43vp'
          '4'            // value: 按键显示的数字 '4'
        ),
        new PressKeysBean(
            1,              // flag: 1 表示普通键
            '19vp',         // width: 按键宽度为 '19vp'
            '43vp',         // height: 按键高度为 '43vp'
            '1'             // value: 按键显示的数字 '1'
        ),
        new PressKeysBean(
            1,              // flag: 1 表示普通键
            '25vp',         // width: 按键宽度为 '25vp'
            '43vp',         // height: 按键高度为 '43vp'
            '%'             // value: 按键显示的符号 '%'
        ),
      ],
      [
      // 第二行按键：功能键 'div' 和普通键 '8', '5', '2', '0'
          new PressKeysBean(
            0,              // flag: 0 表示功能键
            '32vp',         // width: 按键宽度为 '32vp'
            '32vp',         // height: 按键高度为 '32vp'
            'div',          // value: 按键显示的文本 'div' 表示除法操作
            $r('app.media.ic_div') // source: 除法键图标资源
          ),
          new PressKeysBean(
            1,              // flag: 1 表示普通键
            '19vp',         // width: 按键宽度为 '19vp'
            '43vp',         // height: 按键高度为 '43vp'
            '8'             // value: 按键显示的数字 '8'
          ),
          new PressKeysBean(
            1,              // flag: 1 表示普通键
            '19vp',         // width: 按键宽度为 '19vp'
            '43vp',         // height: 按键高度为 '43vp'
            '5'             // value: 按键显示的数字 '5'
          ),

          new PressKeysBean(
            1,              // flag: 1 表示普通键
            '19vp',         // width: 按键宽度为 '19vp'
            '43vp',        // height: 按键高度为 '43vp'
            '2'             // value: 按键显示的数字 '2'
          ),
          new PressKeysBean(
            1,              // flag: 1 表示普通键
            '19vp',         // width: 按键宽度为 '19vp'
            '43vp',        // height: 按键高度为 '43vp'
            '0'            // value: 按键显示的数字 '0'
          )
          ],
          [
          // 第三行按键：功能键 'mul' 和普通键 '9', '6', '3', '.'
            new PressKeysBean(
              0,              // flag: 0 表示功能键
              '32vp',         // width: 按键宽度为 '32vp'
              '32vp',        // height: 按键高度为 '32vp'
              'mul',          // value: 按键显示的文本 'mul' 表示乘法操作
              $r('app.media.ic_mul') // source: 乘法键图标资源
            ),
            new PressKeysBean(
              1,              // flag: 1 表示普通键
              '19vp',         // width: 按键宽度为 '19vp'
              '43vp',        // height: 按键高度为 '43vp'
              '9'             // value: 按键显示的数字 '9'
            ),
            new PressKeysBean(
              1,              // flag: 1 表示普通键
              '19vp',         // width: 按键宽度为 '19vp'
              '43vp',        // height: 按键高度为 '43vp'
              '6'             // value: 按键显示的数字 '6'
            ),
            new PressKeysBean(
              1,              // flag: 1 表示普通键
              '19vp',         // width: 按键宽度为 '19vp'
              '43vp',        // height: 按键高度为 '43vp'
              '3'             // value: 按键显示的数字 '3'
            ),
            new PressKeysBean(
              1,              // flag: 1 表示普通键
              '25vp',        // width: 按键宽度为 '25vp'
              '43vp',        // height: 按键高度为 '43vp'
              '.'            // value: 按键显示的小数点符号
            )
          ],
          [
          // 第四行按键：功能键 'del', 'min', 'add', 'equ'
            new PressKeysBean(
              0,              // flag: 0 表示功能键
              '30.48vp',      // width: 按键宽度为 '30.48vp'
              '20vp',         // height: 按键高度为 '20vp'
              'del',          // value: 按键显示的文本 'del' 表示删除操作
              $r('app.media.ic_del')  // source: 删除键图标资源
            ),
            new PressKeysBean(
              0,              // flag: 0 表示功能键
              '24vp',         // width: 按键宽度为 '24vp'
              '24vp',         // height: 按键高度为 '24vp'
              'min',          // value: 按键显示的文本 'min' 表示减法操作
              $r('app.media.ic_min')  // source: 减法键图标资源
            ),
            new PressKeysBean(
              0,              // flag: 0 表示功能键
              '32vp',         // width: 按键宽度为 '32vp'
              '32vp',         // height: 按键高度为 '32vp'
              'add',          // value: 按键显示的文本 'add' 表示加法操作
              $r('app.media.ic_add')  // source: 加法键图标资源
            ),
            new PressKeysBean(
              0,              // flag: 0 表示功能键
              '32vp',         // width: 按键宽度为 '32vp'
              '32vp',         // height: 按键高度为 '32vp'
              'equ',          // value: 按键显示的文本 'equ' 表示等号操作
              $r('app.media.ic_equ')  // source: 等号键图标资源
            )
          ]
      ];
  }
}

// 创建一个 keysModel 实例，用于全局导出按键数据模型
let keysModel = new PressKeysBeanViewModel();

// 导出 keysModel 实例，供其他模块使用，类型为 PressKeysBeanViewModel
export default keysModel as PressKeysBeanViewModel;
