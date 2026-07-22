import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vibeu_fe/routing/router.dart';

void main() {
  // debugRepaintRainbowEnabled = true;

  runApp(
    ProviderScope(
      child: MaterialApp.router(routerConfig: router())
    )
  );
}
