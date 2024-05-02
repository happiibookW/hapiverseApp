import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:happiverse/logic/create_album/create_album_cubit.dart';
import 'package:happiverse/views/create_album/create_album.dart';
import 'package:happiverse/views/profile/components/view_all_images.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../utils/config/assets_config.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../views/components/universal_card.dart';

import '../../create_album/add_album_photo.dart';
import '../../create_album/display_album_photo.dart';
import '../../feeds/post/add_post.dart';
import '../see_profile_image.dart';

class ViewAllAlbumPage extends StatefulWidget {
  final bool isMYPRofile;

  const ViewAllAlbumPage({Key? key, required this.isMYPRofile}) : super(key: key);

  @override
  _ViewAllAlbumPageState createState() => _ViewAllAlbumPageState();
}

class _ViewAllAlbumPageState extends State<ViewAllAlbumPage> {
  @override
  Widget build(BuildContext context) {
    final authB = context.read<RegisterCubit>();
    final bloc = context.read<ProfileCubit>();
    final album = context.read<CreateAlbumCubit>();
    album.fetchAlbum(authB.userID!, authB.accesToken!);


    return BlocBuilder<CreateAlbumCubit, CreateAlbumState>(
      builder: (context, albumState) {
        return BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
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
                        nextScreen(context, AddPostPage(isFromGroup: false, isBusiness: authB.isBusinessShared! ? true : false,));

                        // nextScreen(context, AddPostPage(isFromGroup: false,isBusiness: true));
                      },
                      child: const Text("Add Photo"))
                ],
              ),
              body: Column(
                children: [
                  Row(
                    children: [
                      // Post Photos
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              nextScreen(context, AddPostPage(isFromGroup: false, isBusiness: authB.isBusinessShared! ? true : false,));
                            },
                            child: Container(
                              height: 100,
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.photo_album),
                                  Text(
                                    getTranslated(context, 'POST_PHOTOS')!,
                                    textScaleFactor: 1,
                                    style: TextStyle(color: Colors.black, fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Create Album


                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              nextScreen(context, const CreateAlbum());
                            },
                            child: Container(
                              height: 100,
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.photo),
                                  Text(
                                    getTranslated(context, 'CREATE_ALBUM')!,
                                    textScaleFactor: 1,
                                    style: const TextStyle(color: Colors.black, fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      tileColor: Colors.white,
                      leading: Image.asset("assets/images/notfound.png"),
                      title: Text(getTranslated(context, 'Uploads')!, style: const TextStyle(color: Colors.black, fontSize: 14),),
                      subtitle: Text('${bloc.allMYphotos.length} Photos'),
                      onTap: () {
                        // Handle tap
                        nextScreen(context, ViewAllImagesPage(isMYPRofile: widget.isMYPRofile));
                      },
                    ),
                  ),

                  albumState.loadingState ? const Center(child: CircularProgressIndicator()) :
                  Expanded(child:  ListView.builder(itemCount: albumState.fetchAlbumModel?.data?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Ink(
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              color: Colors.white,
                              alignment: Alignment.center,
                              height: 80,
                              child: ListTile(
                                tileColor: Colors.white,
                                leading:  const Icon(Icons.photo_library_outlined),
                                title: Text(albumState.fetchAlbumModel != null ?  albumState.fetchAlbumModel!.data![index].albumName.toString() : "", style: const TextStyle(color: Colors.black, fontSize: 14),),
                                onTap: () {
                                  nextScreen(context, DisplayAlbumPhoto(isMYPRofile: widget.isMYPRofile, albumId: albumState.fetchAlbumModel!.data![index].albumId.toString()));
                                  // nextScreen(context, AddAlbumPhoto(isFromGroup: false, isBusiness: authB.isBusinessShared! ? true : false,albumId:  albumState.fetchAlbumModel!.data![index].albumId.toString()));
                                  // print('Item $index tapped');
                                },
                              ),
                            ),
                          ),
                        );
                      }))


                  // Old Commented Code
                  // Container(
                  //   height: 150,
                  //   width: 150,
                  //   child: UniversalCard(
                  //     widget: widget.isMYPRofile
                  //         ? SingleChildScrollView(
                  //             child: StaggeredGrid.count(
                  //               crossAxisCount: 3,
                  //               crossAxisSpacing: 10,
                  //               mainAxisSpacing: 12,
                  //               children: state.allMyPosts!.map((e) {
                  //                 return InkWell(
                  //                   onTap: () {
                  //                     nextScreen(
                  //                         context,
                  //                         SeeProfileImage(
                  //                           imageUrl: "${Utils.baseImageUrl}${e.postFiles![0].postFileUrl}",
                  //                           title: e.profileName!,
                  //                         ));
                  //                   },
                  //                   child: Container(
                  //                     decoration: const BoxDecoration(
                  //                       color: Colors.transparent,
                  //                       // borderRadius: BorderRadius.all(
                  //                       //   Radius.circular(15),
                  //                       // ),
                  //                     ),
                  //                     child: ClipRRect(
                  //                         // borderRadius: const BorderRadius.all(
                  //                         //     Radius.circular(15)),
                  //                         child: e.postType == 'image'
                  //                             ? e.postFiles == null || e.postFiles!.isEmpty
                  //                                 ? Container()
                  //                                 : Image.network("${Utils.baseImageUrl}${e.postFiles![0].postFileUrl}")
                  //                             : Container()),
                  //                   ),
                  //                 );
                  //               }).toList(),
                  //             ),
                  //           )
                  //         : StaggeredGrid.count(
                  //             crossAxisCount: 3,
                  //             crossAxisSpacing: 10,
                  //             mainAxisSpacing: 12,
                  //             children: state.allOtherPhotos!.map((e) {
                  //               return InkWell(
                  //                 onTap: () {
                  //                   nextScreen(
                  //                       context,
                  //                       SeeProfileImage(
                  //                         imageUrl: "${Utils.baseImageUrl}${e.postFiles![0].postFileUrl}",
                  //                         title: e.profileName!,
                  //                       ));
                  //                 },
                  //                 child: Container(
                  //                   decoration: const BoxDecoration(
                  //                     color: Colors.transparent,
                  //                     // borderRadius: BorderRadius.all(
                  //                     //   Radius.circular(15),
                  //                     // ),
                  //                   ),
                  //                   child: ClipRRect(
                  //                       // borderRadius: const BorderRadius.all(
                  //                       //     Radius.circular(15)),
                  //                       child: e.postFiles == null || e.postFiles!.isEmpty ? Container() : Image.network("${Utils.baseImageUrl}${e.postFiles![0].postFileUrl}")),
                  //                 ),
                  //               );
                  //             }).toList(),
                  //           ),
                  //   ),
                  // )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
