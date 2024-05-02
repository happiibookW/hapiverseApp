import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:happiverse/data/model/fetch_album_photo.dart';
import '../../data/model/create_album_model.dart';
import '../../data/model/fetch_album_model.dart';
import '../../data/repository/profile_repository.dart';

part 'create_album_state.dart';

class CreateAlbumCubit extends Cubit<CreateAlbumState> {
  CreateAlbumCubit() : super(CreateAlbumState(loadingState: false));
  final repository = ProfileRepository();

  assignName(String val) {
    emit(state.copyWith(albumNamee: val));
  }


  createAlbumApi(String userId,String albumName, String token, BuildContext context) {

    repository.createAlbumApi(userId,albumName,token).then((response) {
      var dec = json.decode(response.body);
      if (dec['message'] == "Album created successfully") {
        Fluttertoast.showToast(msg: "Album created successfully");
        fetchAlbum(userId, token);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: "Something Went Wrong Try again!");
      }
    });
  }

  fetchAlbum(String userId,String token) {
    emit(state.copyWith(erro: "",loadingSt: true));
    repository.fetchAlbumApi(userId,token).then((response) {
      var dec = json.decode(response.body);
      if (dec['message'] == "Album fetched successfully") {
        var data = fetchAlbumModelFromJson(response.body);


        emit(state.copyWith(fetchAlbumModell: data));
        emit(state.copyWith(erro: "",loadingSt: false));
        Fluttertoast.showToast(msg: "Album fetched successfully");
      } else {
        emit(state.copyWith(erro: "",loadingSt: false));
        Fluttertoast.showToast(msg: "Something Went Wrong Try again!");
      }
    });
  }

  fetchAlbumPhoto(String userId,String albumId,String token) {
    emit(state.copyWith(erro: "",loadingSt: true));
    repository.fetchAlbumPhotoApi(userId,albumId,token).then((response) {
      var dec = json.decode(response.body);
      if (dec['message'] == "Album Images fetched successfully") {
        var data = fetchAlbumPhotoModelFromJson(response.body);
        emit(state.copyWith(fetchAlbumPhotoo: data));
        emit(state.copyWith(erro: "",loadingSt: false));
        Fluttertoast.showToast(msg: "Album Images fetched successfully");
      } else {
        emit(state.copyWith(erro: "",loadingSt: false));
        Fluttertoast.showToast(msg: "Something Went Wrong Try again!");
      }
    });
  }
}
