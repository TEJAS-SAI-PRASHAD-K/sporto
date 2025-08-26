import 'package:flutter/material.dart';
import 'package:playo/features/train/model/trainer.dart';
import 'package:playo/features/train/view/widgets/connect_option_widget.dart';

class InstantConnectBottomSheet extends StatelessWidget {
  final Trainer trainer;

  const InstantConnectBottomSheet({super.key, required this.trainer});

  static void show(BuildContext context, Trainer trainer) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => InstantConnectBottomSheet(trainer: trainer),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                'Connect with ${trainer.name}',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    ConnectOptionWidget(
                      icon: Icons.video_call,
                      title: 'Video Call',
                      subtitle: 'Start an instant video session',
                      onTap: () {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Initiating video call...'),
                          ),
                        );
                      },
                    ),
                    ConnectOptionWidget(
                      icon: Icons.phone,
                      title: 'Voice Call',
                      subtitle: 'Start an instant voice call',
                      onTap: () {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Initiating voice call...'),
                          ),
                        );
                      },
                    ),
                    ConnectOptionWidget(
                      icon: Icons.message,
                      title: 'Send Message',
                      subtitle: 'Send a quick message',
                      onTap: () {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Opening chat...')),
                        );
                      },
                    ),
                    ConnectOptionWidget(
                      icon: Icons.calendar_today,
                      title: 'Schedule Session',
                      subtitle: 'Book a training session',
                      onTap: () {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Opening scheduler...')),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
