import 'dart:io';
import '../utils/app_utils.dart';
import 'api_exception_model.dart';

class ApiResponseHandler {
  ApiException handle(dynamic error, StackTrace stackTrace) {
    try {

      if (error is ApiException) {
        throw  error;
      }
      if (error is SocketException) {
        throw  ApiException("No internet connection");
      }
      if (error is FormatException || error is TypeError) {
        throw  ApiException("Data parsing error");
      }
      throw ApiException("Something went wrong");
    } catch (e, st) {
      final String message = e is ApiException
          ? e.message
          : "Something went wrong";
      printDebug("######### Normalised  ERROR#######", message);
      printDebug("\n#########RAW Error#######", e);
      printDebug("\n#########RAW StackTree#######", stackTrace);
      return ApiException(message);
    }
  }
}
