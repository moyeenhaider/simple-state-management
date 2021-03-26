import 'package:taste/state/store.dart';

final _store = Store();

abstract class IObservable {
  Store get data => _store;
  void subscribe(Function funRef);
  void notify();
}

class Observable extends IObservable {
  List<Function> _subscribedFuntion = [];

  @override
  void subscribe(Function funRef) {
    _subscribedFuntion.add(funRef);
  }

  @override
  void notify() {
    _subscribedFuntion.forEach((element) {
      element();
    });
  }

  unsubscribe(Function ref) => _subscribedFuntion.remove(ref);
}
