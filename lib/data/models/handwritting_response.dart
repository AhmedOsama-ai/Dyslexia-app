class HandwrittingResponse {
// {message: success, parsedText: Cat}
  final String message;
  final String parsedText;

  HandwrittingResponse({
    required this.message,
    required this.parsedText,
  });

  factory HandwrittingResponse.fromJson(Map<String, dynamic> json) {
    return HandwrittingResponse(
        message: json['message']!, parsedText: json['parsedText']!);
  }

  @override
  String toString() {
    return 'msg: $message \nParsed txt: $parsedText';
  }
}
