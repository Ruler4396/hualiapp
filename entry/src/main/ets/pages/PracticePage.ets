import { AnswerStatus } from '../enums/AnswerStatus'
import { PracticeStatus } from '../enums/PracticeStatus'
import { Question, getRandomQuestions } from '../models/Question'
import { promptAction } from '@kit.ArkUI'
import { OptionStatus } from '../enums/OptionStatus'
import { convertMillisecondsToTime } from '../utils/DateUtil'

@Entry
@Component
export struct PracticePage {
  @State practiceStatus: PracticeStatus = PracticeStatus.Stopped
  @State totalCount: number = 10
  @State question: Question[] = getRandomQuestions(this.totalCount)
  @State currentIndex: number = 0
  @State answerStatus: AnswerStatus = AnswerStatus.Answering
  @State selectedOption: string = ''
  @State answeredCount: number = 0
  @State rightCount: number = 0
  timeUsed: number = 0
  //controller声明
  timerController: TextTimerController = new TextTimerController()
  dialogController: CustomDialogController = new CustomDialogController({
    builder: ResultDialog({
      answeredCount: this.answeredCount,
      rightCount: this.rightCount,
      timeUsed: this.timeUsed,
      resetPractice: () => {
        this.question = getRandomQuestions(this.totalCount)
        this.currentIndex = 0
        this.selectedOption = ''
        this.answeredCount = 0
        this.rightCount = 0
        this.timeUsed = 0
        this.timerController.reset()
        this.answerStatus = AnswerStatus.Answering
      },
      startPractice: () => {
        this.startPractice()
      }
    }),
    customStyle: true,
    autoCancel: false
  })

  startPractice() {
    this.practiceStatus = PracticeStatus.Running
    // 启动定时器
    this.timerController.start()
  }

  pausedPractice() {
    this.practiceStatus = PracticeStatus.Paused
    // 暂停定时器
    this.timerController.pause()
  }

  stopPractice() {
    this.practiceStatus = PracticeStatus.Stopped
    // 暂停定时器
    this.timerController.pause()
    // 弹框
    this.dialogController.open()
  }

  build() {
    Column() {
      // 统计面板
      Column() {
        // 准确率
        StatItem({
          icon: $r('app.media.ic_accuracy'),
          name: '准确率',
          fontColor: Color.Black,
        }) {
          Text((this.answeredCount === 0 ? 0 : this.rightCount / this.answeredCount * 100).toFixed() + '%')
            .width(100)
            .textAlign(TextAlign.Center)
        }

        // 进度
        StatItem({
          icon: $r('app.media.ic_progress'),
          name: '进度',
          fontColor: Color.Black,
        }) {
          Progress({
            value: this.answeredCount,
            total: this.totalCount
          })
            .width(100)

        }

        // 个数
        StatItem({
          icon: $r('app.media.ic_count'),
          name: '个数',
          fontColor: Color.Black,
        }) {
          Button(this.totalCount.toString())
            .width(100)
            .height(25)
            .backgroundColor('#EBEBEB')
            .fontColor(Color.Black)
            .enabled(this.practiceStatus === PracticeStatus.Stopped)
            .onClick(() => {
              TextPickerDialog.show({
                range: ['5', '10', '15', '20'],
                value: this.totalCount.toString(),
                onAccept: (res) => {
                  this.totalCount = parseInt(res.value as string)
                  this.question = getRandomQuestions(this.totalCount)
                }
              })
            })
        }

        // 进度
        StatItem({
          icon: $r('app.media.ic_timer'),
          name: '用时',
          fontColor: Color.Black,
        }) {
          Row() {
            TextTimer({ controller: this.timerController })
              .onTimer((utc: number, elapsedTime: number) => {
                this.timeUsed = elapsedTime
              })
          }
          .width(100)
          .justifyContent(FlexAlign.Center)
        }
      }
      .statBgStyle()

      // 单词
      Column({ space: 10 }) {
        Text(this.question[this.currentIndex].word).wordStyle()
        Text(this.question[this.currentIndex].sentence).sentenceStyle()
      }

      // 选项按钮
      Column({ space: 10 }) {
        ForEach(this.question[this.currentIndex].options, (option: string) => {
          OptionBotton({
            option,
            answerStatus: this.answerStatus,
            answer: this.question[this.currentIndex].answer,
            selectedOption: this.selectedOption
          })
            .enabled(this.answerStatus === AnswerStatus.Answering)
            .onClick(() => {
              // 判断练习状态
              if (this.practiceStatus !== PracticeStatus.Running) {
                promptAction.showToast({
                  message: '请先点击开始测试'
                })
                return
              }
              // 判断正误
              this.selectedOption = option

              // 更新统计信息
              this.answeredCount++
              if (option === this.question[this.currentIndex].answer) {
                this.rightCount++
              }

              this.answerStatus = AnswerStatus.Answered

              if (this.currentIndex < this.question.length - 1) {
                setTimeout(() => {
                  this.currentIndex++
                  this.answerStatus = AnswerStatus.Answering
                }, 500)
              } else {
                this.stopPractice()
              }
            })
        })
      }

      // 测试按钮
      Row({ space: 10 }) {
        Button("停⽌测试")
          .controlButtonStyle({
            bg: Color.Transparent,
            border: this.practiceStatus === PracticeStatus.Stopped ? Color.Gray : Color.Black,
            font: this.practiceStatus === PracticeStatus.Stopped ? Color.Black : Color.Gray
          })
          .enabled(this.practiceStatus !== PracticeStatus.Stopped)
          .onClick(() => {
            // 停⽌测试
            this.stopPractice()
          })

        Button(this.practiceStatus === PracticeStatus.Running ? '暂停测试' : '开始测试')
          .controlButtonStyle({
            bg: this.practiceStatus === PracticeStatus.Running ? '#555555' : Color.Black,
            border: this.practiceStatus === PracticeStatus.Running ? '#555555' : Color.Black,
            font: Color.White
          })
          .onClick(() => {
            if (this.practiceStatus === PracticeStatus.Running) {
              // 暂停测试
              this.pausedPractice()
            } else {
              // 开始测试
              this.startPractice()
            }
          })
      }

    }.practiceBgStyle()
  }
}

// 这里，content属性被赋予了一个有效的默认值 MyContentFunction，这是一个满足 () => void 类型的函数。这样，即使在组件的其他部分没有显式地为content赋值，它也能在 build 方法中安全地被调用，因为它总是有一个有效的函数值。
@Builder
function MyContentFunction(): void {
}

// 弹框
@CustomDialog
struct ResultDialog {
  answeredCount: number = 0;
  rightCount: number = 0;
  timeUsed: number = 0;
  resetPractice: () => void = MyContentFunction;
  startPractice: () => void = MyContentFunction;
  controller: CustomDialogController = new CustomDialogController({
    builder: ResultDialog()
  })

  build() {
    Column({ space: 10 }) {
      Image($r('app.media.ic_close'))
        .width(25)
        .height(25)
        .alignSelf(ItemAlign.End)
        .onClick(() => {
          this.controller.close()
          this.resetPractice()
        })

      Column({ space: 10 }) {
        Image($r('app.media.img_post'))
          .width('100%')
          .borderRadius(10)

        StatItem({
          icon: $r('app.media.ic_timer'),
          name: '用时',
          fontColor: Color.Black
        }) {
          Text(convertMillisecondsToTime(this.timeUsed))
        }

        StatItem({
          icon: $r('app.media.ic_accuracy'),
          name: '准确率',
          fontColor: Color.Black
        }) {
          Text((this.answeredCount === 0 ? 0 :
            this.rightCount / this.answeredCount as number * 100).toFixed() + '%')
        }

        StatItem({
          icon: $r('app.media.ic_count'),
          name: '个数',
          fontColor: Color.Black
        }) {
          Text(this.answeredCount.toString())
        }

        Divider()

        Row({ space: 30 }) {
          Button('再来一局')
            .controlButtonStyle({
              bg: Color.Transparent,
              font: Color.Black,
              border: Color.Black
            })
            .onClick(() => {
              this.controller.close()
              this.resetPractice()
              this.startPractice()
            })
          Button('登录打卡')
            .controlButtonStyle({
              bg: Color.Black,
              font: Color.White,
              border: Color.Black
            })
            .onClick(() => {
              this.controller.close()
              this.resetPractice()
              // todo: 登录并打卡
            })
        }

      }
      .backgroundColor(Color.White)
      .width('100%')
      .padding(20)
      .borderRadius(10)
    }
    .backgroundColor(Color.Transparent)
    .width('80%')
  }
}


// 统计面板公共组件
@Component
struct StatItem {
  icon?: Resource;
  name?: string
  @BuilderParam statComp: () => void = MyContentFunction
  fontColor?: Color

  build() {
    Row({ space: 10 }) {
      Image(this.icon)
        .height(14)
        .width(14)
      Text(this.name)
        .fontWeight(FontWeight.Medium)
        .fontSize(14)
        .fontColor(this.fontColor)
      Blank()
      this.statComp()
    }
    .width('100%')
    .height(30)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

// 选项按钮公共组件
@Component
struct OptionBotton {
  option?: string // 选项
  answer?: string // 答案
  @State optionStatus: OptionStatus = OptionStatus.Default
  @Prop selectedOption: string = ''
  @Prop @Watch('answerStatusChange') answerStatus: AnswerStatus

  // 监听回答状态
  answerStatusChange() {
    if (this.option === this.answer) {
      this.optionStatus = OptionStatus.Right
    } else {
      if (this.option === this.selectedOption) {
        this.optionStatus = OptionStatus.Wrong
      } else {
        this.optionStatus = OptionStatus.Default
      }
    }

  }

  // 背景颜色
  getBgColor() {
    switch (this.optionStatus) {
      case OptionStatus.Right:
        return '#1DBF7B'
      case OptionStatus.Wrong:
        return '#FA635F'
      default:
        return Color.White
    }
  }

  build() {
    Stack() {
      Button(this.option)
        .optionButtonStyle({
          bg: this.getBgColor(),
          font: this.optionStatus === OptionStatus.Default ? Color.Black : Color.White
        })

      if (this.optionStatus === OptionStatus.Right) {
        Image($r('app.media.ic_right'))
          .width(22)
          .height(22)
          .offset({ x: 10 })
      } else if (this.optionStatus === OptionStatus.Wrong) {
        Image($r('app.media.ic_wrong'))
          .width(22)
          .height(22)
          .offset({ x: 10 })
      }
    }
    .alignContent(Alignment.Start)

  }
}

// ⻚⾯背景
@Extend(Column)
function practiceBgStyle() {
  .width('100%')
  .height('100%')
  .backgroundImage($r('app.media.img_practice_bg'))
  .backgroundImageSize({ width: '100%', height: '100%' })
  .justifyContent(FlexAlign.SpaceEvenly)
}

// 统计面板
@Styles
function statBgStyle() {
  .width('90%')
  .backgroundColor(Color.White)
  .padding(20)
  .borderRadius(10)
}

// 单词
@Extend(Text)
function wordStyle() {
  .fontSize(50)
  .fontWeight(FontWeight.Bold)
}

// 例句
@Extend(Text)
function sentenceStyle() {
  .height(40)
  .fontSize(16)
  .fontColor('#9BA1A5')
  .fontWeight(FontWeight.Medium)
  .width('80%')
  .textAlign(TextAlign.Center)
}

// 选项按钮
interface colorInt {
  bg: ResourceColor,
  font: ResourceColor
}

@Extend(Button)
function optionButtonStyle(color: colorInt) {
  .width(240)
  .height(48)
  .fontSize(16)
  .type(ButtonType.Normal)
  .fontWeight(FontWeight.Medium)
  .borderRadius(10)
  .backgroundColor(color.bg)
  .fontColor(color.font)
}

// 控制按钮
interface controlColorInt {
  bg: ResourceColor,
  border: ResourceColor,
  font: ResourceColor
}

@Extend(Button)
function controlButtonStyle(color: controlColorInt) {
  .fontSize(16)
  .borderWidth(1)
  .backgroundColor(color.bg)
  .borderColor(color.border)
  .fontColor(color.font)
}