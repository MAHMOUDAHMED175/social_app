

class PostModel{
  String name;
  String uid;
  String image;
  String dateTime;
  String  text;
  String postImage;

  PostModel({
    this.uid,
    this.name,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,

  });

  PostModel.fromJson(Map<String,dynamic>json){
    dateTime=json['dateTime'];
    uid=json['uid'];
    name=json['name'];
    text=json['text'];
    image=json['image'];
    postImage=json['postImage'];
  }

  /* علشان احول الداتا اللى جايالى الى Map*/
  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'text':text,
      'postImage':postImage,
      'dateTime':dateTime,
      'uid':uid,
      'image':image,
    };

  }
}