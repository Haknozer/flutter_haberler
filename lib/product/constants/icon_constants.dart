enum IconConstants {
  applogo('app_logo'),
  share('share'),
  ;

  final String value;

  const IconConstants(this.value);

  String get getIcon => "assets/icon/$value.png";
}
