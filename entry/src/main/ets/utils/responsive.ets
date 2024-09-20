// 获取状态栏高度
export const getWindowTopHeight = () => {
  return px2vp(AppStorage.get('windowTopHeight') || 0)
}

// 获取底部高度
export const getWindowBottomHeight = () => {
  return px2vp(AppStorage.get('windowBottomHeight') || 0)
}