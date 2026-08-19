import 'package:flutter/material.dart';

abstract base class FormValues {
  void init(State<StatefulWidget> screenState);

  Set<Object?> get encapsulatedObjects;

  @mustCallSuper
  void dispose() {
    for (final object in encapsulatedObjects) {
      if (object is ChangeNotifier) {
        object.dispose();
      }
    }
  }
}
