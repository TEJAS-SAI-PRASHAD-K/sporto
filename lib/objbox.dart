import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'objectbox.g.dart';

/// ObjectBox database singleton
class ObjectBox {
  late final Store _store;

  static ObjectBox? _instance;

  static ObjectBox get instance {
    if (_instance == null) {
      throw Exception(
        'ObjectBox not initialized. Call ObjectBox.init() first.',
      );
    }
    return _instance!;
  }

  ObjectBox._create(this._store);

  /// Initialize ObjectBox store
  static Future<ObjectBox> init() async {
    if (_instance != null) {
      return _instance!;
    }

    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, 'playo_db'));

    _instance = ObjectBox._create(store);
    return _instance!;
  }

  Store get store => _store;

  /// Close the store and clean up resources
  void close() {
    _store.close();
    _instance = null;
  }
}
