# VibeU - Clean Architecture Project Structure

This project follows **Clean Architecture** (Kiến trúc sạch) to ensure scalability, maintainability, and testability.

## 📁 Directory Structure (Cấu trúc thư mục)

The core logic of the application resides in the `lib/` directory, organized as follows:

### ⚙️ `lib/config/`
Contains application-wide configurations such as routes, themes, and global constants.
*(Chứa các cài đặt cấu hình toàn ứng dụng như định tuyến, chủ đề và các hằng số chung.)*

### 🛠️ `lib/core/`
Contains shared components, utilities, error handling, and base classes that are used across multiple features.
*(Chứa các thành phần dùng chung, tiện ích, xử lý lỗi và các lớp cơ sở được sử dụng trong nhiều tính năng khác nhau.)*

### 🚀 `lib/features/`
Each feature (e.g., `auth`, `chatting`) is modularized and follows its own internal Clean Architecture layers.
*(Mỗi tính năng được module hóa và tuân theo các lớp kiến trúc riêng bên trong.)*

---

## 🏛️ Feature Layers (Các lớp trong một tính năng)

Inside each feature (e.g., `lib/features/auth/`), we divide the code into three main layers:

### 1. 💼 Domain Layer (Lớp Nghiệp vụ)
The center of the feature. It is independent of any other layers and contains the business logic.
- **Entities (Thực thể):** Simple objects representing the core business data.
- **Use Cases (Trường hợp sử dụng):** Contains the application-specific business rules (what the app does).
- **Models:** Domain-specific data structures.

### 2. 💾 Data Layer (Lớp Dữ liệu)
Responsible for retrieving and managing data from various sources.
- **Repositories Implementation:** Implements the repository interfaces defined in the domain layer.
- **Data Sources:**
    - **Remote (Nguồn từ xa):** APIs, Firebase, or other external services.
    - **Local (Nguồn tại chỗ):** Database (SQLite, Hive), Shared Preferences, or Cache.

### 3. 🎨 Presentation Layer (Lớp Hiển thị)
Everything related to the UI and state management.
- **Pages/Screens:** The actual Flutter widgets representing the UI.
- **Widgets:** Reusable UI components specific to this feature.
- **State Management:** BLoC, Cubit, Provider, or Riverpod logic to handle user interactions and update the UI.

---

## 🔄 Dependency Flow (Luồng phụ thuộc)
**Presentation ➔ Domain ⬅ Data**

- The **Domain** layer should never depend on anything else.
- The **Presentation** layer depends on the **Domain** (Use Cases).
- The **Data** layer depends on the **Domain** (Implementing interfaces).

---

## 📝 Guidelines for the Team
- Always keep business logic in **Use Cases**.
- Do not leak implementation details (like JSON parsing or SQL) into the **Domain** layer.
- Use **core** for code that is truly global and reused everywhere.
