const DAY_TIME = 1000 * 3600 * 24;

export interface IDateItem {
  date: string
  week: string
}

export type IDateList = IDateItem[]


function formatDate(time: number): IDateItem {
  const date = new Date(time);
  const year = date.getFullYear();
  const month = addZero(date.getMonth() + 1);
  const day = addZero(date.getDate());
  const week = date.getDay();
  return {
    date: `${year}-${month}-${day}`,
    week: getWeek(week)
  }
}

function getWeek(week: number): string {
  switch (week) {
    case 0:
      return '周日'
    case 1:
      return '周一'
    case 2:
      return '周二'
    case 3:
      return '周三'
    case 4:
      return '周四'
    case 5:
      return '周五'
    case 6:
      return '周六'
    default:
      return ''
  }
}

function addZero(val: number) {
  return val < 10 ? '0' + val : `${val}`;
}

export default function createDateList(): IDateList {
  const nowTime = Date.now();
  return Array.from({
    length: 7
  }).map((item, index) => {
    const result = formatDate(nowTime + index * DAY_TIME)
    if (index === 0) {
      result.week = '今天'
    }
    return result
  })
}