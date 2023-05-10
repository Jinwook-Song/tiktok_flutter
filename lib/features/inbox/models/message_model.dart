class MessageModel {
  final String text;
  final String uid;

  MessageModel({
    required this.text,
    required this.uid,
  });

  MessageModel.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        uid = json['uid'];

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'uid': uid,
    };
  }
}
