import 'package:flutter/material.dart';
import 'package:dice_bear/dice_bear.dart';

Widget diceBearAvatar(String seed, DiceBearPersonasOptions preset) {
  return DiceBearRequest<DiceBearPersonasOptions>(
    style: DiceBearStyle.personas,
    coreOptions: DiceBearCoreOptions(
      seed: seed
    ),
    styleOptions: preset,
  ).toImage();
}
