import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String _databaseName = 'playo_local.db';
  static const int _databaseVersion = 2;

  // Singleton pattern
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await _createTables(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Apply additive migrations to keep local cache in sync with models
    if (oldVersion < newVersion) {
      await _migrateSchema(db);
      await _createTables(db); // ensure tables exist for fresh installs
    }
  }

  Future<bool> _columnExists(Database db, String table, String column) async {
    final res = await db.rawQuery(
      "PRAGMA table_info($table)",
    );
    for (final row in res) {
      if ((row['name'] as String?)?.toLowerCase() == column.toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  Future<void> _addColumnIfMissing(
    Database db,
    String table,
    String columnName,
    String columnTypeAndDefault,
  ) async {
    final exists = await _columnExists(db, table, columnName);
    if (!exists) {
      try {
        await db.execute(
          'ALTER TABLE ' + table + ' ADD COLUMN ' + columnName + ' ' + columnTypeAndDefault,
        );
      } catch (_) {
        // Ignore if ALTER fails for any reason; better to be lenient for cache
      }
    }
  }

  Future<void> _migrateSchema(Database db) async {
    // Users: add new-model columns if missing
    await _addColumnIfMissing(db, 'users', 'location_area', 'TEXT');
    await _addColumnIfMissing(db, 'users', 'karma_score', 'INTEGER DEFAULT 0');
    await _addColumnIfMissing(db, 'users', 'games_played_count', 'INTEGER DEFAULT 0');
    await _addColumnIfMissing(db, 'users', 'playpals_user_ids', 'TEXT');
    await _addColumnIfMissing(db, 'users', 'booked_sessions_ids', 'TEXT');
    await _addColumnIfMissing(db, 'users', 'blocked_user_ids', 'TEXT');

    // User preferences: add new columns alongside existing ones
    await _addColumnIfMissing(db, 'user_preferences', 'app_theme', 'TEXT DEFAULT \'' + 'dark' + '\'');
    await _addColumnIfMissing(db, 'user_preferences', 'preferred_language', 'TEXT DEFAULT \'' + 'en' + '\'');
    await _addColumnIfMissing(db, 'user_preferences', 'search_radius_km', 'REAL');
  }

  Future<void> _createTables(Database db) async {
    // Users table
  await db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id TEXT PRIMARY KEY,
        email TEXT NOT NULL,
        phone TEXT,
        full_name TEXT NOT NULL,
        first_name TEXT,
        last_name TEXT,
    profile_picture_url TEXT,
    role TEXT DEFAULT 'user',
    auth_provider TEXT, -- legacy
    subscription_status TEXT, -- legacy
        bio TEXT,
    date_of_birth TEXT, -- legacy
        gender TEXT,
    location_area TEXT,
        city TEXT,
        state TEXT,
        country TEXT,
        latitude REAL,
        longitude REAL,
    preferred_sports TEXT, -- JSON array as string (maps to favorite_sports)
    playpals_user_ids TEXT, -- JSON array as string
    booked_sessions_ids TEXT, -- JSON array as string
    blocked_user_ids TEXT, -- JSON array as string
    karma_score INTEGER DEFAULT 0,
    games_played_count INTEGER DEFAULT 0,
    subscription_expires_at TEXT, -- legacy
        is_active INTEGER DEFAULT 1,
        is_email_verified INTEGER DEFAULT 0,
        is_phone_verified INTEGER DEFAULT 0,
        is_profile_completed INTEGER DEFAULT 0,
    fcm_token TEXT, -- legacy
    last_active_at TEXT, -- legacy
    is_online INTEGER DEFAULT 0, -- legacy
        created_at TEXT,
        updated_at TEXT
      )
    ''');

    // User preferences table
  await db.execute('''
      CREATE TABLE IF NOT EXISTS user_preferences (
    id TEXT PRIMARY KEY,
    user_id TEXT NOT NULL,
    notifications_enabled INTEGER DEFAULT 1,
    game_invites_enabled INTEGER DEFAULT 1,
    promotional_emails_enabled INTEGER DEFAULT 1,
    location_sharing_enabled INTEGER DEFAULT 1,
    -- New-model aligned fields (kept alongside legacy for compatibility)
    app_theme TEXT DEFAULT 'dark',
    preferred_language TEXT DEFAULT 'en',
    distance_unit TEXT DEFAULT 'km',
    time_format TEXT DEFAULT '24h',
    search_radius_km REAL,
    -- Legacy fields kept for migration/read-compat
    theme_mode TEXT,
    language TEXT,
    search_radius REAL,
    default_skill_level TEXT,
    created_at TEXT,
    updated_at TEXT,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    // User sport profiles table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS user_sport_profiles (
        id TEXT PRIMARY KEY,
        user_id TEXT NOT NULL,
        sport_name TEXT NOT NULL,
        skill_level TEXT NOT NULL,
        years_of_experience INTEGER,
        position TEXT,
        achievements TEXT, -- JSON array as string
        bio TEXT,
        rating REAL,
        total_games_played INTEGER DEFAULT 0,
        total_wins INTEGER DEFAULT 0,
        total_losses INTEGER DEFAULT 0,
        preferred_game_type TEXT,
        certifications TEXT, -- JSON array as string
        equipment_owned TEXT,
        is_public INTEGER DEFAULT 1,
        created_at TEXT,
        updated_at TEXT,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
        UNIQUE (user_id, sport_name)
      )
    ''');

    // User connections table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS user_connections (
        id TEXT PRIMARY KEY,
        user_id TEXT NOT NULL,
        connected_user_id TEXT NOT NULL,
        status TEXT DEFAULT 'pending',
        requested_at TEXT,
        accepted_at TEXT,
        blocked_at TEXT,
        notes TEXT,
        created_at TEXT,
        updated_at TEXT,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
        FOREIGN KEY (connected_user_id) REFERENCES users (id) ON DELETE CASCADE,
        UNIQUE (user_id, connected_user_id)
      )
    ''');

    // Games table (for offline storage)
    await db.execute('''
      CREATE TABLE IF NOT EXISTS games (
        id TEXT PRIMARY KEY,
        organizer_id TEXT NOT NULL,
        sport_id TEXT NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        game_type TEXT NOT NULL,
        skill_level TEXT NOT NULL,
        status TEXT DEFAULT 'draft',
        start_time TEXT NOT NULL,
        end_time TEXT NOT NULL,
        venue_id TEXT,
        venue_name TEXT,
        venue_address TEXT,
        latitude REAL,
        longitude REAL,
        capacity INTEGER NOT NULL,
        current_players INTEGER DEFAULT 0,
        max_players INTEGER NOT NULL,
        entry_fee REAL,
        price_per_player REAL,
        currency TEXT DEFAULT 'INR',
        rules TEXT, -- JSON array as string
        equipment_provided TEXT, -- JSON array as string
        equipment_required TEXT, -- JSON array as string
        is_public INTEGER DEFAULT 1,
        is_private INTEGER DEFAULT 0,
        allow_waitlist INTEGER DEFAULT 0,
        requires_approval INTEGER DEFAULT 0,
        contact_info TEXT,
        tags TEXT, -- JSON array as string
        notes TEXT,
        rating INTEGER,
        view_count INTEGER DEFAULT 0,
        scheduled_date TEXT NOT NULL,
        created_at TEXT,
        updated_at TEXT,
        FOREIGN KEY (organizer_id) REFERENCES users (id)
      )
    ''');

    // Create indexes for better performance
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_users_email ON users(email)',
    );
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_users_phone ON users(phone)',
    );
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_user_preferences_user_id ON user_preferences(user_id)',
    );
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_user_sport_profiles_user_id ON user_sport_profiles(user_id)',
    );
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_user_connections_user_id ON user_connections(user_id)',
    );
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_games_organizer_id ON games(organizer_id)',
    );
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_games_start_time ON games(start_time)',
    );
    await db.execute(
      'CREATE INDEX IF NOT EXISTS idx_games_status ON games(status)',
    );

    debugPrint('SQLite database tables created successfully');
  }

  // Generic CRUD operations
  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(
      table,
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> query(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    Database db = await instance.database;
    return await db.query(
      table,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  Future<Map<String, dynamic>?> queryById(String table, String id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<int> update(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    String id = row['id'];
    return await db.update(table, row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> delete(String table, String id) async {
    Database db = await instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearTable(String table) async {
    Database db = await instance.database;
    await db.delete(table);
  }

  Future<void> close() async {
    Database? db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }

  // User-specific methods
  Future<Map<String, dynamic>?> getUserById(String userId) async {
    return await queryById('users', userId);
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    return await insert('users', user);
  }

  Future<int> updateUser(Map<String, dynamic> user) async {
    return await update('users', user);
  }

  Future<int> deleteUser(String userId) async {
    return await delete('users', userId);
  }

  // User preferences methods
  Future<Map<String, dynamic>?> getUserPreferences(String userId) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query(
      'user_preferences',
      where: 'user_id = ?',
      whereArgs: [userId],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<int> insertUserPreferences(Map<String, dynamic> preferences) async {
    return await insert('user_preferences', preferences);
  }

  Future<int> updateUserPreferences(Map<String, dynamic> preferences) async {
    return await update('user_preferences', preferences);
  }

  // Games methods
  Future<List<Map<String, dynamic>>> getGamesByUserId(String userId) async {
    return await query(
      'games',
      where: 'organizer_id = ?',
      whereArgs: [userId],
      orderBy: 'start_time DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getUpcomingGames() async {
    return await query(
      'games',
      where: 'start_time > ? AND status != ?',
      whereArgs: [DateTime.now().toIso8601String(), 'cancelled'],
      orderBy: 'start_time ASC',
    );
  }
}
