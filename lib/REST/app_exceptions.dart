class RestException implements Exception {
  final prefix;
  final message;
  final errorCode;

  RestException([this.prefix, this.message, this.errorCode]);

  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends RestException {
  final message;

  FetchDataException([this.message])
      : super("Error During Communication: ", message, 500);
}

class FetchDataErrorException extends RestException {
  final message;

  FetchDataErrorException([this.message])
      : super("Something went wrong please try again: ", message, 404);
}

class BadRequestException extends RestException {
  final message;

  BadRequestException([this.message])
      : super("Invalid Request: ", message, 404);
}

class UnauthorisedException extends RestException {
  final message;

  UnauthorisedException([this.message]) : super("Unauthorised: ", message, 401);
}

class InvalidInputException extends RestException {
  final message;

  InvalidInputException([this.message]) : super("Invalid Input: ", message);
}
