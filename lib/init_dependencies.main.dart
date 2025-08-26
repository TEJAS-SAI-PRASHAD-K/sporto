part of 'init_dependecies.dart';

/// Service locator for dependency injection
final GetIt serviceLocator = GetIt.instance;

/// Initialize all dependencies
Future<void> initDependencies() async {
  await dotenv.load(fileName: ".env");

  await _initSupabase();
  await _initDatabase();
  await _initServices();
  await _initRepositories();
  await _initProviders();
}

/// Initialize Supabase client
Future<void> _initSupabase() async {
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  serviceLocator.registerSingleton<SupabaseClient>(Supabase.instance.client);
}

/// Initialize SQLite database
Future<void> _initDatabase() async {
  final databaseHelper = DatabaseHelper.instance;
  await databaseHelper.database; // Initialize the database
  serviceLocator.registerSingleton<DatabaseHelper>(databaseHelper);
}

/// Initialize core services
Future<void> _initServices() async {
  // Services will be registered here
  // serviceLocator.registerLazySingleton<AuthService>(() => AuthService());
  // serviceLocator.registerLazySingleton<UserService>(() => UserService());
  // serviceLocator.registerLazySingleton<GameService>(() => GameService());
  // serviceLocator.registerLazySingleton<VenueService>(() => VenueService());
  // serviceLocator.registerLazySingleton<TrainerService>(() => TrainerService());
  // serviceLocator.registerLazySingleton<NotificationService>(() => NotificationService());
  // serviceLocator.registerLazySingleton<PaymentService>(() => PaymentService());
}

/// Initialize repositories
Future<void> _initRepositories() async {
  // Repositories will be registered here
  // serviceLocator.registerLazySingleton<UserRepository>(() => UserRepository());
  // serviceLocator.registerLazySingleton<GameRepository>(() => GameRepository());
  // serviceLocator.registerLazySingleton<VenueRepository>(() => VenueRepository());
  // serviceLocator.registerLazySingleton<TrainerRepository>(() => TrainerRepository());
}

/// Initialize providers/notifiers
Future<void> _initProviders() async {
  // Providers will be registered here if needed for GetIt
  // Most Riverpod providers are registered automatically
}

/// Clean up resources
Future<void> disposeDependencies() async {
  serviceLocator<DatabaseHelper>().close();
  await serviceLocator.reset();
}
