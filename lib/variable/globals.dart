// lib/globals.dart
library myapp.globals;

import 'package:flutter/foundation.dart';

bool isLogin = true;

bool first = false;

double opacity_main_logo = 0;

/// Karanlık tema durumu - değişince uygulama yeniden çizilir
final ValueNotifier<bool> isDarkMode = ValueNotifier<bool>(false);
