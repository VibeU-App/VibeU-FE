# Internal Interface Contracts: Auth Feature

**Date**: 2026-06-08

## Domain Layer Interfaces

### AuthRepository (abstract)

Contract between Domain and Data layers. The Data layer must implement this interface.

```dart
abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, UserEntity>> signUp(String email, String password, String name);
  Future<Either<Failure, String>> forgotPassword(String email);
  Future<Either<Failure, String>> verifyOtp(String email, String otp);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, UserEntity>> checkAuthStatus();
}
```

**Return Types**:
- `login()` → `UserEntity` on success, `Failure` on error
- `signUp()` → `UserEntity` on success, `Failure` on error
- `forgotPassword()` → success message string, `Failure` on error
- `verifyOtp()` → success message string, `Failure` on error
- `logout()` → void on success, `Failure` on error
- `checkAuthStatus()` → `UserEntity` if session valid, `Failure` if no session

---

### UseCase Base (abstract)

```dart
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
```

**Concrete Use Cases**:

| UseCase                  | Params                        | Returns            |
|--------------------------|-------------------------------|---------------------|
| LoginUseCase             | LoginParams (email, password) | UserEntity          |
| SignUpUseCase            | SignUpParams (email, pwd, name)| UserEntity         |
| ForgotPasswordUseCase    | EmailParams (email)           | String (message)    |
| VerifyOtpUseCase         | OtpParams (email, otp)        | String (message)    |
| LogoutUseCase            | NoParams                      | void                |
| CheckAuthStatusUseCase   | NoParams                      | UserEntity          |

---

## Data Layer Interfaces

### AuthRemoteDataSource (abstract)

Contract for remote API operations.

```dart
abstract class AuthRemoteDataSource {
  Future<AuthResponse> login(LoginRequest request);
  Future<AuthResponse> signUp(SignUpRequest request);
  Future<String> forgotPassword(ForgotPasswordRequest request);
  Future<String> verifyOtp(VerifyOtpRequest request);
}
```

---

### AuthLocalDataSource (abstract)

Contract for local storage operations.

```dart
abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> deleteCachedUser();
}
```

---

## BLoC Interface Contract

### AuthBloc

**Events**:
- `AppStarted` → triggers `checkAuthStatus()`
- `LoginRequested(email, password)` → triggers `login()`
- `SignUpRequested(email, password, name)` → triggers `signUp()`
- `ForgotPasswordRequested(email)` → triggers `forgotPassword()`
- `VerifyOtpRequested(email, otp)` → triggers `verifyOtp()`
- `LogoutRequested` → triggers `logout()`

**States**:
- `AuthInitial` → default state
- `AuthLoading` → async operation in progress
- `Authenticated(UserEntity)` → user is logged in
- `Unauthenticated` → user is not logged in
- `AuthError(String message)` → error occurred

**State Transitions**:
```text
AuthInitial → AuthLoading → Authenticated (on login/signup success)
AuthInitial → AuthLoading → Unauthenticated (on checkAuthStatus no token)
AuthInitial → AuthLoading → AuthError (on any failure)
Authenticated → AuthLoading → Unauthenticated (on logout)
```
