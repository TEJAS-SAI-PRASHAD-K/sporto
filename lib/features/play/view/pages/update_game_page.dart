import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playo/core/models/game.dart' as core_game;
import 'package:playo/features/play/view/pages/create_game_page.dart'
    show AreaSearchSheet; // reuse area search
import 'package:playo/features/play/viewmodel/game_view_model.dart';

import '../../../../core/utils/show_snackbar.dart';

class UpdateGamePage extends StatefulWidget {
  const UpdateGamePage({super.key, required this.game});
  final core_game.Game game;

  @override
  State<UpdateGamePage> createState() => _UpdateGamePageState();
}

class _UpdateGamePageState extends State<UpdateGamePage> {
  String? selectedSportId;
  String? selectedSportName;
  String? selectedArea;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  TimeOfDay? selectedEndTime;

  bool isPublic = true;
  bool payAndJoin = false;
  double? costPerPlayer;
  int? totalPlayers;
  bool costShared = false;
  String gameType = 'Regular';
  bool gameSkill = false;
  bool bringYourOwnEquipment = false;

  final TextEditingController _instructionsCtrl = TextEditingController();
  bool showAdvanced = false;

  @override
  void initState() {
    super.initState();
    final g = widget.game;
    selectedSportId = g.sportId;
    selectedArea = g.venueName ?? g.areaOfGame ?? g.venueAddress;
    if (g.gameDate != null) selectedDate = g.gameDate;
    if (g.gameTime != null && g.gameTime!.isNotEmpty) {
      final parts = g.gameTime!.split(':');
      if (parts.length >= 2) {
        final h = int.tryParse(parts[0]) ?? 0;
        final m = int.tryParse(parts[1]) ?? 0;
        selectedTime = TimeOfDay(hour: h, minute: m);
      }
    }
    isPublic = (g.gameAccessType ?? 'Public') == 'Public';
    gameSkill = g.requiresApproval;
    _instructionsCtrl.text = g.notes ?? '';
    if (g.gameRules != null) {
      try {
        final rules = jsonDecode(g.gameRules!) as Map<String, dynamic>;
        payAndJoin = rules['pay_and_join'] == true;
        costPerPlayer = (rules['cost_per_player'] as num?)?.toDouble();
        totalPlayers = rules['total_players'] is int
            ? rules['total_players'] as int
            : int.tryParse('${rules['total_players']}');
        costShared = rules['cost_shared'] == true;
        gameType = (rules['game_type'] as String?) ?? gameType;
        bringYourOwnEquipment = rules['bring_your_own_equipment'] == true;
      } catch (_) {}
    }
  }

  @override
  void dispose() {
    _instructionsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
    body: Consumer(
      builder: (context, ref, _) {
        final async = ref.watch(gameViewModelProvider);
        final isLoading = async.isLoading;
        ref.listen(gameViewModelProvider, (_, next) {
          next.whenOrNull(
            error: (e, st) =>
                showSnackBar(context, e.toString(), SnackBarType.error),
          );
        });
        return Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildOptionTile(
                  icon: Icons.sports_soccer,
                  title: 'Sport',
                  subtitle:
                      selectedSportName ?? selectedSportId ?? 'Select a Sport',
                  onTap: _onSelectSport,
                ),
                _buildOptionTile(
                  icon: Icons.location_on_outlined,
                  title: 'Area',
                  subtitle: selectedArea ?? 'Locality or Venue Name',
                  onTap: _onSelectArea,
                ),
                _buildOptionTile(
                  icon: Icons.calendar_today_outlined,
                  title: 'Date',
                  subtitle: selectedDate == null
                      ? 'Pick a day'
                      : _formatDate(selectedDate!),
                  onTap: _onSelectDate,
                ),
                _buildOptionTile(
                  icon: Icons.access_time,
                  title: 'Time',
                  subtitle: _formatTimeTile(),
                  onTap: _onSelectTime,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Game Access',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const SizedBox(height: 12),
                _buildAccessButtons(),
                const SizedBox(height: 8),
                Text(
                  isPublic
                      ? 'This game can be discovered by all players on Playo'
                      : 'This game can be accessed by anyone via shared link',
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                const SizedBox(height: 24),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.settings_outlined),
                  title: const Text('Advanced Settings'),
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
                const SizedBox(height: 90),
              ],
            ),
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.12),
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        );
      },
    ),
    bottomNavigationBar: Consumer(
      builder: (context, ref, _) {
        final isLoading = ref.watch(gameViewModelProvider).isLoading;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: isLoading ? null : () => _onUpdateGame(ref),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
              ),
              child: Text(isLoading ? 'Updating...' : 'Update Game'),
            ),
          ),
        );
      },
    ),
  );

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) => ListTile(
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

  Widget _buildAccessButtons() => Row(
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
                  'Public',
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
                  'Invite only',
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

  Widget _buildAdvancedSettings() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
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
            onChanged: (v) => setState(() => gameSkill = v),
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
      for (final type in ['Regular', 'Coaching', 'Tournament'])
        RadioListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(type),
          value: type,
          groupValue: gameType,
          onChanged: (val) => setState(() => gameType = val.toString()),
        ),
      ListTile(
        contentPadding: const EdgeInsets.all(8),
        title: const Text('Pay and Join'),
        trailing: Transform.scale(
          scale: 0.8,
          child: Switch(
            value: payAndJoin,
            onChanged: (v) => setState(() => payAndJoin = v),
          ),
        ),
      ),
      if (payAndJoin) ...[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
            value: bringYourOwnEquipment,
            onChanged: (v) =>
                setState(() => bringYourOwnEquipment = v ?? false),
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

  Future<void> _onSelectSport() async {}
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
    final pick = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (pick != null) {
      setState(() {
        selectedTime = pick;
        selectedEndTime = null;
      });
      final end = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: (pick.hour + 1) % 24, minute: pick.minute),
      );
      if (end != null) setState(() => selectedEndTime = end);
    }
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}-${d.month.toString().padLeft(2, '0')}-${d.year}';
  String _formatTimeTile() {
    if (selectedTime == null) return 'Pick Exact Time';
    final start = selectedTime!.format(context);
    if (selectedEndTime == null) return start;
    return '$start - ${selectedEndTime!.format(context)}';
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
      final container = ProviderScope.containerOf(context, listen: false);
      final notifier = container.read(gameViewModelProvider.notifier);
      final res = await notifier.deleteGame(widget.game.gameId);
      res.when(
        data: (_) {
          if (mounted) Navigator.pop(context, 'deleted');
        },
        error: (e, st) =>
            showSnackBar(context, e.toString(), SnackBarType.error),
        loading: () {},
      );
    }
  }

  Future<void> _onUpdateGame(WidgetRef ref) async {
    final updates = <String, dynamic>{
      'game_access_type': isPublic ? 'Public' : 'Invite Only',
      'venue_name': selectedArea,
      'venue_address': selectedArea,
      'notes': _instructionsCtrl.text.trim().isEmpty
          ? null
          : _instructionsCtrl.text.trim(),
      'requires_approval': gameSkill,
    };
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
    final rules = <String, dynamic>{
      'pay_and_join': payAndJoin,
      'cost_per_player': costPerPlayer,
      'total_players': totalPlayers,
      'cost_shared': costShared,
      'game_type': gameType,
      'game_skill': gameSkill,
      'bring_your_own_equipment': bringYourOwnEquipment,
    }..removeWhere((k, v) => v == null);
    updates['game_rules'] = jsonEncode(rules);
    final res = await ref
        .read(gameViewModelProvider.notifier)
        .patchGame(widget.game.gameId, updates);
    res.when(
      data: (_) {
        if (mounted) Navigator.pop(context, 'updated');
      },
      error: (e, st) => showSnackBar(context, e.toString(), SnackBarType.error),
      loading: () {},
    );
  }
}
