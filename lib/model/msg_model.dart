class MessagerModel {
  String? senderId;
  String? reciverId;
  String? text;
  String? dateTime;

  MessagerModel({
    this.senderId,
    this.reciverId,
    this.text,
    this.dateTime,
  });

  MessagerModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    reciverId = json['reciverId'];
    text = json['text'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'reciverId': reciverId,
      'text': text,
      'dateTime': dateTime,
    };
  }
}