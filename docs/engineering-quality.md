# Engineering quality

AFK aims to make the reliable path the easy path.

## Definition of done
- The change has a clear owning feature or foundation package.
- Public APIs and dependency decisions are documented.
- UI uses semantic design tokens and supports English/Arabic directionality.
- Behavior has focused tests; visual behavior has widget tests where practical.
- `dart format`, `flutter analyze`, and relevant tests pass on a supported Flutter SDK.
- Native application identifiers and display names are validated against the Dart `AppIdentity` by reading the actual Android and iOS project files.
- CI builds an Android Debug APK and an unsigned iOS Simulator app on their respective hosted operating systems.
- The author reports what was actually verified and what remains unverified.

## AI-assisted contribution rules
- Read repository instructions before editing.
- Inspect nearby code and existing abstractions before adding new ones.
- Make small, coherent changes; do not rewrite unrelated files.
- Do not invent package APIs or claim tests passed without execution.
- Keep generated output out of the repository unless explicitly approved (AFK avoids code generation by default).
