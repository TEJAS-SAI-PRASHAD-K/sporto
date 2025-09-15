import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playo/core/models/trainer.dart' as model;
// ...existing code... (removed unused import)
import 'package:playo/features/train/viewmodel/train_view_model.dart';

class InstantConnectBottomSheet extends ConsumerStatefulWidget {
  final model.Datum datum;
  const InstantConnectBottomSheet({super.key, required this.datum});

  static void show(BuildContext context, model.Datum trainer) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => InstantConnectBottomSheet(datum: trainer),
    );
  }

  @override
  ConsumerState<InstantConnectBottomSheet> createState() =>
      _InstantConnectBottomSheetState();
}

class _InstantConnectBottomSheetState
    extends ConsumerState<InstantConnectBottomSheet> {
  late TextEditingController _controller;
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.datum.trainer;
    final List<String> items = t.sportIds;
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.3,
      expand: false,
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Connect with ${t.firstName}',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Interested in",
                  hintText: 'Select a sport or activity',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                value: selectedValue,
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,
                minLines: 2,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Message',
                  hintText: 'Ask any queries',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 32,
                    horizontal: 16,
                  ),
                ),
              ),
              SizedBox(height: 150),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        final message = _controller.text;
                        try {
                          // Call view model
                          final vm = ref.read(trainViewModelProvider.notifier);
                          await vm.sendInstantMessageEmail(
                            datum: widget.datum,
                            sport: selectedValue,
                            message: message,
                          );
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Message sent successfully'),
                            ),
                          );
                          Navigator.of(context).pop();
                        } catch (e) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to send message: $e'),
                            ),
                          );
                        }
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text('Send Message'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
