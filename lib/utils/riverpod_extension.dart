import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';

extension WidgetRefExtension on WidgetRef {
  void listenQuick<T>(
    ProviderListenable<AsyncValue<T>> provider, {
    Function(T data)? onData,
    handleError = false,
  }) {
    listen(
      provider,
      (prev, next) {
        next.whenOrNull(
          data: onData,
          error: handleError
            ? (e, st) {
              Get.snackbar("", e.toString());
            }
            : null,
        );
      }
    );
  }
}
