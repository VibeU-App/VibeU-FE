import 'package:flutter_riverpod/flutter_riverpod.dart';

final class RiverpodLogger extends ProviderObserver {
  @override
  void didDisposeProvider(
    ProviderObserverContext context
  ) {
    print('Disposed: ${context.provider.name}');
  }

  @override
  void didAddProvider(
    ProviderObserverContext context,
    Object? value
  ) {
    print('Created: ${context.provider.name}');
  }
}
