import 'dart:ffi';
import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_circular_text/circular_text/model.dart';
import 'package:flutter_circular_text/circular_text/widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:happiverse/utils/user_url.dart';
import 'package:happiverse/views/profile/add_occupation/add_occupation_screen.dart';
import 'package:happiverse/views/profile/add_occupation/edit_occupation_screen.dart';
import 'package:happiverse/views/profile/edit_profile/edit_interest.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../routes/routes_names.dart';
import '../../../utils/utils.dart';
import '../../../views/components/secondry_button.dart';
import '../../../utils/constants.dart';
import '../select_relegion.dart';
import 'edit_education.dart';
import 'edit_occupation.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  DateFormat df = DateFormat('yyyy-mm-dd');
  GlobalKey<FormState> key = GlobalKey<FormState>();

  getColors(int i) {
    switch (i) {
      case 1:
        return Colors.blue;
      case 2:
        return Colors.redAccent;
      case 3:
        return Colors.deepOrangeAccent;
      case 4:
        return Colors.green;
      case 5:
        return Colors.yellowAccent;
    }
  }

  String profileName = '';
  String city = '';
  String mystate = '';
  double _weightValue = 0.0;

  // String country = '';
  String phoneNumber = '';
  String religion = '';
  RangeValues _distance = const RangeValues(1, 13000);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final authB = context.read<RegisterCubit>();
    final profCubit = context.read<ProfileCubit>();
    profCubit.fetchInterests(authB.userID!);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();

    TextEditingController newcountry = TextEditingController(text: bloc.state.country ?? "");
    TextEditingController mynewstate = TextEditingController(text: bloc.state.mystate ?? "");
    TextEditingController newcity = TextEditingController(text: bloc.state.city ?? "");

    _weightValue = double.parse(bloc.state.weight ?? "0.0");
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: const Text(
            "Edit Profile",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: key,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Profile Image",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, editProfileImage);
                          },
                          child: const Text("Edit"))
                    ],
                  ),
                  Center(
                      child: state.avatarType == "0"
                          ? Center(
                              child: CircleAvatar(
                              radius: 35,
                              child: Container(
                                decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.cover, image: NetworkImage("${state.profileImage!}"))),
                              ),
                            ))
                          : state.avatarType == "1"
                              ? InkWell(
                                  onTap: () {
                                    // nextScreen(context, PreviewProfileAvatar(flatColor: data['flatColor'], avatarType: data['avatarType'], text: data['profileImageText'], gredient1: data['firstgredientcolor'], gredient2: data['secondgredientcolor'], profileUrl: data['profile_url']));
                                  },
                                  child: SizedBox(
                                    width: 100,
                                    child: Stack(
                                      children: [
                                        Center(
                                            child: CircleAvatar(
                                          radius: 35,
                                          child: Container(
                                            decoration: BoxDecoration(border: Border.all(width: 8, color: getColors(int.parse("1")).withOpacity(0.8)), shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.cover, image: NetworkImage("${Utils.baseImageUrl}${state.profileImage!}"))),
                                          ),
                                        )),
                                        state.profileImageText! == null
                                            ? Container()
                                            : Center(
                                                child: CircularText(
                                                  children: [
                                                    TextItem(
                                                      text: Text(
                                                        state.profileImageText!.toUpperCase(),
                                                        style: TextStyle(
                                                          fontSize: 7,
                                                          color: Colors.black.withOpacity(0.4),
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      space: 10,
                                                      startAngle: 90,
                                                      startAngleAlignment: StartAngleAlignment.center,
                                                      direction: CircularTextDirection.anticlockwise,
                                                    ),
                                                  ],
                                                  radius: 35,
                                                  position: CircularTextPosition.inside,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    // nextScreen(context, PreviewProfileAvatar(flatColor: data['flatColor'], avatarType: data['avatarType'], text: data['profileImageText'], gredient1: data['firstgredientcolor'], gredient2: data['secondgredientcolor'], profileUrl: data['profile_url']));
                                  },
                                  child: SizedBox(
                                    width: 100,
                                    child: Stack(
                                      children: [
                                        Center(
                                            child: CircleAvatar(
                                          radius: 35,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                gradient: LinearGradient(colors: [
                                                  getColors(int.parse(state.firstGredientColor!)),
                                                  getColors(int.parse(state.secondGredientColor!)),
                                                ])),
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.cover, image: NetworkImage("${Utils.baseImageUrl}${state.profileImage!}"))),
                                            ),
                                          ),
                                        )),
                                        Center(
                                          child: CircularText(
                                            children: [
                                              TextItem(
                                                text: Text(
                                                  state.profileImageText == null ? "" : state.profileImageText!.toUpperCase(),
                                                  style: TextStyle(
                                                    fontSize: 7,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                space: 10,
                                                startAngle: 90,
                                                startAngleAlignment: StartAngleAlignment.center,
                                                direction: CircularTextDirection.anticlockwise,
                                              ),
                                            ],
                                            radius: 35,
                                            position: CircularTextPosition.inside,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        children: [
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Interests"),
                              TextButton(
                                  onPressed: () {
                                    nextScreen(context, EditInterests());
                                  },
                                  child: Text("Edit"))
                            ],
                          ),
                          state.userInterest == null
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      children: List.generate(state.userInterest!.length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Chip(label: Text(state.userInterest![index].interestSubCategoryTitle)),
                                    );
                                  }).toList()),
                                ),


                          // state.userInterest == null ? const Center():state.userInterest!.length > 4 ? SingleChildScrollView(
                          //   scrollDirection: Axis.horizontal,
                          //   child: Row(
                          //       children: List.generate(state.userInterest!.length > 8 ? 4:state.userInterest!.length, (index){
                          //         return Padding(
                          //           padding: const EdgeInsets.all(8.0),
                          //           child: Chip(label: Text(state.userInterest![index + 4].interestSubCategoryTitle)),
                          //         );
                          //       }).toList()
                          //   ),
                          // ):Container()
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Divider(),
                  const SizedBox(height: 10,),
                  const Row(
                    children: [
                      Text(
                        "Personal Info",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please Enter Profile Name";
                      } else {
                        return null;
                      }
                    },
                    controller: TextEditingController(text: state.profileName),
                    decoration: const InputDecoration(hintText: "Profile Name"),
                    onChanged: (val) {
                      profileName = val;
                      // bloc.setProfileName(val);
                      print("called");
                    },
                  ),

                  /*TextField(
                    onTap: () {
                      showCountryPicker(
                        // showWorldWide: true,
                        context: context,
                        countryListTheme: CountryListThemeData(
                          flagSize: 25,
                          backgroundColor: Colors.white,
                          textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                          // bottomSheetHeight: 500, // Optional. Country list modal height
                          //Optional. Sets the border radius for the bottomsheet.
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                          //Optional. Styles the search field.
                          inputDecoration: InputDecoration(
                            labelText: 'Search',
                            hintText: 'Start typing to search',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color(0xFF8C98A8).withOpacity(0.2),
                              ),
                            ),
                          ),
                        ),
                        onSelect: (Country country) {
                          bloc.setCountryVal(country.name);
                          // bloc.addAdsLocations(country.name);
                          print('Select country: ${country.name}');
                        },
                      );
                    },
                    decoration: const InputDecoration(hintText: "Country"),
                    controller: TextEditingController(text: state.country),
                    onChanged: (val) {
                      bloc.setCountryVal(val);
                    },
                  ),

                  TextField(
                    controller: TextEditingController(text: state.mystate),
                    decoration: const InputDecoration(hintText: "State"),
                    onChanged: (val) {
                      mystate = val;
                    },
                  ),

                  TextField(
                    controller: TextEditingController(text: state.city),
                    decoration: const InputDecoration(hintText: "City"),
                    onChanged: (val) {
                      city = val;
                    },
                  ),*/
                  const SizedBox(height: 10),
                  TextField(
                    decoration: const InputDecoration(hintText: "Phone No"),
                    controller: TextEditingController(text: state.phoneNo),
                    onChanged: (val) {
                      phoneNumber = val;
                    },
                  ),
                  const SizedBox(height: 10),

                  InkWell(
                    onTap: () {
                      nextScreen(context, const SelectReligion());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          state.religion.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 10),
                  CountryStateCityPicker(
                    country: newcountry,
                    state: mynewstate,
                    city: newcity,
                    dialogColor: Colors.white,
                    textFieldDecoration: const InputDecoration(filled: true, suffixIcon: Icon(Icons.arrow_drop_down_sharp), border: OutlineInputBorder(borderSide: BorderSide.none)),
                  ),

                  const SizedBox(height: 10),
                  const Row(
                    children: [Text("Education", style: TextStyle(fontSize: 20))],
                  ),

                  const SizedBox(height: 10),
                  state.educationName != null
                      ? ListTile(
                          title: Text(state.educationName ?? ""),
                          leading: const Icon(LineIcons.graduationCap),
                          subtitle: Text("${state.educationLevel}\n${df.format(state.educationStartYear == null ? DateTime.now() : DateTime.parse(state.educationStartYear!))} - ${state.currentlyReading == "1" ? "Present" : df.format(state.educationEndYaer == null ? DateTime.now() : DateTime.parse(state.educationEndYaer!))}"),
                          trailing: IconButton(
                            onPressed: () {
                              nextScreen(context, EditEducation());
                            },
                            icon: Icon(Icons.edit),
                          ),
                        )
                      : Container(),
                  Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Occupation",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            nextScreen(context, const AddOccupations());
                          },
                          child: const CircleAvatar(child: Icon(Icons.add, color: Colors.black)))
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
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width * .9,
                                    child: Row(
                                      children: [
                                        const Icon(LineIcons.briefcase),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(state.occupationDetailModel!.data?[index].title ?? "", overflow: TextOverflow.ellipsis, maxLines: 2),
                                              Text(state.occupationDetailModel!.data?[index].workSpaceName ?? "", overflow: TextOverflow.ellipsis, maxLines: 1),
                                              Text("${state.occupationDetailModel!.data?[index].startDate} - ${state.occupationDetailModel!.data?[index].currentWorking.toString() == "1" ? "Present" : state.occupationDetailModel!.data?[index].endDate ?? "Present"}", overflow: TextOverflow.ellipsis, maxLines: 1),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Divider()

                                  // Add a Divider below each ListTile
                                ],
                              ),
                              Positioned(
                                top: 0,
                                bottom: 0,
                                right: 0,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        nextScreen(context, EditOccupationsScreen(data: state.occupationDetailModel!.data![index]));
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Delete Confirmation'),
                                              content: Text('Are you sure you want to delete?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop(); // Close the dialog
                                                  },
                                                  child: Text('No'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop(); // Close the dialog
                                                    // Perform delete action here
                                                    bloc.deleteOccupation(authBloc.userID!, state.occupationDetailModel!.data![index].id.toString(), authBloc.token!);
                                                  },
                                                  child: Text('Yes'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(Icons.delete),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // state.workTitle != null
                  //     ? ListTile(
                  //         title: Text(state.workTitle ?? ""),
                  //         leading: Icon(LineIcons.briefcase),
                  //         subtitle: Text("${state.workStartDate} - ${state.currentlyWorking == "1" ? "Present" : state.workEndDate}"),
                  //         trailing: IconButton(
                  //           onPressed: () {
                  //             nextScreen(context, EditOccupations());
                  //           },
                  //           icon: Icon(Icons.edit),
                  //         ),
                  //       )
                  //     : Container(),
                  // Divider(),
                  SizedBox(
                    height: 10,
                  ),

                  const Row(
                    children: [
                      Text(
                        "Relationship Status",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 45,
                    child: DropdownButton<String>(
                      underline: const Divider(
                        color: Colors.grey,
                        thickness: 1.5,
                      ),
                      isExpanded: true,
                      iconEnabledColor: kUniversalColor,
                      items: state.relationDropList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: state.relationShip,
                      onChanged: (val) => bloc.changeRelationDrop(val),
                      isDense: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 45,
                    child: DropdownButton<String>(
                      underline: const Divider(
                        color: Colors.grey,
                        thickness: 1.5,
                      ),
                      isExpanded: true,
                      iconEnabledColor: kUniversalColor,
                      items: state.genderList.map(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                      value: state.gender,
                      onChanged: (val) => bloc.changeGenderDrop(val),
                      isDense: true,
                    ),
                  ),
                  TextField(
                    readOnly: true,
                    decoration: const InputDecoration(hintText: "Height"),
                    controller: TextEditingController(text: state.heightInches == null ||  state.heightInches.toString().isEmpty ? "${state.height} ft" : "${state.height}.${state.heightInches} ft"),
                    onTap: () {
                      showCupertinoModalPopup(
                          barrierDismissible: false,
                          context: context,
                          builder: (c) {
                            return CupertinoActionSheet(
                              title: const Text("Choose Height"),
                              actions: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 200,
                                        child: CupertinoPicker(
                                          selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                                            background: CupertinoColors.activeBlue.withOpacity(0.2),
                                          ),
                                          itemExtent: 50,
                                          looping: true,
                                          onSelectedItemChanged: (v) {
                                            print("ffet ${v + 1}");
                                            bloc.assignHeightFeet("${v + 1}");
                                          },
                                          useMagnifier: true,
                                          children: [
                                            Center(
                                              child: Text("1'"),
                                            ),
                                            Center(
                                              child: Text("2'"),
                                            ),
                                            Center(
                                              child: Text("3'"),
                                            ),
                                            Center(
                                              child: Text("4'"),
                                            ),
                                            Center(
                                              child: Text("5'"),
                                            ),
                                            Center(
                                              child: Text("6'"),
                                            ),
                                            Center(
                                              child: Text("7'"),
                                            ),
                                            Center(
                                              child: Text("8'"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        height: 200,
                                        child: CupertinoPicker(
                                          selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                                            background: CupertinoColors.activeBlue.withOpacity(0.2),
                                          ),
                                          itemExtent: 50,
                                          onSelectedItemChanged: (v) {
                                            bloc.assignHeightInches("${v + 1}");
                                          },
                                          children: [
                                            Center(
                                              child: Text("1\""),
                                            ),
                                            Center(
                                              child: Text("2\""),
                                            ),
                                            Center(
                                              child: Text("3\""),
                                            ),
                                            Center(
                                              child: Text("4\""),
                                            ),
                                            Center(
                                              child: Text("5\""),
                                            ),
                                            Center(
                                              child: Text("6\""),
                                            ),
                                            Center(
                                              child: Text("7\""),
                                            ),
                                            Center(
                                              child: Text("8\""),
                                            ),
                                            Center(
                                              child: Text("9\""),
                                            ),
                                            Center(
                                              child: Text("10\""),
                                            ),
                                            Center(
                                              child: Text("11\""),
                                            ),
                                            Center(
                                              child: Text("12\""),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: SecendoryButton(
                                      text: "Done",
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                )
                              ],
                            );
                          });
                    },
                    // onChanged: (val)=>bloc.setHobby(val),
                    onChanged: (val) {
                      // phoneNumber = val;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Weight 0 lbs - 500 lbs",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Slider(
                    value: _weightValue,
                    min: 0,
                    max: 500,
                    divisions: 500,
                    label: _weightValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _weightValue = value;
                      });
                      bloc.setWeight(value.toString());
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Distance ${_distance.start.round().toString()} km - ${_distance.end.round().toString()} km",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  SliderTheme(
                    data: const SliderThemeData(
                      thumbShape: RoundSliderThumbShape(disabledThumbRadius: 0.0),
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
                    ),
                    child: RangeSlider(
                      values: _distance,
                      min: 0,
                      max: 13000,
                      divisions: 300,
                      labels: RangeLabels(
                        _distance.start.round().toString(),
                        _distance.end.round().toString(),
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _distance = values;
                          // bloc.setAdsAudionce("${_currentRangeValues.start.round().toString()} - ${_currentRangeValues.end.round() == 65 ? '65+' :_currentRangeValues.end.round().toString()}",_currentRangeValues.start.round().toString(),'${_currentRangeValues.end.round() == 65 ? '65+' :_currentRangeValues.end.round().toString()}');
                        });
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  state.isProfileUpdating
                      ? CupertinoActivityIndicator()
                      : SecendoryButton(
                          text: "Save",
                          onPressed: () {
                            if (profileName != '') {
                              bloc.setProfileName(profileName);
                            }

                            if (phoneNumber != '') {
                              bloc.setPhoneNum(phoneNumber);
                            }

                            if (newcountry.text.isEmpty) {
                              Fluttertoast.showToast(msg: "Country is required");
                            } else if (mynewstate.text.isEmpty) {
                              Fluttertoast.showToast(msg: "State is required");
                            } else if (newcity.text.isEmpty) {
                              Fluttertoast.showToast(msg: "City is required");
                            } else {
                              bloc.setCountryVal(newcountry.text);
                              bloc.setStateVal(mynewstate.text);
                              bloc.setCityVal(newcity.text);
                              bloc.updateUserProfileInfo(authBloc.userID!, authBloc.accesToken!);
                            }
                          })
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
