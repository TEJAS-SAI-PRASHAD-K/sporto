import 'package:flutter/material.dart';
import 'package:playo/core/common/widgets/filter_sort_bottom_sheet.dart';
import 'package:playo/features/play/view/widgets/contacts.dart';

class AddPlayersPage extends StatefulWidget {
  const AddPlayersPage({super.key});

  @override
  State<AddPlayersPage> createState() => _AddPlayersPageState();
}

class _AddPlayersPageState extends State<AddPlayersPage> {
  SortBy _sortBy = SortBy.recentlyAdded;
  final List<_Playpal> _playpals = const [
    _Playpal(name: 'Arun Kumar'),
    _Playpal(name: 'Divya Sharma'),
    _Playpal(name: 'Mahesh Babu'),
    _Playpal(name: 'Sahana Iyer'),
    _Playpal(name: 'Karthik R'),
  ];
  final Set<int> _selected = <int>{};
  int _contactsInvited = 0;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: const Text(
            'Add Players',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Center(
                child: Text(
                  'INVITED (${_selected.length + _contactsInvited})',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const Icon(Icons.more_vert),
            const SizedBox(width: 8),
          ],
          bottom: TabBar(
            labelColor: cs.primary,
            unselectedLabelColor: cs.onSurfaceVariant,
            indicatorColor: cs.primary,
            tabs: const [
              Tab(text: 'Playpals'),
              Tab(text: 'Contacts'),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search By Name, Number or Email',
                  filled: true,
                  fillColor: cs.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TabBarView(
                children: [
                  // Playpals tab
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final res = await showFilterSortBottomSheet(
                                  context,
                                  initialSort: _sortBy,
                                );
                                if (res != null) {
                                  setState(() => _sortBy = res.sortBy);
                                }
                              },
                              child: const _FilterChipButton(
                                icon: Icons.filter_alt_outlined,
                                label: 'Filter',
                              ),
                            ),
                            const SizedBox(width: 8),
                            _FilterChipButton(
                              icon: Icons.tag_outlined,
                              label: sortByLabel(_sortBy),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: _playpals.isEmpty
                            ? const _NoPlaypalsPlaceholder()
                            : ListView.separated(
                                itemCount: _playpals.length,
                                separatorBuilder: (_, __) =>
                                    const Divider(height: 1),
                                itemBuilder: (context, index) {
                                  final p = _playpals[index];
                                  final selected = _selected.contains(index);
                                  return ListTile(
                                    onTap: () {
                                      setState(() {
                                        if (selected) {
                                          _selected.remove(index);
                                        } else {
                                          _selected.add(index);
                                        }
                                      });
                                    },
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 2,
                                    ),
                                    leading: CircleAvatar(
                                      backgroundColor: cs.primary,
                                      child: Icon(
                                        Icons.person,
                                        color: cs.onPrimary,
                                      ),
                                    ),
                                    title: Text(p.name),
                                    trailing: Checkbox.adaptive(
                                      value: selected,
                                      onChanged: (v) {
                                        setState(() {
                                          if (v == true) {
                                            _selected.add(index);
                                          } else {
                                            _selected.remove(index);
                                          }
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),

                  // Contacts tab
                  Contacts(
                    items: [
                      ContactItem(
                        name: 'Tejas  K',
                        skill: 'NO SKILL',
                        lastGameAt: DateTime.now().subtract(
                          const Duration(days: 2),
                        ),
                      ),
                      ContactItem(
                        name: 'Kranthi Akurathi',
                        skill: 'INTERMEDIATE',
                        lastGameAt: DateTime.now().subtract(
                          const Duration(days: 60),
                        ),
                      ),
                      ContactItem(
                        name: 'Apoorva Rayala',
                        skill: 'NO SKILL',
                        lastGameAt: DateTime.now().subtract(
                          const Duration(days: 60),
                        ),
                      ),
                      ContactItem(
                        name: 'Shyam Varshan',
                        skill: 'NO SKILL',
                        lastGameAt: DateTime.now().subtract(
                          const Duration(days: 300),
                        ),
                      ),
                      ContactItem(
                        name: 'Rohith Vasamsetti',
                        skill: 'NO SKILL',
                        lastGameAt: DateTime.now().subtract(
                          const Duration(days: 365),
                        ),
                      ),
                      ContactItem(
                        name: 'Tejas  K',
                        skill: 'NO SKILL',
                        lastGameAt: DateTime.now().subtract(
                          const Duration(days: 2),
                        ),
                      ),
                    ],
                    lastSyncedAt: DateTime.now().subtract(
                      const Duration(days: 4),
                    ),
                    onSyncNow: () {},
                    onInvite: (_) {
                      setState(() {
                        _contactsInvited++;
                      });
                    },
                    otherContacts: const [
                      OtherContact(
                        displayName: 'ashok',
                        phoneLabel: '6382881445',
                      ),
                      OtherContact(
                        displayName: 'sri',
                        phoneLabel: '9843419499',
                      ),
                      OtherContact(
                        displayName: 'raj',
                        phoneLabel: '9759847894',
                      ),
                    ],
                    onSendOtherContact: (oc) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Send to ${oc.displayName}')),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Bottom bar only for Playpals tab
            Builder(
              builder: (context) {
                final tc = DefaultTabController.of(context);
                return AnimatedBuilder(
                  animation: tc,
                  builder: (context, _) {
                    if (tc.index != 0) return const SizedBox.shrink();
                    return _InviteBottomBar(
                      enabled: _selected.isNotEmpty,
                      count: _selected.length,
                      cs: cs,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Playpal {
  final String name;
  const _Playpal({required this.name});
}

class _FilterChipButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _FilterChipButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: cs.onSurface),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: cs.onSurface)),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, size: 18),
        ],
      ),
    );
  }
}

class _InviteBottomBar extends StatelessWidget {
  final bool enabled;
  final int count;
  final ColorScheme cs;
  const _InviteBottomBar({
    required this.enabled,
    required this.count,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: enabled ? () {} : null,
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 16),
              ),
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Theme.of(context).colorScheme.surfaceContainerHighest;
                }
                return Theme.of(context).colorScheme.primary;
              }),
              foregroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Theme.of(context).colorScheme.onSurfaceVariant;
                }
                return Theme.of(context).colorScheme.onPrimary;
              }),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            child: Text('SEND INVITE ($count)'),
          ),
        ),
      ),
    );
  }
}

class _NoPlaypalsPlaceholder extends StatelessWidget {
  const _NoPlaypalsPlaceholder();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.group_outlined, size: 48, color: cs.onSurfaceVariant),
            const SizedBox(height: 12),
            Text(
              'No Playpals',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              "When you add Playpals, they'll show up here.",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
