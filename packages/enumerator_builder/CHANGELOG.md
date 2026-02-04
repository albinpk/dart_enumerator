## 0.0.1-dev.2

 - **DOCS**: update `README.md` and `LICENSE`.

## 0.0.1-dev.1

> Note: This release has breaking changes.

 - **REFACTOR**: rename generated files from `.g.dart` to `.enum.dart`.
 - **FEAT**: add `EnumLookup` annotation for custom enum field lookups and enable builder configuration via `build.yaml`.
 - **FEAT**: add `isIn` method for enum extensions.
 - **FEAT**: add `map` and `mapOrNull` extension methods for enums, configurable via the `Enumerator` annotation.
 - **FEAT**: customization with `predicate` and `iterableExtension` parameters in the `Enumerator` annotation.
 - **FEAT**: implement enum code generation with `Enumerator` annotation.
 - **FEAT**: create workspace.
 - **BREAKING** **REFACTOR**: renamed to `enumerator_annotation`.

