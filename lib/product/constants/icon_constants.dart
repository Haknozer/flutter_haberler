enum IconConstants {
  applogo('app_logo'),
  ;

  final String value;

  const IconConstants(this.value);

  String get getIcon => "assets/icon/$value.png";
}
