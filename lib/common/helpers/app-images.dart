class AppImages {
  static const String github = 'github-icon.png';
  static const String skype = 'skype-icon.png';
  static const String slack = 'slack.png';
  static const String filter = 'assets/filter.png';
  static const String boroda = 'assets/mac_boroda.png';
  static const String noAvatar = 'assets/no-avatar.png';

  static String getIconByName(String iconName) {
    return 'assets/$iconName';
  }
}
