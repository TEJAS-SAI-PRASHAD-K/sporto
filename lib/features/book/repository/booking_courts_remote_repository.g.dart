// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_courts_remote_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bookingCourtsRemoteRepository)
const bookingCourtsRemoteRepositoryProvider =
    BookingCourtsRemoteRepositoryProvider._();

final class BookingCourtsRemoteRepositoryProvider
    extends
        $FunctionalProvider<
          BookingCourtsRemoteRepository,
          BookingCourtsRemoteRepository,
          BookingCourtsRemoteRepository
        >
    with $Provider<BookingCourtsRemoteRepository> {
  const BookingCourtsRemoteRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookingCourtsRemoteRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookingCourtsRemoteRepositoryHash();

  @$internal
  @override
  $ProviderElement<BookingCourtsRemoteRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BookingCourtsRemoteRepository create(Ref ref) {
    return bookingCourtsRemoteRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookingCourtsRemoteRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BookingCourtsRemoteRepository>(
        value,
      ),
    );
  }
}

String _$bookingCourtsRemoteRepositoryHash() =>
    r'b3267abd28695009fcc6c90d9fd1588eaf724eb1';
