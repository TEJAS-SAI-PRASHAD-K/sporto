import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider to store the selected avatar information
final selectedAvatarProvider = StateNotifierProvider<AvatarNotifier, SelectedAvatar>((ref) {
  return AvatarNotifier();
});

class SelectedAvatar {
  final int? index;
  final String? imagePath;

  SelectedAvatar({this.index, this.imagePath});

  SelectedAvatar copyWith({int? index, String? imagePath}) {
    return SelectedAvatar(
      index: index ?? this.index,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}

class AvatarNotifier extends StateNotifier<SelectedAvatar> {
  AvatarNotifier() : super(SelectedAvatar(index: 0, imagePath: 'assets/images/boy_avatar.png')); // Default avatar

  // Available avatar images
  final List<String> avatarImages = [
    'assets/images/boy_avatar.png',
    'assets/images/girl_avatar.png',
    'assets/images/boy_avatar.jpeg',
    'assets/images/girl_avatar.jpeg',
  ];

  void selectAvatar(int index) {
    if (index >= 0 && index < avatarImages.length) {
      state = state.copyWith(
        index: index,
        imagePath: avatarImages[index],
      );
    }
  }

  void clearSelection() {
    state = SelectedAvatar();
  }

  String? get selectedAvatarPath => state.imagePath;
  int? get selectedAvatarIndex => state.index;
}
