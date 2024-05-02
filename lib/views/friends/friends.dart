import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/feeds/feeds_cubit.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/views/feeds/components/friends_suggestion_widget.dart';

import '../../logic/register/register_cubit.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../feeds/other_profile/other_profile_page.dart';

class Friends extends StatefulWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    // bloc.fetchFollowerFollowingList(authBloc.userID!, authBloc.accesToken!, '3', true);
    bloc.getMyFriendList(authBloc.userID!, authBloc.accesToken!);

  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, pState) {
        return BlocBuilder<FeedsCubit, FeedsState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: Container(),
                title: Text(
                  "Friends",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "People you may know",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      state.sugeestedFriends == null
                          ? const Center(
                              child: CupertinoActivityIndicator(),
                            )
                          : state.sugeestedFriends!.isEmpty
                              ? const Center(
                                  child: Text("No Suggestion Found"),
                                )
                              : Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text("Peoples you may know"),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: List.generate(state.sugeestedFriends!.length, (index) {
                                              return state.sugeestedFriends![index].isDeleted ? Container() : FriendSuggestionWidget(index: index);
                                            }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "All Friend",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      pState.myFriendsList == null
                          ? Center(
                              child: CupertinoActivityIndicator(),
                            )
                          : pState.myFriendsList!.isEmpty
                              ? const Center(
                                  child: Text("No Friends"),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: pState.myFriendsList!.length,
                                  itemBuilder: (c, i) {
                                    var d = pState.myFriendsList![i];
                                    return ListTile(
                                      onTap: () {
                                        bloc.fetchOtherProfile(d.userId, authBloc.accesToken!, authBloc.userID!);
                                        bloc.fetchOtherAllPost(d.userId, authBloc.accesToken!, authBloc.userID!);
                                        bloc.getOtherFriends(authBloc.userID!, authBloc.accesToken!, d.userId);
                                        nextScreen(context, OtherProfilePage(userId: d.userId));
                                      },
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(d.profileImageUrl),
                                      ),
                                      title: Text(d.userName),
                                    );
                                  },
                                ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
