# Quickstart: Auth Feature Validation

**Date**: 2026-06-08

## Prerequisites

- Flutter SDK installed (3.x+)
- Dependencies added to `pubspec.yaml`:
  - `flutter_bloc`
  - `dio`
  - `flutter_secure_storage`
  - `shared_preferences`
  - `jwt_decoder`
  - `get_it` (service locator)
  - `dartz` (Either type) or custom Either implementation
  - `equatable` (for BLoC events/states)
- Backend API running with auth endpoints available

## Setup

```bash
# Install dependencies
flutter pub get

# Verify no analysis issues
flutter analyze
```

## Validation Scenarios

### 1. Domain Layer Compiles

Verify all domain-layer files compile without errors:

```bash
flutter analyze lib/features/auth/domain/
```

**Expected**: No errors. All entities, repository interface, and use cases are valid Dart.

### 2. Data Layer Compiles

Verify all data-layer files compile without errors:

```bash
flutter analyze lib/features/auth/data/
```

**Expected**: No errors. Models, data sources, and repository implementation are valid Dart.

### 3. BLoC Layer Compiles

Verify all presentation-layer files compile without errors:

```bash
flutter analyze lib/features/auth/presentation/
```

**Expected**: No errors. BLoC, events, and states are valid Dart.

### 4. Unit Tests Pass

Run all auth-related unit tests:

```bash
flutter test test/features/auth/
```

**Expected**: All tests pass. Tests should cover:
- UserModel JSON serialization/deserialization
- UserModel JWT decoding
- Use case execution with mock repository
- BLoC state transitions
- Repository implementation with mock data sources

### 5. Full App Compiles

Verify the entire application compiles:

```bash
flutter build apk --debug
```

**Expected**: Build succeeds with no errors.

### 6. Manual Smoke Test (requires running backend)

1. Launch app
2. Navigate to login screen
3. Enter valid credentials → should navigate to home
4. Close and reopen app → should restore session (no re-login)
5. Tap logout → should navigate to login screen
6. Reopen app → should show login screen (session cleared)

## Acceptance Criteria Mapping

| Scenario | Spec Story | Validates |
|----------|-----------|-----------|
| Domain compiles | All | FR-001 through FR-012 |
| Data compiles | All | FR-003, FR-004, FR-009, FR-011 |
| BLoC compiles | All | FR-012 |
| Unit tests pass | All | SC-004 |
| Full build | All | SC-004 |
| Manual smoke | US1-US6 | SC-001, SC-002, SC-003, SC-006 |
