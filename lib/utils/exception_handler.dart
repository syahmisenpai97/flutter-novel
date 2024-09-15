import 'package:kacs/utils/extract_exception_api.dart';
import 'package:kacs/utils/utils.dart';

Future<void> handleApiException(dynamic e) async {
  if (e is Exception) {
    final errorMessage = ExtractExceptionApi.extractErrorMessage(e.toString());
    final status = ExtractExceptionApi.extractErrorStatus(e.toString());
    await Utils.showToast(errorMessage, isError: true);
    print('Error Status: $status');
    print('Error Message: $errorMessage');
  } else {
    await Utils.showToast('Unexpected error', isError: true);
    print('Unexpected error: $e');
  }
}
