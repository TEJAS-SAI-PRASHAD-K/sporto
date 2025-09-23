import 'package:flutter/material.dart';
import 'package:playo/features/play/view/pages/create_game_page.dart'
    show AreaSearchSheet; // reuse helper
import 'package:playo/features/play/repository/games_remote_repository.dart';
import 'package:playo/core/models/game.dart' as core_game;
import 'package:playo/init_dependecies.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';

class UpdateGamePage extends StatefulWidget {
  final core_game.Game game;
  const UpdateGamePage({super.key, required this.game});

  @override
  State<UpdateGamePage> createState() => _UpdateGamePageState();
}

class _UpdateGamePageState extends State<UpdateGamePage> {
  bool isPublic = true;
  bool showAdvanced = false;

  String gameType = "Regular"; // for radio buttons
  bool gameSkill = false;
  bool payAndJoin = false;
  double? costPerPlayer;
  int? totalPlayers;
  bool bringOwnEquipment = false;
  bool costShared = false;
  final TextEditingController _instructionsCtrl = TextEditingController();

  String? selectedSportName;
  String? selectedSportId;
  String? selectedArea;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  TimeOfDay? selectedEndTime;

  @override
  void initState() {
    super.initState();
    final g = widget.game;
    isPublic = (g.gameAccessType ?? 'Public') == 'Public';
    selectedSportId = g.sportId;
    selectedSportName = null; // resolve below
    selectedArea = g.venueName ?? g.areaOfGame;
    if (g.gameDate != null) {
      selectedDate = DateTime(
        g.gameDate!.year,
        g.gameDate!.month,
        g.gameDate!.day,
      );
    }
    if (g.gameTime != null) {
      final parts = g.gameTime!.split(':');
      selectedTime = TimeOfDay(
        hour: int.tryParse(parts[0]) ?? 0,
        minute: int.tryParse(parts[1]) ?? 0,
      );
      // default end time to +1 hr
      selectedEndTime = TimeOfDay(
        hour: ((int.tryParse(parts[0]) ?? 0) + 1) % 24,
        minute: int.tryParse(parts[1]) ?? 0,
      );
    }
    _instructionsCtrl.text = g.notes ?? '';
    gameSkill = g.requiresApproval;

    bringOwnEquipment = (g.equipmentRequired ?? '').toLowerCase().contains(
      'bring',
    );
    costShared = (g.equipmentRequired ?? '').toLowerCase().contains(
      'cost shared',
    );

    _loadSportName();
  }

  Future<void> _loadSportName() async {
    try {
      final id = selectedSportId;
      if (id == null) return;
      final supabase = serviceLocator<SupabaseClient>();
      final res = await supabase
          .from('sports')
          .select('sport_name')
          .eq('sport_id', id)
          .single();
      setState(() {
        selectedSportName = (res['sport_name'] as String?) ?? id;
      });
    } catch (_) {
      setState(() {
        selectedSportName = selectedSportId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Game',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: _onDeleteGame,
            child: const Text(
              'Delete Game',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildOptionTile(
              icon: Icons.sports_soccer,
              title: "Sport",
              subtitle:
                  selectedSportName ?? selectedSportId ?? "Select a Sport",
              onTap: _onSelectSport,
            ),
            _buildOptionTile(
              icon: Icons.location_on_outlined,
              title: "Area",
              subtitle: selectedArea ?? "Locality or Venue Name",
              onTap: _onSelectArea,
            ),
            _buildOptionTile(
              icon: Icons.calendar_today_outlined,
              title: "Date",
              subtitle: selectedDate == null
                  ? "Pick a day"
                  : _formatDate(selectedDate!),
              onTap: _onSelectDate,
            ),
            _buildOptionTile(
              icon: Icons.access_time,
              title: "Time",
              subtitle: _formatTimeTile(),
              onTap: _onSelectTime,
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
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.settings_outlined),
              title: const Text("Advanced Settings"),
              trailing: AnimatedRotation(
                duration: const Duration(milliseconds: 200),
                turns: showAdvanced ? 0.25 : 0,
                child: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
              onTap: () => setState(() => showAdvanced = !showAdvanced),
            ),
            if (showAdvanced) _buildAdvancedSettings(),
            const SizedBox(height: 16),
            _buildAddInstructionsSection(),
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
            onPressed: _onUpdateGame,
            child: const Text(
              "UPDATE GAME",
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
    required VoidCallback onTap,
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
      onTap: onTap,
    );
  }

  Future<void> _onSelectSport() async {
    // Optional: reuse SportSelectionPage if desired.
  }

  Future<void> _onSelectArea() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => AreaSearchSheet(initialQuery: selectedArea),
    );
    if (result != null && result.trim().isNotEmpty) {
      setState(() => selectedArea = result.trim());
    }
  }

  Future<void> _onSelectDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now.subtract(const Duration(days: 0)),
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  Future<void> _onSelectTime() async {
    final baseTheme = Theme.of(context);
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        final scheme = baseTheme.colorScheme;
        return Theme(
          data: baseTheme.copyWith(
            colorScheme: scheme.copyWith(
              primary: scheme.primary,
              onPrimary: scheme.onPrimary,
              surface: scheme.surface,
              onSurface: scheme.onSurface,
            ),
            timePickerTheme: TimePickerThemeData(
              dialBackgroundColor: scheme.surfaceVariant,
              dialHandColor: scheme.primary,
              dialTextColor: WidgetStateColor.resolveWith(
                (states) => states.contains(WidgetState.selected)
                    ? scheme.onPrimary
                    : scheme.onSurface,
              ),
              hourMinuteColor: WidgetStateColor.resolveWith(
                (states) => states.contains(WidgetState.selected)
                    ? scheme.primary
                    : scheme.surface,
              ),
              hourMinuteTextColor: WidgetStateColor.resolveWith(
                (states) => states.contains(WidgetState.selected)
                    ? scheme.onPrimary
                    : scheme.onSurface,
              ),
              entryModeIconColor: scheme.primary,
              helpTextStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: scheme.primary),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        selectedEndTime = null;
      });
      // Prompt for end time immediately
      final endPicked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: (picked.hour + 1) % 24,
          minute: picked.minute,
        ),
        builder: (context, child) {
          final scheme = Theme.of(context).colorScheme;
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: scheme.copyWith(
                primary: scheme.primary,
                onPrimary: scheme.onPrimary,
                surface: scheme.surface,
                onSurface: scheme.onSurface,
              ),
              timePickerTheme: TimePickerThemeData(
                dialBackgroundColor: scheme.surfaceVariant,
                dialHandColor: scheme.primary,
                dialTextColor: WidgetStateColor.resolveWith(
                  (states) => states.contains(WidgetState.selected)
                      ? scheme.onPrimary
                      : scheme.onSurface,
                ),
                hourMinuteColor: WidgetStateColor.resolveWith(
                  (states) => states.contains(WidgetState.selected)
                      ? scheme.primary
                      : scheme.surface,
                ),
                hourMinuteTextColor: WidgetStateColor.resolveWith(
                  (states) => states.contains(WidgetState.selected)
                      ? scheme.onPrimary
                      : scheme.onSurface,
                ),
                entryModeIconColor: scheme.primary,
                helpTextStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(foregroundColor: scheme.primary),
              ),
            ),
            child: child!,
          );
        },
      );
      if (endPicked != null) {
        setState(() => selectedEndTime = endPicked);
      }
    }
  }

  String _formatDate(DateTime date) =>
      "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";

  String _formatTimeTile() {
    if (selectedTime == null) return 'Pick Exact Time';
    final start = selectedTime!.format(context);
    if (selectedEndTime == null) return start;
    final end = selectedEndTime!.format(context);
    return '$start - $end';
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
        // Game Skill like Create Game
        ListTile(
          contentPadding: const EdgeInsets.all(8),
          title: const Text('Game Skill'),
          subtitle: const Text(
            'By default your overall rating skill for the sport will be taken as game skill.',
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
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Game Type',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        RadioListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Regular'),
          value: 'Regular',
          groupValue: gameType,
          onChanged: (val) => setState(() => gameType = val.toString()),
        ),
        RadioListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Coaching'),
          value: 'Coaching',
          groupValue: gameType,
          onChanged: (val) => setState(() => gameType = val.toString()),
        ),
        RadioListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Tournament'),
          value: 'Tournament',
          groupValue: gameType,
          onChanged: (val) => setState(() => gameType = val.toString()),
        ),

        // Pay & Join like Create Game
        ListTile(
          contentPadding: const EdgeInsets.all(8),
          title: const Text('Pay and Join'),
          trailing: Transform.scale(
            scale: 0.8,
            child: Switch(
              value: payAndJoin,
              onChanged: (val) => setState(() => payAndJoin = val),
            ),
          ),
        ),
        if (payAndJoin) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Cost Per Player',
                border: OutlineInputBorder(),
              ),
              onChanged: (v) =>
                  setState(() => costPerPlayer = double.tryParse(v)),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Total Players (including you)',
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => setState(() => totalPlayers = int.tryParse(v)),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAddInstructionsSection() {
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Instructions',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: bringOwnEquipment,
            onChanged: (v) => setState(() => bringOwnEquipment = v ?? false),
            title: const Text('Bring Your Own Equipment'),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: costShared,
            onChanged: (v) => setState(() => costShared = v ?? false),
            title: const Text('Cost Shared'),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _instructionsCtrl,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText:
                  'Use this space to tell others about the format of the game and other details',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onDeleteGame() async {
    final yes = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Are you sure you want to cancel the game?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('NO'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('YES'),
          ),
        ],
      ),
    );
    if (yes == true) {
      final supabase = serviceLocator<SupabaseClient>();
      final repo = GamesRemoteRepository(supabase);
      await repo.deleteGame(widget.game.gameId);
      if (!mounted) return;
      Navigator.pop(context, 'deleted');
    }
  }

  Future<void> _onUpdateGame() async {
    final updates = <String, dynamic>{
      'game_access_type': isPublic ? 'Public' : 'Invite Only',
      'venue_name': selectedArea,

      'venue_address': selectedArea,
      'notes': _instructionsCtrl.text.trim().isEmpty
          ? null
          : _instructionsCtrl.text.trim(),
      'requires_approval': gameSkill,
    };
    // Persist advanced and instruction options into game_rules JSON
    final rules = <String, dynamic>{
      'pay_and_join': payAndJoin,
      'cost_per_player': costPerPlayer,
      'total_players': totalPlayers,
      'cost_shared': costShared,
      'game_type': gameType,
      'game_skill': gameSkill,
      'bring_your_own_equipment': bringOwnEquipment,
    }..removeWhere((k, v) => v == null);
    updates['game_rules'] = jsonEncode(rules);
    if (selectedDate != null) {
      updates['game_date'] = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
      ).toIso8601String();
    }
    if (selectedTime != null) {
      final h = selectedTime!.hour.toString().padLeft(2, '0');
      final m = selectedTime!.minute.toString().padLeft(2, '0');
      updates['game_time'] = '$h:$m:00';
    }

    final supabase = serviceLocator<SupabaseClient>();
    final repo = GamesRemoteRepository(supabase);
    final either = await repo.patchGame(widget.game.gameId, updates);
    either.match(
      (_) => ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to update game'))),
      (_) {
        Navigator.pop(context, 'updated');
      },
    );
  }

  // removed in favor of top-right AppBar action
}
