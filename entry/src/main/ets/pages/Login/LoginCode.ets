import router from '@ohos.router'

import NavBar from '../../components/NavBar'

import { getWindowTopHeight, rvp } from '../../utils/responsive'
import { loginApi, sendSMSCodeApi } from '../../api/user'
import showToast from '../../utils/showToast'
import { CODE_REG } from '../../constants/regs'

@Entry
@Component
struct LoginCode {
  @StorageLink('token') token: string = ''
  // 发送验证码
  @State phone: string = ''
  // 倒计时
  @State isSendCode: boolean = false
  @State time: number = 61;
  @State timeId: number = 0
  // 高亮
  @State code: string = ''
  @State isBtnActive: boolean = false
  sendSMSCode = async () => {
    this.startCountDown()
    this.isSendCode = true
    const code = await sendSMSCodeApi(this.phone)
    showToast(code)
  }
  // 登录
  login = async () => {
    try {
      const loginRes = await loginApi(this.phone, this.code);
      // 持久化存储 token
      this.token = loginRes.token
      // 跳转回去
      router.replaceUrl({ url: 'pages/Index', params: { currentIndex: 4 } })
    } catch {
      showToast('验证码不正确')
    }
  }

  aboutToAppear() {
    interface IParams {
      phone: string
    }

    const routerParams = router.getParams() as IParams
    this.phone = routerParams.phone;
    this.sendSMSCode()
  }

  // 倒计时
  startCountDown = () => {
    this.time--
    this.timeId = setInterval(() => {
      this.time--
      if (this.time <= 0) {
        this.time = 61
        clearInterval(this.timeId)
      }
    }, 1000)
  }

  aboutToDisappear() {
    clearInterval(this.timeId)
  }

  // 验证验证码
  handleInputChange = (val: string) => {
    this.code = val;
    this.isBtnActive = CODE_REG.test(val);
  }

  @Builder
  LoginCodeForm() {
    Column() {
      Stack() {
        TextInput({ placeholder: '请输入验证码' })
          .inputStyles()
          .onChange((value: string) => {
            this.handleInputChange(value)
          })
        if (this.time <= 60) {
          Text(`${this.time}s`).fontSize(rvp(20)).fontColor($r('app.color.primary'))
        } else if (this.isSendCode) {
          Text(`重新发送`).fontSize(rvp(14)).fontColor($r('app.color.primary')).onClick(this.sendSMSCode)
        }
      }.alignContent(Alignment.End)

      Divider().color('#C4EDCE')
      Button('确认')
        .margin({ top: rvp(40) })
        .backgroundColor(this.isBtnActive ? $r('app.color.primary') : '#F0F0F0')
        .fontSize(rvp(14))
        .width(rvp(100))
        .fontColor(this.isBtnActive ? $r('app.color.white') : '#C1C1C1')
        .padding({ top: rvp(12), bottom: rvp(12) })
        .enabled(this.isBtnActive)
        .onClick(this.login)
    }.margin({ top: rvp(47) }).padding({ left: rvp(37), right: rvp(37) }).alignItems(HorizontalAlign.End)
  }

  build() {
    Column() {
      NavBar({ title: '验证码登录' }).margin({ top: getWindowTopHeight() })
      this.LoginCodeForm()
    }
    .width('100%').height('100%').linearGradient({
      angle: 180,
      colors: [
        ['#DEFBE5', 0],
        ['#ffffff', 0.3],
        ['#ffffff', 1],
      ]
    })
  }
}

@Styles
function pressedStyles() {
  // 无法实现点击时，完全透明
  .backgroundColor('rgba(255, 255, 255, 0)')
  .borderRadius(0)
}

@Extend(TextInput)
function inputStyles() {
  .padding({
    left: 0,
    right: 0,
    top: 0,
    bottom: rvp(8)
  })
  .backgroundColor(Color.Transparent)
  .placeholderColor('#C1C1C1')
  .placeholderFont({ size: rvp(20) })
  .caretColor('#C1C1C1')
  .type(InputType.PhoneNumber)
  .maxLength(11)
  .stateStyles({
    pressed: pressedStyles,
    clicked: pressedStyles
  })
}