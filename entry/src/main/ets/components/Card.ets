import { BORDER_RADIUS } from '../constants/size';
import { rvp } from '../utils/responsive';

@Component
export default struct Card {
  @Prop cardPadding: number;
  @BuilderParam renderBuilder: () => void

  build() {
    Column() {
      this.renderBuilder()
    }
    .padding(this.cardPadding)
    .backgroundColor($r('app.color.white'))
    .borderRadius(rvp(BORDER_RADIUS))
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}