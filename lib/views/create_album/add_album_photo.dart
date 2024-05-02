import 'dart:io';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../logic/post_cubit/post_cubit.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../routes/routes_names.dart';
import 'package:flick_video_player/flick_video_player.dart';
import '../../../utils/config/assets_config.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../views/authentication/scale_navigation.dart';
import '../../../views/feeds/post/record_video.dart';
import 'package:line_icons/line_icons.dart';

import '../feeds/post/add_places.dart';

class AddAlbumPhoto extends StatefulWidget {
  final bool isFromGroup;
  final String? groupId;
  final bool isBusiness;
  final String? albumId;

  const AddAlbumPhoto({Key? key, required this.isFromGroup, this.groupId, required this.isBusiness, required this.albumId}) : super(key: key);

  @override
  _AddAlbumPhotoState createState() => _AddAlbumPhotoState();
}

class _AddAlbumPhotoState extends State<AddAlbumPhoto> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final bloc = context.read<PostCubit>();
    bloc.resetPost();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PostCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<PostCubit,PostState>(
        builder: (context,state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white70,
              leading: const BackButton(color: Colors.black,),
              title: Text(getTranslated(context, 'CREATE_POST')!,style: TextStyle(color: Colors.black),),
              actions: [
                TextButton(
                  onPressed: (){
                    print("Geeks on click ");
                    print(widget.isFromGroup);
                    if(widget.isFromGroup == false){
                      print("Geeks widget.isFromGroup ");
                      bloc.addAlbumPost(authB.userId,authB.accesToken!,widget.isBusiness,context,widget.albumId.toString());
                      Navigator.pop(context);
                      // Navigator.pop(context);
                    }else if(widget.isFromGroup == true){
                      print("Geeks widget.isFromGroup false ");
                      bloc.createGroupPost(authB.userId,authB.accesToken!,widget.groupId!,widget.isBusiness,context);
                      Navigator.pop(context);
                      // Navigator.pop(context);
                      print("yeah else");
                    }

                  },
                  child: Text(getTranslated(context, 'SHARE')!),
                ),
              ],
            ),
            body: Stack(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BlocBuilder<ProfileCubit,ProfileState>(
                                  builder: (context,stateP) {
                                    return Expanded(
                                      child: Row(
                                        children: [
                                          Column(
                                            children:  [
                                              CircleAvatar(
                                                radius: 25,
                                                backgroundImage: NetworkImage(widget.isBusiness ? "${Utils.baseImageUrl}${stateP.businessProfile?.logoImageUrl}":"${stateP.profileImage}"),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 10,),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children:  [
                                                Row(
                                                  children: [
                                                    Expanded(child: Text("${widget.isBusiness ? stateP.businessProfile!.businessName:stateP.profileName} ${state.currentPlace != null ? " - ${state.currentPlace}":""}",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),)),
                                                  ],
                                                ),
                                                const SizedBox(height: 5,),
                                                Container(
                                                  height: 25,
                                                  padding: const EdgeInsets.only(left: 5,right: 5),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8),
                                                      border: Border.all(width: 0.3)
                                                  ),
                                                  child: DropdownButtonHideUnderline(
                                                    child: DropdownButton<String>(
                                                      items: state.dropList.map((String value) {
                                                        return DropdownMenuItem<String>(
                                                          value: value,
                                                          child: Text(value,style: const TextStyle(fontSize: 9),),
                                                        );
                                                      }).toList(),
                                                      value: state.dropVal,
                                                      onChanged: (val)=>bloc.changeDropVal(val!),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                              ),
                              InkWell(
                                onTap: (){
                                  bloc.pickImages(0);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 100,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Colors.grey, // Border color
                                        width: 1.0, // Border thickness
                                      ),
                                    ),
                                    child: Text("Add Photo"),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10,),
                          if(state.images!.isEmpty && state.videoController == null)...[
                            Column(
                              children: [
                                state.postBGImage == null ? AutoSizeTextField(
                                  maxLines: null,
                                  controller: state.postController,
                                  // textAlign: TextAlign.center,
                                  onTap: ()=> bloc.changeBottomSheetSize(),
                                  decoration: InputDecoration(
                                    hintText: getTranslated(context, 'WRITE_SOMETHING')!,
                                    border: InputBorder.none,
                                  ),
                                ): Container(
                                  height: getHeight(context) / 4,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit:BoxFit.fill,
                                          image: AssetImage(
                                              state.postBGImage!
                                          )
                                      )
                                  ),
                                  child: Center(
                                    child: AutoSizeTextField(
                                      maxLines: null,
                                      style: state.captionTextStyle,
                                      controller: state.postController,
                                      textAlign: TextAlign.center,
                                      onTap: ()=> bloc.changeBottomSheetSize(),
                                      decoration: InputDecoration(
                                          hintText: getTranslated(context, 'WRITE_SOMETHING')!,
                                          border: InputBorder.none,
                                          hintStyle: state.captionTextStyle
                                      ),
                                      onChanged: (val){
                                        bloc.ontextControllerChange(val);
                                      },
                                    ),
                                  ),
                                ),
                                // SingleChildScrollView(
                                //   scrollDirection: Axis.horizontal,
                                //   child: Row(
                                //     children: List.generate(8, (index) => Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: InkWell(
                                //         onTap: ()=>bloc.changeBGImage(index),
                                //         child: Container(
                                //           height: 50,
                                //           width: 50,
                                //           decoration: BoxDecoration(
                                //               image: DecorationImage(
                                //                   fit: BoxFit.cover,
                                //                   image: AssetImage("${AssetConfig.postBgBase}bg$index.png")
                                //               ),
                                //               borderRadius: BorderRadius.circular(5)
                                //           ),
                                //         ),
                                //       ),
                                //     )),
                                //   ),
                                // ),
                              ],
                            )
                          ]else if(state.showVideo ?? false)...[
                            Column(
                              children: [
                                AutoSizeTextField(
                                  maxLines: null,
                                  controller: state.postController,
                                  // maxLines: null,
                                  decoration:  InputDecoration(
                                      border: InputBorder.none,
                                      hintText: getTranslated(context, 'WRITE_SOMETHING')!
                                  ),
                                  onChanged: (val){
                                    bloc.ontextControllerChange(val);
                                  },
                                ),
                                Container(
                                  // height: getHeight(context) / 3,
                                    width: double.infinity,
                                    // height: getHeight(context)/4,
                                    child: FlickVideoPlayer(flickManager: state.videoController!,)
                                )
                              ],
                            )
                          ]else ...[
                            Column(
                              children: [
                                AutoSizeTextField(
                                  maxLines: null,
                                  controller: state.postController,
                                  // maxLines: null,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: getTranslated(context, 'WRITE_SOMETHING')!
                                  ),
                                  onChanged: (val){
                                    bloc.ontextControllerChange(val);
                                  },
                                ),
                                StaggeredGrid.count(
                                    crossAxisCount: state.images!.length == 1 ? 1 : 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 12,
                                    children: List.generate(state.images!.length, (index){
                                      return Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                        ),
                                        child: ClipRRect(
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(15)),
                                            child: Stack(
                                              children: [
                                                Image.file(File(state.images![index]),fit: BoxFit.fill,),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: IconButton(
                                                    onPressed: (){
                                                      print("image length ${state.images!.length}");
                                                      if(state.images != null && state.images!.length == 1){
                                                        bloc.clearAllPostImage();
                                                      }else{
                                                        bloc.clearImage(index);
                                                      }
                                                    },
                                                    icon: const Icon(Icons.clear,color: Colors.white,),
                                                  ),
                                                )
                                              ],
                                            )
                                        ),
                                      );
                                    })
                                ),
                              ],
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                ),

                

              ],
            ),
          );
        }
    );
  }
}
