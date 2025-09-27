import 'package:flutter/material.dart';

class ChangeAvatarSheet extends StatelessWidget {
  final List<String> avatarImages;
  final int? selectedIndex;
  final ValueChanged<int> onAvatarSelected;

  const ChangeAvatarSheet({
    super.key,
    required this.avatarImages,
    required this.selectedIndex,
    required this.onAvatarSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    int numRows = (avatarImages.length / 4).ceil();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Pick an Avatar',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: List.generate(numRows, (rowIndex) {
              int startIndex = rowIndex * 4;
              int endIndex = (rowIndex + 1) * 4;
              if (endIndex > avatarImages.length)
                endIndex = avatarImages.length;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(endIndex - startIndex, (index) {
                    int imageIndex = startIndex + index;
                    final isSelected = selectedIndex == imageIndex;
                    return GestureDetector(
                      onTap: () {
                        onAvatarSelected(imageIndex);
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          child: CircleAvatar(
                            radius: 38,
                            backgroundColor: isSelected
                                ? colorScheme.primary
                                : Colors.transparent,
                            child: CircleAvatar(
                              radius: isSelected ? 34 : 36,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(
                                avatarImages[imageIndex],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.upload, size: 20),
              label: const Text('Upload from Gallery'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                textStyle: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // TODO: Implement gallery upload logic
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
