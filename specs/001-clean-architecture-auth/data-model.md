# Data Model: Clean Architecture Auth Feature

**Date**: 2026-06-08

## Entities

### UserEntity

Domain entity representing an authenticated user. Immutable, used across all layers.

| Field     | Type   | Description                          | Validation                    |
|-----------|--------|--------------------------------------|-------------------------------|
| id        | String | Unique user identifier               | Required, non-empty           |
| email     | String | User email address                   | Required, valid email format  |
| name      | String | User display name                    | Required, non-empty           |
| createdAt | String | Account creation timestamp (ISO8601) | Optional                      |

**State Transitions**: None (entity is immutable once created)

## Models

### UserModel (extends UserEntity)

Data layer model with JSON serialization and JWT decoding capabilities.

| Field     | Type   | Source                | Description                          |
|-----------|--------|-----------------------|--------------------------------------|
| id        | String | JWT payload / API     | Unique user identifier               |
| email     | String | JWT payload / API     | User email address                   |
| name      | String | JWT payload / API     | User display name                    |
| createdAt | String | API response          | Account creation timestamp           |

**Serialization**:
- `fromJson(Map<String, dynamic>)`: Factory constructor for JSON deserialization
- `toJson()`: Returns `Map<String, dynamic>` for serialization
- `fromJwt(String token)`: Factory constructor that decodes JWT payload and extracts user fields

**JWT Decode Logic**:
1. Split token by `.` separator
2. Base64-decode the payload (index 1)
3. Parse JSON
4. Extract `user_id`/`sub`, `email`, `name`, `exp`
5. Construct UserModel

## Storage Entities

### TokenStorage

| Key              | Storage Type        | Value Type | Description                    |
|------------------|---------------------|------------|--------------------------------|
| access_token     | FlutterSecureStorage | String     | Raw JWT access token           |
| cached_user      | SharedPreferences    | String     | JSON-encoded UserModel         |

## API Request/Response Models

### LoginRequest

| Field    | Type   | Description         | Validation                  |
|----------|--------|---------------------|-----------------------------|
| email    | String | User email          | Required, valid email       |
| password | String | User password       | Required, min 6 characters  |

### SignUpRequest

| Field    | Type   | Description         | Validation                  |
|----------|--------|---------------------|-----------------------------|
| email    | String | User email          | Required, valid email       |
| password | String | User password       | Required, min 8 characters  |
| name     | String | User display name   | Required, non-empty         |

### ForgotPasswordRequest

| Field | Type   | Description  | Validation            |
|-------|--------|--------------|-----------------------|
| email | String | User email   | Required, valid email |

### VerifyOtpRequest

| Field | Type   | Description       | Validation            |
|-------|--------|-------------------|-----------------------|
| email | String | User email        | Required, valid email |
| otp   | String | OTP code received | Required, 4-6 digits  |

### AuthResponse

| Field       | Type   | Description                    |
|-------------|--------|--------------------------------|
| accessToken | String | JWT access token               |
| user        | Map    | User profile data (JSON object)|
| message     | String | Optional success/error message |

## Relationships

```text
UserEntity (domain)
    └── UserModel (data) extends UserEntity
            ├── serialized from AuthResponse.user
            └── decoded from JWT access token payload

AuthRepository (domain interface)
    ├── uses LoginRequest, SignUpRequest, ForgotPasswordRequest, VerifyOtpRequest
    ├── returns UserEntity (on success)
    └── returns Failure (on error)

AuthRemoteDataSource (data)
    ├── consumes: LoginRequest, SignUpRequest, ForgotPasswordRequest, VerifyOtpRequest
    └── produces: AuthResponse (contains token + user data)

AuthLocalDataSource (data)
    ├── stores: access_token (FlutterSecureStorage)
    ├── stores: cached_user JSON (SharedPreferences)
    └── retrieves: token, cached UserModel
```
