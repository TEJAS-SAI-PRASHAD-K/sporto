// Simple singleton class to store selected avatar globally
class AvatarSelection {
  static final AvatarSelection _instance = AvatarSelection._internal();
  factory AvatarSelection() => _instance;
  AvatarSelection._internal();

  String _selectedAvatarPath = 'assets/images/boy_avatar.png'; // Default avatar
  
  String get selectedAvatarPath => _selectedAvatarPath;
  
  void selectAvatar(String avatarPath) {
    _selectedAvatarPath = avatarPath;
  }
  
  // Available avatar options
  static const List<String> availableAvatars = [
    'assets/images/boy_avatar.png',
    'assets/images/girl_avatar.png',
    'assets/images/boy_avatar.jpeg',
    'assets/images/girl_avatar.jpeg',
  ];
}
