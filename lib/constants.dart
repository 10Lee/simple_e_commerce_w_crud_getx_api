class Constants {
  static const String baseUrl = 'https://openapi.mrstein.web.id';

  static const String authorization =
      "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InN0ZW5seUBnbWFpbC5jb20iLCJuYW1lIjoiU3Rlbmx5IFJhY2htYWQiLCJwYXNzd29yZCI6IiQyYiQwOCRoN29CVnJHQ295Ly9ic2lrWk1RSGNlUEFHbkI3bEsvQmhKNUtZVE9HU2kxS1VLNDJPamFhNiIsImlkIjoyNCwiaWF0IjoxNjUwMDY4MjI1fQ.EK2SHHGA71iPuRhOON3tBMMv9pe_LDrNzh7rky0urzU";

  static String airsoft = '$baseUrl/airsoft';
  static String imageUrl = '$baseUrl/uploads';
  static String listOfTransactionBaseUrl = '$baseUrl/transaction?page=1';
  static String detailTransactionBaseUrl = '$baseUrl/transaction';
}
