class ExtractExceptionApi {
  // Helper method to extract error message from exception
  static String extractErrorMessage(String exceptionString) {
    final match = RegExp(r'"message":"(.*?)"').firstMatch(exceptionString);
    return match?.group(1) ?? 'Unknown error occurred';
  }

// Helper method to extract error status from exception
  static String extractErrorStatus(String exceptionString) {
    final match = RegExp(r'"status":(\d+)').firstMatch(exceptionString);
    return match?.group(1) ?? 'No status code';
  }
}
