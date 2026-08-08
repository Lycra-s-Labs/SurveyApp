import 'package:flutter/material.dart';

/// Project-local icon compatibility layer.
///
/// The app only needs this small subset of the Lucide API. Keeping the names
/// aligned with Lucide makes call sites easy to read while avoiding a separate
/// icon-font dependency. These Material symbols are included by Flutter's
/// `uses-material-design` setting.
abstract final class LucideIcons {
  const LucideIcons._();

  static const IconData crosshair = Icons.gps_fixed;
  static const IconData clipboard = Icons.content_paste;
  static const IconData arrowRight = Icons.arrow_forward;
  static const IconData arrowLeftRight = Icons.swap_horiz;
  static const IconData chevronRight = Icons.chevron_right;
  static const IconData check = Icons.check;
}
