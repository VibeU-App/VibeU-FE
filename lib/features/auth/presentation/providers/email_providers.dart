import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'email_providers.g.dart';

// in the future, using a user repo and get the email out of it might be better
@riverpod
class EmailState extends _$EmailState {
  @override
  Future<String> build() async {
    // TODO: inject repo
    return '';
  }

  Future<void> getPrimaryEmail() async {
    // TODO: Implement getPrimaryEmail
    state = const AsyncLoading();
    print('primary email!');
    state = AsyncValue.data('primary@email.com');
  }

  Future<void> getRecoveryEmail() async {
    // TODO: Implement getRecoveryEmail
    state = const AsyncLoading();
    print('recovery email!');
    state = AsyncValue.data('recovery@email.com');
  }

  Future<void> getEmail(String email) async {
    // TODO: Implement getEmail
    state = const AsyncLoading();
    if (email.isEmpty) {
    }
    print('get email!');
    state = AsyncValue.data(email);
  }
}
