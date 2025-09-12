import 'package:flutter/material.dart';
import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:playo/init_dependecies.dart';
import 'package:playo/core/models/sport.dart';

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

  // Selected values for the option tiles
  String? selectedSport;
  String? selectedSportId; // database sport_id corresponding to selectedSport
  String? selectedArea;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

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
              subtitle: selectedSport ?? "Select a Sport",
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
              subtitle: selectedTime == null
                  ? "Pick Exact Time"
                  : selectedTime!.format(context),
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

  // ----- Selection Handlers -----
  Future<void> _onSelectSport() async {
    final result = await Navigator.push<Sport>(
      context,
      MaterialPageRoute(builder: (_) => const SportSelectionPage()),
    );
    if (result != null) {
      setState(() {
        selectedSport = result.sportName;
        selectedSportId = result.sportId;
      });
    }
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
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
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
      setState(() => selectedTime = picked);
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
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

// ---------------- Helper Pages ----------------

class SportSelectionPage extends StatefulWidget {
  const SportSelectionPage({super.key});

  @override
  State<SportSelectionPage> createState() => _SportSelectionPageState();
}

class _SportSelectionPageState extends State<SportSelectionPage> {
  final _supabase = serviceLocator<SupabaseClient>();
  late Future<List<Sport>> _futureSports;
  List<Sport> _allSports = [];
  List<Sport> _filtered = [];
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _futureSports = _loadSports();
    _searchCtrl.addListener(_onSearchChanged);
  }

  Future<List<Sport>> _loadSports() async {
    // Fetch every active sport. Adjust selected columns to those mapped in model.
    final response = await _supabase
        .from('sports')
        .select(
          'sport_id, sport_name, icon_url, image_url, sport_category, is_sport_active',
        )
        .eq('is_sport_active', true)
        .order('sport_name');
    final sports = (response as List).map((e) => Sport.fromJson(e)).toList();
    _allSports = sports;
    _filtered = sports;
    return sports;
  }

  void _onSearchChanged() {
    final q = _searchCtrl.text.trim().toLowerCase();
    setState(() {
      if (q.isEmpty) {
        _filtered = _allSports;
      } else {
        _filtered = _allSports
            .where((s) => s.sportName.toLowerCase().contains(q))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Sport')),
      body: FutureBuilder<List<Sport>>(
        future: _futureSports,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return _ErrorRetry(
              message: 'Failed to load sports',
              error: snapshot.error?.toString(),
              onRetry: () {
                setState(() => _futureSports = _loadSports());
              },
            );
          }
          if (_filtered.isEmpty) {
            return Column(
              children: [
                _SearchBar(controller: _searchCtrl),
                const SizedBox(height: 32),
                const Text('No sports found'),
              ],
            );
          }
          return Column(
            children: [
              _SearchBar(controller: _searchCtrl),
              Expanded(
                child: ListView.separated(
                  itemCount: _filtered.length,
                  separatorBuilder: (_, __) => const Divider(height: 0),
                  itemBuilder: (context, index) {
                    final sport = _filtered[index];
                    return ListTile(
                      leading: sport.iconUrl != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(sport.iconUrl!),
                            )
                          : const CircleAvatar(child: Icon(Icons.sports)),
                      title: Text(sport.sportName),
                      onTap: () => Navigator.pop(context, sport),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  const _SearchBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search sport',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => controller.clear(),
                ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          isDense: true,
        ),
      ),
    );
  }
}

class _ErrorRetry extends StatelessWidget {
  final String message;
  final String? error;
  final VoidCallback onRetry;
  const _ErrorRetry({required this.message, this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, style: const TextStyle(fontWeight: FontWeight.w600)),
            if (error != null) ...[
              const SizedBox(height: 8),
              Text(
                error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

// Bottom sheet for searching/selecting location/area
class AreaSearchSheet extends StatefulWidget {
  final String? initialQuery;
  const AreaSearchSheet({super.key, this.initialQuery});

  @override
  State<AreaSearchSheet> createState() => _AreaSearchSheetState();
}

class _AreaSearchSheetState extends State<AreaSearchSheet> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _query = '';
  List<String> _results = [];
  bool _loading = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    if (widget.initialQuery != null) {
      _controller.text = widget.initialQuery!;
      _query = widget.initialQuery!;
    }
    // Auto focus slight delay to ensure bottom sheet animation finished
    Future.delayed(const Duration(milliseconds: 180), () {
      if (mounted) _focusNode.requestFocus();
    });
  }

  // Simulated async search; replace with real geocoding / Places API.
  Future<void> _performSearch(String q) async {
    if (q.trim().isEmpty) {
      setState(() {
        _results = [];
        _loading = false;
      });
      return;
    }
    setState(() => _loading = true);
    // Simulate network latency
    await Future.delayed(const Duration(milliseconds: 450));
    // For now just return query variants as placeholder.
    final base = q.trim();
    setState(() {
      _results = [base];
      _loading = false;
    });
  }

  void _onQueryChanged(String val) {
    _query = val;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      _performSearch(_query);
    });
    setState(() {}); // Refresh clear icon visibility & empty state message
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(bottom: viewInsets),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: scheme.outlineVariant.withOpacity(.6),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Search location or venue',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          tooltip: 'Clear',
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _controller.clear();
                              _query = '';
                            });
                          },
                        ),
                  filled: true,
                  fillColor: scheme.surfaceVariant.withOpacity(.4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
                onChanged: _onQueryChanged,
                onSubmitted: (val) {
                  if (val.trim().isNotEmpty) Navigator.pop(context, val.trim());
                },
              ),
            ),
            const SizedBox(height: 8),
            Expanded(child: _buildResults(scheme)),
          ],
        ),
      ),
    );
  }

  Widget _buildResults(ColorScheme scheme) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2.2));
    }
    if (_query.isEmpty) {
      return Center(
        child: Text(
          'Start typing to search locations',
          style: TextStyle(color: scheme.outline),
        ),
      );
    }
    if (_results.isEmpty) {
      return Center(
        child: Text(
          'No results for "$_query"',
          style: TextStyle(color: scheme.outline),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 24),
      itemCount: _results.length,
      separatorBuilder: (_, __) => const Divider(height: 0),
      itemBuilder: (context, index) {
        final area = _results[index];
        return ListTile(
          leading: const Icon(Icons.place_outlined),
          title: Text(area),
          onTap: () => Navigator.pop(context, area),
        );
      },
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
