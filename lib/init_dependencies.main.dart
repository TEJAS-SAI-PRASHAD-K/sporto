import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'objbox.dart';

/// Service locator for dependency injection
final GetIt serviceLocator = GetIt.instance;

/// Initialize all dependencies
Future<void> initDependencies() async {
  await _initSupabase();
  await _initDatabase();
  await _initServices();
  await _initRepositories();
  await _initProviders();
}

/// Initialize Supabase client
Future<void> _initSupabase() async {
  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL',
    anonKey: 'YOUR_SUPABASE_ANON_KEY',
  );

  serviceLocator.registerSingleton<SupabaseClient>(Supabase.instance.client);
}

/// Initialize ObjectBox database
Future<void> _initDatabase() async {
  final objectBox = await ObjectBox.init();
  serviceLocator.registerSingleton<ObjectBox>(objectBox);
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
  serviceLocator<ObjectBox>().close();
  await serviceLocator.reset();
}
