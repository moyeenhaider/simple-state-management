import 'package:flutter/material.dart';

import 'xcontroller.dart';

class XStateBuilder extends StatelessWidget {
  final Widget Function(XController) builder;

  final XController _controller;

  XStateBuilder({Key key, this.builder, XController controller})
      : _controller = controller ?? XController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _controller.stream,
      builder: (_, __) => builder(_controller),
    );
  }
}
