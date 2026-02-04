# Enumerator

**Code generation utilities for Dart enums**

`enumerator` is a lightweight Dart code generator that adds **useful, type-safe helpers** to enums—such as predicate getters derived from enum values, lookup utilities, functional mapping, and custom field lookups, using a single annotation.

---

## Features

With one annotation, `enumerator` generates:

- Predicate boolean getters derived from enum value names (for example, `is<EnumValue>`)
- Safe lookup helpers (`fromName`, `fromNameOrNull`)
- Functional mapping (`map`, `mapOrNull`)
- Membership checks (`isIn`)
- Custom lookup fields (e.g. API values)
- Configurable per enum and globally

---

## Installation

Add the dependencies:

- Dart

```
dart pub add \
  enumerator \
  dev:build_runner \
  dev:enumerator_builder
```

- Flutter

```
flutter pub add \
  enumerator \
  dev:build_runner \
  dev:enumerator_builder
```

---

## Basic Usage

### 1. Annotate your enum

```dart
// status.dart

import 'package:enumerator/enumerator.dart';

part 'status.enum.dart';

@enumerator
enum Status { pending, success, error }
```

Run the generator:

```bash
dart run build_runner build
```

---

### 2. Use the generated helpers

```dart
void main() {
  const status = Status.pending;

  // Predicate getters derived from enum value names
  print(status.isPending); // true
  print(status.isSuccess); // false
  print(status.isError);   // false

  // Lookup by name
  Status enum1 = Status.values.fromName('pending');
  Status? enum2 = Status.values.fromNameOrNull('something');

  // Functional mapping
  int value1 = status.map(
    pending: () => 1,
    success: () => 2,
    error: () => 3,
  );

  // Optional mapping
  String? value2 = status.mapOrNull(
    success: () => 'Success',
    // error: () { ... },
  );

  // Membership check
  status.isIn({.pending, .error}); // true
}
```

---

## Custom Lookup Fields

Enums often need to map to API or external values.
`enumerator` supports this using `@enumLookup`.

```dart
@enumerator
enum Role {
  admin('ROLE-ADMIN'),
  user('ROLE-USER'),
  guest('ROLE-GUEST');

  const Role(this.apiValue);

  @enumLookup
  final String apiValue;
}
```

Generated usage:

```dart
final role = Role.values.fromApiValue('ROLE-ADMIN');
print(role); // Role.admin

Role.values.fromApiValueOrNull('UNKNOWN'); // null
```

---

## Configuration

All features are enabled by default.

Configuration can be applied per enum or globally.

---

### Per-enum configuration

```dart
@Enumerator(
  predicate: true,
  iterableLookup: true,
  map: true,
  isIn: true,
)
enum Status { pending, success, error }
```

---

### Global configuration (`build.yaml`)

```yaml
targets:
  $default:
    builders:
      enumerator_builder:
        options:
          predicate: false
          iterableLookup: false
          map: false
          isIn: false
```

---

### Configuration options

| Option           | Description                                                            | Default |
| ---------------- | ---------------------------------------------------------------------- | ------- |
| `predicate`      | Generates predicate getters derived from enum values (eg. `isPending`) | `true`  |
| `iterableLookup` | Generates `fromName`, `fromNameOrNull` helpers                         | `true`  |
| `map`            | Generates `map`, `mapOrNull`                                           | `true`  |
| `isIn`           | Generates `isIn()`                                                     | `true`  |

**Resolution priority:**

1. Enum annotation
2. `build.yaml`
3. Default value (`true`)

---

## Contributing

Issues, feature ideas, and pull requests are welcome.

---

## License

MIT
