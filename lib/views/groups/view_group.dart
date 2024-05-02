import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/video_audio_call/agora_video_call_cubit.dart';
import 'package:happiverse/views/chat/call_page.dart';
import 'package:happiverse/views/chat/conservation.dart';
import '../../logic/groups/groups_cubit.dart';
import '../../logic/post_cubit/post_cubit.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/utils.dart';
import '../../views/components/secondry_button.dart';
import '../../views/feeds/comments_page.dart';
import '../../views/feeds/components/loading_post_widget.dart';
import '../../views/groups/post/create_post.dart';
import '../../views/groups/settings.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import '../../utils/constants.dart';
import '../feeds/components/friends_suggestion_widget.dart';
import '../feeds/components/post_widget.dart';
import '../feeds/components/text_feed_widget.dart';
import '../feeds/components/video_post_card.dart';
import '../feeds/post/add_post.dart';

class ViewGroups extends StatefulWidget {
  final int index;

  const ViewGroups({Key? key, required this.index}) : super(key: key);

  @override
  _ViewGroupsState createState() => _ViewGroupsState();
}

class _ViewGroupsState extends State<ViewGroups> {

  @override
  void initState() {
    super.initState();
    var b = context.read<RegisterCubit>();
    var gb = context.read<GroupsCubit>();

    context.read<GroupsCubit>().fetchFeedsPosts(b.userID!, b.accesToken!,gb.groups[widget.index].groupId);
  }

  makeCall(bool audio,String groupIdf){
    FirebaseFirestore.instance.collection('groupcall').doc(groupIdf).get().then((value){
      if(value.exists){
        showCupertinoDialog(context: context, builder: (context){
          return CupertinoAlertDialog(
            title: Text("You can't make call you already in call"),
            actions: [
              CupertinoDialogAction(child: Text("Ok"),onPressed: ()=> Navigator.pop(context),)
            ],
          );
        });
      }else{
        FirebaseFirestore.instance.collection('groupcall').doc(groupIdf).set({
          'groupId':groupIdf,
          'channelId':groupIdf,
          'callType':audio ? 'Audio':'Video',
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dF = DateFormat('dd MMM yyyy');
    final tF = DateFormat('hh:mm a');
    final bloc = context.read<GroupsCubit>();
    final callBloc = context.read<AgoraVideoCallCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<GroupsCubit,GroupsState>(
      builder: (context,state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              //2
              SliverAppBar(
                actions: [
                  CircleAvatar(
                    child: IconButton(onPressed: (){
                      showModalBottomSheet(context: context, builder: (c){
                        return Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              )),
                          child: Material(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  )),
                              elevation: 3,
                              child: Column(
                                children: [
                                  SizedBox(height: 10,),
                                  Container(
                                    height: 6,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[300]
                                    ),
                                  ),
                                  ListTile(
                                    onTap: (){
                                      FirebaseFirestore.instance.collection('groupcall').doc(state.groups![widget.index].groupId).get().then((value){
                                        if(value.exists){
                                          showCupertinoDialog(context: context, builder: (context){
                                            return CupertinoAlertDialog(
                                              title: Text("You can't make call you already in call"),
                                              actions: [
                                                CupertinoDialogAction(child: Text("Ok"),onPressed: ()=> Navigator.pop(context),)
                                              ],
                                            );
                                          });
                                        }else{
                                          FirebaseFirestore.instance.collection('groupcall').doc(state.groups![widget.index].groupId).set({
                                            'groupId':state.groups![widget.index].groupId,
                                            'channelId':state.groups![widget.index].groupId,
                                            'callType':'Audio',
                                          });
                                          callBloc.setCallValue({
                                            'userName':state.groups![widget.index].groupName,
                                            'avatar':"${Utils.baseImageUrl}${state.groups![widget.index].groupImageUrl}",
                                            'seconds': 0,
                                            'callType':'Audio',
                                            'channelId': state.groups![widget.index].groupId,
                                            'time':''
                                          });
                                          nextScreen(context, CallPage(userName: state.groups![widget.index].groupName, avatar: "${Utils.baseImageUrl}${state.groups![widget.index].groupImageUrl}", isAudio: true, channelId: state.groups![widget.index].groupId, seconds: 0));
                                        }
                                      });
                                    },
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(LineIcons.phone),
                                    ),
                                    title: Text("Group Audio Call",style: TextStyle(color: Colors.blue),),
                                  ),
                                  Divider(
                                    height: 10,
                                  ),
                                  ListTile(
                                    onTap: (){
                                      FirebaseFirestore.instance.collection('groupcall').doc(state.groups![widget.index].groupId).get().then((value){
                                        if(value.exists){
                                          showCupertinoDialog(context: context, builder: (context){
                                            return CupertinoAlertDialog(
                                              title: Text("You can't make call you already in call"),
                                              actions: [
                                                CupertinoDialogAction(child: Text("Ok"),onPressed: ()=> Navigator.pop(context),)
                                              ],
                                            );
                                          });
                                        }else{
                                          FirebaseFirestore.instance.collection('groupcall').doc(state.groups![widget.index].groupId).set({
                                            'groupId':state.groups![widget.index].groupId,
                                            'channelId':state.groups![widget.index].groupId,
                                            'callType':'Video',
                                          });
                                          callBloc.setCallValue({
                                            'userName':state.groups![widget.index].groupName,
                                            'avatar':"${Utils.baseImageUrl}${state.groups![widget.index].groupImageUrl}",
                                            'seconds': 0,
                                            'callType':'Video',
                                            'channelId': state.groups![widget.index].groupId,
                                            'time':''
                                          });
                                          nextScreen(context, CallPage(userName: state.groups![widget.index].groupName, avatar: "${Utils.baseImageUrl}${state.groups![widget.index].groupImageUrl}", isAudio: false, channelId: state.groups![widget.index].groupId, seconds: 0));
                                        }
                                      });
                                    },
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(LineIcons.video),
                                    ),
                                    title: Text("Group Video Call",style: TextStyle(color: Colors.blue),),
                                  ),
                                  Divider(
                                    height: 10,
                                  ),
                                  ListTile(
                                    onTap: (){
                                      nextScreen(context, ConservationPage(profileImage: "${Utils.baseImageUrl}${state.groups![widget.index].groupImageUrl}", recieverPhone: state.groups![widget.index].groupId, recieverName: state.groups![widget.index].groupName));
                                    },
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(LineIcons.facebookMessenger),
                                    ),
                                    title: Text("Group Chat",style: TextStyle(color: Colors.blue),),
                                  ),
                                ],
                              )
                          ),
                        );
                      });
                    },icon: Icon(Icons.more_vert),),
                  ),
                  SizedBox(width: 10,),
                  CircleAvatar(
                    child: IconButton(onPressed: () {
                      nextScreen(context, GroupSettings(id:state.groups![widget.index].groupId,groupName: state.groups![widget.index].groupName,index: widget.index,));
                    }, icon: Icon(LineIcons.cog)),
                  ),
                ],
                pinned: true,
                snap: false,
                floating: false,
                expandedHeight: 250.0,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  title: Text(state.groups![widget.index].groupName),
                  background: Image.network(
                    "${Utils.baseImageUrl2}${state.groups![widget.index].groupImageUrl}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Privacy Type : ${state.groups![widget.index].groupPrivacy}"),
                ),
              ),
              SliverToBoxAdapter(
                child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance.collection('groupcall').doc(state.groups![widget.index].groupId).snapshots(),
                  builder: (context,AsyncSnapshot<DocumentSnapshot> snapshots){
                    // print("DAta ${snapshots.data!.data()!['callType']}");
                    if(snapshots.hasData && snapshots.data!.data() != null){
                      Map<String, dynamic> data = snapshots.data!.data()! as Map<String, dynamic>;
                      return ListTile(
                        onTap: (){
                          callBloc.setCallValue({
                            'userName':state.groups![widget.index].groupName,
                            'avatar':"${Utils.baseImageUrl}${state.groups![widget.index].groupImageUrl}",
                            'seconds': 0,
                            'callType': data['callType'],
                            'channelId': state.groups![widget.index].groupId,
                            'time':''
                          });
                          nextScreen(context, CallPage(userName: state.groups![widget.index].groupName, avatar: "${Utils.baseImageUrl}${state.groups![widget.index].groupImageUrl}", isAudio: data['callType'] == "Audio" ? true:false, channelId: state.groups![widget.index].groupId, seconds: 0));
                        },
                        tileColor: Colors.green.withOpacity(0.2),
                        // contentPadding: EdgeInsets.zero,
                        title: Text("Group ${data['callType'] == 'Audio' ? 'Audio':'Video'} Call",style: TextStyle(color: Colors.green),),
                        subtitle: Text("Tap to join/return",style: TextStyle(color: Colors.green),),
                        trailing: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text("Join Call",style: TextStyle(color: Colors.white),),
                        ),
                      );
                    }else{
                      return Container();
                    }
                  },
                ),
              ),
              state.groupPosts == null ? SliverToBoxAdapter(child: LoadingPostWidget()):
              state.groupPosts!.isEmpty ? SliverToBoxAdapter(child: Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50,),
                  const Text("No Group Post"),
                  SizedBox(
                    width: getWidth(context) / 2,
                      child: SecendoryButton(text: "Create First Post", onPressed: (){
                        print("Hello I am pressed");
                        nextScreen(context, AddPostPage(isFromGroup: true,groupId: state.groups![widget.index].groupId,isBusiness: authB.isBusinessShared! ? true:false,));}))
                ],
              ),)): SliverAnimatedList(
                itemBuilder: (ctx,i,animation){
                  var d = state.groupPosts![i];
                  // if(i == 1){
                  //   return Card(
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
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
                  if(state.groupPosts![i].postType == 'image'){
                    return SizeTransition(
                      sizeFactor: animation,
                      child: PostWidget(
                        typeId: d.userTypeId,
                        privacy: d.privacy,
                        isFriend: 'default',
                        postId: d.postId,
                        name: d.caption,
                        iamge: d.postFiles!,
                        date: d.postedDate!,
                        commentCount: d.totalComment.toString(),
                        likeCount: d.totalLike.toString(),
                        profileName: d.userName,
                        profilePic: "${Utils.baseImageUrl2}${d.profileImageUrl}",
                        isLiked: d.isLiked!,
                        index: i,
                        userId: d.userId,
                        onLikeTap: (){

                          bloc.addLikeDislike(authB.userID!, authB.accesToken!, d.postId, i);
                        },
                        hasVerified: d.hasVerified,
                      ),
                    );
                  }else if(state.groupPosts![i].postType == 'text'){
                    return SizeTransition(
                        sizeFactor: animation,
                        child: TextFeedsWidget(
                          index: i,
                          userTypeId: d.userTypeId,
                          fontColor: d.fontColor!,
                          userId: d.userId,
                          commentOntap: (){},
                          postId: d.postId,
                          onTap: (){},
                          name: d.postContentText!,
                          bgImage: d.textBackGround!,
                          commentCount: d.totalComment.toString(),
                          date: d.postedDate!,
                          likeCount: d.totalLike.toString(),
                          profileName: d.userName,
                          profilePic: "${Utils.baseImageUrl2}${d.profileImageUrl}",
                          isFriend: 'default',
                          onLikeTap: (){
                            bloc.addLikeDislike(authB.userID!, authB.accesToken!, d.postId, i);
                          },
                          isLiked: d.isLiked!,
                          hasVerified: d.hasVerified,
                        )
                    );
                  }else if(state.groupPosts![i].postType == 'video'){
                    return SizeTransition(
                      sizeFactor: animation,
                      child: VideoPostCard(
                        userTypeid: d.userTypeId,
                        isLiked: d.isLiked!,
                        postId: d.postId,
                        name: d.caption,
                        iamge: "${Utils.baseImageUrl}${d.postFiles![0].postFileUrl}",
                        date: d.postedDate!,
                        commentCount: d.totalComment.toString(),
                        likeCount: d.totalLike.toString(),
                        profileName:d.userName,
                        profilePic: "${Utils.baseImageUrl2}${d.profileImageUrl}",
                        videothumb: "${Utils.baseImageUrl}26986e6069f11685de65a0cb8580036a.jpg",
                        userId: d.userId,
                        index: i,
                        isFriend: "default",
                        onLikeTap: (){
                          bloc.addLikeDislike(authB.userID!, authB.accesToken!, d.postId, i);
                        },
                        hasVerified: d.hasVerified,
                      ),
                    );
                  }else{
                    return Container();
                  }
                },
                initialItemCount: state.groupPosts!.length,
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              if(authB.isBusinessShared == null || authB.isBusinessShared == false && authB.planID == 1){
                showDialog(context: context, builder: (ctx){
                  return CupertinoAlertDialog(
                    // title: Text("Please Wait"),
                    content: CupertinoActivityIndicator(),
                  );
                });
                Future.delayed(Duration(seconds: 2),(){
                  Navigator.pop(context);
                  showDialog(context: context, builder: (ctx){
                    return CupertinoAlertDialog(
                      title: Text("Access Denied"),
                      content: Text("Please Upgrade your plan for group post"),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: ()=> Navigator.pop(context),
                          child: Text("Cancel",style: TextStyle(color: Colors.red),),
                        ),
                        CupertinoDialogAction(
                          onPressed: (){},
                          child: Text("Upgrade Plan"),
                        ),
                      ],
                    );
                  });
                });
              }else{
                nextScreen(context, AddPostPage(isFromGroup: true,groupId: state.groups![widget.index].groupId,isBusiness: authB.isBusinessShared! ? true:false,));
              }
              print(state.groups![widget.index].groupId,);
              // bloc.assignGroupId(widget.id);

            },
          ),
        );
      }
    );
  }

  // Widget postWidget() {
  //   return ListView.builder(
  //     physics: const NeverScrollableScrollPhysics(),
  //     shrinkWrap: true,
  //     itemCount: 5,
  //     itemBuilder: (ctx, i) {
  //       if (i == 1) {
  //         return Card(
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 const Text("Peoples you may know"),
  //                 SingleChildScrollView(
  //                   scrollDirection: Axis.horizontal,
  //                   child: Row(
  //                     children: List.generate(4, (index) {
  //                       return const FriendSuggestionWidget();
  //                     }),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       } else {
  //         return PostWidget(
  //           privacy: "d.privacy",
  //           isFriend: 'default',
  //           postId: 'd',
  //           userId: "2",
  //           name: "Ameer Hamza",
  //           iamge:[],
  //           date: DateTime.now(),
  //           commentCount: '18',
  //           likeCount: '12k',
  //           profileName: "John Doe",
  //           profilePic:
  //               "https://i.pinimg.com/736x/b8/03/78/b80378993da7282e58b35bdd3adbce89.jpg",
  //           isLiked: false,
  //           index: 0,
  //         );
  //       }
  //     },
  //   );
  // }
}
