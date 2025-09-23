import 'package:flutter/material.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _headCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final List<String> _players = [
    'Tejas',
    'You',
    'udhay',
    'w',
    'Tejasfd',
    'Youfg',
    'udhayfg',
    'wee',
  ];
  String _paidBy = 'You';
  Set<String> _allocated = {};

  @override
  void initState() {
    super.initState();
    _allocated = _players.toSet();
  }

  @override
  void dispose() {
    _headCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final onVar = cs.onSurfaceVariant;

    if (_allocated.isEmpty && _players.isNotEmpty) {
      _allocated = _players.toSet();
    }
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          'Expense',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _LabeledField(
                      label: 'Expense Title',
                      child: TextField(
                        controller: _headCtrl,
                        decoration: InputDecoration(
                          hintText: 'Eg: Drinks, Shuttle',
                          hintStyle: TextStyle(fontSize: 12, color: onVar),
                          isDense: true,
                          contentPadding: const EdgeInsets.fromLTRB(
                            16,
                            10,
                            16,
                            10,
                          ),
                          filled: true,
                          fillColor: cs.surface,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _LabeledField(
                      label: 'Amount Paid (in \$)',
                      fieldInset: const EdgeInsets.fromLTRB(2, 6, 2, 0),
                      child: TextField(
                        controller: _amountCtrl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '0.00',
                          hintStyle: TextStyle(fontSize: 12, color: onVar),
                          isDense: true,
                          contentPadding: const EdgeInsets.fromLTRB(
                            16,
                            10,
                            16,
                            10,
                          ),
                          filled: true,
                          fillColor: cs.surface,
                          prefixText: '\$ ',
                          prefixStyle: TextStyle(color: cs.onSurface),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _InlineSelectorButton(
                            caption: 'Paid by',
                            value: _paidBy,
                            onTap: _showPaidByDialog,
                            labelColor: onVar,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _InlineSelectorButton(
                            caption: 'allocated to',
                            value: _allocated.length == _players.length
                                ? 'All Players'
                                : '${_allocated.length} Selected',
                            onTap: _showAllocateDialog,
                            labelColor: onVar,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                      backgroundColor: cs.primary,
                      foregroundColor: cs.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // TODO: submit expense
                    },
                    child: const Text('ADD EXPENSE'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showPaidByDialog() async {
    final result = await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        final cs = Theme.of(ctx).colorScheme;
        final maxHeight = MediaQuery.of(ctx).size.height * 0.6;
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 8, 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Paid By',
                  style: TextStyle(
                    color: cs.onSurface,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: maxHeight),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (_, i) {
                      final p = _players[i];
                      return _PaidByItem(
                        name: p,
                        selected: _paidBy == p,
                        onSelect: () => Navigator.of(ctx).pop(p),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 4),
                    itemCount: _players.length,
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        );
      },
    );
    if (result != null) setState(() => _paidBy = result);
  }

  Future<void> _showAllocateDialog() async {
    // Local mutable copies that persist across dialog rebuilds
    final players = List<String>.of(_players);
    final selected = Set<String>.of(_allocated);

    final result = await showDialog<_AllocateResult>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        final cs = Theme.of(ctx).colorScheme;
        return StatefulBuilder(
          builder: (ctx, setLocal) {
            Future<void> addNew() async {
              final name = await _promptNewPlayerName(ctx);
              if (name == null) return;
              final trimmed = name.trim();
              if (trimmed.isEmpty) return;
              setLocal(() {
                if (!players.contains(trimmed)) {
                  players.add(trimmed);
                }
                selected.add(trimmed);
              });
            }

            void toggleAll() {
              setLocal(() {
                if (selected.length == players.length) {
                  selected.clear();
                } else {
                  selected
                    ..clear()
                    ..addAll(players);
                }
              });
            }

            final maxHeight = MediaQuery.of(ctx).size.height * 0.65;
            return Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 12, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose Players to split',
                      style: TextStyle(
                        color: cs.onSurface,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: maxHeight),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          // All Players row
                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: toggleAll,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 4,
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 44),
                                  Expanded(
                                    child: Text(
                                      'All Players',
                                      style: TextStyle(
                                        color: cs.onSurface,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  _CheckSquare(
                                    checked:
                                        selected.length == players.length &&
                                        players.isNotEmpty,
                                    color: cs.primary,
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          ...players.map(
                            (p) => _SelectablePlayerItem(
                              name: p,
                              selected: selected.contains(p),
                              onToggle: () {
                                setLocal(() {
                                  if (selected.contains(p)) {
                                    selected.remove(p);
                                  } else {
                                    selected.add(p);
                                  }
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: addNew,
                          child: const Text('ADD NEW'),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: cs.onSurfaceVariant),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(
                              ctx,
                            ).pop(_AllocateResult(players, selected));
                          },
                          child: Text(
                            'Ok',
                            style: TextStyle(color: cs.primary),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
    if (result != null) {
      setState(() {
        _players
          ..clear()
          ..addAll(result.players);
        _allocated = result.selected.isEmpty
            ? _players.toSet()
            : result.selected;
      });
    }
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final Widget child;
  final EdgeInsets fieldInset;
  const _LabeledField({
    required this.label,
    required this.child,
    this.fieldInset = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: cs.onSurface, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Padding(padding: fieldInset, child: child),
      ],
    );
  }
}

class _InlineSelectorButton extends StatelessWidget {
  final String caption;
  final String value;
  final VoidCallback onTap;
  final Color? labelColor;

  const _InlineSelectorButton({
    required this.caption,
    required this.value,
    required this.onTap,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final border = Border.all(color: cs.outlineVariant);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(12),
          border: border,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              caption,
              style: TextStyle(
                color: labelColor ?? cs.onSurfaceVariant,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: cs.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaidByItem extends StatelessWidget {
  final String name;
  final bool selected;
  final VoidCallback onSelect;

  const _PaidByItem({
    required this.name,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final borderColor = cs.outlineVariant;
    final active = cs.primary;
    return InkWell(
      onTap: onSelect,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: cs.primary,
              child: Icon(Icons.person, color: cs.onPrimary, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            _CheckboxCircle(
              selected: selected,
              color: active,
              borderColor: borderColor,
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

class _CheckboxCircle extends StatelessWidget {
  final bool selected;
  final Color color;
  final Color borderColor;

  const _CheckboxCircle({
    required this.selected,
    required this.color,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: selected ? color : borderColor, width: 2),
      ),
      child: Center(
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected ? color : Colors.transparent,
          ),
        ),
      ),
    );
  }
}

// ---------------- Allocation Dialog ----------------

class _AllocateResult {
  final List<String> players;
  final Set<String> selected;
  _AllocateResult(this.players, this.selected);
}

Future<String?> _promptNewPlayerName(BuildContext context) async {
  final controller = TextEditingController();
  final cs = Theme.of(context).colorScheme;
  return showDialog<String>(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text('Add Player'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter name'),
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Cancel', style: TextStyle(color: cs.onSurfaceVariant)),
          ),
          TextButton(
            onPressed: () {
              final text = controller.text.trim();
              if (text.isEmpty) return; // keep dialog if empty
              Navigator.of(ctx).pop(text);
            },
            child: Text('Add', style: TextStyle(color: cs.primary)),
          ),
        ],
      );
    },
  );
}

class _CheckSquare extends StatelessWidget {
  final bool checked;
  final Color color;
  const _CheckSquare({required this.checked, required this.color});

  @override
  Widget build(BuildContext context) {
    return Icon(
      checked ? Icons.check_box : Icons.check_box_outline_blank,
      color: checked ? color : Theme.of(context).colorScheme.outline,
    );
  }
}

class _SelectablePlayerItem extends StatelessWidget {
  final String name;
  final bool selected;
  final VoidCallback onToggle;
  const _SelectablePlayerItem({
    required this.name,
    required this.selected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onToggle,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: cs.primary,
              child: Icon(Icons.person, color: cs.onPrimary, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            _CheckSquare(checked: selected, color: cs.primary),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
