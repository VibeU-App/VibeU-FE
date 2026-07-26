import 'package:flutter/material.dart';

import 'result.dart';

// Command objects based on Flutter Command pattern
// consult Flutter design patterns page for more info
abstract class Command<T> extends ChangeNotifier {
  Command();

  bool _running = false;

  Result<T>? _result;
  Result<T>? get result => _result;

  bool get isRunning => _running;
  bool get iError => _result is Error;
  bool get isCompleted => _result is Ok;

  Future<void> _execute(
    Future<Result<T>> Function() action
  ) async {
    if (_running) return;

    _running = true;
    _result = null;
    notifyListeners();

    try {
      _result = await action();
    } finally {
      _running = false;
      notifyListeners();
    }
  }

  void clear() {
    _running = false;
    _result = null;
  }
}

class Command0<T> extends Command<T> {
  Command0(this._action);
  
  final Future<Result<T>> Function() _action;

  Future<void> execute() async {
    await _execute(_action);
  }
}

class Command1<T, A> extends Command<T> {
  Command1(this._action);

  final Future<Result<T>> Function(A) _action;

  Future<void> execute(A args) async {
    _execute(() => _action(args));
  }
}
