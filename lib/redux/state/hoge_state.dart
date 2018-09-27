import 'package:flutter/foundation.dart';

@immutable
class HogeState {
  final String fuga;

  const HogeState({
    this.fuga = 'fuga',
  });

  HogeState copyWith({
    String fuga,
  }) {
    return HogeState(
      fuga: fuga ?? this.fuga,
    );
  }
}
