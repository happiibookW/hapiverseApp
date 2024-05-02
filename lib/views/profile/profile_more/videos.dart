import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';

import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../feeds/components/loading_post_widget.dart';
import '../../feeds/components/video_post_card.dart';
import '../../feeds/post/add_post.dart';
class VideoPageInfo extends StatefulWidget {
  const VideoPageInfo({Key? key}) : super(key: key);

  @override
  State<VideoPageInfo> createState() => _VideoPageInfoState();
}

class _VideoPageInfoState extends State<VideoPageInfo> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black,),
        backgroundColor: Colors.white,
        title: Text("Videos",style: TextStyle(color: Colors.black),),
        actions: [
          TextButton(onPressed: (){
            nextScreen(context, AddPostPage(isFromGroup: false,isBusiness: false));
          }, child: Text("Add Video"))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            state.allMyPosts == null ? LoadingPostWidget():state.allMyPosts!.isEmpty ? Center(child: Text("No Posts"),):
            Container(
              color: Colors.grey[200],
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (ctx,i){
                  var data = state.allMyPosts![i];
                  // if(i == 1){
                  //   return Card(
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           const SizedBox(height: 10,),
                  //           const Text("Peoples you may know"),
                  //           SingleChildScrollView(
                  //             scrollDirection: Axis.horizontal,
                  //             child: Row(
                  //               children: List.generate(4, (index){
                  //                 return const FriendSuggestionWidget();
                  //               }),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   );
                  // }else{
                  if(state.allMyPosts![i].postType == 'image'){
                    return Container();
                  }else if(state.allMyPosts![i].postType == 'text'){
                    return Container();
                  }else if(state.allMyPosts![i].postType == 'video'){
                    if(data.postFiles!.isNotEmpty){
                      return VideoPostCard(
                        userTypeid: data.userTypeId,
                        isLiked: true,
                        postId: data.postId,
                        name: data.caption,
                        iamge: "${Utils.baseImageUrl}${data.postFiles![0].postFileUrl}",
                        date: data.postedDate,
                        commentCount: data.totalComment.toString(),
                        likeCount: data.totalLike.toString(),
                        profileName:state.profileName!,
                        profilePic: "${Utils.baseImageUrl}${data.profileImageUrl}",
                        videothumb: "${Utils.baseImageUrl}26986e6069f11685de65a0cb8580036a.jpg",
                        userId: data.userId,
                        index: i,
                        isFriend: 'Friend',
                        onLikeTap: (){
                          // bloc.addLikeDislike(authB.userID!, authB.accesToken!, data.postId!, i,data.userId!);
                        },
                        hasVerified: data.hasVerified,
                      );
                    }else{
                      return Container();
                    }

                  }else{
                    return Container();
                  }
                  // }
                },
                itemCount: state.allMyPosts!.length,
              ),
            ),
          ],
        ),
      ),
    );
  },
);
  }
}
