import 'package:flutter/material.dart';

import 'package:vibeu_fe/routing/router.dart';

void main() {
  // debugRepaintRainbowEnabled = true;

  runApp(MaterialApp.router(
    routerConfig: router(),
  ));
}
