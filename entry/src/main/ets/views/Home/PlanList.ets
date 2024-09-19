import type { IPlanItem, IPlanList } from '../../models/HomeData';

@Component
export default struct PlanList {
  @Prop planList: IPlanList;

  build() {
    Row() {
      ForEach(this.planList, (plan: IPlanItem) => {
        Image(plan.imageURL).width(78).height(60).objectFit(ImageFit.Fill)
      }, (plan: IPlanItem) => plan.id + '')
    }.width('100%').margin({ top: 18 }).justifyContent(FlexAlign.SpaceBetween)
  }
}