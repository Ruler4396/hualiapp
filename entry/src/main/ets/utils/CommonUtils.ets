class HobbyItem {
  label?: string;
  isChecked?: boolean;
}

export class CommonUtils {
  getBirthDateValue(year:number,month:number,day:number):string{
    let resourceYear = getContext(this).resourceManager.getStringSync($r('app.string.year'));
    let resourceMonth = getContext(this).resourceManager.getStringSync($r('app.string.month'));
    let resourceDay = getContext(this).resourceManager.getStringSync($r('app.string.day'));
    let birthdate: string = `${year}年${month}`+`月${day}日`;
    return birthdate;
  }

  isEmpty(obj: object|string):boolean{
    return obj === undefined || obj === null || obj ==='';
  }

  isEmptyArr(array: Array<HobbyItem>):boolean{
    return this.isEmpty(array)||array.length === 0;
  }
}

export default new CommonUtils();