import { SHADOW_RADIUS } from '../../constants/size';
import { rvp } from '../../utils/responsive'

@Component
export default struct Ad {
  @Prop adPicture: string;

  build() {
    Image(this.adPicture)
      .width('100%')
      .height(rvp(61))
      .objectFit(ImageFit.Fill) // 不保持宽高比进行放大缩小，使得图片充满显示边界。
      .margin({ top: rvp(9) })
      .shadow({ // 可以为当前组件添加阴影效果
        radius: SHADOW_RADIUS,
        color: $r('app.color.shadow'),
        offsetX: 0,
        offsetY: 0
      })
  }
}