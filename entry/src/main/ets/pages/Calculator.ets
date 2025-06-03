/**
 * HomePage 组件实现了一个计算器界面，包括显示输入/计算结果的区域和按键区域。
 * 其中按键区域根据 keysModel.getPressKeys() 返回的二维数组数据动态渲染。
 * 此组件主要用于展示 ArkTS 框架中如何构建响应式 UI 以及如何处理数据的动态渲染。
 */
import Logger from '../common/util/Logger';         // 日志工具类
import CalculateUtil from '../common/util/CalculateUtil';   // 计算工具类
import CheckEmptyUtil from '../common/util/CheckEmptyUtil'; // 空值检查工具类
import keysModel from '../viewmodel/PressKeysViewModel'; // 导入按键数据模型实例
import { PressKeysBean } from '../viewmodel/PressKeysItem'; // 导入按键数据结构定义
import {  CommonConstants, Symbol } from '../common/constants/CommonConstants'; // 导入常量和符号定义

@Entry
@Component // 声明该结构作为一个组件
export struct Calculator{
  @State inputValue: string = ''; // 定义状态变量 inputValue，用于存储用户输入的计算表达式
  @State calValue: string = ''; // 定义状态变量 calcValue，用于存储计算结果
  private expressions: Array<string> = []; // 私有属性 expressions，用于存储分解的表达式片段
  @Consume('NavPathStack') pathStack:NavPathStack
  /**
   * build 方法构建 UI 布局，返回计算器界面
   */
  build() {
    NavDestination() {
      Column() { // 最外层容器，使用 Column 布局，将子组件垂直排列
        // 第一部分：显示输入内容的区域
        Column() {
          TextInput({ text: this.resultFormat(this.inputValue) })// 绑定输入值
            .height(CommonConstants.FULL_PERCENT)// 高度 100%
            .fontSize(
              (this.inputValue.length > CommonConstants.INPUT_LENGTH_MAX) ?
              $r('app.float.font_size_text') : $r('app.float.font_size_input')
            )// 根据inputValue输入长度动态调整字体大小
            .enabled(false)// false只读模式
            .fontColor('#000')
            .textAlign(TextAlign.End)
            .backgroundColor($r('app.color.input_back_color'))
        }
        .width(CommonConstants.FULL_PERCENT)
        .height($r('app.float.input_height'))
        .alignItems(HorizontalAlign.End)
        .margin({
          right: $r('app.float.input_margin_right'),
          top: $r('app.float.input_margin_top1')
        })

        // 第二部分：显示计算结果或辅助文本的区域
        Column() {
          Text(this.resultFormat(this.calValue))// 绑定计算结果
            .fontSize($r('app.float.font_size_text'))
            .fontColor($r('app.color.text_color'))
        }
        .width(CommonConstants.FULL_PERCENT) // 宽度设置为 100%
        .height($r('app.float.text_height')) // 高度从资源中获取
        .alignItems(HorizontalAlign.End) // 设置文本右对齐
        .margin({
          right: $r('app.float.text_margin_right'), // 设置右边距，从资源中获取
          bottom: $r('app.float.text_margin_bottom') // 设置下边距，从资源中获取
        })

        // 第三部分：按键区域。包含计算器的所有按键
        Column() { // 新建一个 Column，作为按键区域的容器
          Row() { // 使用 Row 水平排列按键列
            // 使用 ForEach 遍历 KeysModel.getPressKeys() 返回的二维数组
            ForEach(keysModel.getPressKeys(), (columnItem: Array<PressKeysBean>, columnItemIndex?: number) => {
              Column() { // 每一列使用 Column 垂直排列各个按键
                // 遍历当前列中的所有按键
                ForEach(columnItem, (keyItem: PressKeysBean, keyItemIndex?: number) => {
                  Column() { // 定义单个按键的容器
                    Column() { // 内部 Column 用于放置按键的图标或文本
                      if (keyItem.flag === 0) { // 如果按键为功能键 (flag 为 0)
                        Image(keyItem.source != undefined ? keyItem.source : '')
                          .width(keyItem.width)// 设置图标宽度
                          .height(keyItem.height) // 设置图标高度
                      } else { // 对于普通按键 (flag 为 1)，显示文本
                        Text(keyItem.value)// 按键显示的文本内容
                          .fontSize(
                            (keyItem.value === CommonConstants.DOTS) ?
                            $r('app.float.font_size_dot') : $r('app.float.font_size_text')
                          )// 如果按键值为小数点，则使用特定字体大小
                          .width(keyItem.width)// 设置文本显示区域的宽度
                          .height(keyItem.height) // 设置文本显示区域的高度
                      }
                    }
                    .width($r('app.float.key_width')) // 外层按键容器固定宽度，从资源中获取
                    .height(
                      ((columnItemIndex === (keysModel.getPressKeys().length - 1)) &&
                        (keyItemIndex === (columnItem.length - 1))) ?
                      $r('app.float.equals_height') : $r('app.float.key_height')
                      // 对于等号键（最后一列最后一个按键），设置特殊高度；否则使用普通按键高度
                    )
                    .borderWidth(1) // 设置按键边框宽度为 1
                    .borderColor($r('app.color.border_color1')) // 设置按键边框颜色，从资源获取
                    .borderRadius($r('app.float.border_radius')) // 设置按键圆角，从资源获取
                    .backgroundColor(
                      ((columnItemIndex === (keysModel.getPressKeys().length - 1)) &&
                        (keyItemIndex === (columnItem.length - 1))) ?
                      $r('app.color.equals_back_color') : Color.White
                      // 对于等号键，设置特殊背景颜色，其余按键背景颜色为白色
                    )
                    .alignItems(HorizontalAlign.Center) // 设置按键内容水平方向居中
                    .justifyContent(FlexAlign.Center) // 设置按键内容垂直方向居中
                    .onClick(() => { // 为按键绑定点击事件
                      // 点击事件处理逻辑（目前注释称，可根据需要启用）
                      Logger.info(`点击按键：value=${keyItem.value} flag=${keyItem.flag}`);

                      if (keyItem.flag === 0) {
                        this.inputSymbol(keyItem.value);
                      } else {
                        this.inputNumber(keyItem.value);
                      }
                    })
                  }
                  .layoutWeight(
                    ((columnItemIndex === (keysModel.getPressKeys().length - 1)) &&
                      (keyItemIndex === (columnItem.length - 1))) ? CommonConstants.TWO : 1
                    // 设置布局权重，对于等号键给予更大权重（占空间更大），其余按键权重为 1
                  )
                  .width(CommonConstants.FULL_PERCENT) // 设置每个按键宽度占满所在容器
                  .justifyContent(FlexAlign.Center) // 在按键容器内设置内容水平居中
                }, (keyItem: PressKeysBean) => JSON.stringify(keyItem))
                // 第二个参数为每个按键提供唯一标识，使用 JSON 序列化 keyItem 对象
              }
              .layoutWeight(1) // 每一列按键的布局权重均为 1，确保各列均分可用空间
              .margin({
                top: $r('app.float.margin_top'), // 设置每一列的上边距，从资源中获取
                bottom: $r('app.float.margin_bottom') // 设置每一列的下边距，从资源中获取
              })
            }, (item: Array<Array<PressKeysBean>>) => JSON.stringify(item))
            // 最外层 ForEach 为每一列提供唯一标识，使用 JSON 序列化整个列数据
          }
          .height(CommonConstants.FULL_PERCENT) // 按键区域行的高度设置为 100%
          .alignItems(VerticalAlign.Top) // 设置按键行内各列顶面对齐
          .margin({
            left: $r('app.float.margin_left'), // 设置左边距，从资源中获取
            right: $r('app.float.margin_right') // 设置右边距，从资源中获取
          })
        }
        .layoutWeight(1) // 设置按键区域在整体布局中的权重，使其占据剩余空间
        .width(CommonConstants.FULL_PERCENT) // 按键区域宽度为 100%
        .backgroundColor($r('app.color.row_back_color')) // 按键区域背景颜色，从资源中获取
      }
      .height(CommonConstants.FULL_PERCENT) // 整个界面高度为 100%
      .backgroundColor($r('app.color.column_back_color')) // 整体背景颜色，从资源中获取
    }
    .onBackPressed(() => {
      this.pathStack.pop();
      return true;
    })
    .backgroundColor('#F1F3F5')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
  /**
   * 输入符号。
   *
   * @param value 输入的运算符或符号
   */
  inputSymbol(value: string) { // 定义 inputSymbol 方法，处理符号输入
    if (CheckEmptyUtil.isEmpty(value)) { // 如果输入值为空，使用 CheckEmptyUtil 检查
      return; // 直接返回，不处理
    }
    let len = this.expressions.length; // 获取当前表达式数组的长度
    switch (value) { // 根据输入值进行分支处理
      case Symbol.CLEAN: // 如果是清空符号
        this.expressions = []; // 清空表达式数组
        this.calValue = ''; // 清空计算结果
        break;
      case Symbol.DEL: // 如果是删除符号
        this.inputDelete(len); // 调用 inputDelete 处理删除操作
        break;
      case Symbol.EQU: // 如果是等于符号
        if (len === 0) { // 如果表达式为空
          return; // 直接返回，不处理
        }
        this.getResult().then((result: boolean) => { // 异步调用 getResult 获取计算结果
          if (!result) { // 如果计算失败
            return; // 直接返回，不更新
          }
          this.inputValue = this.calValue; // 将计算结果赋值给输入值
          this.calValue = ''; // 清空计算结果
          this.expressions = []; // 清空表达式数组
          this.expressions.push(this.inputValue); // 将结果作为新表达式添加
        });
        break;
      default: // 如果是其他运算符（如加减乘除）
        this.inputOperators(len, value); // 调用 inputOperators 处理运算符输入
        break;
    }
    this.formatInputValue(); // 更新格式化后的输入值显示
  }
  /**
   * 输入数字。
   *
   * @param value 输入的数字或小数点
   */
  inputNumber(value: string) {
    // 处理数字输入
    if (CheckEmptyUtil.isEmpty(value)) { // 空值检查
      return; // 不处理空输入
    }
    let len = this.expressions.length; // 表达式长度
    let last = len > 0 ? this.expressions[len - 1] : ''; // 最后一个元素,无则是空
    let secondLast = len > 1 ? this.expressions[len - CommonConstants.TWO] : undefined; // 倒数第二个元素
    if (!this.validateEnter(last, value)) { // 验证输入
      return; // 非法输入终止
    }
    if (!last) { // 空表达式情况
      this.expressions.push(value); // 直接添加
    } else if (!secondLast) { // 单元素情况
      this.expressions[len - 1] += value; // 追加数字
    }
    if (secondLast && CalculateUtil.isSymbol(secondLast)) { // 运算符检查（mbo疑似未定义）
      this.expressions[len - 1] += value; // 追加到末位
    }
    if (secondLast && !CalculateUtil.isSymbol((secondLast))) { // 非运算符情况
      this.expressions.push(value); // 新建元素
    }
      this.formatInputValue();
    // 更新显示
    if (value !== CommonConstants.DOTS) { // 非小数点触发计算
      this.getResult(); // 计算结果
    }
  }
  /**
   * 验证是否可以输入。
   * @param last 最后一个元素的值
   * @param value 当前输入的值
   * @return 是否允许输入
   */
  validateEnter(last: string, value: string) { // 输入验证方法
    if (!last && value === CommonConstants.PERCENT_SIGN) { // 空表达式输入百分号
      return false;
    }
    if ((last === CommonConstants.MIN) && (value === CommonConstants.PERCENT_SIGN)) { // 负号后接百分号
      return false;
    }
    if (last.endsWith(CommonConstants.PERCENT_SIGN)) {
      return false;
    }
    if ((last.indexOf(CommonConstants.DOTS) !== -1) && (value === CommonConstants.DOTS)) { // 重复小数点
      return false;
    }
    if ((last === '0') && (value !== CommonConstants.DOTS) && // 数字0后接非小数点
      (value !== CommonConstants.PERCENT_SIGN)) {
      return false;
    }
    return true; // 默认通过验证
  }
  /**
   * 删除键触发操作。
   * @param len 表达式长度
   */
  inputDelete(len: number) { // 处理删除操作
    if (len === 0) { // 空表达式检查
      return; // 不处理空表达式
    }
    let last = this.expressions[len - 1]; // 获取末位元素
    let lastLen = last.length; // 获取末位元素长度
    if (lastLen === 1) { // 单字符元素处理
      this.expressions.pop(); // 移除整个元素
      len = this.expressions.length; // 更新长度
    } else { // 多字符元素处理
      this.expressions[len - 1] = last.slice(0, last.length - 1); // 删除末位字符
    }
    if (len === 0) { // 删除后为空的情况
      this.inputValue = ''; // 清空输入显示
      this.calValue = ''; // 清空计算结果
      return;
    }
    if (!CalculateUtil.isSymbol(this.expressions[len - 1])) { // 末位非运算符时
      this.getResult(); // 触发重新计算
    }
  }
  /**
   * 输入运算符时触发。
   *
   * @param len 表达式长度
   * @param value 当前输入值
   */
  inputOperators(len: number, value: string) { // 处理运算符输入
    let last = len > 0 ? this.expressions[len - 1] : undefined; // 获取末位元素
    let secondLast = len > 1 ? this.expressions[len - CommonConstants.TWO] : undefined; // 获取倒数第二元素
    // 空表达式输入负号处理
    if (!last && (value === Symbol.MIN)) {
      this.expressions.push(this.getSymbol(value));
      return;
    }
    // 空表达式非负号处理
    if (!last) {
      return;
    }
    // 末位为数字时处理（注意Last拼写错误）
    if (!CalculateUtil.isSymbol(last)) {
      this.expressions.push(this.getSymbol(value));
      return;
    }
    // 连续负号/加号替换逻辑（注意Value应为value）
    if ((value === Symbol.MIN) &&
      (last === CommonConstants.MIN || last === CommonConstants.ADD)) {
      this.expressions.pop();
      this.expressions.push(this.getSymbol(value));
      return;
    }
    // 单元素表达式处理
    if (!secondLast) {
      return;
    }
    // 非负号运算符替换
    if (value !== Symbol.MIN) {
      this.expressions.pop();
    }
    // 运算符堆叠处理（注意SecondLast拼写错误）
    if (CalculateUtil.isSymbol(secondLast)) {
      this.expressions.pop();
    }
    this.expressions.push(this.getSymbol(value)); // 最终添加新运算符
  }

  /**
   * 获取运算符。
   *
   * @param value 输入值
   * @return 标准运算符
   */
  getSymbol(value: string) { // 将输入转换为标准运算符
    if (CheckEmptyUtil.isEmpty(value)) { // 空值检查
      return ''; // 返回空字符串
    }
    let symbol = ''; // 初始化运算符
    switch (value) { // 运算符转换逻辑
      case Symbol.ADD: // 加号转换
        symbol = CommonConstants.ADD;
        break;
      case Symbol.MIN: // 减号转换
        symbol = CommonConstants.MIN;
        break;
      case Symbol.MUL: // 乘号转换
        symbol = CommonConstants.MUL;
        break;
      case Symbol.DIV: // 除号转换
        symbol = CommonConstants.DIV;
        break;
      default: // 其他情况
        break;
    }
    return symbol; // 返回转换后的运算符
  }
  /**
   * 深拷贝表达式。
   *
   * @return 深拷贝后的表达式数组
   */
  deepCopy(): Array<string> { // 创建表达式深拷贝
    let copyExpressions: Array<string> = Array.from(this.expressions); // 使用Array.from浅拷贝
    return copyExpressions; // 实际为浅拷贝
  }
  /**
   * 获取计算结果。
   *
   * @return 计算是否成功
   */
  async getResult() { // 异步计算结果
    let calResult = CalculateUtil.parseExpression(this.deepCopy()); // 拼写错误：CalculateUtl应为CalculateUtil
    if (calResult === 'NaN') { // 'NaN'）
      this.calValue = this.resourceToString($r('app.string.error'));
      return false;
    }
    this.calValue = calResult;
    return true;
  }
  /**
   * 数字格式化。
   *
   * @param value 格式化参数
   * @return 添加千分位后的字符串
   */
  resultFormat(value: string) { // 数字千分位格式化
    let reg = (value.indexOf('.') > -1)
      ? new RegExp("/(\d)(?=(\d(3))+\.)/g")  // 含小数点的错误正则
      : new RegExp("/(\d)(?=(?:\d(3))+$)/g"); // 无小数点的错误正则
    return value.replace(reg, '$1,');
  }
  /**
   * 将资源文件转换为字符串。
   *
   * @param resource 资源文件
   * @return 转换后的字符串
   */
  resourceToString(resource: Resource): string { // 资源转字符串方法
    if (CheckEmptyUtil.isEmpty(resource)) { // 空值检查（多一个右括号）
      return '';
    }
    let result = '';
    try {
      result = getContext(this).resourceManager.getStringSync(resource.id); // 同步获取资源字符串
    } catch (error) {
      Logger.error('[calculateModel] getResourceString fail: ' + JSON.stringify(error)); // 错误日志
    }
    return result;
  }

  /**
   * 格式化输入值并更新显示。
   */
  formatInputValue() { // 输入值格式化方法
    let deepExpressions: Array<string> = [];
    this.deepCopy().forEach((item: string, index: number) => { // 遍历表达式
      deepExpressions[index] = this.resultFormat(item); // 格式化每个元素
    });
    this.inputValue = deepExpressions.join(''); // 拼接为显示字符串
  }
}
