/**
 * PressKeysBean 类主要用于描述计算器按键的数据结构。
 * 包含按键的类型、尺寸、显示内容以及可选的图标资源。
 *
 * 参数说明：
 * flag: number — 表示按键的类型，通常 0 表示功能键（如清除、删除等），1 表示普通键（如数字、运算符）。
 * width: string — 按键的宽度，单位可能为 Vp（虚拟像素）或其他字符串描述的尺寸。
 * height: string — 按键的高度，单位与宽度相同。
 * value: string — 按键显示的文本内容，例如数字或操作符。
 * source?: Resource — 可选参数。表示按键使用的图标资源，用于功能键显示图标。
 */
export class PressKeysBean {
  flag: number;       // 按键类型：0 表示功能键，1 表示普通键
  width: string;      // 按键宽度，例如 '32Vp'
  height: string;     // 按键高度，例如 '32Vp'
  value: string;      // 按键上显示的文本，如 '7' 或 'clean'
  source?: Resource;  // 可选的图标资源，适用于功能键

  /**
   * 构造函数，用于初始化一个新的 PressKeysBean 对象
   * @param flag 按键类型（0：功能键，1：普通键）
   * @param width 按键宽度（字符串形式，例如 '32Vp'）
   * @param height 按键高度（字符串形式，例如 '32Vp'）
   * @param value 按键显示的文本值
   * @param source 可选的图标资源，如果按键需要显示图标时使用
   */
  constructor(flag: number, width: string, height: string, value: string, source?: Resource) {
    this.flag = flag;     // 初始化按键类型
    this.width = width;   // 初始化按键宽度
    this.height = height;  // 初始化按键高度
    this.value = value;   // 初始化按键显示的文本值
    this.source = source;  // 初始化图标资源（如果有）
  }
}