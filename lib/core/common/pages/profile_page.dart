import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playo/core/common/pages/edit_profile_page.dart';
import '../../providers/current_user_provider.dart';
import '../../models/user.dart';

class ProfilePage extends ConsumerStatefulWidget {
  final String userId;

  const ProfilePage({super.key, required this.userId});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  User? _otherUser; // For storing other user's profile data
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    // Load user data when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserData();
    });
  }

  Future<void> _loadUserData() async {
    final currentUser = ref.read(currentUserNotifierProvider);
    final isCurrentUserProfile = currentUser?.userId == widget.userId;

    if (isCurrentUserProfile) {
      // Refresh current user data
      ref.read(currentUserNotifierProvider.notifier).refreshUser();
    } else {
      // Load other user's profile
      setState(() {
        _isLoading = true;
        _error = null;
      });

      try {
        final otherUser = await ref
            .read(currentUserNotifierProvider.notifier)
            .getUserProfile(widget.userId);

        if (mounted) {
          setState(() {
            _otherUser = otherUser;
            _isLoading = false;
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _error = e.toString();
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currentUser = ref.watch(currentUserNotifierProvider);

    // Check if viewing current user's profile
    final isCurrentUserProfile = currentUser?.userId == widget.userId;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: colorScheme.onSurface),
            onPressed: () {
              // TODO: Implement share functionality
            },
          ),
          if (isCurrentUserProfile)
            IconButton(
              icon: Icon(Icons.edit, color: colorScheme.onSurface),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              },
            ),
        ],
      ),
      body: _buildBody(currentUser, isCurrentUserProfile, colorScheme),
    );
  }

  Widget _buildBody(
    User? user,
    bool isCurrentUserProfile,
    ColorScheme colorScheme,
  ) {
    if (!isCurrentUserProfile) {
      // For other users' profiles, use _otherUser state
      if (_isLoading) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: colorScheme.primary),
              const SizedBox(height: 16),
              Text(
                'Loading profile...',
                style: TextStyle(fontSize: 16, color: colorScheme.onSurface),
              ),
            ],
          ),
        );
      }

      if (_error != null) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: colorScheme.error),
              const SizedBox(height: 16),
              Text(
                'Failed to load profile',
                style: TextStyle(fontSize: 18, color: colorScheme.error),
              ),
              const SizedBox(height: 8),
              Text(
                _error!,
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadUserData,
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      }

      if (_otherUser == null) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person_off_outlined,
                size: 64,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              Text(
                'User not found',
                style: TextStyle(fontSize: 18, color: colorScheme.onSurface),
              ),
            ],
          ),
        );
      }

      return _buildProfileContent(_otherUser!, colorScheme);
    }

    if (user == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              'Loading profile...',
              style: TextStyle(fontSize: 16, color: colorScheme.onSurface),
            ),
          ],
        ),
      );
    }

    return _buildProfileContent(user, colorScheme);
  }

  Widget _buildProfileContent(User user, ColorScheme colorScheme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Profile Header Card
          _buildProfileHeader(user, colorScheme),
          const SizedBox(height: 16),

          // Weekly Fit Goal Card
          _buildWeeklyFitGoal(colorScheme),
          const SizedBox(height: 16),

          // Activity Level Card
          _buildActivityLevel(colorScheme),
          const SizedBox(height: 16),

          // Badges Section
          _buildBadges(user, colorScheme),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(User user, ColorScheme colorScheme) {
    final displayName = '${user.firstName} ${user.lastName ?? ''}'.trim();
    final gamesCount = user.gamesPlayedCount;
    final playpalsCount = user.playpalsUserIds?.length ?? 0;
    final karmaScore = user.karmaScore;
    final lastPlayedText = _getLastPlayedText(user.updatedAt);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Profile Avatar
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: colorScheme.primaryContainer,
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: _buildAvatarImage(user, colorScheme),
                ),
              ),
              const SizedBox(width: 20),
              // Stats
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatColumn(gamesCount.toString(), 'Games'),
                    _buildStatColumn(playpalsCount.toString(), 'Playpals'),
                    _buildStatColumn(karmaScore.toString(), 'Karma'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // User Info
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  lastPlayedText,
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '0 NO SHOWS', // TODO: This will come from database schema you'll provide
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Recently Played Button
          _buildRecentlyPlayedButton(colorScheme),
        ],
      ),
    );
  }

  Widget _buildRecentlyPlayedButton(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: colorScheme.secondary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.history,
              color: colorScheme.onSecondary,
              size: 16,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Recently played',
            style: TextStyle(
              color: colorScheme.onSecondaryContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyFitGoal(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly fit goal',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Achieve 2X/week to maintain',
            style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          // Activity Levels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActivityLevelItem('Beginner', colorScheme.primary, false),
              _buildActivityLevelItem('Average', colorScheme.secondary, true),
              _buildActivityLevelItem('Expert', colorScheme.tertiary, false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityLevel(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Active Level',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActivityLevelItem('Low', colorScheme.error, false),
              _buildActivityLevelItem('Medium', colorScheme.primary, true),
              _buildActivityLevelItem('High', colorScheme.tertiary, false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityLevelItem(String label, Color color, bool isActive) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: isActive
                ? color.withValues(alpha: 0.2)
                : colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isActive ? color : colorScheme.outline,
              width: 2,
            ),
          ),
          child: Icon(
            Icons.show_chart,
            color: isActive ? color : colorScheme.onSurfaceVariant,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive
                ? colorScheme.onSurface
                : colorScheme.onSurfaceVariant,
            fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildBadges(User user, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Badges',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildBadge(
                'Completed',
                user.gamesPlayedCount.toString(),
                Icons.check_circle,
                colorScheme.primary,
              ),
              const SizedBox(width: 16),
              _buildBadge(
                'Karma',
                user.karmaScore.toString(),
                Icons.favorite,
                colorScheme.primary,
              ),
              const SizedBox(width: 16),
              _buildBadge(
                'Playpals',
                (user.playpalsUserIds?.length ?? 0).toString(),
                Icons.group,
                colorScheme.tertiary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String number, String label) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _buildBadge(String title, String count, IconData icon, Color color) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            count,
            style: TextStyle(
              fontSize: 16,
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarImage(User user, ColorScheme colorScheme) {
    // If no avatarUrl, show default asset image (same as main app bar)
    if (user.avatarUrl == null || user.avatarUrl!.isEmpty) {
      return Image.asset(
        "assets/images/boy_10.png",
        fit: BoxFit.cover,
        width: 80,
        height: 80,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallbackAvatar(user, colorScheme);
        },
      );
    }

    final avatarUrl = user.avatarUrl!;

    // Check if it's a network URL (starts with http/https)
    if (avatarUrl.startsWith('http://') || avatarUrl.startsWith('https://')) {
      return Image.network(
        avatarUrl,
        fit: BoxFit.cover,
        width: 80,
        height: 80,
        errorBuilder: (context, error, stackTrace) {
          // Fallback to default asset if network fails
          return Image.asset(
            "assets/images/boy_10.png",
            fit: BoxFit.cover,
            width: 80,
            height: 80,
            errorBuilder: (context, error, stackTrace) {
              return _buildFallbackAvatar(user, colorScheme);
            },
          );
        },
      );
    }

    // Otherwise, treat it as an asset path (from onboarding selection)
    final assetPath = avatarUrl.startsWith('assets/')
        ? avatarUrl
        : "assets/images/$avatarUrl";

    return Image.asset(
      assetPath,
      fit: BoxFit.cover,
      width: 80,
      height: 80,
      errorBuilder: (context, error, stackTrace) {
        // Fallback to default asset if custom asset fails
        return Image.asset(
          "assets/images/boy_10.png",
          fit: BoxFit.cover,
          width: 80,
          height: 80,
          errorBuilder: (context, error, stackTrace) {
            return _buildFallbackAvatar(user, colorScheme);
          },
        );
      },
    );
  }

  Widget _buildFallbackAvatar(User user, ColorScheme colorScheme) {
    // Create initials from user's name
    final firstName = user.firstName.trim();
    final lastName = user.lastName?.trim() ?? '';

    String initials;
    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      initials = '${firstName[0]}${lastName[0]}';
    } else if (firstName.isNotEmpty) {
      initials = firstName.length >= 2
          ? firstName.substring(0, 2)
          : firstName[0];
    } else {
      initials = 'U'; // Default to 'U' for User
    }

    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Center(
        child: Text(
          initials.toUpperCase(),
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }

  String _getLastPlayedText(DateTime? updatedAt) {
    if (updatedAt != null) {
      final now = DateTime.now();
      final difference = now.difference(updatedAt).inDays;

      if (difference == 0) {
        return 'Last played today';
      } else if (difference == 1) {
        return 'Last played yesterday';
      } else {
        final months = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ];
        final day = updatedAt.day;
        final month = months[updatedAt.month - 1];

        String daySuffix;
        if (day % 10 == 1 && day != 11) {
          daySuffix = 'st';
        } else if (day % 10 == 2 && day != 12) {
          daySuffix = 'nd';
        } else if (day % 10 == 3 && day != 13) {
          daySuffix = 'rd';
        } else {
          daySuffix = 'th';
        }

        return 'Last played on $day$daySuffix $month';
      }
    }
    return 'No recent activity';
  }
}
