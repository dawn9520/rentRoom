import router from '@ohos.router'

import Avatar from '../../components/Avatar'

import { rvp } from '../../utils/responsive'
import type { IUserInfo } from '../../models/UserData'

@Component
export default struct UserInfo {
  @State avatarSrc: string = ''
  @Link userInfo: IUserInfo
  goLoginPhone = () => {
    router.pushUrl({ url: 'pages/Login/LoginPhone' })
  }

  build() {
    Row({ space: rvp(10) }) {
      Avatar({ src: this.avatarSrc, avatarSize: rvp(60) }).onClick(this.goLoginPhone)
      Column({ space: rvp(4) }) {
        Text(this.userInfo.nickname || '登录/注册')
          .fontSize(rvp(16))
          .fontColor($r('app.color.white'))
          .fontWeight(700)
        // Text('谷粒点15').fontSize(rvp(12)).fontColor($r('app.color.white'))
      }.alignItems(HorizontalAlign.Start).onClick(this.goLoginPhone)
    }.margin({ top: rvp(11) }).width('100%')
  }
}