import 'package:flutter/material.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _headCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final List<String> _players = ['Tejas', 'You', 'udhay', 'w'];
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
                            borderRadius: BorderRadius.circular(12),
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
                            borderRadius: BorderRadius.circular(12),
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
    String temp = _paidBy;
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) {
        return Scaffold();
      },
    );
    if (result != null) setState(() => _paidBy = result);
  }

  Future<void> _showAllocateDialog() async {}
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
