class TabItem {
  final String title;
  final int count;
  final bool isSelected;

  const TabItem({
    required this.title,
    required this.count,
    this.isSelected = false,
  });

  TabItem copyWith({String? title, int? count, bool? isSelected}) {
    return TabItem(
      title: title ?? this.title,
      count: count ?? this.count,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
