import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/views/profile/edit_profile/select_edit_time.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../utils/constants.dart';
import '../../../views/authentication/components/select_time.dart';

class EditBusinessHours extends StatefulWidget {
  const EditBusinessHours({Key? key}) : super(key: key);

  @override
  _EditBusinessHoursState createState() => _EditBusinessHoursState();
}

class _EditBusinessHoursState extends State<EditBusinessHours> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const BackButton(
                color: Colors.white,
              ),
            ),
            title: const Text("Business Hours", style: TextStyle(color: Colors.white)),
            actions: [
              MaterialButton(
                onPressed: () {
                  // Navigator.pop(context);
                  print("HelloBuisnessId===> "+authBloc.userId);
                  print("day===> ${state.businessProfile!.businessHours![0].hoursId},"
                      "${state.businessProfile!.businessHours![1].hoursId},"
                      "${state.businessProfile!.businessHours![2].hoursId},"
                      "${state.businessProfile!.businessHours![3].hoursId},"
                      "${state.businessProfile!.businessHours![4].hoursId},"
                      "${state.businessProfile!.businessHours![5].hoursId},"
                      "${state.businessProfile!.businessHours![6].hoursId}");
                  print("open time==>  ${state.closedAllDaySaturday ? "Closed":state.saturdayStartTime.format(context)},${state.closedAllDaySunday ? "Closed":state.sundaryStartTime.format(context)},${state.closedAllDayMonday ? "Closed":state.mondayStartTime.format(context)},${state.closedAllDayTuesday ? "Closed":state.tuesdayStartTime.format(context)},${state.closedAllDayWednesDay ? "Closed":state.wednesdayStartTime.format(context)},${state.closedAllDayThursday ? "Closed":state.thursdayStartTime.format(context)},${state.closedAllDayFriday ? "Closed":state.fridayStartTime.format(context)}");
                  print("close time==>  ${state.closedAllDaySaturday ? "Closed":state.saturdayEndTime.format(context)},${state.closedAllDaySunday ? "Closed":state.sundayEndTime.format(context)},${state.closedAllDayMonday ? "Closed":state.mondayEndTime.format(context)},${state.closedAllDayTuesday ? "Closed":state.tuesdayEndTime.format(context)},${state.closedAllDayWednesDay ? "Closed":state.wednesdayEndTime.format(context)},${state.closedAllDayThursday ? "Closed":state.thursdayEndTime.format(context)},${state.closedAllDayFriday ? "Closed":state.firdayEndTime.format(context)}");

                  String openTime = "${state.closedAllDaySaturday ? "Closed":state.saturdayStartTime.format(context)},${state.closedAllDaySunday ? "Closed":state.sundaryStartTime.format(context)},${state.closedAllDayMonday ? "Closed":state.mondayStartTime.format(context)},${state.closedAllDayTuesday ? "Closed":state.tuesdayStartTime.format(context)},${state.closedAllDayWednesDay ? "Closed":state.wednesdayStartTime.format(context)},${state.closedAllDayThursday ? "Closed":state.thursdayStartTime.format(context)},${state.closedAllDayFriday ? "Closed":state.fridayStartTime.format(context)}";
                  String closeTime =  "${state.closedAllDaySaturday ? "Closed":state.saturdayEndTime.format(context)},${state.closedAllDaySunday ? "Closed":state.sundayEndTime.format(context)},${state.closedAllDayMonday ? "Closed":state.mondayEndTime.format(context)},${state.closedAllDayTuesday ? "Closed":state.tuesdayEndTime.format(context)},${state.closedAllDayWednesDay ? "Closed":state.wednesdayEndTime.format(context)},${state.closedAllDayThursday ? "Closed":state.thursdayEndTime.format(context)},${state.closedAllDayFriday ? "Closed":state.firdayEndTime.format(context)}";
                  String hourId = "${state.businessProfile!.businessHours![0].hoursId},${state.businessProfile!.businessHours![1].hoursId},${state.businessProfile!.businessHours![2].hoursId},${state.businessProfile!.businessHours![3].hoursId},${state.businessProfile!.businessHours![4].hoursId},${state.businessProfile!.businessHours![5].hoursId},${state.businessProfile!.businessHours![6].hoursId}";

                  bloc.updateMyBusinessHour(authBloc.userId,openTime,closeTime,hourId,context,authBloc.token);


                  },
                child: const Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "SCHEDULE",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            bloc.selectAlwayBusinessHours(false);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [const Text("Open For Selected hours"), state.alwaysOpen ? Container() : Icon(Icons.check)],
                          ),
                        ),
                        const Divider(),
                        InkWell(
                          onTap: () {
                            bloc.selectAlwayBusinessHours(true);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [const Text("Always Open"), state.alwaysOpen ? const Icon(Icons.check) : Container()],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: state.alwaysOpen
                            ? null
                            : () {
                                nextScreen(context, SelectEditHoursTime(whichDay: 1));
                              },
                        child: ListTile(
                          title: const Text("Saturday"),
                          subtitle: state.alwaysOpen
                              ? Text("Open 24 hours")
                              : state.closedAllDaySaturday
                                  ? const Text("Closed All Day")
                                  : Text("${state.saturdayStartTime.format(context)} to ${state.saturdayEndTime.format(context)}"),
                          trailing: state.alwaysOpen
                              ? Container(
                                  width: 2,
                                )
                              : Icon(Icons.arrow_forward_ios_sharp),
                        ),
                      ),
                      InkWell(
                        onTap: state.alwaysOpen
                            ? null
                            : () {
                                nextScreen(context, SelectEditHoursTime(whichDay: 2));
                              },
                        child: ListTile(
                          title: const Text("Sunday"),
                          subtitle: state.alwaysOpen
                              ? Text("Open 24 hours")
                              : state.closedAllDaySunday
                                  ? const Text("Closed All Day")
                                  : Text("${state.sundaryStartTime.format(context)} to ${state.sundayEndTime.format(context)}"),
                          trailing: state.alwaysOpen
                              ? Container(
                                  width: 2,
                                )
                              : Icon(Icons.arrow_forward_ios_sharp),
                        ),
                      ),
                      InkWell(
                        onTap: state.alwaysOpen
                            ? null
                            : () {
                                nextScreen(context, const SelectEditHoursTime(whichDay: 3));
                              },
                        child: ListTile(
                          title: const Text("Monday"),
                          subtitle: state.alwaysOpen
                              ? const Text("Open 24 hours")
                              : state.closedAllDayMonday
                                  ? const Text("Closed All Day")
                                  : Text("${state.mondayStartTime.format(context)} to ${state.mondayEndTime.format(context)}"),
                          trailing: state.alwaysOpen
                              ? Container(
                                  width: 2,
                                )
                              : Icon(Icons.arrow_forward_ios_sharp),
                        ),
                      ),
                      InkWell(
                        onTap: state.alwaysOpen
                            ? null
                            : () {
                                nextScreen(context, const SelectEditHoursTime(whichDay: 4));
                              },
                        child: ListTile(
                          title: const Text("Tuesday"),
                          subtitle: state.alwaysOpen
                              ? const Text("Open 24 hours")
                              : state.closedAllDayTuesday
                                  ? const Text("Closed All Day")
                                  : Text("${state.tuesdayStartTime.format(context)} to ${state.tuesdayEndTime.format(context)}"),
                          trailing: state.alwaysOpen
                              ? Container(
                                  width: 2,
                                )
                              : const Icon(Icons.arrow_forward_ios_sharp),
                        ),
                      ),
                      InkWell(
                        onTap: state.alwaysOpen
                            ? null
                            : () {
                                nextScreen(context, const SelectEditHoursTime(whichDay: 5));
                              },
                        child: ListTile(
                          title: const Text("Wednesday"),
                          subtitle: state.alwaysOpen
                              ? const Text("Open 24 hours")
                              : state.closedAllDayWednesDay
                                  ? const Text("Closed All Day")
                                  : Text("${state.wednesdayStartTime.format(context)} to ${state.wednesdayEndTime.format(context)}"),
                          trailing: state.alwaysOpen
                              ? Container(
                                  width: 2,
                                )
                              : const Icon(Icons.arrow_forward_ios_sharp),
                        ),
                      ),
                      InkWell(
                        onTap: state.alwaysOpen
                            ? null
                            : () {
                                nextScreen(context, const SelectEditHoursTime(whichDay: 6));
                              },
                        child: ListTile(
                          title: const Text("Thursday"),
                          subtitle: state.alwaysOpen
                              ? const Text("Open 24 hours")
                              : state.closedAllDayThursday
                                  ? const Text("Closed All Day")
                                  : Text("${state.thursdayStartTime.format(context)} to ${state.thursdayEndTime.format(context)}"),
                          trailing: state.alwaysOpen
                              ? Container(
                                  width: 2,
                                )
                              : const Icon(Icons.arrow_forward_ios_sharp),
                        ),
                      ),
                      InkWell(
                        onTap: state.alwaysOpen
                            ? null
                            : () {
                                nextScreen(context, const SelectEditHoursTime(whichDay: 7));
                              },
                        child: ListTile(
                          title: const Text("Friday"),
                          subtitle: state.alwaysOpen
                              ? const Text("Open 24 hours")
                              : state.closedAllDayFriday
                                  ? const Text("Closed All Day")
                                  : Text("${state.fridayStartTime.format(context)} to ${state.firdayEndTime.format(context)}"),
                          trailing: state.alwaysOpen
                              ? Container(
                                  width: 2,
                                )
                              : const Icon(Icons.arrow_forward_ios_sharp),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
