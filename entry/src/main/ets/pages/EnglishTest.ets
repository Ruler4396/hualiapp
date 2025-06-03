import { PracticePage } from './PracticePage'

@Entry
@Component
export struct EnglishTest {
  @State message: string = 'Hello World'

  @StorageLink('currentTabIndex') currentTabIndex: number = 2
  @Consume('NavPathStack')
  NavPathStack : NavPathStack;

  build() {NavDestination() {

    Tabs({ index: this.currentTabIndex }) {
      TabContent() {
        PracticePage()

      }
      .tabBar(this.tabbarBuilder(0, '答题', $r('app.media.ic_practice'), $r('app.media.ic_practice_selected')))
    }
    .width('100%')
    .height('100%')
    .vertical(false)
    .barPosition(BarPosition.End)
    .onChange((index) => {
      this.currentTabIndex = index
    })
  }
  .onBackPressed(() => {
    this.NavPathStack.pop();
    return true;
  })
  .backgroundColor('#F1F3F5')
  .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  @Builder
  tabbarBuilder(tab_index: number,tab_title:string, tab_icon:Resource,tab_selected_icon:Resource) {
    Column() {
      Image(this.currentTabIndex === tab_index ? tab_selected_icon : tab_icon)
        .width(25)
        .height(25)

      Text(tab_title)
        .fontSize(16)
        .fontColor(this.currentTabIndex === tab_index ? '#ffaec6a2' : '#ff6b6767')
    }
    .width('100%')
    .backgroundColor('#fff')

  }
}