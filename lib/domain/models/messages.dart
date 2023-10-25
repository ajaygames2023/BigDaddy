class Message {
  int? respCode;
  String? message;

  Message({this.respCode, this.message});

  Message.fromJson(Map<String, dynamic> json) {
    respCode = json['respCode'];
    message = json['message'];
  }
}