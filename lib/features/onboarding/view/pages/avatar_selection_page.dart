import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:playo/features/onboarding/view/pages/pick_your_fav_sports_page.dart';
import 'package:playo/features/onboarding/viewmodel/auth_view_model.dart';

class AvatarSelectionPage extends ConsumerStatefulWidget {
  const AvatarSelectionPage({super.key});

  @override
  ConsumerState<AvatarSelectionPage> createState() =>
      _AvatarSelectionPageState();
}

class _AvatarSelectionPageState extends ConsumerState<AvatarSelectionPage> {
  int? selectedAvatarIndex;

  final List<String> avatarImages = [
    'assets/images/boy_1.png',
    'assets/images/girl_9.png',
    'assets/images/boy_8.png',
    'assets/images/girl_8.png',
    'assets/images/boy_9.png',
    'assets/images/girl_10.png',
    'assets/images/girl_1.png',
    'assets/images/girl_2.png',
  ];
  @override
  Widget build(BuildContext context) {
    int numRows = (avatarImages.length / 4).ceil();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pick an Avatar',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Choose an avatar that best represents you',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 30),

              // Selected avatar preview
              if (selectedAvatarIndex != null)
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 45,
                  child: CircleAvatar(
                    radius: 43,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(
                      avatarImages[selectedAvatarIndex!],
                    ),
                  ),
                ),
              if (selectedAvatarIndex == null)
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage("assets/images/default.png"),
                ),
              const SizedBox(height: 30),

              // Avatar grid
              Column(
                children: List.generate(numRows, (rowIndex) {
                  int startIndex = rowIndex * 4;
                  int endIndex = (rowIndex + 1) * 4;
                  if (endIndex > avatarImages.length) {
                    endIndex = avatarImages.length;
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(endIndex - startIndex, (index) {
                        int imageIndex = startIndex + index;
                        final isSelected = selectedAvatarIndex == imageIndex;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedAvatarIndex = imageIndex;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              child: CircleAvatar(
                                radius: 38,
                                backgroundColor: isSelected
                                    ? Theme.of(context).colorScheme.primary
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

              const SizedBox(height: 40),

              // OR divider
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Theme.of(
                        context,
                      ).colorScheme.outline.withOpacity(0.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'OR',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Theme.of(
                        context,
                      ).colorScheme.outline.withOpacity(0.5),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Upload from gallery button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GestureDetector(
                  onTap: () {},
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.gallery,
                          color: Theme.of(context).colorScheme.primary,
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Upload from Gallery',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Continue Button
              if (selectedAvatarIndex != null)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    minimumSize: Size(MediaQuery.sizeOf(context).width / 2, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      // Save selected avatar to user profile
                      if (selectedAvatarIndex != null) {
                        await ref
                            .read(authViewModelProvider.notifier)
                            .updateUserAvatar(
                              profilePictureUrl:
                                  avatarImages[selectedAvatarIndex!],
                            );
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PickYourFavSportsPage(),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Error: $e')));
                    }
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
