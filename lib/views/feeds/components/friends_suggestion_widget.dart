import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/feeds/feeds_cubit.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:happiverse/utils/utils.dart';
import 'package:happiverse/views/profile/other_business_profile.dart';
import 'package:sizer/sizer.dart';

import '../../../logic/profile/profile_cubit.dart';
import '../../../utils/constants.dart';
import '../other_profile/other_profile_page.dart';

class FriendSuggestionWidget extends StatelessWidget {
  final int index;

  const FriendSuggestionWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FeedsCubit>();
    final profileBloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    return BlocBuilder<FeedsCubit, FeedsState>(
      builder: (context, state) {
        return SizedBox(
          height: 330,
          width: getWidth(context) / 1.5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    print("HelloMyAccountType====>   "+authBloc.isBusinessShared.toString());
                    if(authBloc.isBusinessShared!){
                      profileBloc.fetchOtherBusinessProfile(state.sugeestedFriends![index].userId, authBloc.accesToken!, authBloc.userID!);
                      profileBloc.fetchOtherAllPost(state.sugeestedFriends![index].userId, authBloc.accesToken!, authBloc.userID!);
                      profileBloc.getOtherFriends(authBloc.userID!, authBloc.accesToken!, state.sugeestedFriends![index].userId);
                      // profileBloc.fetchBusinessRating(state.sugeestedFriends![index].userId, authBloc.accesToken!, authBloc.userID!);
                      nextScreen(context, OtherBusinessProfile(businessId: state.sugeestedFriends![index].userId));
                    }else{
                      profileBloc.fetchOtherProfile(state.sugeestedFriends![index].userId, authBloc.accesToken!, authBloc.userID!);
                      profileBloc.fetchOtherAllPost(state.sugeestedFriends![index].userId, authBloc.accesToken!, authBloc.userID!);
                      profileBloc.getOtherFriends(authBloc.userID!, authBloc.accesToken!, state.sugeestedFriends![index].userId);
                      nextScreen(context, OtherProfilePage(userId: state.sugeestedFriends![index].userId));
                    }
                  },
                  child: Container(
                    height: 200,
                    width: getWidth(context) / 1.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                              state.sugeestedFriends![index].profileImageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/user.jpg',
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  state.sugeestedFriends![index].userName,
                  style:  TextStyle(fontSize: 10.sp),
                ),
                const SizedBox(
                  height: 10,
                ),
                state.sugeestedFriends![index].isFollowed
                    ? Container(
                        width: double.infinity,
                        height: 40,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(border: Border.all(color: kSecendoryColor), borderRadius: BorderRadius.circular(10)),
                        child: MaterialButton(
                          onPressed: () {
                            if(authBloc.isBusinessShared!){
                              profileBloc.fetchOtherBusinessProfile(state.sugeestedFriends![index].userId, authBloc.accesToken!, authBloc.userID!);
                              profileBloc.fetchOtherAllPost(state.sugeestedFriends![index].userId, authBloc.accesToken!, authBloc.userID!);
                              profileBloc.getOtherFriends(authBloc.userID!, authBloc.accesToken!, state.sugeestedFriends![index].userId);
                              // profileBloc.fetchBusinessRating(state.sugeestedFriends![index].userId, authBloc.accesToken!, authBloc.userID!);
                              nextScreen(context, OtherBusinessProfile(businessId: state.sugeestedFriends![index].userId));
                            }else{
                              profileBloc.fetchOtherProfile(state.sugeestedFriends![index].userId, authBloc.accesToken!, authBloc.userID!);
                              profileBloc.fetchOtherAllPost(state.sugeestedFriends![index].userId, authBloc.accesToken!, authBloc.userID!);
                              profileBloc.getOtherFriends(authBloc.userID!, authBloc.accesToken!, state.sugeestedFriends![index].userId);
                              nextScreen(context, OtherProfilePage(userId: state.sugeestedFriends![index].userId));
                            }
                          },
                          child:  Text(
                            "See Profile",
                            style: TextStyle(color: kSecendoryColor,fontSize: 10.sp),overflow: TextOverflow.ellipsis,maxLines: 1,
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: MaterialButton(
                              height: 30,
                              color: kSecendoryColor,
                              shape: const StadiumBorder(),
                              onPressed: () {
                                profileBloc.addFollow(authBloc.userID!,state.sugeestedFriends![index].userId, authBloc.accesToken!, context, authBloc.isBusinessShared! ? true : false);
                                //Commented by rahul because id pass here is wrong
                                // profileBloc.addFollow(state.sugeestedFriends![index].userId, authBloc.userID!, authBloc.accesToken!, context, authBloc.isBusinessShared! ? true : false);
                                bloc.followUnfollowFriendSuggestion(index);
                              },
                              child: Text(
                                "Follow",
                                style: TextStyle(color: Colors.white,fontSize: 10.sp),overflow: TextOverflow.ellipsis,maxLines: 1
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(border: Border.all(color: kSecendoryColor), borderRadius: BorderRadius.circular(10)),
                              child: MaterialButton(
                                onPressed: () {
                                  bloc.removeFriendSuggestion(index);
                                },
                                child:  Text(
                                  "Remove",
                                  style: TextStyle(color: kSecendoryColor,fontSize: 10.sp),overflow: TextOverflow.ellipsis,maxLines: 1
                                ),
                              ),
                            ),
                          )
                        ],
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}
