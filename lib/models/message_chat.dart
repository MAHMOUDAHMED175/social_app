

class MessageModel{
  String sender;
  String receiver;
  String dateTime;
  String text;
  String image;
  MessageModel({
    this.sender,
    this.receiver,
    this.dateTime,
    this.text,
    this.image,
  });

  MessageModel.fromJson(Map<String,dynamic>json){
    dateTime=json['dateTime'];
    sender=json['sender'];
    receiver=json['receiver'];
    text=json['text'];
    image=json['image'];
  }

  /* علشان احول الداتا اللى جايالى الى Map*/
  Map<String,dynamic> toMap(){
    return {
      'text':text,
      'sender':sender,
      'dateTime':dateTime,
      'receiver':receiver,
      'image':image,
    };

  }
}