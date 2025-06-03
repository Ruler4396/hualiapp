import { hilog } from '@kit.PerformanceAnalysisKit'; // 导入 hiloq 模块，用于日志记录

class Logger { // 日志记录封装类
  private domain: number; // 服务域标识（16进制，0x0-0xFFFFF）
  private prefix: string; // 日志来源标识
  private format: string = '%[public]s, %[public]s'; // 默认日志格式模板

  /**
   * 构造函数
   * @param prefix 日志标签（默认'MyApp'）
   * @param domain 业务域（16进制，默认0xFF00）
   */
  constructor(prefix: string = 'MyApp', domain: number = 0xFF00) {
    this.prefix = prefix;
    this.domain = domain;
  }

  /**
   * 记录调试级别日志。
   *
   * @param args 可变数量的字符串参数，表示日志内容
   */
  debug(...args: string[]): void { // 定义 debug 方法
    hilog.debug(this.domain, this.prefix, this.format, args); // 调用 debug 日志
    // - this.domain 提供服务域
    // - this.prefix 提供日志前缀
    // - this.format 指定日志格式
    // - args 是日志的具体内容
  }

  /**
   * 记录信息级别日志。
   *
   * @param args 可变数量的字符串参数，表示日志内容
   */
  info(...args: string[]): void { // 定义 info 方法
    hilog.info(this.domain, this.prefix, this.format, args); // 调用 info 日志
    // - 参数含义同 debug 方法
  }

  /**
   * 记录警告级别日志。
   *
   * @param args 可变数量的字符串参数，表示日志内容
   */
  warn(...args: string[]): void { // 方法名疑似拼写错误（应为 warn）
    hilog.warn(this.domain, this.prefix, this.format, args); // 调用 warn 日志
    // - 参数含义同 debug 方法
  }

  /**
   * 记录错误级别日志。
   *
   * @param args 可变数量的字符串参数，表示日志内容
   */
  error(...args: string[]): void { // 定义 error 方法
    hilog.error(this.domain, this.prefix, this.format, args); // 调用 error 日志
    // - 参数含义同 debug 方法
  }
}

export default new Logger ('SimpleCalculator', 0xFF00); // 导出 Logger 实例
