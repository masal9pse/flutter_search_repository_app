import 'package:flutter_engineer_codecheck/domain/model/error.dart';
import 'package:flutter_engineer_codecheck/domain/model/search_api_model.dart';

sealed class AppState {
 const AppState(); 
}

class Idle extends AppState {
  const Idle();
}

class Loading extends AppState {
  const Loading();
}

class Data extends AppState {
  const Data(this.searchApiModel);
  final SearchApiModel searchApiModel;
}

class Error extends AppState {
  const Error(this.exception);
  final Exception exception;
}