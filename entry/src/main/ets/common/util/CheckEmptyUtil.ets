class CheckEmptyUtil { // 定义 CheckEmptyUtil 类，用于检查各种数据是否为空
  /*
  * 检查对象是否为空。
  *
  * @param {object} obj 要检查的对象或字符串
  * @return {boolean} 如果为空返回 true
  */
  isEmpty(obj: object | string): boolean { // 定义 isEmpty 函数。接受一个对象或字符串参数 obj，返回布尔值
    return (typeof obj === 'undefined' || obj === null || obj === ''); // 返回 obj 是否为 undefined. null 或空字符串
      // - typeof obj === ' undefined' 检查 obj 是否未定义
      // - obj === null 检查 obj 是否为 null
      // - obj === '\ 检查 obj 是否为空字符串
  }



    /**
     *检查字符串是否为空。
     *
     *@param {string} str 要检查的字符串
     *@return {boolean} 如果为空返回 true
     */
    checkStrIsEmpty(str: string): boolean { // 定义 checkStrIsEmpty 函数，接受一个字符串参数 str，返回布尔值
      return str.trim().length === 0; // 返回去除首尾空白后字符串长度是否为 0
      // - str.trim() 移除字符串首尾的空白字符（如空格、箭头符号）
      // -.length === 0 检查去除空白后的字符串是否为空
    }

    /**
     * 检查数组是否为空。
     *
     *
     *@param {Array} arr 要检查的字符串数组
     *@return {boolean} 如果为空返回 true
     */
    isEmptyArr(arr: Array<string>): boolean { // 定义 isEmptyArr 函数，接受一个字符串数组参数 arr，返回布尔值
      return arr.length === 0; // 返回数组长度是否为 0
      // - arr.length 获取数组的元素个数
      // - === 0 检查数组是否为空
    }
}
export default new CheckEmptyUtil(); // 默认导出 CheckEmptyUtil 类的实例

