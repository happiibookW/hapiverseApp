// To parse this JSON data, do
//
//     final getAllMyPostsModel = getAllMyPostsModelFromJson(jsonString);

import 'dart:convert';

GetAllMyPostsModel getAllMyPostsModelFromJson(String str) => GetAllMyPostsModel.fromJson(json.decode(str));

String getAllMyPostsModelToJson(GetAllMyPostsModel data) => json.encode(data.toJson());

class GetAllMyPostsModel {
  GetAllMyPostsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<GetMyAllPosts> data;

  factory GetAllMyPostsModel.fromJson(Map<String, dynamic> json) => GetAllMyPostsModel(
    status: json["status"],
    message: json["message"],
    data: List<GetMyAllPosts>.from(json["data"].map((x) => GetMyAllPosts.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetMyAllPosts {
  GetMyAllPosts({
    required this.postId,
    required this.userId,
    required this.caption,
    required this.privacy,
    required this.contentType,
    required this.postType,
    this.fontColor,
    this.textBackGround,
    required this.postedDate,
    this.expireAt,
    this.interest,
    required this.active,
    this.profileName,
    this.profileImageUrl,
    this.location,
    this.postContentText,
    required this.totalLike,
    required this.totalComment,
    this.postFiles,
    required this.firstgredientcolor,
    required this.secondgredientcolor,
    required this.hasVerified,
    required this.userTypeId,
    this.isLiked,
  });

  String postId;
  String userId;
  String userTypeId;
  String hasVerified;
  String caption;
  String privacy;
  String contentType;
  String postType;
  String? fontColor;
  String? textBackGround;
  DateTime postedDate;
  String? expireAt;
  String? interest;
  String active;
  String? profileName;
  String? profileImageUrl;
  String? location;
  String? postContentText;
  String totalLike;
  String totalComment;
  String firstgredientcolor;
  String secondgredientcolor;
  List<PostFile>? postFiles;
  bool? isLiked;

  factory GetMyAllPosts.fromJson(Map<String, dynamic> json) => GetMyAllPosts(
    postId: json["postId"],
    userId: json["userId"],
    caption: json["caption"] ?? "",
    userTypeId: json["userTypeId"] ?? "1",
    hasVerified: json["hasVerified"] == null ? "0" :json["hasVerified"],
    privacy: json["privacy"],
    contentType: json["content_type"],
    postType: json["postType"],
    fontColor: json["font_color"],
    firstgredientcolor: json["firstgredientcolor"].toString(),
    secondgredientcolor: json["secondgredientcolor"].toString(),
    textBackGround: json["text_back_ground"],
    postedDate: DateTime.parse(json["posted_date"]),
    expireAt: json["expire_at"],
    interest: json["interest"],
    active: json["active"],
    profileName: json["profileName"],
    profileImageUrl: json["profileImageUrl"],
    location: json["location"],
    postContentText: json["postContentText"],
    totalLike: json["totalLike"],
    isLiked: json["isLiked"],
    totalComment: json["totalComment"],
    postFiles: List<PostFile>.from(json["postFiles"].map((x) => PostFile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "postId": postId,
    "userId": userId,
    "caption": caption,
    "privacy": privacy,
    "content_type": contentType,
    "postType": postType,
    "font_color": fontColor,
    "text_back_ground": textBackGround,
    "posted_date": postedDate.toIso8601String(),
    "expire_at": expireAt,
    "interest": interest,
    "active": active,
    "profileName": profileName,
    "profileImageUrl": profileImageUrl,
    "location": location,
    "postContentText": postContentText,
    "totalLike": totalLike,
    "totalComment": totalComment,
    "isLiked": isLiked,
    "postFiles": List<dynamic>.from(postFiles!.map((x) => x.toJson())),
  };
}

class PostFile {
  PostFile({
    required this.postFileId,
    required this.postId,
    required this.userId,
    required this.postFileUrl,
  });

  String postFileId;
  String postId;
  String userId;
  String postFileUrl;

  factory PostFile.fromJson(Map<String, dynamic> json) => PostFile(
    postFileId: json["postFileId"],
    postId: json["postId"],
    userId: json["userId"],
    postFileUrl: json["postFileUrl"],
  );

  Map<String, dynamic> toJson() => {
    "postFileId": postFileId,
    "postId": postId,
    "userId": userId,
    "postFileUrl": postFileUrl,
  };
}
