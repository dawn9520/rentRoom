import { window } from '@kit.ArkUI';

// 设置 window 状态栏颜色
 export const  setWindowStatusColor = async (color: string) => {
    const windowClass = await window.getLastWindow(getContext())
    windowClass.setWindowSystemBarProperties({
      statusBarContentColor: color,
    })
  }