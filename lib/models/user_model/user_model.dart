class UserModel{
  String? name;
  String? email;
  String? phone;
  String? userID;
 bool? isEmailVerified;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.userID,
    this.isEmailVerified,
});
  UserModel.fromJson(Map<String?,dynamic> json){
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    userID = json['userID'];
   isEmailVerified = json['isEmailVerified'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'userID':userID,
      'isEmailVerified':isEmailVerified,
    };
  }

}