import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String _databaseName = 'playo_local.db';
  static const int _databaseVersion = 1; // Initial version

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
      // If an older dev db exists with a higher version, drop & recreate
      onDowngrade: onDatabaseDowngradeDelete,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await _createTables(db);
  }

  // No onUpgrade/migrations needed for initial version

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

  // Removed legacy game cache methods
}
