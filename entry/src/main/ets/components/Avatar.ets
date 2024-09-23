@Component
export default struct Avatar {
  @Prop src: string
  @Prop avatarSize: number

  build() {
    Image(this.src || $r('app.media.userbac')).width(this.avatarSize).height(this.avatarSize).objectFit(ImageFit.Fill)
  }
}