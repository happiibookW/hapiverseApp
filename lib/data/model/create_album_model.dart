class CreateAlbumModel {
  String? statusCode;
  String? status;
  String? message;

  CreateAlbumModel({this.statusCode, this.status, this.message});

  CreateAlbumModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}