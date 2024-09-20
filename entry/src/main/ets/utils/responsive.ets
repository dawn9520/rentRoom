// 获取状态栏高度
export const getWindowTopHeight = () => {
  return px2vp(AppStorage.get('windowTopHeight') || 0)
}

// 获取底部高度
export const getWindowBottomHeight = () => {
  return px2vp(AppStorage.get('windowBottomHeight') || 0)
}

// 设计稿宽度
const DRAFT_WIDTH = 360

// 将元素按照原来比例进行转化
export function rvp(val: number) {
  /*
    * 设计稿总宽度：360 (固定值)
    * 设计稿某个元素大小：120 -> val
    * 实际设备屏幕宽度：400 -> 通过 window.getWindowProperties().windowRect.width 方式获取, 得到单位是 px，需要转 vp 计算
    * 元素实际大小：x
    * x / 400 = val / 360
    *
    * 解方程式得出: x = val / 360 * 实际设备屏幕宽度
   */
  if (AppStorage.get('windowWidth')) {
    return val / DRAFT_WIDTH * px2vp(AppStorage.get('windowWidth') as number)
  }
  // 预览器获取不到设备宽度直接返回val
  return val
}