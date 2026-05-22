import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/app_utils.dart';
import 'api_exception_model.dart';

class ApiResponseHandler {
  ApiException handle(dynamic error, StackTrace stackTrace) {
    late final ApiException exception;

    if (error is ApiException) {
      exception = error;
    } else if (error is SocketException) {
      exception = ApiException("No internet connection");
    } else if (error is FormatException || error is TypeError) {
      exception = ApiException("Data parsing error");
    } else if (error is FirebaseException) {
      exception = ApiException(getMessage(error));
    } else {
      exception = ApiException("Something went wrong");
    }

    // DEBUG LOGS
    printDebug("######### Normalised ERROR #######", exception.message);

    printDebug("\n######### RAW Error #######", error);

    printDebug("\n######### RAW StackTrace #######", stackTrace);

    return exception;
  }

  static String getMessage(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return 'Permission denied';

      case 'unavailable':
        return 'Firebase service unavailable';

      case 'not-found':
        return 'Requested document not found';

      case 'already-exists':
        return 'Data already exists';

      case 'cancelled':
        return 'Request cancelled';

      case 'deadline-exceeded':
        return 'Request timeout';

      case 'resource-exhausted':
        return 'Too many requests';

      case 'failed-precondition':
        return 'Operation failed';

      case 'aborted':
        return 'Operation aborted';

      case 'out-of-range':
        return 'Out of range';

      case 'unimplemented':
        return 'Feature not implemented';

      case 'internal':
        return 'Internal server error';

      case 'data-loss':
        return 'Data loss occurred';

      case 'unauthenticated':
        return 'User unauthenticated';

      default:
        return e.message ?? 'Something went wrong';
    }
  }
}
