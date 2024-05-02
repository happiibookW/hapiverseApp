

import 'dart:convert';

FetchAlbumModel fetchAlbumModelFromJson(String str) => FetchAlbumModel.fromJson(json.decode(str));

String fetchAlbumModelToJson(FetchAlbumModel data) => json.encode(data.toJson());


class FetchAlbumModel {
  String? statusCode;
  String? status;
  String? message;
  List<Data>? data;

  FetchAlbumModel({this.statusCode, this.status, this.message, this.data});

  FetchAlbumModel.fromJson(Map<String, dynamic> json) {
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
  int? albumId;
  String? userId;
  String? albumName;
  String? addDate;

  Data({this.albumId, this.userId, this.albumName, this.addDate});

  Data.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    userId = json['userId'];
    albumName = json['albumName'];
    addDate = json['addDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumId'] = this.albumId;
    data['userId'] = this.userId;
    data['albumName'] = this.albumName;
    data['addDate'] = this.addDate;
    return data;
  }
}