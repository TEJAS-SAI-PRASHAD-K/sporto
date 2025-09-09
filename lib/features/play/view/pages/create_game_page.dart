import 'package:flutter/material.dart';

class CreateGamePage extends StatefulWidget {
  const CreateGamePage({super.key});

  @override
  State<CreateGamePage> createState() => _CreateGamePageState();
}

class _CreateGamePageState extends State<CreateGamePage> {
  bool isPublic = true;
  bool showAdvanced = false;

  String gameType = "Regular"; // for radio buttons
  bool gameSkill = false;
  bool payAndJoin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Create Game",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // sport/area/date/time tiles
            _buildOptionTile(
              icon: Icons.sports_soccer,
              title: "Sport",
              subtitle: "Eg. Badminton / Football / Cricket…",
            ),
            _buildOptionTile(
              icon: Icons.location_on_outlined,
              title: "Area",
              subtitle: "Locality or Venue Name",
            ),
            _buildOptionTile(
              icon: Icons.calendar_today_outlined,
              title: "Date",
              subtitle: "Pick a day",
            ),
            _buildOptionTile(
              icon: Icons.access_time,
              title: "Time",
              subtitle: "Pick Exact Time",
            ),

            const SizedBox(height: 24),
            const Text(
              "Game Access",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 12),

            _buildAccessButtons(),

            const SizedBox(height: 8),
            Text(
              isPublic
                  ? "This game can be discovered by all players on Playo"
                  : "This game can be accessed by anyone via shared link",
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),

            const SizedBox(height: 24),
            // Advanced Settings Toggle
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.settings_outlined),
              title: const Text("Advanced Settings"),
              trailing: AnimatedRotation(
                duration: const Duration(milliseconds: 200),
                turns: showAdvanced ? 0.25 : 0,
                child: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
              onTap: () {
                setState(() => showAdvanced = !showAdvanced);
              },
            ),

            if (showAdvanced) _buildAdvancedSettings(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "CREATE GAME",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.outline),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Theme.of(context).colorScheme.outline),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      contentPadding: EdgeInsets.zero,
      onTap: () {},
    );
  }

  Widget _buildAccessButtons() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => isPublic = true),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: isPublic
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isPublic
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outline,
                  width: 1.2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.public,
                    color: isPublic
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Public",
                    style: TextStyle(
                      color: isPublic
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => isPublic = false),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: !isPublic
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: !isPublic
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outline,
                  width: 1.2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock,
                    color: !isPublic
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Invite only",
                    style: TextStyle(
                      color: !isPublic
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAdvancedSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        // Game Skill Switch
        ListTile(
          contentPadding: EdgeInsets.all(8),
          title: const Text("Game Skill"),
          subtitle: const Text(
            "By default your overall rating skill for the sport will be taken as game skill.",
          ),
          trailing: Transform.scale(
            scale: 0.8,
            child: Switch(
              value: gameSkill,
              onChanged: (val) => setState(() => gameSkill = val),
            ),
          ),
        ),

        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            "Game Type",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        RadioListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text("Regular"),
          value: "Regular",
          groupValue: gameType,
          onChanged: (val) => setState(() => gameType = val.toString()),
        ),
        RadioListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text("Coaching"),
          value: "Coaching",
          groupValue: gameType,
          onChanged: (val) => setState(() => gameType = val.toString()),
        ),
        RadioListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text("Tournament"),
          value: "Tournament",
          groupValue: gameType,
          onChanged: (val) => setState(() => gameType = val.toString()),
        ),

        // Pay & Join Switch
        ListTile(
          contentPadding: EdgeInsets.all(8),
          title: const Text("Pay and Join"),
          trailing: Transform.scale(
            scale: 0.8, // adjust size here
            child: Switch(
              value: payAndJoin,
              onChanged: (val) => setState(() => payAndJoin = val),
            ),
          ),
        ),
      ],
    );
  }
}
