import router from '@ohos.router'

import NavBar from '../../components/NavBar'

import { getWindowTopHeight, rvp } from '../../utils/responsive'
import { PHONE_REG } from '../../constants/regs'
import showToast from '../../utils/showToast'

@Entry
@Component
struct LoginPhone {
  @State phone: string = ''
  @State isPhoneValid: boolean = false
  @State isAgree: boolean = false
  @State isBtnActive: boolean = false;

  // 验证手机号
  handleInputChange(val: string) {
    this.phone = val;
    this.isPhoneValid = PHONE_REG.test(val);
    this.handleBtnActive()
  }

  // 协议确认
  handleAgree = () => {
    this.isAgree = !this.isAgree;
    this.handleBtnActive()
  }

  // 获取验证码按钮功能
  handleBtnActive() {
    if (this.isAgree && this.isPhoneValid) {
      this.isBtnActive = true
    } else {
      this.isBtnActive = false
    }
  }

  // 点击跳转LoginCode页面
  goLoginCode = () => {
    if (!this.isBtnActive) {
      return;
    }
    if (!this.isPhoneValid) {
      showToast('手机号不符合格式')
      return;
    }
    // 验证码在下一个页面发送
    router.pushUrl({ url: 'pages/Login/LoginCode', params: { phone: this.phone } })
  }

  @Builder
  LoginPhoneForm() {
    Column() {
      Stack() {
        TextInput({ placeholder: '请输入手机号' })
          .inputStyles()
          .onChange((value: string) => {
            this.handleInputChange(value)
          })
        if (this.isPhoneValid) {
          Image($r('app.media.success')).width(rvp(12)).height(rvp(8)).margin({ right: rvp(5) })
        }
      }.alignContent(Alignment.End)

      Divider().color('#C4EDCE')
      Row() {
        Image(this.isAgree ? $r('app.media.radio_active') : $r('app.media.radio'))
          .width(rvp(14))
          .height(rvp(14))
          .onClick(this.handleAgree)
        Text() {
          Span('同意').fontSize(rvp(12)).fontColor('#C1C1C1')
          Span('《用户协议》').fontSize(rvp(12)).fontColor($r('app.color.primary'))
          Span('和').fontSize(rvp(12)).fontColor('#C1C1C1')
          Span('《隐私政策》').fontSize(rvp(12)).fontColor($r('app.color.primary'))
        }.margin({ left: rvp(6) })
      }.margin({ top: rvp(16) }).width('100%')

      Button('获取验证码')
        .margin({ top: rvp(40) })
        .backgroundColor(this.isBtnActive ? $r('app.color.primary') : '#F0F0F0')
        .fontSize(rvp(12))
        .fontColor(this.isBtnActive ? $r('app.color.white') : '#C1C1C1')
        .padding({
          top: rvp(12),
          bottom: rvp(12),
          left: rvp(15),
          right: rvp(15)
        })
        .onClick(this.goLoginCode)
    }.margin({ top: rvp(47) }).padding({ left: rvp(37), right: rvp(37) }).alignItems(HorizontalAlign.End)
  }

  build() {
    Column() {
      // SafeArea()
      NavBar({ title: '验证码登录' }).margin({ top: getWindowTopHeight() })
      this.LoginPhoneForm()
    }
    .width('100%')
    .height('100%')
    .linearGradient({
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
  .placeholderFont({ size: rvp(16) })
  .caretColor('#C1C1C1')
  .type(InputType.PhoneNumber)
  .maxLength(11)
  .stateStyles({
    pressed: pressedStyles,
    clicked: pressedStyles
  })
}