# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 2026-02-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`enumerator_annotation` - `v0.0.1-dev.2`](#enumerator_annotation---v001-dev2)
 - [`enumerator_builder` - `v0.0.1-dev.3`](#enumerator_builder---v001-dev3)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `enumerator_builder` - `v0.0.1-dev.3`

---

#### `enumerator_annotation` - `v0.0.1-dev.2`

 - **DOCS**: update `README.md`.


## 2026-02-04

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`enumerator_builder` - `v0.0.1-dev.2`](#enumerator_builder---v001-dev2)

---

#### `enumerator_builder` - `v0.0.1-dev.2`

 - **DOCS**: update `README.md` and `LICENSE`.


## 2026-02-04

### Changes

---

Packages with breaking changes:

 - [`enumerator_annotation` - `v0.0.1-dev.1`](#enumerator_annotation---v001-dev1)
 - [`enumerator_builder` - `v0.0.1-dev.1`](#enumerator_builder---v001-dev1)

Packages with other changes:

 - There are no other changes in this release.

---

#### `enumerator_annotation` - `v0.0.1-dev.1`

 - **BREAKING** **REFACTOR**: renamed to `enumerator_annotation`.

#### `enumerator_builder` - `v0.0.1-dev.1`

 - **REFACTOR**: rename generated files from `.g.dart` to `.enum.dart`.
 - **FEAT**: add `EnumLookup` annotation for custom enum field lookups and enable builder configuration via `build.yaml`.
 - **FEAT**: add `isIn` method for enum extensions.
 - **FEAT**: add `map` and `mapOrNull` extension methods for enums, configurable via the `Enumerator` annotation.
 - **FEAT**: customization with `predicate` and `iterableExtension` parameters in the `Enumerator` annotation.
 - **FEAT**: implement enum code generation with `Enumerator` annotation.
 - **FEAT**: create workspace.
 - **BREAKING** **REFACTOR**: renamed to `enumerator_annotation`.

