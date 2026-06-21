# API Contracts: Auth Feature

**Date**: 2026-06-08

## Base URL

`{API_BASE_URL}/api/v1/auth`

All endpoints expect `Content-Type: application/json`.

## Endpoints

### POST /login

Authenticate an existing user with email and password.

**Request**:
```json
{
  "email": "user@example.com",
  "password": "securePassword123"
}
```

**Success Response (200)**:
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIs...",
  "user": {
    "id": "usr_abc123",
    "email": "user@example.com",
    "name": "John Doe",
    "created_at": "2026-01-15T10:30:00Z"
  }
}
```

**Error Response (401)**:
```json
{
  "message": "Invalid email or password"
}
```

---

### POST /signup

Register a new user account.

**Request**:
```json
{
  "email": "newuser@example.com",
  "password": "securePassword123",
  "name": "Jane Doe"
}
```

**Success Response (201)**:
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIs...",
  "user": {
    "id": "usr_def456",
    "email": "newuser@example.com",
    "name": "Jane Doe",
    "created_at": "2026-06-08T09:00:00Z"
  }
}
```

**Error Response (409)**:
```json
{
  "message": "Email already registered"
}
```

---

### POST /forgot-password

Request a password reset OTP to be sent to the user's email.

**Request**:
```json
{
  "email": "user@example.com"
}
```

**Success Response (200)**:
```json
{
  "message": "OTP sent to email"
}
```

**Error Response (404)**:
```json
{
  "message": "Email not found"
}
```

---

### POST /verify-otp

Verify the OTP code for password reset.

**Request**:
```json
{
  "email": "user@example.com",
  "otp": "123456"
}
```

**Success Response (200)**:
```json
{
  "message": "OTP verified successfully"
}
```

**Error Response (400)**:
```json
{
  "message": "Invalid or expired OTP"
}
```
