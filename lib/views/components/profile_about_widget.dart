import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/profile/profile_cubit.dart';
import '../../views/plans/user_plan.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';

class ProfileAboutInfo extends StatelessWidget {
  bool isMyProfie;
  Map<String, dynamic> data;
  String userId;

  ProfileAboutInfo({Key? key, required this.isMyProfie, required this.userId, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dF = DateFormat('dd MMM yyyy');

    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      return Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    LineIcons.mapMarker,
                    color: kSecendoryColor,
                  ),
                  Text(getTranslated(context, 'LIVE_IN')!)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  data['country'] == null ? "" : data['country'],
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    LineIcons.birthdayCake,
                    color: kSecendoryColor,
                  ),
                  SizedBox(width: 5),
                  Text(getTranslated(context, 'BIRTH_DATE')!)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  data['dobFormat'] ?? "",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    LineIcons.userFriends,
                    color: kSecendoryColor,
                  ),
                  SizedBox(width: 5),
                  Text(getTranslated(context, 'RELATIONSHIP')!)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  data['replationship'] ?? "",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    LineIcons.graduationCap,
                    color: kSecendoryColor,
                  ),
                  SizedBox(width: 5),
                  Text("Education")
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: Icon(LineIcons.graduationCap),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['educationTitle'] ?? "",
                            style: TextStyle(fontSize: 18),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            "Level : ${data['educationLevel']}",
                            style: TextStyle(fontSize: 14, fontFamily: '', color: Colors.grey),
                          ),
                          Text(
                            "${data['educationStartDate'] ?? DateFormat('yyyy-MM-dd').format(DateTime.now())} - ${data['currentlyReading'] == '1' ? "Present" : data['educationEndDate'] ?? DateFormat('yyyy-MM-dd').format(DateTime.now())}",
                            style: const TextStyle(fontSize: 12, fontFamily: ''),
                          ),
                          Text(
                            data['educationLocation'] != null ? "${data['educationLocation']}" : "",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    LineIcons.briefcase,
                    color: kSecendoryColor,
                  ),
                  SizedBox(width: 5),
                  Text("Works At ")
                ],
              ),
              const SizedBox(
                height: 10,
              ),

              SizedBox(
                height: state.occupationDetailModel?.data?.length != null ? state.occupationDetailModel!.data!.length * 70.0 : 0,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.occupationDetailModel?.data?.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(LineIcons.briefcase),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(state.occupationDetailModel?.data?[index].title ?? "",overflow: TextOverflow.ellipsis,maxLines: 1),
                                    Text(state.occupationDetailModel?.data?[index].workSpaceName ?? "",overflow: TextOverflow.ellipsis,maxLines: 1),
                                    Text("${state.occupationDetailModel?.data?[index].startDate} - ${state.occupationDetailModel?.data?[index].currentWorking.toString() == "1" ? "Present" : state.occupationDetailModel?.data?[index].endDate ?? "Present"}",overflow: TextOverflow.ellipsis,maxLines: 1)],
                                ),
                              )
                            ],
                          ),
                          Divider()

                          // Add a Divider below each ListTile
                        ],
                      ),
                    );
                  },
                ),
              ),

              //Old Code Commented
              /*Padding(
                padding: const EdgeInsets.only(left:10.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: Icon(CupertinoIcons.briefcase_fill),
                        )
                      ],
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data['workTitle'] ?? "",style: TextStyle(fontSize: 18),),
                        Row(
                          children: [
                            Text(data['workDescription'].toString().length > 40 ?  "${data['workDescription'].toString().substring(0,40)}..." :data['workDescription'].toString(),style: TextStyle(fontSize: 14,fontFamily: '',color: Colors.grey),),
                          ],
                        ),
                        Text("${data['workStartDate']} - ${data['currentlyWorking'] == '1' ? "Present" : data['workEndDate']}",style: TextStyle(fontSize: 12,fontFamily: '')),
                        Text( data['workLocation'] != null ? "${data['workLocation']}" : "",style: TextStyle(fontSize: 14,),),
                      ],
                    ),
                  ],
                ),
              ),*/
              SizedBox(
                height: 10,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    LineIcons.rulerVertical,
                    color: kSecendoryColor,
                  ),
                  SizedBox(width: 5),
                  Text("Height")
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "${data['height']} ft",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    LineIcons.starAndCrescent,
                    color: kSecendoryColor,
                  ),
                  SizedBox(width: 5),
                  Text("Religion")
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  data['religion'] ?? "",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          isMyProfie
              ? InkWell(
                  onTap: () => nextScreen(context, UserPlans()),
                  child: Row(
                    children: [
                      const Icon(
                        LineIcons.arrowCircleUp,
                        color: kSecendoryColor,
                      ),
                      SizedBox(width: 5),
                      Text(getTranslated(context, 'UPGRAD_MY_PLAN')!)
                    ],
                  ),
                )
              : Container(),
        ],
      );
    });
  }
}
