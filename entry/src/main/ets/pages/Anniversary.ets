import { CommonConstants } from '../common/constants/CommonConstants';
import preferences from '@ohos.data.preferences';
import promptAction from '@ohos.promptAction';

interface AnniversaryItem {
  id: string;
  title: string;
  date: string;
  days: number;
  isFavorite: boolean;
}

interface DatePickerResult {
  year: number;
  month: number;
  day: number;
}

interface DialogResult {
  index: number;
}

@Component
export struct Anniversary {
  @State anniversaryList: AnniversaryItem[] = [];
  @State showAddDialog: boolean = false;
  @State newTitle: string = '';
  @State newDate: string = '';
  @State currentFavoriteIndex: number = 0;
  private preferences: preferences.Preferences | null = null;
  private animationDuration: number = 300;
  private favoriteTimer: number = -1;

  async aboutToAppear() {
    try {
      const context = getContext(this);
      this.preferences = await preferences.getPreferences(context, 'anniversary');
      await this.loadAnniversaryList();
      this.startFavoriteTimer();
    } catch (err) {
      console.error('Failed to initialize preferences:', err);
    }
  }

  aboutToDisappear() {
    this.stopFavoriteTimer();
  }

  startFavoriteTimer() {
    this.stopFavoriteTimer();
    const favoriteItems = this.anniversaryList.filter(item => item.isFavorite);
    if (favoriteItems.length > 1) {
      this.favoriteTimer = setInterval(() => {
        this.currentFavoriteIndex = (this.currentFavoriteIndex + 1) % favoriteItems.length;
      }, 2000);
    }
  }

  stopFavoriteTimer() {
    if (this.favoriteTimer !== -1) {
      clearInterval(this.favoriteTimer);
      this.favoriteTimer = -1;
    }
  }

  async loadAnniversaryList() {
    try {
      if (!this.preferences) {
        return;
      }
      const value = await this.preferences.get('anniversaryList', '[]');
      const list = JSON.parse(value as string) as AnniversaryItem[];
      const newList: AnniversaryItem[] = [];
      for (const item of list) {
        const newItem: AnniversaryItem = {
          id: item.id,
          title: item.title,
          date: item.date,
          days: this.calculateDays(item.date),
          isFavorite: item.isFavorite || false
        };
        newList.push(newItem);
      }
      this.anniversaryList = newList;
      this.startFavoriteTimer();
    } catch (err) {
      console.error('Failed to load anniversary list:', err);
    }
  }

  calculateDays(dateStr: string): number {
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const targetDate = new Date(dateStr);
    targetDate.setHours(0, 0, 0, 0);
    const diffTime = Math.abs(targetDate.getTime() - today.getTime());
    return Math.ceil(diffTime / (1000 * 60 * 60 * 24));
  }

  async addAnniversary() {
    if (this.newTitle && this.newDate) {
      const newItem: AnniversaryItem = {
        id: Date.now().toString(),
        title: this.newTitle,
        date: this.newDate,
        days: this.calculateDays(this.newDate),
        isFavorite: false
      };
      this.anniversaryList.push(newItem);
      this.showAddDialog = false;
      this.newTitle = '';
      this.newDate = '';
      
      try {
        if (!this.preferences) {
          return;
        }
        await this.preferences.put('anniversaryList', JSON.stringify(this.anniversaryList));
        await this.preferences.flush();
      } catch (err) {
        console.error('Failed to save anniversary list:', err);
      }
    }
  }

  async toggleFavorite(id: string) {
    const index = this.anniversaryList.findIndex(item => item.id === id);
    if (index !== -1) {
      this.anniversaryList = this.anniversaryList.map((item, idx) => {
        if (idx === index) {
          return {
            id: item.id,
            title: item.title,
            date: item.date,
            days: item.days,
            isFavorite: !item.isFavorite
          };
        }
        return item;
      });
      
      try {
        if (!this.preferences) {
          return;
        }
        await this.preferences.put('anniversaryList', JSON.stringify(this.anniversaryList));
        await this.preferences.flush();
        this.startFavoriteTimer();
      } catch (err) {
        console.error('Failed to update anniversary list:', err);
      }
    }
  }

  async deleteAnniversary(id: string) {
    const item = this.anniversaryList.find(item => item.id === id);
    if (item && item.isFavorite) {
      try {
        const result = await promptAction.showDialog({
          title: '确认删除',
          message: '确定要删除这个收藏的纪念日吗？',
          buttons: [
            { text: '取消', color: '#999999' },
            { text: '确定', color: '#FF6B6B' }
          ]
        });
        if (result.index === 1) {
          this.doDeleteAnniversary(id);
        }
      } catch (err) {
        console.error('Failed to show dialog:', err);
      }
    } else {
      this.doDeleteAnniversary(id);
    }
  }

  async doDeleteAnniversary(id: string) {
    this.anniversaryList = this.anniversaryList.filter(item => item.id !== id);
    try {
      if (!this.preferences) {
        return;
      }
      await this.preferences.put('anniversaryList', JSON.stringify(this.anniversaryList));
      await this.preferences.flush();
      this.startFavoriteTimer();
    } catch (err) {
      console.error('Failed to update anniversary list:', err);
    }
  }

  @Builder
  FavoriteSection() {
    Column() {
      if (this.anniversaryList.some(item => item.isFavorite)) {
        Swiper() {
          ForEach(this.anniversaryList.filter(item => item.isFavorite), (item: AnniversaryItem) => {
            Column() {
              Text(item.title)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .margin({ bottom: 8 })
              Text(item.date)
                .fontSize(18)
                .fontColor('#666666')
                .margin({ bottom: 16 })
              Text(item.days + '天')
                .fontSize(32)
                .fontColor('#FF6B6B')
                .fontWeight(FontWeight.Bold)
            }
            .width('100%')
            .padding(24)
            .backgroundColor('#FFFFFF')
            .borderRadius(16)
            .margin({ bottom: 16 })
            .animation({
              duration: this.animationDuration,
              curve: Curve.EaseInOut
            })
          })
        }
        .width('100%')
        .height('100%')
        .autoPlay(true)
        .interval(2000)
        .indicator(true)
        .loop(true)
      } else {
        Column() {
          Text('暂无收藏的纪念日')
            .fontSize(18)
            .fontColor('#999999')
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
    }
    .width('100%')
    .height('33%')
    .padding(16)
  }

  @Builder
  TimelineView() {
    Column() {
      ForEach(this.anniversaryList, (item: AnniversaryItem) => {
        Row() {
          Column() {
            Circle()
              .width(12)
              .height(12)
              .fill('#FF6B6B')
            Line()
              .width(2)
              .height(60)
              .backgroundColor('#FF6B6B')
          }
          .margin({ right: 16 })

          Column() {
            Row() {
              Column() {
                Text(item.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                Text(item.date)
                  .fontSize(14)
                  .margin({ top: 4 })
                  .fontColor('#666666')
              }
              .layoutWeight(1)

              Text(item.days + '天')
                .fontSize(16)
                .fontColor('#FF6B6B')

              Image(item.isFavorite ? $r('app.media.favorite_red') : $r('app.media.favorite_gray'))
                .width(24)
                .height(24)
                .margin({ left: 8 })
                .onClick(() => {
                  this.toggleFavorite(item.id);
                })

              Button('删除')
                .fontSize(14)
                .backgroundColor(item.isFavorite ? '#FFD700' : '#999999')
                .margin({ left: 8 })
                .onClick(() => {
                  this.deleteAnniversary(item.id);
                })
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
          }
          .layoutWeight(1)
        }
        .width('100%')
        .margin({ bottom: 16 })
        .animation({
          duration: this.animationDuration,
          curve: Curve.EaseInOut
        })
      })
    }
    .width('100%')
    .padding(16)
  }

  build() {
    Stack() {
      Column() {
        // 收藏的纪念日展示区
        this.FavoriteSection()

        // 时间轴视图
        Scroll() {
          this.TimelineView()
        }
        .width('100%')
        .layoutWeight(1)

        // 添加按钮
        Button('添加纪念日')
          .width('90%')
          .height(48)
          .margin({ bottom: 16 })
          .onClick(() => {
            this.showAddDialog = true;
          })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')

      // 添加纪念日对话框
      if (this.showAddDialog) {
        Column() {
          Text('添加纪念日')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 16 })

          TextInput({ placeholder: '请输入纪念日名称' })
            .width('100%')
            .height(40)
            .margin({ bottom: 16 })
            .onChange((value: string) => {
              this.newTitle = value;
            })

          DatePicker({
            start: new Date('1970-1-1'),
            end: new Date('2100-12-31'),
            selected: new Date()
          })
            .onDateChange((value: Date) => {
              const today = new Date();
              today.setHours(0, 0, 0, 0);
              const selectedDate = new Date(value);
              selectedDate.setHours(0, 0, 0, 0);
              
              if (selectedDate.getTime() === today.getTime()) {
                promptAction.showToast({ message: '不能选择今天作为纪念日' });
                return;
              }
              
              this.newDate = `${value.getFullYear()}-${value.getMonth() + 1}-${value.getDate()}`;
            })

          Row() {
            Button('取消')
              .onClick(() => {
                this.showAddDialog = false;
              })
            Button('确定')
              .onClick(() => {
                this.addAnniversary();
              })
          }
          .justifyContent(FlexAlign.SpaceAround)
          .width('100%')
          .margin({ top: 16 })
        }
        .width('90%')
        .padding(16)
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
        .animation({
          duration: this.animationDuration,
          curve: Curve.EaseInOut
        })
      }
    }
    .width('100%')
    .height('100%')
  }
}

@Entry
@Component
struct AnniversaryPage {
  build() {
    Column() {
      Anniversary()
    }
    .width('100%')
    .height('100%')
  }
} 