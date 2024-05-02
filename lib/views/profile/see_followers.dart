import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:happiverse/utils/utils.dart';
import 'package:happiverse/views/feeds/other_profile/other_profile_page.dart';

import '../../utils/constants.dart';

class SeeFollowers extends StatefulWidget {
  final int index;
  final bool isMyProfile;
  final String userName;
  final String userId;
  const SeeFollowers({Key? key,required this.index,required this.isMyProfile,required this.userName,required this.userId}) : super(key: key);

  @override
  State<SeeFollowers> createState() => _SeeFollowersState();
}

class _SeeFollowersState extends State<SeeFollowers> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    bloc.fetchFollowerFollowingList(widget.isMyProfile ? authBloc.userID! : widget.userId, authBloc.accesToken!, '1',widget.isMyProfile);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    var d;
    if(state.otherProfileInfoResponse != null){
      var json = jsonDecode(state.otherProfileInfoResponse!.body);
      d = json['data'];
    }
    return DefaultTabController(
      initialIndex: widget.index,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.userName),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Followers (${widget.isMyProfile ? state.followers : d['follower']})",
              ),
              Tab(
                text: "Following (${widget.isMyProfile ? state.following : d['following']})",
              ),
              Tab(
                text: "Friends (${widget.isMyProfile ? state.myFriendList == null ? "0" :state.myFriendList!.length.toString() : state.otherFriendList == null ? "0":state.otherFriendList!.length})",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              child: widget.isMyProfile ? state.myFollowList == null ? Center(child: CupertinoActivityIndicator(),) : state.myFollowList!.isEmpty ? Center(child: Text("No Followers"),):
              ListView.builder(
                itemCount: state.myFollowList!.length,
                itemBuilder: (c,i){
                  var d = state.myFollowList![i];
                  return ListTile(
                    onTap: (){
                      bloc.fetchOtherProfile(d.userId, authBloc.accesToken!,authBloc.userID!);
                      bloc.fetchOtherAllPost(d.userId, authBloc.accesToken!,authBloc.userID!);
                      bloc.getOtherFriends(authBloc.userID!, authBloc.accesToken!,d.userId);
                      nextScreen(context, OtherProfilePage(userId: d.userId));
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("${Utils.baseImageUrl}${d.profileImageUrl}"),
                    ),
                    title: Text(d.userName),
                    trailing: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[400]
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text("Follower"),
                    ),
                  );
                },
              ):state.otherFollowList == null ? Center(child: CupertinoActivityIndicator(),) : state.otherFollowList!.isEmpty ? Center(child: Text("No Followers"),):
              ListView.builder(
                itemCount: state.otherFollowList!.length,
                itemBuilder: (c,i){
                  var d = state.otherFollowList![i];
                  return ListTile(
                    onTap: (){
                      bloc.fetchOtherProfile(widget.userId, authBloc.accesToken!,authBloc.userID!);
                      bloc.fetchOtherAllPost(widget.userId, authBloc.accesToken!,authBloc.userID!);
                      bloc.getOtherFriends(authBloc.userID!, authBloc.accesToken!,widget.userId);
                      nextScreen(context, OtherProfilePage(userId: widget.userId));
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("${Utils.baseImageUrl}${d.profileImageUrl}"),
                    ),
                    title: Text(d.userName),
                  );
                },
              ),
            ),
            Container(
              child: widget.isMyProfile ? state.myFollowingList == null ? Center(child: CupertinoActivityIndicator(),) : state.myFollowingList!.isEmpty ? Center(child: Text("No Followers"),):
              ListView.builder(
                itemCount: state.myFollowingList!.length,
                itemBuilder: (c,i){
                  var d = state.myFollowingList![i];
                  return ListTile(
                    onTap: (){
                      bloc.fetchOtherProfile(d.userId, authBloc.accesToken!,authBloc.userID!);
                      bloc.fetchOtherAllPost(d.userId, authBloc.accesToken!,authBloc.userID!);
                      bloc.getOtherFriends(authBloc.userID!, authBloc.accesToken!,d.userId);
                      nextScreen(context, OtherProfilePage(userId: d.userId));
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("${Utils.baseImageUrl}${d.profileImageUrl}"),
                    ),
                    title: Text(d.userName),
                    trailing: InkWell(
                      onTap: (){
                        bloc.addFollow(authBloc.userID!, d.userId, authBloc.accesToken!, context, authBloc.isBusinessShared!);
                        bloc.fetchFollowerFollowingList(widget.isMyProfile ? authBloc.userID! : widget.userId, authBloc.accesToken!, '1',widget.isMyProfile);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[400]
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text("Unfollow"),
                      ),
                    ),
                  );
                },
              ):state.otherFollowingList == null ? Center(child: CupertinoActivityIndicator(),) : state.otherFollowingList!.isEmpty ? Center(child: Text("No Followers"),):
              ListView.builder(
                itemCount: state.otherFollowingList!.length,
                itemBuilder: (c,i){
                  var d = state.otherFollowingList![i];
                  return ListTile(
                    onTap: (){
                      bloc.fetchOtherProfile(widget.userId, authBloc.accesToken!,authBloc.userID!);
                      bloc.fetchOtherAllPost(widget.userId, authBloc.accesToken!,authBloc.userID!);
                      bloc.getOtherFriends(authBloc.userID!, authBloc.accesToken!,widget.userId);
                      nextScreen(context, OtherProfilePage(userId: widget.userId));
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("${Utils.baseImageUrl}${d.profileImageUrl}"),
                    ),
                    title: Text(d.userName),
                  );
                },
              ),
            ),
            Container(
              child: widget.isMyProfile ? state.myFriendList == null ? Center(child: CupertinoActivityIndicator(),) : state.myFriendList!.isEmpty ? Center(child: Text("No Following"),):
              ListView.builder(
                itemCount: state.myFriendList!.length,
                itemBuilder: (c,i){
                  var d = state.myFriendList![i];
                  return ListTile(
                    onTap: (){
                      bloc.fetchOtherProfile(widget.userId, authBloc.accesToken!,authBloc.userID!);
                      bloc.fetchOtherAllPost(widget.userId, authBloc.accesToken!,authBloc.userID!);
                      bloc.getOtherFriends(authBloc.userID!, authBloc.accesToken!,widget.userId);
                      nextScreen(context, OtherProfilePage(userId: widget.userId));
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("${Utils.baseImageUrl}${d.profileImageUrl}"),
                    ),
                    title: Text(d.userName),
                    trailing: InkWell(
                      onTap: (){
                        bloc.addFollow(authBloc.userID!, d.userId, authBloc.accesToken!, context, authBloc.isBusinessShared!);
                        bloc.fetchFollowerFollowingList(widget.isMyProfile ? authBloc.userID! : widget.userId, authBloc.accesToken!, '1',widget.isMyProfile);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300]
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text("Unfriend"),
                      ),
                    ),
                  );
                },
              ):state.otherFriendList == null ? Center(child: CupertinoActivityIndicator(),) : state.otherFriendList!.isEmpty ? Center(child: Text("No Friends"),):
              ListView.builder(
                itemCount: state.otherFriendList!.length,
                itemBuilder: (c,i){
                  var d = state.otherFriendList![i];
                  return ListTile(
                    onTap: (){
                      bloc.fetchOtherProfile(widget.userId, authBloc.accesToken!,authBloc.userID!);
                      bloc.fetchOtherAllPost(widget.userId, authBloc.accesToken!,authBloc.userID!);
                      bloc.getOtherFriends(authBloc.userID!, authBloc.accesToken!,widget.userId);
                      nextScreen(context, OtherProfilePage(userId: widget.userId));
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("${Utils.baseImageUrl}${d.profileImageUrl}"),
                    ),
                    title: Text(d.userName),
                  );
                },
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
