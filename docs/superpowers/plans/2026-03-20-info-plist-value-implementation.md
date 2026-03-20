# InfoPlistValue Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Remove public `Any` from the package by introducing `InfoPlistValue` and replacing public dictionary access with strongly typed plist values.

**Architecture:** Add a low-level public plist AST (`InfoPlistValue`) with literal conformances, then bridge Foundation plist objects into that AST inside `Bundle+InfoDictionaryKey`. Keep `InfoDictionaryKey<Value>` as the strict contract for each key, migrate dictionary-shaped APIs/constants from `[String: Any]` to `[String: InfoPlistValue]`, and expand tests/README to cover the new surface.

**Tech Stack:** Swift 6, Swift Package Manager, Foundation, Swift Testing

---

## File Map

- Create: `Sources/InfoDictionaryKey/InfoPlistValue.swift`
- Modify: `Sources/InfoDictionaryKey/Bundle+InfoDictionaryKey.swift`
- Modify: `Sources/InfoDictionaryKey/InfoDictionaryKey+Define.swift`
- Modify: `README.md`
- Modify: `Tests/InfoDictionaryKeyTests/Fixtures/InfoDictionaryFixture.bundle/Contents/Info.plist`
- Modify: `Tests/InfoDictionaryKeyTests/InfoDictionaryKeyTests.swift`

## Chunk 1: Public AST Type

### Task 1: Add `InfoPlistValue`

**Files:**
- Create: `Sources/InfoDictionaryKey/InfoPlistValue.swift`
- Test: `Tests/InfoDictionaryKeyTests/InfoDictionaryKeyTests.swift`

- [ ] **Step 1: Write the failing literal tests**

Add Swift Testing cases that assert:
- `"hello"` becomes `.string("hello")`
- `true` becomes `.bool(true)`
- `3` becomes `.integer(3)`
- `3.5` becomes `.double(3.5)`
- `["a", true, 1]` becomes `.array([...])`
- `["name": "demo", "enabled": true]` becomes `.dictionary([...])`

- [ ] **Step 2: Run the focused test suite to verify failure**

Run: `swift test --filter InfoDictionaryKeyTests`
Expected: FAIL because `InfoPlistValue` does not exist yet.

- [ ] **Step 3: Implement `InfoPlistValue`**

Create `Sources/InfoDictionaryKey/InfoPlistValue.swift` with:
- a public `enum InfoPlistValue: Sendable, Hashable`
- cases:
  - `.string(String)`
  - `.bool(Bool)`
  - `.integer(Int)`
  - `.double(Double)`
  - `.array([InfoPlistValue])`
  - `.dictionary([String: InfoPlistValue])`
- literal conformances:
  - `ExpressibleByStringLiteral`
  - `ExpressibleByBooleanLiteral`
  - `ExpressibleByIntegerLiteral`
  - `ExpressibleByFloatLiteral`
  - `ExpressibleByArrayLiteral`
  - `ExpressibleByDictionaryLiteral`

Dictionary literal conformance must constrain keys to `String`.

- [ ] **Step 4: Run the focused test suite to verify it passes**

Run: `swift test --filter InfoDictionaryKeyTests`
Expected: the new `InfoPlistValue` literal tests pass, existing dictionary tests may still fail until later tasks.

- [ ] **Step 5: Commit**

```bash
git add Sources/InfoDictionaryKey/InfoPlistValue.swift Tests/InfoDictionaryKeyTests/InfoDictionaryKeyTests.swift
git commit -m "feat: add InfoPlistValue plist AST"
```

## Chunk 2: Replace Public `[String: Any]`

### Task 2: Bridge Foundation plist objects into `InfoPlistValue`

**Files:**
- Modify: `Sources/InfoDictionaryKey/Bundle+InfoDictionaryKey.swift`
- Test: `Tests/InfoDictionaryKeyTests/InfoDictionaryKeyTests.swift`

- [ ] **Step 1: Write the failing bridge tests**

Add tests for:
- reading a nested dictionary key as `[String: InfoPlistValue]`
- reading a heterogeneous key as `InfoPlistValue`
- dictionary and plist-value mismatch throwing `InfoDictionaryError.typeMismatch`

- [ ] **Step 2: Run the focused test suite to verify failure**

Run: `swift test --filter InfoDictionaryKeyTests`
Expected: FAIL because the package still exposes `[String: Any]`.

- [ ] **Step 3: Implement the internal bridge**

Update `Sources/InfoDictionaryKey/Bundle+InfoDictionaryKey.swift`:
- keep `value(for:)`, `value(for:default:)`, `string(for:)`, `bool(for:)`, `array(for:)`
- change `dictionary(for:)` and `dictionary(for:default:)` to `[String: InfoPlistValue]`
- add optional readability sugar:
  - `plistValue(for key: InfoDictionaryKey<InfoPlistValue>) throws -> InfoPlistValue`
  - `plistValue(for key: InfoDictionaryKey<InfoPlistValue>, default defaultValue: @autoclosure () -> InfoPlistValue) -> InfoPlistValue`
- add private helpers in the same file:
  - a function that converts raw Foundation plist values into `InfoPlistValue`
  - a function that converts Foundation dictionaries into `[String: InfoPlistValue]`

Bridge rules:
- `String` -> `.string`
- `NSNumber` that is `kCFBooleanTrue`/`kCFBooleanFalse` -> `.bool`
- integral numeric values -> `.integer`
- other numeric values -> `.double`
- `[Any]` -> `.array` recursively
- `[String: Any]` -> `.dictionary` recursively
- unknown runtime shapes -> `nil` from bridge helper so caller throws `typeMismatch`

- [ ] **Step 4: Route public methods through the bridge where needed**

In `value(for:)`, before the plain `as? T` fallback:
- if `T == InfoPlistValue`, convert raw value into `InfoPlistValue`
- if `T == [String: InfoPlistValue]`, convert raw value into a typed dictionary

Keep scalar behavior unchanged for `String`, `Bool`, `[String]`, etc.

- [ ] **Step 5: Run the focused test suite to verify pass**

Run: `swift test --filter InfoDictionaryKeyTests`
Expected: dictionary/plist-value tests pass.

- [ ] **Step 6: Commit**

```bash
git add Sources/InfoDictionaryKey/Bundle+InfoDictionaryKey.swift Tests/InfoDictionaryKeyTests/InfoDictionaryKeyTests.swift
git commit -m "feat: bridge plist values without public Any"
```

### Task 3: Migrate predefined keys to strict dictionary typing

**Files:**
- Modify: `Sources/InfoDictionaryKey/InfoDictionaryKey+Define.swift`
- Test: `Tests/InfoDictionaryKeyTests/InfoDictionaryKeyTests.swift`

- [ ] **Step 1: Write the failing constant-mapping assertions**

Add/adjust tests so dictionary-shaped predefined keys assert against:
- `InfoDictionaryKey<[String: InfoPlistValue]>`

- [ ] **Step 2: Run focused tests to verify failure**

Run: `swift test --filter InfoDictionaryKeyTests`
Expected: FAIL because predefined dictionary keys still use `[String: Any]`.

- [ ] **Step 3: Update constants**

Modify `Sources/InfoDictionaryKey/InfoDictionaryKey+Define.swift`:
- change dictionary-shaped constants from `[String: Any]` to `[String: InfoPlistValue]`
- keep scalar and array constants unchanged
- add DocC comments for any new `InfoDictionaryKey<InfoPlistValue>` constants if introduced

- [ ] **Step 4: Run focused tests to verify pass**

Run: `swift test --filter InfoDictionaryKeyTests`
Expected: constant-catalog tests pass.

- [ ] **Step 5: Commit**

```bash
git add Sources/InfoDictionaryKey/InfoDictionaryKey+Define.swift Tests/InfoDictionaryKeyTests/InfoDictionaryKeyTests.swift
git commit -m "feat: type plist dictionary keys with InfoPlistValue"
```

## Chunk 3: Fixtures, Docs, and Regression Coverage

### Task 4: Expand fixture data for nested plist coverage

**Files:**
- Modify: `Tests/InfoDictionaryKeyTests/Fixtures/InfoDictionaryFixture.bundle/Contents/Info.plist`
- Test: `Tests/InfoDictionaryKeyTests/InfoDictionaryKeyTests.swift`

- [ ] **Step 1: Add failing nested-shape tests**

Add tests for fixture values such as:
- nested dictionary
- mixed array inside dictionary
- numeric scalar mapping to `.integer`
- floating-point scalar mapping to `.double`

- [ ] **Step 2: Run focused tests to verify failure**

Run: `swift test --filter InfoDictionaryKeyTests`
Expected: FAIL because fixture values do not exist yet.

- [ ] **Step 3: Extend the fixture plist**

Add keys like:
- `FixtureNestedDictionary`
- `FixtureHeterogeneousArray`
- `FixtureDouble`
- `FixtureValueTree`

Make sure all values are valid property-list values.

- [ ] **Step 4: Run focused tests to verify pass**

Run: `swift test --filter InfoDictionaryKeyTests`
Expected: nested bridge tests pass.

- [ ] **Step 5: Commit**

```bash
git add Tests/InfoDictionaryKeyTests/Fixtures/InfoDictionaryFixture.bundle/Contents/Info.plist Tests/InfoDictionaryKeyTests/InfoDictionaryKeyTests.swift
git commit -m "test: cover nested InfoPlistValue bridging"
```

### Task 5: Remove public `Any` from examples and docs

**Files:**
- Modify: `README.md`
- Test: `Tests/InfoDictionaryKeyTests/InfoDictionaryKeyTests.swift`

- [ ] **Step 1: Add a failing documentation regression assertion**

Extend the existing regression test so it also asserts README does not contain `[String: Any]`.

- [ ] **Step 2: Update README usage**

Replace any dictionary example or wording that implies `Any` with:
- scalar sugar examples
- `InfoPlistValue` example for heterogeneous values
- optionally a short dictionary example using `[String: InfoPlistValue]`

- [ ] **Step 3: Run focused tests to verify pass**

Run: `swift test --filter InfoDictionaryKeyTests`
Expected: README regression check passes.

- [ ] **Step 4: Commit**

```bash
git add README.md Tests/InfoDictionaryKeyTests/InfoDictionaryKeyTests.swift
git commit -m "docs: remove public Any from package examples"
```

## Chunk 4: Final Verification

### Task 6: Run full package verification

**Files:**
- Modify: none

- [ ] **Step 1: Run full build**

Run: `swift build`
Expected: `Build complete!`

- [ ] **Step 2: Run full test suite**

Run: `swift test`
Expected: all Swift Testing cases pass.

- [ ] **Step 3: Review public API for `Any` leakage**

Run:

```bash
rg -n "\\[String: Any\\]|\\bAny\\b" Sources README.md Tests
```

Expected:
- no public API signatures returning or exposing `Any`
- any remaining `Any` usage is internal bridge implementation only

- [ ] **Step 4: Inspect final diff**

Run:

```bash
git diff --stat main...
```

Expected: changes limited to the AST type, bundle bridge, constants, fixture/tests, and docs.

- [ ] **Step 5: Push branch**

```bash
git push
```

