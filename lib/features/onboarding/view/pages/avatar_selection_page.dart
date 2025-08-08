import 'package:flutter/material.dart';
import 'package:playo/features/onboarding/view/pages/pick_your_fav_sports_page.dart';

class AvatarSelectionPage extends StatefulWidget {
  const AvatarSelectionPage({super.key});

  @override
  State<AvatarSelectionPage> createState() => _AvatarSelectionPageState();
}

class _AvatarSelectionPageState extends State<AvatarSelectionPage> {
  int? selectedAvatarIndex;

  final List<String> avatarImages = [
    'assets/images/boy_1.png',
    'assets/images/girl_9.png',
    'assets/images/boy_8.png',
    'assets/images/girl_11.png',
    'assets/images/boy_9.png',
    'assets/images/girl_10.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Complete Your Profile',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            // Centered title
            Center(
              child: Text(
                'Choose Your Avatar',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Scrollable avatar grid with animations
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: avatarImages.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedAvatarIndex == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAvatarIndex = index;
                        });
                      },
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            width: isSelected ? 90 : 80,
                            height: isSelected ? 90 : 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: isSelected ? 2 : 0),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                avatarImages[index],
                                fit: BoxFit.cover,
                                width: isSelected ? 86 : 76,
                                height: isSelected ? 86 : 76,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: isSelected ? 1.0 : 0.0,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
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
                onTap: () {
                  // TODO: Implement gallery picker
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Gallery picker will be implemented here'),
                    ),
                  );
                },
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
                        Icons.photo_library_outlined,
                        color: Theme.of(context).colorScheme.primary,
                        size: 24,
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

            const Spacer(),

            // Continue Button
            if (selectedAvatarIndex != null)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to Complete Your Profile page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PickYourFavSportsPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
