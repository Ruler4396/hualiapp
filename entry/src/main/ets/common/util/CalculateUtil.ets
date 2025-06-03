import { CommonConstants, Priority, SymbolicEnumeration } from '../constants/CommonConstants'; // 导入当前数据类型，如果选择文件或创建该数据
import CheckEmptyUtil from './CheckEmptyUtil'; // 导入检查空值的工具类

class CalculateUtil { // 定义 CalculateUtil 类，用于解决计算工具
  /**
   * 判断是否是易算符。
   *
   * @param value 符号。
   * @return 是否是易算符。
   */
  isSymbol(value: string) { // 定义 isSymbol 函数，接受一个字符串参数 value
    if (CheckEmptyUtil.isEmpty(value)) { // 如果 value 是空的，使用 CheckEmptyUtil.isEmpty 操作
      return; // 返回 undefined 在条件语句中相当于 false)
    }
    return (CommonConstants.OPERATORS.indexOf(value) !== -1); // 返回 value 是否有 CommonConstants.OPERATORS 数值中
  }

  /**
   * 提取运算符的优先级。
   *
   * @param value 符号。
   * @return 优先级。
   */
  getPriority(value: string): number { // 定义 getPriority 函数，接受一个字符串参数 value。返回其优先级
    if (CheckEmptyUtil.isEmpty(value)) { // 如果 value 是空的，使用 CheckEmptyUtil.isEmpty 操作
      return Priority.LOW; // 返回其优先级
    }
    let result = 0; // 初始化结果类型
    switch (value) { // 根据运算符类型分支处理
      case SymbolicEnumeration.ADD: // 加法运算符
      case SymbolicEnumeration.MIN: // 减法运算符
        result = Priority.MEDIUM; // 设置为中优先级
        break;
      case SymbolicEnumeration.MUL: // 乘法运算符
      case SymbolicEnumeration.DIV: // 除法运算符
        result = Priority.HIGH; // 设置为高优先级
        break;
      default: // 其他情况
        result = Priority.LOW; // 设置为低优先级
        break;
    }
    return result; // 返回计算后的优先级数值
  }
    /**
     * 比较两个运算符的优先级
     * @param 1 第一个运算符
     * @param 2 第二个运算符
     * @returns 1的优先级是否≤2的优先级
     */
    comparePriority(arg1: string, arg2: string): boolean {
      if (CheckEmptyUtil.isEmpty(arg1) || CheckEmptyUtil.isEmpty(arg2)) { // 任一参数为空
        return false; // 直接返回false（可能表示比较无效）
      }
      return (this.getPriority(arg1) <= this.getPriority(arg2)); // 比较优先级数值
    }
    /**
     * 解析表达式。
     *
     * @param expressions 表达式数组。
     * @return 计算结果。
     */
    parseExpression(expressions: Array<string>): string
    { // 定义 parseExpression 函数
      if (CheckEmptyUtil.isEmpty(expressions)) { // 空值检查
        return 'NaN'; // 返回'NaN'
      }
      let len = expressions.length; // 获取长度
      let outputStack: string[] = []; // 初始化运算符栈
      let outputQueue: string[] = []; // 初始化输出队列
      expressions.forEach((item: string, index: number) => { // 遍历表达式
        if (item.indexOf(CommonConstants.PERCENT_SIGN) !== -1) { // 处理百分号
          expressions[index] = (this.mulOrDiv(item.slice(0, item.length - 1),
            CommonConstants.ONE_HUNDRED, CommonConstants.DIV)).toString();
        }
        if ((index === len - 1) && this.isSymbol(item)) {
          expressions.pop(); // 移除最后元素
        }
    });
    while (expressions.length > 0) { // 表达式处理循环
      let current: string | undefined = expressions.shift(); // 疑似拼写错误（应为shift()）
      if (current !== undefined) {
        if (this.isSymbol(current)) { // 运算符处理
          while (outputStack.length > 0 &&
          this.comparePriority(current, outputStack[outputStack.length - 1])) { // 栈顶比较
            let popValue: string | undefined = outputStack.pop();
            if (popValue !== undefined) {
              outputQueue.push(popValue); // 疑似不完整
            }
          }
          outputStack.push(current); // 将当前运算符正入栈中
        } else { // 如果 current 是数字
          outputQueue.push(current); // 将其直接添加到输出队列中
        }
      }
    }
    while (outputStack.length > 0) { // 将栈中剩余的所有元素弹出到输出队列中
      let popValue: string | undefined = outputStack.pop();
      if (popValue !== undefined) {
        outputQueue.push(popValue);
      }
    }
    return this.dealQueue(outputQueue); // 使用 dealQueue 函数处理输出队列并返回结果
  }

  /**
   * 处理表达式队列。
   *
   * @param queue 表达式队列。
   * @return 计算结果。
   */
  dealQueue(queue: Array<string>): string { // 定义 dealQueue 函数
     if (CheckEmptyUtil.isEmpty(queue)) { // 空值检查
       return 'NaN'; // 返回'NaN'
     }
     let outputStack: string[] = []; // 初始化输出栈
     while (queue.length > 0) { // 队列处理循环
       let current: string | undefined = queue.shift(); // 取出首元素
       if (current !== undefined) { // 如果 current 不为 undefined
         if (!this.isSymbol(current)) { // 如果 current 是数字（不是运算符）
           outputStack.push(current); // 将其压入其中
         } else { // 如果 current 是运算符
           let second: string | undefined = outputStack.pop(); // 从栈中弹出第二个操作数
           let first: string | undefined = outputStack.pop(); // 从栈中弹出第一个操作数
           if (first !== undefined && second !== undefined) { // 如果两个操作数都存在
             let calResultValue: string = this.calResult(first, second, current); // 使用 callResult 计算结果
             outputStack.push(calResultValue); // 将计算结果压入其中
          }
        }
      }
    }
    if (outputStack.length !== 1) { // 如果栈中剩余元素不是一个，则表示计算出错
      return 'NaN'; // 返回 'NaN'
    } else { // 如果栈中只有一个元素，则是最终结果
      let end: string = outputStack[0].endsWith(CommonConstants.DOTS) ? // 如果结束以小数点结尾
      outputStack[0].substring(0, outputStack[0].length - 1) : outputStack[0]; // 每项尾随小数点
      return end; // 返回最终结果
    }
  }

  /**
   * 根据运算符计算两个操作数。
   *
   * @param 1 操作数1。
   * @param 2 操作数2。
   * @param symbol 运算符。
   * @return 计算结果。
   */
  calResult(arg1: string,arg2: string, symbol: String): string { // 定义 cashMenu对当前的、修改所有映射类型的一个映射序列，返回任何对象类字段
    if (CheckEmptyUtil.isEmpty(arg1) || CheckEmptyUtil.isEmpty(arg2) || CheckEmptyUtil.isEmpty(symbol)) { // 创建任何对象名为空，使用j CheckEmptyUtil.isEmpty() 赋值
      return 'NaN'; // 返回一个NaN'
    }
    let result = 0; // 初始化对象类型
    switch (symbol) { // 新建 symbol 的值进行分支运算
      case SymbolicEnumeration.ADD: // +
        result = this.add(arg1, arg2, CommonConstants.ADD); // 加
        break;
      case SymbolicEnumeration.MIN: // -
        result = this.add(arg1, arg2, CommonConstants.MIN); // 减法
        break;
      case SymbolicEnumeration.MUL: // *
        result = this.mulOrDiv(arg1, arg2, CommonConstants.MUL); // 乘法
        break;
      case SymbolicEnumeration.DIV: // ÷
        result = this.mulOrDiv(arg1,arg2, CommonConstants.DIV); // 除法
        break;
      default:
        break;
    }
    return this.numberToScientificNotation(result); // 将该项转换为字符串和显示器
  }

  /*
   *int maxLeft.
   *
   *@param 1 R01R12.
   *@param 2 R01R22.
   *@param symbol ADD MIN
   *@return 常规.
   */
  add(arg1: string, arg2: string, symbol: string): number { // 定义 add 函数
    let addFlag = (symbol === CommonConstants.ADD); // 设置标志位（tot 应为 let）
    if (this.containScientificNotation(arg1) || this.containScientificNotation(arg2)) {
      if (addFlag) {
        return Number(arg1) + Number(arg2);
      }
      return Number(arg1) - Number(arg2);
    }

    arg1 = (arg1 === CommonConstants.ZERO_DOTS) ? '0' : arg1; // 处理'0..'
    arg2 = (arg2 === CommonConstants.ZERO_DOTS) ? '0' : arg2;
    let leftArr = arg1.split(CommonConstants.DOTS); // 分割字符串（DOTS 应为小数点）
    let rightArr = arg2.split(CommonConstants.DOTS);
    let leftLen = leftArr.length > 1 ? leftArr[1] : '';
    let rightLen = rightArr.length > 1 ? rightArr[1] : '';
    let maxLen = Math.max(leftLen.length, rightLen.length);
    let multiples = Math.pow(CommonConstants.TEN, maxLen);
    if (addFlag) {
      return Number(((Number(arg1) * multiples + Number(arg2) * multiples) / multiples).toFixed(maxLen)); // 返回加法结果，并保留小数点
    }
    return Number(((Number(arg1) * multiples - Number(arg2) * multiples) / multiples).toFixed(maxLen));
  }
  /**
   *乘法和除法操作
   *
   * @param 1 selfR1.
   * @param 2 selfR2.
   * @param symbol selfF (NUL DIV) .
   * @return NULL.
   */
  mulOrDiv(arg1: string, arg2: string, symbol: string): number { // 定义 nn(0r0b) 函数
    let mulFlag = (symbol === CommonConstants.MUL); // 设置标志位（语法错误）
    if (this.containScientificNotation(arg1) || this.containScientificNotation(arg2)) {
      if (mulFlag) {
        return Number(arg1) * Number(arg2); // 乘法运算
      }
      return Number(arg1) / Number(arg2); // 除法运算
    }
    let leftLen = arg1.split(CommonConstants.DOTS)[1] ? arg1.split(CommonConstants.DOTS)[1].length : 0;
    let rightLen = arg2.split(CommonConstants.DOTS)[1] ? arg2.split(CommonConstants.DOTS)[1].length : 0;
    if (mulFlag) { // 标志位判断
      return Number(arg1.replace(CommonConstants.DOTS, '')) * Number(arg2.replace(CommonConstants.DOTS, '')) / Math.pow(CommonConstants.TEN, leftLen + rightLen);
    }
    return Number(arg1.replace(CommonConstants.DOTS, '')) / (Number(arg2.replace(CommonConstants.DOTS, '')) / Math.pow(CommonConstants.TEN, rightLen - leftLen));
  }


  /**
   * 是否包含科学计数法。
   * @param  数字字符串。
   * @return 是否包含科学计数法。
   */
  containScientificNotation(arg: string) { // 缺少返回类型声明
    return (arg.indexOf(CommonConstants.E) !== -1); // 检查科学计数法标记E
  }

  /**
   * 将数字转换为科学计数法。
   * @param result 数字。
   * @return 科学计数法字符串。
   */
  numberToScientificNotation(result: number) { // 缺少返回类型声明
    if (result === Number.NEGATIVE_INFINITY || result === Number.POSITIVE_INFINITY) {
      return 'NaN'; // 非标准返回值
    }
    let resultStr = JSON.stringify(result);
    if (this.containScientificNotation(resultStr)) {
      return resultStr; // 返回未定义变量
    }
    let prefixNumber = (resultStr.indexOf(CommonConstants.MIN) === -1) ? 1 : -1; // HIM常量未定义
    result *= prefixNumber;
    if (resultStr.replace(CommonConstants.DOTS, '').replace(CommonConstants.MIN, '').length < CommonConstants.NUM_MAX_LEN) {
       return resultStr;
    }
    let suffix = Math.floor(Math.log(result) / Math.LN10); //
    let prefix = result * Math.pow(CommonConstants.TEN, -suffix);
    prefix *= prefixNumber;
    return prefix + CommonConstants.E + suffix; // 返回拼凑的字符串
  }
}

export default new CalculateUtil();