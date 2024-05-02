// To parse this JSON data, do
//
//     final fetchFollowFollowingList = fetchFollowFollowingListFromJson(jsonString);

import 'dart:convert';

FetchFollowFollowingList fetchFollowFollowingListFromJson(String str) => FetchFollowFollowingList.fromJson(json.decode(str));

String fetchFollowFollowingListToJson(FetchFollowFollowingList data) => json.encode(data.toJson());

class FetchFollowFollowingList {
  FetchFollowFollowingList({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<FollowFollowingList> data;

  factory FetchFollowFollowingList.fromJson(Map<String, dynamic> json) => FetchFollowFollowingList(
    status: json["status"],
    message: json["message"],
    data: List<FollowFollowingList>.from(json["data"].map((x) => FollowFollowingList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class FollowFollowingList {
  FollowFollowingList({
    required this.userId,
    required this.userName,
    required this.email,
    required this.dob,
    required this.martialStatus,
    required this.profileImageUrl,
    required this.gender,
    required this.city,
    this.postCode,
    required this.phoneNo,
    required this.country,
    required this.lat,
    required this.long,
    this.address,
    required this.following,
    required this.follower,
    required this.totalPosts,
    required this.userTypeId,
    required this.isActive,
    required this.addDate,
    this.editDate,
    required this.isFriend,
  });

  String userId;
  String userName;
  String email;
  DateTime dob;
  String martialStatus;
  String profileImageUrl;
  String gender;
  String city;
  dynamic postCode;
  String phoneNo;
  String country;
  String lat;
  String long;
  dynamic address;
  String following;
  String follower;
  String totalPosts;
  String userTypeId;
  String isActive;
  DateTime addDate;
  dynamic editDate;
  String isFriend;

  factory FollowFollowingList.fromJson(Map<String, dynamic> json) => FollowFollowingList(
    userId: json["userId"],
    userName: json["userName"],
    email: json["email"],
    dob: DateTime.parse(json["DOB"]),
    martialStatus: json["martialStatus"],
    profileImageUrl: json["profileImageUrl"],
    gender: json["gender"],
    city: json["city"] ?? "",
    postCode: json["postCode"],
    phoneNo: json["phoneNo"],
    country: json["country"] ?? "",
    lat: json["lat"],
    long: json["long"],
    address: json["address"],
    following: json["following"],
    follower: json["follower"],
    totalPosts: json["totalPosts"],
    userTypeId: json["userTypeId"],
    isActive: json["isActive"],
    addDate: DateTime.parse(json["addDate"]),
    editDate: json["editDate"],
    isFriend: json["IsFriend"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "userName": userName,
    "email": email,
    "DOB": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "martialStatus": martialStatus,
    "profileImageUrl": profileImageUrl,
    "gender": gender,
    "city": city,
    "postCode": postCode,
    "phoneNo": phoneNo,
    "country": country,
    "lat": lat,
    "long": long,
    "address": address,
    "following": following,
    "follower": follower,
    "totalPosts": totalPosts,
    "userTypeId": userTypeId,
    "isActive": isActive,
    "addDate": addDate.toIso8601String(),
    "editDate": editDate,
    "IsFriend": isFriend,
  };
}
