enum ImageConstants {
  onboardbuild('onboard_build'),
  welcomehands('welcome_hands'),
  ;

  final String value;

  const ImageConstants(this.value);

  String get getImage => "assets/image/$value.png";
}
