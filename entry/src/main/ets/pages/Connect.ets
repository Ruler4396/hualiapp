// 导入用户数据模型和路由模块
import { DefaultUserList, UserInfo } from '../models/user'
import { router } from '@kit.ArkUI'

// 使用 @Preview 注解方便预览。@Component 声明组件
@Preview
@Component
export default  struct Connect {
  // 使用 @State 创建响应式状态：搜索框内容
  @State
  @Watch('filterName') // 监听 searchName 变化，触发 filterName 方法
  searchName: string = ""

  // 过滤后的用户列表
  @State
  filterList: UserInfo[] = []

  // 监听函数：当 searchName 变化时调用，更新 filterList
  filterName() {
    this.filterList = DefaultUserList.filter((userInfo: UserInfo) => {
      return userInfo.username.includes(this.searchName) // 筛选用户名中包含 searchName 的用户
    })
  }

  // 生命周期节点：组件即将显示时调用，初始加载所有用户
  aboutToAppear(): void {
    this.filterList = DefaultUserList
  }

  // 构建组件 UI
  build() {
    Column() { // 垂直布局容器

      // 搜索输入框组件
      Search({ placeholder: "搜索", value: $$this.searchName }) // 双向绑定 searchName
        .height(30) // 高度设置为30
        .backgroundColor($r('app.color.white')) // 背景颜色为白色
        .borderRadius(4) // 圆角半径 4
        .margin(20) // 外边距 20

      // 列表组件，显示过滤后的用户
      List() {
        ForEach(this.filterList, (item: UserInfo) => { // 遍历过滤后的用户列表
          ListItem() { // 每个用户项
            Row({ space: 10 }) { // 行布局，元素间距为10
              Image(item.avatar)// 显示用户头像
                .width(30)
                .height(30)
                .borderRadius(4) // 圆角头像

              Column() { // 垂直展示用户名
                Text(item.username)// 用户名文本
                  .fontColor($r('app.color.text_primary'))// 字体颜色
                  .fontSize(14) // 字号
              }
              .layoutWeight(1) // 占据剩余空间
              .alignItems(HorizontalAlign.Start) // 左对齐
              .justifyContent(FlexAlign.Start) // 顶部对齐
            }
            .width('100%') // 宽度占满
            .height(60) // 每项高度为60
            .padding({
              left: 10,
              right: 10
            })
            .stateStyles({
              // 不同状态的背景色
              pressed: {
                .backgroundColor($r('app.color.back_color')) // 按压态背景色
              },
              normal: {
                .backgroundColor($r('app.color.white')) // 正常态背景色
              }
            })
          }
          // 列表项点击跳转至聊天详情页面，并传递当前用户数据
          .onClick(() => {
            router.pushUrl({
              url: 'pages/ChatDetail/ChatDetail', // 跳转的页面路径
              params: item // 携带的参数为用户对象
            })
          })
        }, (item: UserInfo) => item.user_id) // 使用 user_id 作为 key
      }
      .backgroundColor($r('app.color.white')) // 列表背景色
      .divider({ // 列表项之间的分割线
        strokeWidth: 1,
        color: $r('app.color.border_color') // 分割的颜色
      })
    }
    .backgroundColor($r('app.color.back_color')) // 页面背景色
    .height('100%') // 高度占满整个屏幕
  }
}

  // 导出组件