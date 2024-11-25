class Noti {
  String id;
  String type;
  String senderId;
  String senderName;
  String receiverId;
  String senderPhotoUrl;
  String title;
  String body;
  bool isRead;
  String time;
  Noti(
      {required this.id,
      required this.type,
      required this.senderId,
      required this.senderName,
      required this.receiverId,
      required this.senderPhotoUrl,
      required this.title,
      required this.body,
      required this.isRead,
      required this.time});
  factory Noti.fromMap(Map<String, dynamic> map) => Noti(
      id: map['id'],
      type: map['type'],
      senderId: map['senderId'],
      senderName: map['senderName'],
      receiverId: map['receiverId'],
      senderPhotoUrl: map['senderPhotoUrl'],
      title: map['title'],
      body: map['body'],
      isRead: map['isRead'],
      time: map['time']);
}
