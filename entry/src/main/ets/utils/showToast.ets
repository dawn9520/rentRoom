import promptAction from '@ohos.promptAction';

function getHalfHeight() {
  const windowHeight = AppStorage.get('windowHeight') as number || 2340 // 2340 是预览器默认高度，单位px
  const toastHeight = 40
  return (px2vp(windowHeight) + toastHeight) / 2
}

function showToast(message: string, duration: number = 1500) {
  promptAction.showToast({
    message,
    duration,
    bottom: getHalfHeight()
  })
}

export default showToast