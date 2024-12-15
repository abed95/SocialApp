class PostModel {
  String? name;
  String? userID;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;


  PostModel({
    this.name,
    this.userID,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,

  });
  PostModel.fromJson(Map<String?, dynamic> json) {
    name = json['name'];
    userID = json['userID'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'userID': userID,
      'image': image,
      'dateTime': image,
      'text': image,
      'postImage': image,
    };
  }
}
