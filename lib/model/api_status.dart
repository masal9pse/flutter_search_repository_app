class Success {
  int? code;
  Object response;
  Success({required this.code,required this.response});
}

class Failure {
  int code;
  Object errorResponse;
  Failure({required this.code,required this.errorResponse});
}

class SearchApiError {
  int code;
  String message;
  SearchApiError({required this.code,required this.message});
}