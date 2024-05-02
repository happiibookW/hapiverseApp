import 'dart:convert';

OccupationDetailModel occupationDetailModelFromJson(String str) => OccupationDetailModel.fromJson(json.decode(str));

String occupationDetailModelToJson(OccupationDetailModel data) => json.encode(data.toJson());


class OccupationDetailModel {
  String? status;
  String? message;
  List<Data>? data;

  OccupationDetailModel({this.status, this.message, this.data});

  OccupationDetailModel.fromJson(Map<String, dynamic> json) {
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
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? userId;
  String? title;
  String? workSpaceName;
  String? description;
  String? startDate;
  String? endDate;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? currentWorking;
  String? location;
  int? occupationId;

  Data(
      {this.id,
        this.userId,
        this.title,
        this.workSpaceName,
        this.description,
        this.startDate,
        this.endDate,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.currentWorking,
        this.location,
        this.occupationId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    workSpaceName = json['workSpaceName'];
    description = json['description'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    currentWorking = json['current_working'];
    location = json['location'];
    occupationId = json['occupation_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['title'] = this.title;
    data['workSpaceName'] = this.workSpaceName;
    data['description'] = this.description;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['current_working'] = this.currentWorking;
    data['location'] = this.location;
    data['occupation_id'] = this.occupationId;
    return data;
  }
}