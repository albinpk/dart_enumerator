## 0.0.1-dev.1

> Note: This release has breaking changes.

 - **BREAKING** **REFACTOR**: renamed to `enumerator_annotation`.

## 0.0.1-dev.0

 - **CHORE**: fix description in `pubspec.yaml`
 - **CHORE**: add MIT License
 - **CHORE**: add project metadata and topics to pubspec files.
 - **FIX**: add example for `@enumLookup`
 - **FEAT**: add `EnumLookup` annotation for custom enum field lookups and enable builder configuration via `build.yaml`
 - **REFACTOR**: rename generated files from `.g.dart` to `.enum.dart`
 - **FEAT**: add `isIn` method for enum extensions.
 - **FEAT**: add `map` and `mapOrNull` extension methods for enums, configurable via the `Enumerator` annotation.
 - **FEAT**: customization with `predicate` and `iterableExtension` parameters in the `Enumerator` annotation.
 - **FEAT**: create `example` project
 - **FEAT**: implement enum code generation with `Enumerator` annotation
 - **FEAT**: create workspace
