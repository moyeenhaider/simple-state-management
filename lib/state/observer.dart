import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:taste/state/observable.dart';

class Observer extends StatefulWidget {
  final Widget Function(BuildContext) builder;
  final Observable observable;

  const Observer({Key key, this.observable, this.builder}) : super(key: key);

  @override
  _ObserverState createState() => _ObserverState();
}

class _ObserverState extends State<Observer> {
  @override
  void initState() {
    widget.observable.subscribe(_update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }

  _update() => setState(() {});

  @override
  void dispose() {
    widget.observable.unsubscribe(_update);
    super.dispose();
  }
}
