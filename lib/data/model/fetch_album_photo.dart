
import 'dart:convert';

FetchAlbumPhoto fetchAlbumPhotoModelFromJson(String str) => FetchAlbumPhoto.fromJson(json.decode(str));

String fetchAlbumPhotoToJson(FetchAlbumPhoto data) => json.encode(data.toJson());



class FetchAlbumPhoto {
  String? statusCode;
  String? status;
  String? message;
  List<Data>? data;

  FetchAlbumPhoto({this.statusCode, this.status, this.message, this.data});

  FetchAlbumPhoto.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? albumImageId;
  int? albumId;
  String? userId;
  String? imageUrl;
  String? addDate;

  Data(
      {this.albumImageId,
        this.albumId,
        this.userId,
        this.imageUrl,
        this.addDate});

  Data.fromJson(Map<String, dynamic> json) {
    albumImageId = json['albumImageId'];
    albumId = json['albumId'];
    userId = json['userId'];
    imageUrl = json['imageUrl'];
    addDate = json['addDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumImageId'] = this.albumImageId;
    data['albumId'] = this.albumId;
    data['userId'] = this.userId;
    data['imageUrl'] = this.imageUrl;
    data['addDate'] = this.addDate;
    return data;
  }
}