# Tasks: Clean Architecture Auth Feature

**Input**: Design documents from `/specs/001-clean-architecture-auth/`

**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: Not explicitly requested in the specification. Test tasks are omitted.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Flutter project**: `lib/` at repository root
- Feature: `lib/features/auth/`
- Core: `lib/core/`

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Add required dependencies to the Flutter project

- [ ] T001 Add flutter_bloc, dio, flutter_secure_storage, shared_preferences, jwt_decoder, get_it, dartz, and equatable to pubspec.yaml
- [ ] T002 Create directory structure: lib/core/error/, lib/core/usecases/, lib/core/network/, lib/features/auth/data/models/, lib/features/auth/data/remote/, lib/features/auth/data/local/, lib/features/auth/data/repositories/, lib/features/auth/domain/entities/, lib/features/auth/domain/repositories/, lib/features/auth/domain/usecases/, lib/features/auth/presentation/bloc/

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T003 Create Failure abstract class and ServerFailure, CacheFailure subclasses in lib/core/error/failures.dart
- [ ] T004 Create UseCase base abstract class with Either<Failure, Type> return type and Params/NoParams classes in lib/core/usecases/usecase.dart
- [ ] T005 [P] Create UserEntity with id, email, name, createdAt fields in lib/features/auth/domain/entities/user_entity.dart
- [ ] T006 [P] Create AuthRepository abstract class with login, signUp, forgotPassword, verifyOtp, logout, checkAuthStatus methods in lib/features/auth/domain/repositories/auth_repository.dart
- [ ] T007 Create UserModel extending UserEntity with fromJson, toJson, fromJwt factory constructors in lib/features/auth/data/models/user_model.dart
- [ ] T008 Create AuthRemoteDataSource abstract class with login, signUp, forgotPassword, verifyOtp methods in lib/features/auth/data/remote/auth_remote_data_source.dart
- [ ] T009 [P] Create AuthLocalDataSource abstract class with saveToken, getToken, deleteToken, cacheUser, getCachedUser, deleteCachedUser methods in lib/features/auth/data/local/auth_local_data_source.dart
- [ ] T010 Create AuthRemoteDataSourceImpl using Dio for POST /login, /signup, /forgot-password, /verify-otp in lib/features/auth/data/remote/auth_remote_data_source_impl.dart
- [ ] T011 Create AuthLocalDataSourceImpl using FlutterSecureStorage for token and SharedPreferences for cached user in lib/features/auth/data/local/auth_local_data_source_impl.dart
- [ ] T012 Create AuthRepositoryImpl coordinating remote/local sources, saving token and user on auth success in lib/features/auth/data/repositories/auth_repository_impl.dart
- [ ] T013 Configure Dio instance with base URL and interceptors in lib/core/network/api_client.dart
- [ ] T014 Register all dependencies (data sources, repository, use cases, BLoC) in service locator in lib/injection_container.dart

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 & 2 - Login & Registration (Priority: P1) 🎯 MVP

**Goal**: Users can log in with existing credentials or register a new account. Token is stored securely and user data is cached locally.

**Independent Test**: Submit valid login credentials → user is authenticated. Submit valid registration → new account created and user is authenticated. Invalid credentials → error message displayed.

### Implementation for User Story 1 & 2

- [ ] T015 [P] [US1] Create LoginUseCase with LoginParams in lib/features/auth/domain/usecases/login_use_case.dart
- [ ] T016 [P] [US1] Create SignUpUseCase with SignUpParams in lib/features/auth/domain/usecases/sign_up_use_case.dart
- [ ] T017 [US1] Create AuthEvent with AppStarted, LoginRequested, SignUpRequested, ForgotPasswordRequested, VerifyOtpRequested, LogoutRequested events in lib/features/auth/presentation/bloc/auth_event.dart
- [ ] T018 [US1] Create AuthState with AuthInitial, AuthLoading, Authenticated, Unauthenticated, AuthError states in lib/features/auth/presentation/bloc/auth_state.dart
- [ ] T019 [US1] Create AuthBloc handling LoginRequested and SignUpRequested events with proper state transitions in lib/features/auth/presentation/bloc/auth_bloc.dart

**Checkpoint**: Login and Registration flows are functional end-to-end (data → domain → BLoC)

---

## Phase 4: User Story 3 - Session Restoration (Priority: P1)

**Goal**: App automatically restores user session on startup if a valid token exists in local storage.

**Independent Test**: Log in, close app, reopen → user lands on authenticated screen without re-login. No token → login screen shown.

### Implementation for User Story 3

- [ ] T020 [US3] Create CheckAuthStatusUseCase that reads cached token and user, validates token expiry, returns UserEntity or Failure in lib/features/auth/domain/usecases/check_auth_status_use_case.dart
- [ ] T021 [US3] Add AppStarted event handler to AuthBloc that calls CheckAuthStatusUseCase and emits Authenticated or Unauthenticated state in lib/features/auth/presentation/bloc/auth_bloc.dart

**Checkpoint**: Session restoration works on app startup

---

## Phase 5: User Story 4 & 5 - Forgot Password & OTP Verification (Priority: P2)

**Goal**: Users can request a password reset via email and verify the OTP code received.

**Independent Test**: Submit registered email → OTP sent message returned. Submit valid OTP → verification confirmed. Invalid OTP → error displayed.

### Implementation for User Story 4 & 5

- [ ] T022 [P] [US4] Create ForgotPasswordUseCase with EmailParams in lib/features/auth/domain/usecases/forgot_password_use_case.dart
- [ ] T023 [P] [US5] Create VerifyOtpUseCase with OtpParams in lib/features/auth/domain/usecases/verify_otp_use_case.dart
- [ ] T024 [US4] Add ForgotPasswordRequested handler to AuthBloc calling ForgotPasswordUseCase in lib/features/auth/presentation/bloc/auth_bloc.dart
- [ ] T025 [US5] Add VerifyOtpRequested handler to AuthBloc calling VerifyOtpUseCase in lib/features/auth/presentation/bloc/auth_bloc.dart

**Checkpoint**: Forgot password and OTP verification flows are functional

---

## Phase 6: User Story 6 - Logout (Priority: P2)

**Goal**: Authenticated user can log out, clearing all local session data (token and cached user).

**Independent Test**: Log in → log out → user redirected to login screen. Reopen app → login screen (session cleared).

### Implementation for User Story 6

- [ ] T026 [US6] Create LogoutUseCase with NoParams that calls repository logout (clears token and cached user) in lib/features/auth/domain/usecases/logout_use_case.dart
- [ ] T027 [US6] Add LogoutRequested handler to AuthBloc calling LogoutUseCase and emitting Unauthenticated state in lib/features/auth/presentation/bloc/auth_bloc.dart

**Checkpoint**: All six authentication operations are functional

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T028 Add comprehensive error handling in AuthRepositoryImpl for DioException, FormatException, and storage errors in lib/features/auth/data/repositories/auth_repository_impl.dart
- [ ] T029 Add email and password validation in LoginUseCase and SignUpUseCase before making repository calls in lib/features/auth/domain/usecases/login_use_case.dart and lib/features/auth/domain/usecases/sign_up_use_case.dart
- [ ] T030 Add JWT expiration check in CheckAuthStatusUseCase to invalidate expired tokens in lib/features/auth/domain/usecases/check_auth_status_use_case.dart
- [ ] T031 Run flutter analyze to verify no lint errors across all auth feature files
- [ ] T032 Verify full project compiles with flutter build apk --debug

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion (T001-T002) - BLOCKS all user stories
- **US1&2 (Phase 3)**: Depends on Foundational (T003-T014)
- **US3 (Phase 4)**: Depends on Foundational (T003-T014)
- **US4&5 (Phase 5)**: Depends on Foundational (T003-T014)
- **US6 (Phase 6)**: Depends on Foundational (T003-T014)
- **Polish (Phase 7)**: Depends on all user stories being complete

### User Story Dependencies

- **US1&2 (P1)**: Can start after Foundational - No dependencies on other stories
- **US3 (P1)**: Can start after Foundational - No dependencies on other stories
- **US4&5 (P2)**: Can start after Foundational - No dependencies on other stories
- **US6 (P2)**: Can start after Foundational - No dependencies on other stories

All user stories are independent of each other and can be implemented in any order after Foundational phase.

### Within Each User Story

- Use cases before BLoC event handlers
- BLoC event/state definitions before BLoC implementation
- Story complete before moving to next priority

### Parallel Opportunities

- T005, T006 can run in parallel (different files)
- T008, T009 can run in parallel (different files)
- T015, T016 can run in parallel (different files)
- T022, T023 can run in parallel (different files)
- All user story phases (3-6) can run in parallel once Foundational is complete

---

## Parallel Example: User Story 1 & 2

```bash
# Launch use cases in parallel:
Task: "Create LoginUseCase in lib/features/auth/domain/usecases/login_use_case.dart"
Task: "Create SignUpUseCase in lib/features/auth/domain/usecases/sign_up_use_case.dart"

# Then sequentially:
Task: "Create AuthEvent definitions"
Task: "Create AuthState definitions"
Task: "Create AuthBloc with login/signup handlers"
```

---

## Implementation Strategy

### MVP First (User Stories 1 & 2 Only)

1. Complete Phase 1: Setup (T001-T002)
2. Complete Phase 2: Foundational (T003-T014) - CRITICAL
3. Complete Phase 3: User Story 1 & 2 (T015-T019)
4. **STOP and VALIDATE**: Test login and registration independently
5. Deploy/demo if ready

### Incremental Delivery

1. Setup + Foundational → Foundation ready
2. Add US1&2 (Login/SignUp) → Test independently → MVP!
3. Add US3 (Session Restore) → Test independently
4. Add US4&5 (Forgot Password/OTP) → Test independently
5. Add US6 (Logout) → Test independently
6. Polish → Final validation

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: User Story 1 & 2 (Login/SignUp)
   - Developer B: User Story 3 (Session Restore)
   - Developer C: User Story 4 & 5 (Forgot Password/OTP)
3. Developer D or any: User Story 6 (Logout)

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- BLoC events and states are defined once (T017-T018) and serve all stories - new handlers are added incrementally per story
