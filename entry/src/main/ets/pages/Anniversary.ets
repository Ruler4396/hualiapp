import { CommonConstants } from '../common/constants/CommonConstants';
import preferences from '@ohos.data.preferences';
import promptAction from '@ohos.promptAction';

interface AnniversaryItem {
  id: string;
  title: string;
  date: string;
  days: number;
}

interface DatePickerResult {
  year: number;
  month: number;
  day: number;
}

@Entry
@Component
export struct Anniversary {
  @State anniversaryList: AnniversaryItem[] = [];
  @State showAddDialog: boolean = false;
  @State newTitle: string = '';
  @State newDate: string = '';
  private preferences: preferences.Preferences | null = null;

  async aboutToAppear() {
    // 初始化本地存储
    try {
      const context = getContext(this);
      this.preferences = await preferences.getPreferences(context, 'anniversary');
      await this.loadAnniversaryList();
    } catch (err) {
      console.error('Failed to initialize preferences:', err);
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
          days: this.calculateDays(item.date)
        };
        newList.push(newItem);
      }
      this.anniversaryList = newList;
    } catch (err) {
      console.error('Failed to load anniversary list:', err);
    }
  }

  calculateDays(dateStr: string): number {
    const today = new Date();
    const targetDate = new Date(dateStr);
    const diffTime = Math.abs(targetDate.getTime() - today.getTime());
    return Math.ceil(diffTime / (1000 * 60 * 60 * 24));
  }

  async addAnniversary() {
    if (this.newTitle && this.newDate) {
      const newItem: AnniversaryItem = {
        id: Date.now().toString(),
        title: this.newTitle,
        date: this.newDate,
        days: this.calculateDays(this.newDate)
      };
      this.anniversaryList.push(newItem);
      this.showAddDialog = false;
      this.newTitle = '';
      this.newDate = '';
      
      // 保存到本地存储
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

  async deleteAnniversary(id: string) {
    this.anniversaryList = this.anniversaryList.filter(item => item.id !== id);
    
    // 更新本地存储
    try {
      if (!this.preferences) {
        return;
      }
      await this.preferences.put('anniversaryList', JSON.stringify(this.anniversaryList));
      await this.preferences.flush();
    } catch (err) {
      console.error('Failed to update anniversary list:', err);
    }
  }

  build() {
    Stack() {
      Column() {
        // 标题栏
        Row() {
          Text('纪念日')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
          Blank()
          Button('添加')
            .onClick(() => {
              this.showAddDialog = true;
            })
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFF')

        // 纪念日列表
        List() {
          ForEach(this.anniversaryList, (item: AnniversaryItem) => {
            ListItem() {
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

                Button('删除')
                  .fontSize(14)
                  .backgroundColor('#FF6B6B')
                  .margin({ left: 8 })
                  .onClick(() => {
                    this.deleteAnniversary(item.id);
                  })
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#FFFFFF')
              .borderRadius(8)
              .margin({ bottom: 8 })
            }
          })
        }
        .width('100%')
        .padding(16)
        .layoutWeight(1)
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
            .onChange((value: DatePickerResult) => {
              this.newDate = `${value.year}-${value.month}-${value.day}`;
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
      }
    }
    .width('100%')
    .height('100%')
  }
} 