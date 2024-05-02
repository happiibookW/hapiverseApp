import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../views/components/universal_card.dart';
import '../../logic/create_album/create_album_cubit.dart';
import '../profile/see_profile_image.dart';
import 'add_album_photo.dart';

class DisplayAlbumPhoto extends StatefulWidget {
  final bool isMYPRofile;
  final String? albumId;



  const DisplayAlbumPhoto({Key? key, required this.isMYPRofile, required this.albumId}) : super(key: key);

  @override
  _DisplayAlbumPhotoState createState() => _DisplayAlbumPhotoState();
}

class _DisplayAlbumPhotoState extends State<DisplayAlbumPhoto> {

  @override
  Widget build(BuildContext context) {
    final authB = context.read<RegisterCubit>();
    final album = context.read<CreateAlbumCubit>();
    album.fetchAlbumPhoto(authB.userID!,widget.albumId.toString(), authB.accesToken!);


    return BlocBuilder<CreateAlbumCubit, CreateAlbumState>(
        builder: (context, albumState) {
              return BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return Scaffold(
                appBar:AppBar(
                  backgroundColor: Colors.white,
                  title: const Text(
                    "Photos",
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: const BackButton(
                    color: Colors.black,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          nextScreen(context, AddAlbumPhoto(isFromGroup: false, isBusiness: authB.isBusinessShared! ? true : false,albumId: widget.albumId.toString()));

                        },
                        child: const Text("Add Photo"))
                  ],
                ),
                body:
                Center(child:  albumState.loadingState ? const Center(child: CircularProgressIndicator()) :
                GridView.builder(
                  itemCount: album.state.fetchAlbumPhoto != null ?  album.state.fetchAlbumPhoto?.data?.length : 0,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Number of columns
                    crossAxisSpacing: 10.0, // Spacing between columns
                    mainAxisSpacing: 10.0, // Spacing between rows
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      child: InkWell(
                        onTap: (){
                          print("HelloMyUrl=====> ${Utils.baseImageUrl}${album.state.fetchAlbumPhoto!.data?[index].imageUrl}");
                        },
                        child: Card(
                          child: Image.network("${Utils.baseImageUrl}${album.state.fetchAlbumPhoto!.data?[index].imageUrl}",  fit: BoxFit.cover, ),
                        ),
                      ),
                    );
                  },
                ),)
              );

            },
          );
    });
  }
}
