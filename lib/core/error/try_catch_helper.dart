import 'package:fpdart/fpdart.dart';
import 'package:google_contact/core/error/response_handler.dart';
import 'package:google_contact/core/utils/app_utils.dart';
import 'api_exception_model.dart';
import 'failure.dart';

mixin TryCatchHelper {
  Future<Either<Failure, T>> tryCatch<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return right(result);
    } catch (err, st) {
      printDebug("error:", err);
      ApiException error = ApiResponseHandler().handle(err, st);
      return left(Failure(error.message));
    }
  }
}
