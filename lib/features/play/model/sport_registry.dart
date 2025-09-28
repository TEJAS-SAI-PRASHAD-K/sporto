class SportRegistry {
  static Map<String, String> _names = const {};
  static Map<String, String> _images = const {};

  static void setNames(Map<String, String> names) {
    _names = Map.unmodifiable(names);
  }

  static void setImages(Map<String, String> images) {
    _images = Map.unmodifiable(images);
  }

  static String nameFor(String sportId) => _names[sportId] ?? sportId;
  static String imageFor(String sportId) => _images[sportId] ?? '';
}
