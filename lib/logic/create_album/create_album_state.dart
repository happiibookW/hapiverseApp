part of 'create_album_cubit.dart';

class CreateAlbumState {
  bool loadingState;
  String? albumName;
  CreateAlbumModel? createAlbumModel;
  FetchAlbumModel? fetchAlbumModel;
  FetchAlbumPhoto? fetchAlbumPhoto;
  String? errorMessage;

  CreateAlbumState({
    this.albumName,
    this.createAlbumModel,
    this.fetchAlbumModel,
    this.fetchAlbumPhoto,
    required this.loadingState,
    this.errorMessage
  });

  CreateAlbumState copyWith({
    bool? loadingSt,
    String? albumNamee,
    CreateAlbumModel? createAlbumModell,
    FetchAlbumModel? fetchAlbumModell,
    FetchAlbumPhoto? fetchAlbumPhotoo,
    String? erro
  }) {
    return CreateAlbumState(
        loadingState : loadingSt ?? loadingState,
        albumName: albumNamee ?? albumName,
        createAlbumModel : createAlbumModell ?? createAlbumModel,
        fetchAlbumModel: fetchAlbumModell ?? fetchAlbumModel,
        fetchAlbumPhoto: fetchAlbumPhotoo ?? fetchAlbumPhoto,
        errorMessage: erro ?? errorMessage
    );
  }
}
