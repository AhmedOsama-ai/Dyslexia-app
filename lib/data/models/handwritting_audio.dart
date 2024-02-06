class HandwrittingAudio {
  String audioUrl;
  String text;

  HandwrittingAudio({required this.audioUrl, required this.text});

  factory HandwrittingAudio.fromJson(Map<String, dynamic> json) {
    return HandwrittingAudio(audioUrl: json['audioUrl'], text: json['text']);
  }
  @override
  String toString() {
    return 'audioUrl: $audioUrl\ntext: $text';
  }
}
