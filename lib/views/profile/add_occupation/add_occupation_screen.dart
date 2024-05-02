import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/extension.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:happiverse/utils/toast.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../../../utils/constants.dart';
import '../../components/secondry_button.dart';
import '../select_occupation.dart';

class AddOccupations extends StatefulWidget {
  const AddOccupations({Key? key}) : super(key: key);

  @override
  State<AddOccupations> createState() => _AddOccupationsState();
}

class _AddOccupationsState extends State<AddOccupations> {
  bool currentlyWorkhere = false;
  DateFormat dateFormat = DateFormat('dd / MMM / yyyy');
  GlobalKey<FormState> key = GlobalKey<FormState>();

  String title = '';
  String workspaceName = '';
  String location = '';
  String description = '';
  bool? currentlyWorking;
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<RegisterCubit>();
    final bloc = context.read<ProfileCubit>();

    return BlocBuilder<RegisterCubit, RegisterState>(builder: (context, restate) {
      return BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
              title: const Text("Add Occupation", style: TextStyle(color: Colors.white)),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Form(
                  key: key,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: TextEditingController(text: restate.occupation_type),
                        readOnly: true,
                        onTap: () => nextScreen(context, SelectOccupation()),
                        decoration: const InputDecoration(labelText: "Occupation Type", hintText: "eg: Artist", suffixIcon: Icon(LineIcons.briefcase)),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: Icon(LineIcons.briefcase),
                          ),
                          Expanded(
                              child: TextField(
                            decoration: InputDecoration(hintText: "Workplace Name", border: InputBorder.none),
                            onChanged: (v) {
                              workspaceName = v;
                            },
                          ))
                        ],
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(hintText: "Job Title", border: InputBorder.none),
                        onChanged: (v) {
                          title = v;
                        },
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(hintText: "Location", border: InputBorder.none),
                        onChanged: (v) {
                          location = v;
                        },
                      ),
                      Divider(),
                      TextField(
                        maxLines: 4,
                        decoration: InputDecoration(hintText: "Describe your work", border: InputBorder.none),
                        onChanged: (v) {
                          description = v;
                        },
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Currently work here"),
                          Platform.isIOS
                              ? CupertinoSwitch(
                                  value: currentlyWorkhere,
                                  onChanged: (v) {
                                    setState(() {
                                      currentlyWorkhere = !currentlyWorkhere;
                                    });
                                    // bloc.assignWorkValue(5, v == true ? "1":"0");
                                  })
                              : Switch(
                                  value: currentlyWorkhere,
                                  onChanged: (v) {
                                    setState(() {
                                      currentlyWorkhere = !currentlyWorkhere;
                                    });
                                    // bloc.assignWorkValue(5, v == true ? "1":"0");
                                  },
                                )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(currentlyWorkhere ? "Since" : "Start Date"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime(1940, 3, 5),
                            onChanged: (date) {
                              bloc.workStartDate(date);
                            },
                            onConfirm: (date) {
                              startDate = date;
                            },
                            currentTime: DateTime.now(),
                          );
                        },
                        child: SizedBox(
                          height: 40,
                          child: Center(
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // const Icon(LineIcons.briefcase),
                                Text(dateFormat.format(state.newWorkStartDate ?? DateTime.now()).toString()),
                                Icon(Icons.arrow_drop_down_sharp)
                              ],
                            ),
                          ),
                        ),
                      ),
                      !currentlyWorkhere
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Text("End Date"),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    DatePicker.showDatePicker(
                                      context,
                                      showTitleActions: true,
                                      minTime: DateTime(1940, 3, 5),
                                      onChanged: (date) {
                                        bloc.workEndDate(date);
                                      },
                                      onConfirm: (date) {
                                        endDate = date;
                                      },
                                      currentTime: DateTime.now(),
                                    );
                                  },
                                  child: SizedBox(
                                    height: 40,
                                    child: Center(
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          // const Icon(LineIcons.briefcase),
                                          Text(dateFormat.format(state.newWorkEndDate ?? DateTime.now()).toString()),
                                          Icon(Icons.arrow_drop_down_sharp)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: 20,
                      ),
                      SecendoryButton(
                          text: "Update",
                          onPressed: () {

                            if (restate.occupation_id.toString() == 'null' || restate.occupation_id.isNullOrEmpty) {
                              Fluttertoast.showToast(msg: "Please select occupation type");
                            } else if (title.isEmpty) {
                              Fluttertoast.showToast(msg: "Tittle is required");
                            } else if (location.isEmpty) {
                              Fluttertoast.showToast(msg: "Location is required");
                            } else if (workspaceName.isEmpty) {
                              Fluttertoast.showToast(msg: "Workplace Name is required");
                            } else if (description.isEmpty) {
                              Fluttertoast.showToast(msg: "Description is required");
                            } else if (startDate.toString().isNullOrEmpty || startDate.toString() == 'null') {
                              Fluttertoast.showToast(msg: "Start Date  is required");
                            } else {
                              Map<String, dynamic> b = {};

                              b['work_title'] = title;
                              b['workspace_name'] = workspaceName;
                              b['work_location'] = location;
                              b['work_description'] = description;
                              b['occupation_type'] = restate.occupation_id.toString();

                              if (currentlyWorkhere == false) {
                                currentlyWorkhere ? b['current_working'] = '1' : b['current_working'] = '0';
                              }
                              if (startDate != null) {
                                b['work_startDate'] = startDate.toString();
                              }
                              if (endDate != null) {
                                b['work_endDate'] = endDate.toString();
                              }
                              b['userId'] = authBloc.userID!;
                              // b['token'] = authBloc.accesToken!;
                              bloc.addOcupation(authBloc.userID!, authBloc.accesToken!, b, context);
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
