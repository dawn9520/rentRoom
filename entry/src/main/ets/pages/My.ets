import { IColor } from '../models/HomeData'
import { getWindowTopHeight, rvp } from '../utils/responsive'
import { PADDING } from '../constants/size'
import type { IUserInfo } from '../models/UserData'
import { getUserInfoApi } from '../api/user'

import ScrollContainer from '../components/ScrollContainer'
import Bg from '../views/My/Bg'
import NavBar from '../views/My/NavBar'
import UserInfo from '../views/My/UserInfo'
import TimePlan from '../views/My/TimePlan'
import Order from '../views/My/Order'
import PlanList from '../views/My/PlanList'

@Component
export default struct My {
  @Prop @Watch('handleIsActiveTabChange') isActiveTab: boolean
  @State userInfo: IUserInfo = {
    id: 0,
    avatar: '',
    nickname: ''
  }

  aboutToAppear() {
    this.handleIsActiveTabChange()
  }

  handleIsActiveTabChange() {
    console.log('----33')
    if (this.isActiveTab) {
      const token = AppStorage.get('token') as string;
      console.log('----444', token)
      if (token) {
        console.log('---22')
        this.getUserInfo()
      }
    }
  }

  async getUserInfo() {
    this.userInfo = await getUserInfoApi()
    console.log('----11', JSON.stringify(this.userInfo))
  }

  @Builder
  navBuilder($$: IColor) {
    NavBar($$)
  }

  @Builder
  contentBuilder() {
    Stack() {
      Bg()
      Column() {
        UserInfo({ userInfo: this.userInfo })
        TimePlan()
        Order()
        PlanList()
      }.padding({ left: rvp(PADDING), right: rvp(PADDING), top: rvp(44) + getWindowTopHeight() })
    }.width('100%').align(Alignment.TopStart)
  }

  build() {
    ScrollContainer({
      contentBuilder: this.contentBuilder,
      navBuilder: this.navBuilder,
    })
  }
}