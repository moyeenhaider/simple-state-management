import 'dart:async';

import 'state.dart';

final _xState = XState();

class XController {
  XState get state => _xState;
  // ignore: close_sinks
  final StreamController<XState> _streamController = StreamController<XState>();

  Stream<XState> get stream => _streamController.stream;

  update() => _streamController.sink.add(state);
}
