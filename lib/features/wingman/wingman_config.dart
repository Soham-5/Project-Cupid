import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Configuration and feature flag for the Wingman section.
/// 
/// ROLLBACK INSTRUCTIONS:
/// To completely roll back to the previous 5-tab UI:
/// Change [enabled] to `false`.
/// 
/// The application will immediately switch back to the original 5 tabs
/// (home, plans, match, vibes, you) without any Wingman routes or UI elements.
class WingmanConfig {
  WingmanConfig._();

  /// Master switch for the Wingman feature.
  /// Set to `true` to integrate Wingman as the 6th tab.
  /// Set to `false` to roll back to the original 5-tab layout.
  static const bool enabled = true;
}

final wingmanEnabledProvider = Provider<bool>((ref) {
  return WingmanConfig.enabled;
});
