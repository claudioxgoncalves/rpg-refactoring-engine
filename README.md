# RPG Refactoring Engine

**Automated source code transformation for IBM i — built entirely in RPGLE.**

[![Lines of Code](https://img.shields.io/badge/RPGLE-1235%20lines-blue)](#architecture)
[![Performance](https://img.shields.io/badge/Speed-under%201%20second-brightgreen)](#architecture)
[![Dependencies](https://img.shields.io/badge/Dependencies-none-lightgrey)](#why-pure-rpg)

> 10 minutes of manual work → under 1 second.
> No AI. No external dependencies. Fully auditable.

---

## The Problem

I was assigned to refactor 3,000+ programs. Same structural changes, program after program: update subroutines, replace API calls, inject variables, add history entries, standardise error handling.

My first attempt was a 576-line HAScript macro — a recorded refactoring routine edited for compatibility with other programs. It worked, until it didn't. The problem: **variable structures**. Across thousands of programs, naming conventions varied. The macro couldn't adapt.

I needed something that could not only *make* the changes, but *understand* where and why it should.

---

## The Solution

A template-driven transformation engine that treats RPG source code as queryable SQL data.

The engine reads any source member into a temporary workfile, processes it through four transformation levels using embedded SQL cursors and REGEX pattern matching, then outputs clean, resequenced source — ready to compile. All work happens in QTEMP. If anything fails, the original source is untouched.

This is **structural transformation** — modernising subroutines, API calls, error handling, and documentation within the same format and access method. Every program keeps its architecture; only the internals change.

**Result:** 10 minutes of manual work → **under 1 second**.

📹 **[Watch: Engine in action (~ 1 min)](https://1drv.ms/v/c/0a6a30ae31b8d1fe/IQCk3fQIVGb8S6m0OM23Y067AR6GHV2nuphGwhPgolau2_M?e=Ki2RWh)**

---

## Architecture

The engine processes source code through **4 transformation levels**, each building on the structural awareness established by previous levels:

```
┌────────────────────────────────────────────────────────────────┐
│                     REFACTORING ENGINE                         │
│  Input: Library / Source File / Member                         │
├────────────────────────────────────────────────────────────────┤
│                                                                │
│  LEVEL 1 ─ PLACEHOLDER SUBSTITUTION                            │
│  Extracts program-specific variable names from the existing    │
│  code and substitutes them into the template, replacing        │
│  generic placeholders. This is what the macro couldn't do.     │
│                                                                │
│  LEVEL 2 ─ HISTORY INSERTION                                   │
│  Locates the change history section, inserts new dated         │
│  entries. Detects whether related prior changes exist          │
│  to avoid duplicate documentation.                             │
│                                                                │
│  LEVEL 3 ─ VARIABLE INJECTION                                  │
│  Finds variable declaration boundaries and injects required    │
│  new declarations in the correct position.                     │
│                                                                │
│  LEVEL 4 ─ SUBROUTINE TRANSFORMATION                           │
│  Template-diff comparison: matches each source line against    │
│  the template with column-level awareness. Preserves, updates, │
│  inserts, or removes lines based on equivalence logic.         │
├────────────────────────────────────────────────────────────────┤
│  FINALIZATION                                                  │
│  Reorders and resequences all lines for clean, predictable,    │
│  compile-ready output.                                         │
└────────────────────────────────────────────────────────────────┘
```

### Core Concepts

**Source as data** — The source file is loaded into a SQL-accessible workfile. Every line becomes a queryable, updateable row. This is what makes structural awareness possible: instead of reading source top-to-bottom like a macro, the engine can search, compare, and manipulate any region of the code.

**Pattern detection over position** — The engine finds structural boundaries using REGEX, not fixed line numbers. It doesn't care whether a subroutine starts at line 200 or line 850 — it finds it by structure.

**Template-diff comparison** — Each source line is compared against its template counterpart with column-level awareness: code section vs. comment section, evaluated independently. The result determines whether to keep the source version, adopt the template version, or flag the line for removal.

**Configurable templates** — Templates are stored as compile-time data arrays. To change transformation behaviour, edit the data section. No code changes required. Different refactoring tasks require different templates — the engine logic stays the same.

---

## Before / After

<details>
<summary><strong>Click to expand — real transformation example</strong></summary>

### Before
```rpgle
     C     subrout       begsr
     C* Times the call to PGM1
     C                   time                    wzbcall1
     C                   call      'WAPGM1'
     C* Sends
     C                   parm                    wnvar1                         Example variable 1
     C                   parm                    wavar2                         Example variable 2
     C                   parm                    wnvar5                         Example variable 5
     C                   parm                    wavar4                         Example variable 4
     C                   parm                    wnvar3                         Example variable 3
     C* Receives
     C                   parm                    wavar7                         Example variable 7
     C                   parm                    wavar6                         Example variable 6
     ...
     C                   call      'AWPGM2'
     ...
     C                   if        wavar6 <> ' ' and wavar7 <> ' '              if
     ...
     C                   eval      wavar6 = ' '
     C                   eval      wavar7 = ' '
     ...
     C                   time                    wzbcall3
     C                   call      'WAPGM3'                             99
     ...
     C                   if        *in(99) = '1'                                if
     ...
     C                   eval      wnvar13 = 0
     C                   eval      wavar14 = ''
     C                   eval      wnvar15 = 0
     ...
     C                   parm                    hilovar                        |Placeholder 1
     C                   parm                    hiloval                        |Placeholder 2
     C                   parm                    hilohed                        |Placeholder
     C                   parm                    hilofot                        |Placeholder 4
```

### After
```rpgle
     C     subrout       begsr
     C* Times the call to PGM1
     C                   time                    wzbcall1
     C                   call      'WAPGM1'
     C* Sends
     C                   parm                    wnvar1                         Example variable 1
     C                   parm                    wavar2                         Example variable 2
     C                   parm                    wnvar3                         Example variable 3
     C                   parm                    wavar4                         Example variable 4
     C                   parm                    wnvar5                         Example variable 5
     C* Receives
     C                   parm                    wavar6                         Example variable 6
     C                   parm                    wavar7                         Example variable 7
     ...
     C                   call      'WAPGM2'
     ...
     C                   if        wavar6 <> *blanks and wavar7 <> *blanks      if
     ...
     C                   eval      wavar6 = *blanks
     C                   eval      wavar7 = *blanks
     ...
     C                   time                    wzbcall3
     C                   call(e)   'WAPGM3'
     ...
     C                   if        %error                                       if
     ...
     C                   eval      wnvar13 = *zeros
     C                   eval      wavar14 = *blanks
     C                   eval      wnvar15 = *zeros
     ...
     C                   parm                    abcdvar                        |Placeholder 1
     C                   parm                    abcdval                        |Placeholder 2
     C                   parm                    abcdhed                        |Placeholder 3
     C                   parm                    abcdfot                        |Placeholder 4
```

*note: the "BEFORE" version is purposefully chaotic to test the limits of the tool*

Diff-engine: *hold my beer*.

### What changed (in under 1 second)
- **Parameter order corrected** — scrambled parm sequences restored to standard order
- **Program name fixed** — `AWPGM2` → `WAPGM2`
- **Literal blanks standardised** — `' '` → `*blanks`, `''` → `*blanks`, `0` → `*zeros`
- **Error handling modernised** — indicator `*in(99) = '1'` → built-in `%error` with `call(e)`
- **Stray indicator removed** — `time wzbcall3 99` → clean `time wzbcall3`
- **Placeholder variables resolved** — `hilovar`/`hiloval`/`hilohed`/`hilofot` → standard names
- **Missing comments restored** — incomplete or missing parm descriptions filled in
- **Time variables corrected** — mismatched begin/end pairs fixed
- **New variables injected** into declaration section
- **History entry added** with date and task reference
- **Source resequenced** for clean, predictable output

</details>

---

## Performance

| Metric | Value |
|--------|-------|
| Lines of code | 1,235 |
| Execution time | < 1 second per program |
| Manual equivalent | ~10 minutes per program |
| Programs targeted | 3,000+ |
| External dependencies | None |

---

## Why Pure RPG?

No Python wrapper. No Java middleware. No external APIs. No network calls.

The tool runs on the same IBM i system it transforms. Any RPG developer can read this program and verify exactly what it does. Every transformation is traceable. Same input always produces the same output.

When you're touching 3,000+ programs in a financial system, *"it usually works"* isn't good enough.

---

## What's Next

This engine handles structural transformation — modernising code within the same format and access method. The next step is **architectural transformation**: Fixed → Free format conversion, Native I/O → SQL conversion. All in due time.

---

## Access

This repository discusses the engine's architecture and design decisions.

**Full source code is available upon request.**

📧 claudioxyzgoncalves@gmail.com

📍 Madeira, Portugal

---

© 2024–2026 Cláudio Gonçalves. All rights reserved.
