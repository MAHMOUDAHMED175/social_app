

class SocialCreateUserModel{
  String name;
  String email;
  String password;
  String phone;
  String uid;
  String image;
  String cover;
  String bio;
  bool isEmailVerify;

  SocialCreateUserModel({
    this.email,
    this.uid,
    this.name,
    this.image,
    this.cover,
    this.bio,
    this.phone,
    this.password,
    this.isEmailVerify,
});

  SocialCreateUserModel.fromJson(Map<String,dynamic>json){
    email=json['email'];
    uid=json['uid'];
    name=json['name'];
    phone=json['phone'];
    image=json['image'];
    cover=json['cover'];
    bio=json['bio'];
    password=json['password'];
    isEmailVerify=json['isEmailVerify'];
  }

  /* علشان احول الداتا اللى جايالى الى Map*/
  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'phone':phone,
      'password':password,
      'email':email,
      'uid':uid,
      'bio':bio,
      'cover':cover,
      'image':image,
      'isEmailVerify':isEmailVerify,
    };

  }
}