# Research: Clean Architecture Auth Feature

**Date**: 2026-06-08

## Decision 1: BLoC Library Choice

**Decision**: Use `flutter_bloc` package (by Felix Angelov)

**Rationale**: The user explicitly requested BLoC pattern. `flutter_bloc` is the de facto standard BLoC implementation for Flutter with excellent tooling, testing support (`bloc_test`), and community adoption.

**Alternatives considered**:
- `rx_bloc`: Alternative BLoC implementation but smaller community
- `riverpod`: Popular state management but not BLoC pattern
- Provider: Simpler but not BLoC pattern

## Decision 2: HTTP Client

**Decision**: Use `dio` package

**Rationale**: The user explicitly specified Dio. Dio provides interceptors (useful for token injection), request cancellation, and form data handling out of the box.

**Alternatives considered**:
- `http`: Simpler but lacks interceptors and advanced features
- `chopper`: Code-generation based, more boilerplate

## Decision 3: Secure Storage

**Decision**: Use `flutter_secure_storage` package

**Rationale**: The user explicitly specified FlutterSecureStorage. It uses Keychain (iOS) and EncryptedSharedPreferences (Android) for secure credential storage.

**Alternatives considered**:
- `hive` with encryption: More complex setup
- Platform channels: Unnecessary when package exists

## Decision 4: Local Caching

**Decision**: Use `shared_preferences` package

**Rationale**: The user explicitly specified SharedPreferences. Suitable for caching non-sensitive user profile data as JSON strings.

**Alternatives considered**:
- `hive`: Overkill for simple JSON caching
- `sqflite`: Relational DB not needed for single user object

## Decision 5: JWT Decoding

**Decision**: Use `jwt_decoder` package (or manual base64 decoding)

**Rationale**: JWT decoding is a simple base64 operation on the payload segment. `jwt_decoder` is lightweight and handles edge cases. Alternatively, manual decoding using `dart:convert` is feasible since we only need the payload.

**Alternatives considered**:
- `dart_jsonwebtoken`: Full JWT library with verification - overkill for client-side decode only
- Manual base64 decode: Zero dependency but needs manual handling of padding/encoding

## Decision 6: Error Handling Pattern

**Decision**: Use a `Failure` abstract class in `lib/core/error/` with specific failure subclasses

**Rationale**: Standard Clean Architecture approach. Use cases return `Either<Failure, Success>` (using `dartz` package or a custom Either type). This keeps error handling explicit across layers.

**Alternatives considered**:
- Exceptions only: Breaks Clean Architecture boundaries
- Result type with no Either: Less type-safe

## Decision 7: Dependency Injection

**Decision**: Use `get_it` package as service locator

**Rationale**: Standard DI approach for Flutter Clean Architecture. Registers data sources, repositories, and use cases at app startup. Works well with BLoC pattern.

**Alternatives considered**:
- `injectable`: Code-gen based, more setup
- Manual DI: Verbose and error-prone
- `provider`: Can work but `get_it` is more idiomatic for Clean Architecture

## Decision 8: JWT Token Structure

**Decision**: Decode JWT payload to extract `user_id`, `email`, `name`, and `exp` (expiration) fields

**Rationale**: Standard JWT claims. The spec mentions user profile data in the token. Using common field names with fallback to empty defaults.

**Alternatives considered**:
- Fetch user profile separately after login: Extra network call, but more flexible
- Use only token for auth, fetch profile on demand: Hybrid approach
