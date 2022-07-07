class CommentModel {
  String? name;
  String? imageComment;
  String? image;
  String? textComment;
  String? uId;
  String? postId;

  CommentModel(
      {this.image,
        this.name,
        this.imageComment,
        this.textComment,
        this.uId,
        this.postId});

  CommentModel.fromJson(Map<String, dynamic> json) {
    imageComment = json['imageComment'];
    image = json['image'];
    name = json['name'];
    textComment = json['textComment'];
    uId = json['uId'];
    postId = json['postId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'imageComment': imageComment,
      'textComment': textComment,
      'uId': uId,
      'postId': postId
    };
  }
}