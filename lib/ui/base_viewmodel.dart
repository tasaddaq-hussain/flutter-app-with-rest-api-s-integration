import 'package:flutter/material.dart';
import 'package:meta_melon_task_app/enums/enums.dart';


class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.IDLE;
  String _errorMessage = '';

  //Getters
  ViewState get state => _state;

  String get errorMessage => _errorMessage;

  //Setters
  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void setErrorMessage(String errorMessage) {
    _errorMessage = errorMessage;
    notifyListeners();
  }
}