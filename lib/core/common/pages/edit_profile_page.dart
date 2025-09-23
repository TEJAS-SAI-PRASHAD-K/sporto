import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playo/core/providers/current_user_provider.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';

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

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  String? _bioError;
  final TextEditingController _bioController = TextEditingController();
  // Removed unused _formKey
  bool _isSaving = false;
  String? _firstNameError;
  String? _lastNameError;
  String? _emailError;
  String? _phoneError;

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w\-.]+@[\w\-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    // Accepts numbers with optional +country code, spaces, dashes, and min 10 digits
    final phoneRegex = RegExp(r'^(\+\d{1,4}[\s-]?)?(\d[\d\s-]{9,})$');
    // Remove non-digit chars and check at least 10 digits
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    return phoneRegex.hasMatch(phone) && digits.length >= 10;
  }

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _gender;
  int? _selectedAvatarIndex;
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
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => ChangeAvatarSheet(
        avatarImages: avatarImages,
        selectedIndex: _selectedAvatarIndex,
        onAvatarSelected: (index) {
          setState(() {
            _selectedAvatarIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required ColorScheme colorScheme,
    TextInputType? textInputType,
    Widget? suffixIcon,
    ValueChanged<String>? onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        filled: true,
        fillColor: colorScheme.surface,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      style: TextStyle(color: colorScheme.onSurface),
      onChanged: onChanged,
    );
  }

  Widget _buildSectionHeader(String title, ColorScheme colorScheme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required ColorScheme colorScheme,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        filled: true,
        fillColor: colorScheme.surface,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      style: TextStyle(color: colorScheme.onSurface),
      items: items
          .map(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e, style: TextStyle(color: colorScheme.onSurface)),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    // Use ref.watch(currentUserNotifierProvider) directly in field logic

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Profile',
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Builder(
              builder: (context) {
                final allFieldsFilled =
                    _firstNameController.text.trim().isNotEmpty &&
                    _lastNameController.text.trim().isNotEmpty &&
                    _emailController.text.trim().isNotEmpty &&
                    _phoneController.text.trim().isNotEmpty;
                final allFieldsValid =
                    _firstNameError == null &&
                    _lastNameError == null &&
                    _emailError == null &&
                    _phoneError == null;
                final isEnabled = allFieldsFilled && allFieldsValid;
                return ElevatedButton(
                  onPressed: isEnabled && !_isSaving
                      ? () async {
                          setState(() => _isSaving = true);
                          final user = ref.watch(currentUserNotifierProvider);
                          try {
                            await ref
                                .read(currentUserNotifierProvider.notifier)
                                .updateUserProfile(
                                  firstName:
                                      _firstNameController.text.trim() !=
                                          (user?.firstName ?? "")
                                      ? _firstNameController.text.trim()
                                      : null,
                                  lastName:
                                      _lastNameController.text.trim() !=
                                          (user?.lastName ?? "")
                                      ? _lastNameController.text.trim()
                                      : null,
                                  mobileNumber:
                                      _phoneController.text.trim() !=
                                          (user?.mobileNumber ?? "")
                                      ? _phoneController.text.trim()
                                      : null,
                                  avatarUrl: _selectedAvatarIndex != null
                                      ? avatarImages[_selectedAvatarIndex!]
                                      : null,
                                  gender: _gender,
                                  bio:
                                      _bioController.text.trim() !=
                                          (user?.bio ?? "")
                                      ? _bioController.text.trim()
                                      : null,
                                );
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: colorScheme.onPrimary,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Profile Updated!",
                                              style: TextStyle(
                                                color: colorScheme.onPrimary,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              "Your profile has been successfully saved.",
                                              style: TextStyle(
                                                color: colorScheme.onPrimary
                                                    .withValues(alpha: 0.9),
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  backgroundColor: colorScheme.primary,
                                  duration: const Duration(seconds: 4),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            }
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Failed to update profile: $e'),
                                ),
                              );
                            }
                          } finally {
                            if (mounted) setState(() => _isSaving = false);
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isEnabled
                        ? colorScheme.primary
                        : colorScheme.outline.withValues(alpha: 0.3),
                    foregroundColor: isEnabled
                        ? colorScheme.onPrimary
                        : colorScheme.onSurfaceVariant,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                  child: _isSaving
                      ? SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              colorScheme.onPrimary,
                            ),
                          ),
                        )
                      : Text(
                          'SAVE',
                          style: textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _showAvatarPicker,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorScheme.primaryContainer,
                      ),
                      child: ClipOval(
                        child: _selectedAvatarIndex != null
                            ? Image.asset(
                                avatarImages[_selectedAvatarIndex!],
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                              )
                            : Image.asset(
                                "assets/images/boy_10.png",
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _showAvatarPicker,
                    child: Text(
                      'Change Profile Picture',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildTextField(
              label: 'First Name',
              controller: _firstNameController,
              colorScheme: colorScheme,
              textInputType: TextInputType.name,
              suffixIcon: _firstNameError != null
                  ? Icon(Icons.error, color: colorScheme.error)
                  : (_firstNameController.text.trim().isNotEmpty &&
                            _firstNameError == null
                        ? Icon(Icons.check_circle, color: colorScheme.primary)
                        : null),
              onChanged: (val) {
                setState(() {
                  _firstNameError = val.trim().isEmpty
                      ? 'First name is required'
                      : null;
                });
              },
            ),
            if (_firstNameError != null)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _firstNameError!,
                    style: TextStyle(color: colorScheme.error, fontSize: 12),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Last Name',
              controller: _lastNameController,
              colorScheme: colorScheme,
              textInputType: TextInputType.name,
              suffixIcon: _lastNameError != null
                  ? Icon(Icons.error, color: colorScheme.error)
                  : (_lastNameController.text.trim().isNotEmpty &&
                            _lastNameError == null
                        ? Icon(Icons.check_circle, color: colorScheme.primary)
                        : null),
              onChanged: (val) {
                setState(() {
                  _lastNameError = val.trim().isEmpty
                      ? 'Last name is required'
                      : null;
                });
              },
            ),
            if (_lastNameError != null)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _lastNameError!,
                    style: TextStyle(color: colorScheme.error, fontSize: 12),
                  ),
                ),
              ),
            const SizedBox(height: 32),
            _buildSectionHeader('CONTACT DETAILS', colorScheme),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Email',
              controller: _emailController,
              colorScheme: colorScheme,
              textInputType: TextInputType.emailAddress,
              suffixIcon: _emailError != null
                  ? Icon(Icons.error, color: colorScheme.error)
                  : (_emailController.text.trim().isNotEmpty &&
                            _emailError == null
                        ? Icon(Icons.check_circle, color: colorScheme.primary)
                        : null),
              onChanged: (val) {
                setState(() {
                  _emailError = !_isValidEmail(val.trim())
                      ? 'Enter a valid email'
                      : null;
                });
              },
            ),
            if (_emailError != null)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _emailError!,
                    style: TextStyle(color: colorScheme.error, fontSize: 12),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Phone',
              controller: _phoneController,
              colorScheme: colorScheme,
              textInputType: TextInputType.phone,
              suffixIcon: _phoneError != null
                  ? Icon(Icons.error, color: colorScheme.error)
                  : (_phoneController.text.trim().isNotEmpty &&
                            _phoneError == null
                        ? Icon(Icons.check_circle, color: colorScheme.primary)
                        : null),
              onChanged: (val) {
                setState(() {
                  _phoneError = !_isValidPhone(val.trim())
                      ? 'Enter a valid phone number'
                      : null;
                });
              },
            ),
            if (_phoneError != null)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _phoneError!,
                    style: TextStyle(color: colorScheme.error, fontSize: 12),
                  ),
                ),
              ),
            const SizedBox(height: 32),
            _buildSectionHeader('ABOUT', colorScheme),
            const SizedBox(height: 16),
            _buildDropdownField(
              label: 'Gender',
              value: _gender,
              items: const ['Male', 'Female', 'Other'],
              onChanged: (val) => setState(() => _gender = val),
              colorScheme: colorScheme,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Bio',
              controller: _bioController,
              colorScheme: colorScheme,
              textInputType: TextInputType.multiline,
              suffixIcon: _bioError != null
                  ? Icon(Icons.error, color: colorScheme.error)
                  : (_bioController.text.trim().isNotEmpty && _bioError == null
                        ? Icon(Icons.check_circle, color: colorScheme.primary)
                        : null),
              onChanged: (val) {
                setState(() {
                  _bioError = val.trim().length > 200
                      ? 'Bio must be under 200 characters'
                      : null;
                });
              },
            ),
            if (_bioError != null)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _bioError!,
                    style: TextStyle(color: colorScheme.error, fontSize: 12),
                  ),
                ),
              ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
