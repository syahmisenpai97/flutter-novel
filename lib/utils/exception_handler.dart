import 'package:kacs/utils/extract_exception_api.dart';
import 'package:kacs/utils/utils.dart';

void handleApiException(dynamic e) {
  if (e is Exception) {
    final errorMessage = ExtractExceptionApi.extractErrorMessage(e.toString());
    final status = ExtractExceptionApi.extractErrorStatus(e.toString());
    Utils.showToast(errorMessage, isError: true);
    print('Error Status: $status');
    print('Error Message: $errorMessage');
  } else {
    Utils.showToast('Unexpected error', isError: true);
    print('Unexpected error: $e');
  }
}
