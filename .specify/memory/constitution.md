# [VibeU] Constitution

## Core Architectural Principles

### 1. Feature-Based Clean Architecture
Strictly follow Feature-based Clean Architecture. Every feature must be isolated and contain exact `data`, `domain`, and `presentation` folders. Do not share models across features unless they are placed in a global `core` directory.

### 2. The Dependency Rule
The Domain layer is the center of the application. It must NOT depend on the Data or Presentation layers, nor any third-party packages except `dart:core` and `equatable`. The Presentation layer must depend on Domain through Riverpod-driven state exposure, not direct data access.

### 3. State Management (Riverpod)
Strictly use Riverpod for state management. Prefer `Notifier`, `AsyncNotifier`, `StateNotifier`, or `Provider` patterns as appropriate for the feature. Keep state and side effects out of widgets, and expose immutable state objects that the UI can watch and react to.

### 4. UI and Vibe Coding Boundaries
The Presentation layer (UI) is "dumb." Widgets must NEVER contain business logic, HTTP requests, or local data transformations.
- UI must only trigger Riverpod actions and listen to provider changes or notifications to react to state updates.
- Use `ref.listen`, `ConsumerWidget`, or `ConsumerStatefulWidget` to respond to state changes and side effects.
- All colors and typography must be referenced from `Theme.of(context)`; do not hardcode hex colors or text styles.
- Extract any widget tree exceeding 4 levels of indentation into its own private widget class.

### 5. Error Handling & Data Flow
The Data layer must catch all exceptions (e.g., `DioException`, `SocketException`) and convert them into standardized `Failure` objects before passing them to the Domain layer. The UI should only ever deal with `Failure` messages, never raw exceptions.

### 6. Design System & Theming
All UI code MUST strictly adhere to the project's established Design System.
- **Colors:** Never hardcode hex values (e.g., `Color(0xFF0000)`). All colors must be accessed via `Theme.of(context).colorScheme` (e.g., `colorScheme.primary`, `colorScheme.error`).
- **Typography:** Never hardcode `TextStyle` properties like `fontSize` or `fontFamily`. Always use `Theme.of(context).textTheme` (e.g., `textTheme.headlineMedium`, `textTheme.bodyLarge`).
- **Spacing:** Use the predefined spacing constants (e.g., `AppSpacing.sm`, `AppSpacing.md`) rather than raw numbers like `SizedBox(height: 16)`.
- **Components:** Do not build raw buttons or text fields if a custom component exists. Always use `VibePrimaryButton`, `VibeTextField`, etc., if they are available in the `core/ui/components` folder.

## Governance & Quality Gates
- **No warnings:** All Dart code must pass standard `flutter analyze` without any warnings.
- **Null Safety:** Strict null safety is required. Avoid the `!` (bang) operator; use proper null checking (`if (x != null)`) or default values.