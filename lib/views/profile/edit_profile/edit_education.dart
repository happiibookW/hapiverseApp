import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/extension.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../utils/constants.dart';
import '../../components/secondry_button.dart';

class EditEducation extends StatefulWidget {
  const EditEducation({Key? key}) : super(key: key);

  @override
  State<EditEducation> createState() => _EditEducationState();
}

class _EditEducationState extends State<EditEducation> {
  bool currentlyReading = false;
  DateFormat dateFormat = DateFormat('dd / MMM / yyyy');
  List<String> educations = [
    "High School",
    "College",
    "College Graduate",
    "Graduate School",
    "Masters",
    'Doctorates'
  ];
  String educationVal = "High School";

  String name = '';
  String location = '';
  bool? currentlyWorking;
  DateTime? startDate = DateTime.now();
  DateTime? endDate =  DateTime.now();


  @override
  Widget build(BuildContext context) {

    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();

    name =  bloc.state.educationName ?? "";
    location = bloc.state.educationLocation ?? "";
    // educationVal = bloc.state.educationLevel ?? "";


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
            title: const Text("Edit Educations",style: TextStyle(color: Colors.white)),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [

                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: const Icon(LineIcons.graduationCap),
                      ),
                      Expanded(child: TextField(
                        controller: TextEditingController(text: state.educationName),
                        decoration: const InputDecoration(
                            hintText: "Education Name",
                            border: InputBorder.none
                        ),
                        onChanged: (v){
                          name = v;
                          // bloc.assignEducationValue(1, v);
                        },
                      ))
                    ],
                  ),

                  const Divider(),

                  TextField(
                    controller: TextEditingController(text: state.educationLocation),
                    decoration: const InputDecoration(
                        hintText: "Location",
                        border: InputBorder.none
                    ),
                    onChanged: (v){
                      location = v;
                      // bloc.assignEducationValue(2, v);
                    },
                  ),
                  const Divider(),
                  const SizedBox(height: 10),


                  SizedBox(
                    height: 45,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        underline: const Divider(color: Colors.grey,thickness: 1.5,),
                        isExpanded: true,
                        iconEnabledColor: kUniversalColor,
                        items: educations.map((String value) {
                          // educationVal = educationVal == 'School' ? state.educationLevel! : "School";
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: educationVal,
                        onChanged: (val){
                          print(val);
                          setState(() {
                            educationVal = val.toString();
                          });
                          // bloc.assignEducationValue(2, val!);
                        },
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Currently Studying here"),
                      Platform.isIOS ? CupertinoSwitch(
                          value: currentlyReading, onChanged: (v) {
                        setState(() {
                          currentlyReading = !currentlyReading;
                        });
                        // bloc.assig(5, v == true ? "1":"0");
                      }) : Switch(value: currentlyReading, onChanged: (v) {
                        setState(() {
                          currentlyReading = !currentlyReading;
                        });
                        // bloc.assignWorkValue(5, v == true ? "1":"0");
                      },
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text(currentlyReading ? "Since" :"Start Date"),
                    ],
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: () {
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime(1940, 3, 5),
                        onChanged: (date) {},
                        onConfirm: (date) {
                          startDate = date;
                          String formattedDate = DateFormat('yyyy-MM-dd').format(startDate!);
                          bloc.educationStartDate(formattedDate);
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
                            Text(dateFormat.format(DateTime.parse(state.educationStartYear ?? '2022-10-21')).toString()),
                            Icon(Icons.arrow_drop_down_sharp)
                          ],
                        ),
                      ),
                    ),
                  ),
                  !currentlyReading ? Column(
                    children: [
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Text("End Date"),
                        ],
                      ),
                      SizedBox(height: 10,),
                      InkWell(
                        onTap: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime(1940, 3, 5),
                            onChanged: (date) => {},
                            onConfirm: (date) {
                              endDate = date;
                              String formattedDate = DateFormat('yyyy-MM-dd').format(endDate!);
                              bloc.educationEndDate(formattedDate);
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
                                Text(dateFormat.format(DateTime.parse(state.educationEndYaer?? '2022-12-22')).toString()),
                                Icon(Icons.arrow_drop_down_sharp)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ):Container(),
                  SizedBox(height: 20),


                  SecendoryButton(text: "Update", onPressed: (){



                    if(name.isEmpty){
                      Fluttertoast.showToast(msg: "Name is required");
                    }else if(location.toString().isEmpty){
                      Fluttertoast.showToast(msg: "Location is required");
                    }else if(startDate.toString() == 'null' || startDate.toString().isNullOrEmpty){
                      Fluttertoast.showToast(msg: "Start Date is required");
                    }else{

                      Map<String,dynamic> b = {};
                      if(name != ''){
                        b['title'] = name;
                      }
                      if(location != ''){
                        b['location'] = location;
                      }

                      if(educationVal != state.educationLevel){
                        b['level'] = educationVal;
                      }
                      currentlyReading ? b['currently_studying'] = '1':b['currently_studying'] = '0';
                      b['startDate'] = startDate.toString();
                      b['endDate'] = endDate.toString();
                      b['userId'] = authBloc.userID!;
                      b['id'] = bloc.state.educationId.toString();
                      // b['token'] = authBloc.accesToken!;
                      bloc.editEducation(authBloc.userID!,authBloc.accesToken!, b,context);
                    }
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
