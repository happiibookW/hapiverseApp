import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happiverse/data/model/user_interest_model_profile.dart';
import 'package:happiverse/data/model/user_order_model.dart';
import 'package:happiverse/utils/user_url.dart';
import 'package:happiverse/utils/utils.dart';
import 'package:happiverse/views/business_tools/business_tools.dart';
import 'package:happiverse/views/profile/profile_more/orders_page.dart';
import 'package:line_icons/line_icons.dart';
import '../../data/model/CardDataModel.dart';
import '../../data/model/business_profile_model.dart';
import '../../data/model/covid_record_model.dart';
import '../../data/model/fav_music_model.dart';
import '../../data/model/fetch_business_meeting.dart';
import '../../data/model/fetch_card_model.dart';
import '../../data/model/fetch_coins_model.dart';
import '../../data/model/fetch_follow_following_model.dart';
import '../../data/model/fetch_friend_model.dart';
import '../../data/model/fetch_image_album.dart';
import '../../data/model/fetch_job_model.dart';
import '../../data/model/fetch_photo_album.dart';
import '../../data/model/fetch_places.dart';
import '../../data/model/get_all_my_post_model.dart';
import '../../data/model/interest_select_model.dart';
import '../../data/model/intrestes_category.dart';
import '../../data/model/location_share_to_other.dart';
import '../../data/model/music_model.dart';
import '../../data/model/occupation_detail_model.dart';
import '../../data/model/request_location_model.dart';
import '../../data/model/text_completion_model.dart';
import '../../data/repository/business_tools_repository.dart';
import '../../data/repository/profile_repository.dart';
import '../../routes/routes_names.dart';
import '../../utils/constants.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import '../../views/bottom_nav.dart';
import '../register/register_cubit.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState(relationDropList: relationStatusList, genderList: genderList, isProfileUpdating: false, businessRatingValue: 2.5, audioPlayer: audioPlayer, isPlaying: false, progress: Duration(), musicUrl: "", musicTitle: "Unknown Music", musicLength: Duration(), musicImage: "https://static.vecteezy.com/system/resources/previews/001/200/758/original/music-note-png.png", musicArtist: "Unknown Artist", notNowClieked: true, isMapMoving: false, alwaysOpen: false, wednesdayStartTime: TimeOfDay.now(), wednesdayEndTime: TimeOfDay.now(), tuesdayStartTime: TimeOfDay.now(), tuesdayEndTime: TimeOfDay.now(), thursdayStartTime: TimeOfDay.now(), thursdayEndTime: TimeOfDay.now(), sundayEndTime: TimeOfDay.now(), sundaryStartTime: TimeOfDay.now(), saturdayStartTime: TimeOfDay.now(), saturdayEndTime: TimeOfDay.now(), mondayStartTime: TimeOfDay.now(), mondayEndTime: TimeOfDay.now(), fridayStartTime: TimeOfDay.now(), firdayEndTime: TimeOfDay.now(), isHoursSelected: false, closedAllDayWednesDay: false, closedAllDayTuesday: false, closedAllDayThursday: false, closedAllDaySunday: false, closedAllDaySaturday: false, closedAllDayMonday: false, closedAllDayFriday: false, businessLocationMArker: {}, isLoading: false, statee: ApiState.loading, isProfileComplete: false));

  static AudioPlayer audioPlayer = AudioPlayer();

  final repository = ProfileRepository();
  final businessToolRepository = BusinessToolsRepository();
  final registerBloc = RegisterCubit();
  static List<String> relationStatusList = [
    'Single',
    'Engaged',
    'Married',
    'Dating',
    'Divorced',
  ];

  setWeight(String val) {
    emit(state.copyWith(weightt: val));
  }

  String get userName => state.profileName!;

  String get userImage => state.profileImage!;

  String get businessLogo => state.businessProfile!.logoImageUrl!;

  String get businessEmail => state.businessProfile!.email!;

  // String get userEmail => state!;
  bool get isPlaying => state.isPlaying;

  int get musicIndex => state.musicIndex!;

  String? newCityVal;
  String? newCountryVal;
  String? newStateVal;

  changeRelationDrop(val) {
    emit(state.copyWith(relationShipp: val));
  }

  static List<String> genderList = [
    'Male',
    'Female',
  ];

  setRelegion(String val) {
    emit(state.copyWith(religionn: val));
  }

  assignHeightFeet(String height) {
    emit(state.copyWith(heightt: height));
  }

  assignHeightInches(String height) {
    emit(state.copyWith(heightInchess: height));
  }

  changeGenderDrop(val) {
    emit(state.copyWith(genderr: val));
  }

  setNotNowClicked() {
    emit(state.copyWith(notNowClickedd: true));
  }

  hoursSelected() {
    emit(state.copyWith(isHoursSelectedd: true));
  }

  educationStartDate(String date) {
    emit(state.copyWith(educationStartYearr: date));
  }

  educationEndDate(String date) {
    emit(state.copyWith(educationEndYaerr: date));
  }

  workStartDate(DateTime date) {
    emit(state.copyWith(newWorkStartDatee: date));
  }

  workEndDate(DateTime date) {
    emit(state.copyWith(newWorkEndDatee: date));
  }

  selectAlwayBusinessHours(bool val) {
    print("HelloValue==> " + val.toString());
    emit(state.copyWith(alwaysOpenn: val));
  }

  updateBuinsessOwnerName(BusinessProfile? val) {
    emit(state.copyWith(businessProfilee: val));
  }

  setBusinessMarker(bool isFromProfile, {Marker? marker}) async {
    Set<Marker> markers = {};
    String address = "";
    if (isFromProfile) {
      print("LATILOGN ${LatLng(double.parse(state.businessProfile!.latitude!), double.parse(state.businessProfile!.longitude!))}");
      animateCamera(LatLng(double.parse(state.businessProfile!.latitude!), double.parse(state.businessProfile!.longitude!)));
      markers.add(Marker(markerId: MarkerId(DateTime.now().toString()), position: LatLng(double.parse(state.businessProfile!.latitude!), double.parse(state.businessProfile!.longitude!))));
      await http.get(Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=${state.businessProfile!.latitude!},${state.businessProfile!.longitude!}&key=AIzaSyCRez6eZn33IUzPg54m-BZnL5yfPePMBLU")).then((value) {
        var de = jsonDecode(value.body);
        address = de['results'][0]['formatted_address'];
        emit(state.copyWith(businessAddresss: address));
      });
    } else {
      markers.add(marker!);
      animateCamera(marker.position);
      await http.get(Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=${marker.position.latitude},${marker.position.longitude}&key=AIzaSyCRez6eZn33IUzPg54m-BZnL5yfPePMBLU")).then((value) {
        var de = jsonDecode(value.body);
        address = de['results'][0]['formatted_address'];
        emit(state.copyWith(businessAddresss: address));
      });
    }
    emit(state.copyWith(businessMarker: markers));
  }

  Completer<GoogleMapController> completer = Completer();
  GoogleMapController? controllerr;

  onMapCreated(GoogleMapController controller) {
    controllerr = controller;
    completer.complete(controller);
    emit(state.copyWith(controllerr: controller, completerr: completer));
  }

  void animateCamera(LatLng position) async {
    controllerr!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 17.0,
    )));
    emit(state.copyWith(controllerr: controllerr));
  }

  Future<void> selectSaturdayStartTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.saturdayStartTime) {
      emit(state.copyWith(saturdayStartTimee: newTime));
    }
    print(state.saturdayStartTime.format(context));
    emit(state.copyWith(isStartTimeSelectedd: true));
  }

  Future<void> selectSaturdayEndTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.saturdayEndTime) {
      emit(state.copyWith(saturdayEndTimee: newTime));
    }
    emit(state.copyWith(isEndTimeSelectedd: true));
  }

  Future<void> selectSundayStartTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.sundaryStartTime) {
      emit(state.copyWith(sundaryStartTimee: newTime));
    }
    print(state.sundaryStartTime.format(context));
    emit(state.copyWith(isStartTimeSelectedd: true));
  }

  Future<void> selectSundayEndTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.sundayEndTime) {
      emit(state.copyWith(sundayEndTimee: newTime));
    }
    emit(state.copyWith(isEndTimeSelectedd: true));
  }

  Future<void> selectMondayStartTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.mondayStartTime) {
      emit(state.copyWith(mondayStartTimee: newTime));
    }
    print(state.mondayStartTime.format(context));
    emit(state.copyWith(isStartTimeSelectedd: true));
  }

  Future<void> selectMondayEndTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.mondayEndTime) {
      emit(state.copyWith(mondayEndTimee: newTime));
    }
    emit(state.copyWith(isEndTimeSelectedd: true));
  }

  Future<void> selectTuesdayStartTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.tuesdayStartTime) {
      emit(state.copyWith(tuesdayStartTimee: newTime));
    }
    print(state.mondayStartTime.format(context));
    emit(state.copyWith(isStartTimeSelectedd: true));
  }

  Future<void> selectTuesdayEndTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.tuesdayEndTime) {
      emit(state.copyWith(tuesdayEndTimee: newTime));
    }
    emit(state.copyWith(isEndTimeSelectedd: true));
  }

  Future<void> selectWednesdayStartTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.wednesdayStartTime) {
      emit(state.copyWith(wednesdayStartTimee: newTime));
    }
    print(state.mondayStartTime.format(context));
    emit(state.copyWith(isStartTimeSelectedd: true));
  }

  Future<void> selectWednesdayEndTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.wednesdayEndTime) {
      emit(state.copyWith(wednesdayEndTimee: newTime));
    }
    emit(state.copyWith(isEndTimeSelectedd: true));
  }

  Future<void> selectThursdayStartTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.thursdayStartTime) {
      emit(state.copyWith(thursdayStartTimee: newTime));
    }
    print(state.mondayStartTime.format(context));
    emit(state.copyWith(isStartTimeSelectedd: true));
  }

  Future<void> selectThursdayEndTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.thursdayEndTime) {
      emit(state.copyWith(thursdayEndTimee: newTime));
    }
    emit(state.copyWith(isEndTimeSelectedd: true));
  }

  Future<void> selectFridayStartTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.fridayStartTime) {
      emit(state.copyWith(fridayStartTimee: newTime));
    }
    print(state.mondayStartTime.format(context));
    emit(state.copyWith(isStartTimeSelectedd: true));
  }

  Future<void> selectFridayEndTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null && newTime != state.firdayEndTime) {
      emit(state.copyWith(firdayEndTimee: newTime));
    }
    emit(state.copyWith(isEndTimeSelectedd: true));
  }

  mondayAllDayOff() {
    emit(state.copyWith(closedAllDayMondayy: !state.closedAllDayMonday));
  }

  tuesdayAllDayOff() {
    emit(state.copyWith(closedAllDayTuesdayy: !state.closedAllDayTuesday));
  }

  wednesdayAllDayOff() {
    emit(state.copyWith(closedAllDayWednesDayy: !state.closedAllDayWednesDay));
  }

  thursdayAllDayOff() {
    emit(state.copyWith(closedAllDayThursdayy: !state.closedAllDayThursday));
  }

  fridayAllDayOff() {
    emit(state.copyWith(closedAllDayFridayy: !state.closedAllDayFriday));
  }

  saturdayAllDayOff() {
    emit(state.copyWith(closedAllDaySaturdayy: !state.closedAllDaySaturday));
  }

  sundayAllDayOff() {
    emit(state.copyWith(closedAllDaySundayy: !state.closedAllDaySunday));
  }

  List<UserInterestProfile> userInterest = [];

  fetchInterests(String userId) async {
    repository.fetchUserInterest(userId).then((response) {
      var data = userInterestModelProfileFromJson(response.body);
      userInterest = data.data;
      emit(state.copyWith(userInterestt: userInterest));
    });

    // http.Response response = await http.post(Uri.parse("https://www.hapiverse.com/ci_api/API/v1/user/FetchUserInterest"), body: {'userId': userId});
    // print(response.body);
    // var data = userInterestModelProfileFromJson(response.body);
    // userInterest = data.data;
    // emit(state.copyWith(userInterestt: userInterest));
  }

  deleteInterests(String mstUserInterestId, BuildContext context,String userId) async {
    repository.deleteUserInterest(mstUserInterestId).then((response) {
      var deco = json.decode(response.body);
      var message = deco['message'];
      if (message == "Interest Deleted") {
        Fluttertoast.showToast(msg: "Interest Deleted Successfully");
        fetchInterests(userId);
        Navigator.pop(context);
      }else{
        Fluttertoast.showToast(msg: "Something wrong");
      }
    });

    // http.Response response = await http.post(Uri.parse("https://www.hapiverse.com/ci_api/API/v1/user/FetchUserInterest"), body: {'userId': userId});
    // print(response.body);
    // var data = userInterestModelProfileFromJson(response.body);
    // userInterest = data.data;
    // emit(state.copyWith(userInterestt: userInterest));
  }

  List<File> _addEventsImages = [];
  List<Widget> _addEventsImagesWidget = [];

  pickEventsImages(int source) async {
    if (source == 2) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: true);
      for (var i = 0; i < result!.files.length; i++) {
        _addEventsImages.add(File(result.files[i].path!));
      }
      _addEventsImagesWidget.clear();
      for (var i in _addEventsImages) {
        print(i);
        _addEventsImagesWidget.add(Container(
          width: double.infinity,
          height: double.infinity / 4,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), image: DecorationImage(fit: BoxFit.cover, image: FileImage(File(i.path)))),
        ));
      }
      print(_addEventsImagesWidget.length);
      _addEventsImagesWidget.add(
        Container(
          height: double.infinity / 4,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey[200]),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(LineIcons.camera),
                SizedBox(
                  width: 5,
                ),
                Text("Add Images"),
              ],
            ),
          ),
        ),
      );
      emit(state.copyWith(addPlaceImagess: _addEventsImages, addPlaceImagesWidgett: _addEventsImagesWidget));
    } else {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
      _addEventsImages.add(File(image!.path));
      _addEventsImagesWidget.clear();
      for (var i in _addEventsImages) {
        print(i);
        _addEventsImagesWidget.add(Container(
          width: double.infinity,
          height: double.infinity / 4,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), image: DecorationImage(fit: BoxFit.cover, image: FileImage(File(i.path)))),
        ));
      }
      print(_addEventsImagesWidget.length);
      _addEventsImagesWidget.add(
        Container(
          height: double.infinity / 4,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey[200]),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(LineIcons.camera),
                SizedBox(
                  width: 5,
                ),
                Text("Add Images"),
              ],
            ),
          ),
        ),
      );
      emit(state.copyWith(addPlaceImagess: _addEventsImages, addPlaceImagesWidgett: _addEventsImagesWidget));
    }
  }

  selectUnselectInterests(int i) {
    userInterest[i].isSelected = !userInterest[i].isSelected;
    emit(state.copyWith(userInterestt: userInterest));
  }

  fetchMyPRofile(String id, String token) {
    print("HelloFetchProfile");
    try {
      repository.getProfile(id, token).then((response) {
        var deco = json.decode(response.body);

        var d = deco['data'];
        print("HelloFetchProfile====> ${response.body}");
        emit(
          state.copyWith(
            isProfileCompletee: d['is_profile_complete'],
            hobbyy: "FootBall",
            cityy: d['city'],
            mystatee: d['state'],
            weightt: d['weight'],
            countryy: d['country'],
            followerss: d['follower'],
            followingg: d['following'],
            genderr: d['gender'],
            profileImagee: d['profileImageUrl'],
            profileNamee: d['userName'],
            relationShipp: d['martialStatus'],
            totalPostt: d['totalPosts'],
            dateOfBirt: d['DOB'],
            phoneNoo: d['phoneNo'],
            avatarTypee: d['avatarType'],
            flatColorr: d['flatColor'],
            profileImageTextt: d['profileImageText'],
            firstGredientColorr: d['firstgredientcolor'],
            secondGredientColorr: d['secondgredientcolor'],
            heightt: d['height'],
            religionn: d['religion'],
            workNamee: d['occupation'].isNotEmpty ? d['occupation'][0]['title'] : "",
            workLocationn: d['occupation'].isNotEmpty ? d['occupation'][0]['location'] : "",
            workEndDatee: d['occupation'].isNotEmpty ? d['occupation'][0]['endDate'] : "",
            workStartDatee: d['occupation'].isNotEmpty ? d['occupation'][0]['startDate'] : "",
            workDescriptionn: d['occupation'].isNotEmpty ? d['occupation'][0]['description'] : "",
            workTitlee: d['occupation'].isNotEmpty ? d['occupation'][0]['title'] : "",
            currentlyWorkingg: d['occupation'].isNotEmpty ? d['occupation'][0]['current_working'] : "",
            educationEndYaerr: d['education'][0]['endYear'],
            educationLevell: d['education'][0]['level'],
            educationLocationn: d['education'][0]['location'],
            educationNamee: d['education'][0]['title'],
            educationIdd: d['education'][0]['id'],
            educationStartYearr: d['education'][0]['startDate'],
            currentlyReadingg: d['education'][0]['currently_studying'],
            hasVerifiedd: d['hasVerified'],
            badgee: d['badge'],
          ),
        );

        Future.delayed(const Duration(milliseconds: 100), () {
          if (d['country'] == null || d['country'] == '' || d['city'] == null || d['city'] == '') {
            emit(state.copyWith(notNowClickedd: false));
            print("This Called pppppp");
          }
        });
      });
    } catch (e) {
      print("Error Fetching My Profile===> $e");
    }
  }

  List<FetchFriend> myFriendsList = [];
  List<FetchFriend> otherFriendsList = [];

  getMyFriendList(String id, String token) {
    repository.fetchMyFriend(id, token).then((response) {
      var dec = json.decode(response.body);
      if (dec['message'] == "Data not availabe") {
        emit(state.copyWith(myFriendsListt: []));
      } else {
        var data = fetchFriendModelFromJson(response.body);
        myFriendsList = data.data;
        emit(state.copyWith(myFriendsListt: data.data));
        print(response.body);
      }
    });
  }

  getOtherFriends(String id, String token, String otherUserid) {
    repository.fetchOtherFriend(id, token, otherUserid).then((response) {
      var dec = json.decode(response.body);
      print("Other Friend${response.body}");
      if (dec['message'] == "Data not availabe") {
        emit(state.copyWith(otherFriendsListt: []));
      } else {
        var data = fetchFriendModelFromJson(response.body);
        otherFriendsList = data.data;
        emit(state.copyWith(otherFriendsListt: data.data));
        print(response.body);
      }
    });
  }

  fetchOtherProfile(String id, String token, String myUserId) {
    repository.getOtherProfile(id, token, myUserId).then((response) {
      print("HelloUserData====> " + response.body.toString());
      emit(state.copyWith(otherProfileInfoResponsee: response));
    });
  }

  List<GetMyAllPosts> allOtherPosts = [];

  addFollow(String userId, String followerId, String token, BuildContext context, bool isBusiness) {
    showDialog(
        context: context,
        builder: (ctx) {
          return const AlertDialog(
            content: CupertinoActivityIndicator(),
          );
        });

    // authBloc.pushNotification(userId,token, reciverID,"2", "liked your post", "${DateTime.now()}",postId);
    // registerBloc.pushNotification(userId, token, followerId, "1", "Hapiverse", "${isBusiness ? state.businessProfile!.businessName : state.profileName} Follow you", userId);

    //Commented by Rahul becouse passed here are wrong
    repository.addFollower(followerId, token, userId).then((response) {
      print("HelloAdFollower===> ${response.body}");
      if(isBusiness){
        fetchOtherBusinessProfile(followerId, token, userId);
      }else{
        fetchOtherProfile(followerId, token, userId);
      }

      Navigator.pop(context);
    });
  }

  List<GetMyAllPosts>? allPhotos = [];

  fetchOtherAllPost(String id, String token, String myUserId) {
    allPhotos!.clear();
    repository.getOtherAllPorst(id, token, myUserId).then((response) {
      var data = getAllMyPostsModelFromJson(response.body);
      print("other post ${response.body}");
      for (var i in data.data) {
        if (i.postType == "image") {
          print("YEs");
          allPhotos!.add(i);
        }
      }
      emit(state.copyWith(allOtherPostss: data.data, allOtherPhotoss: allPhotos));
    });
  }

  List<GetMyAllPosts> allMYphotos = [];

  fetchAllMyPosts(String token, String myUserId) {
    allMYphotos.clear();
    repository.fetchMyPosts(token, myUserId).then((response) {
      var data = getAllMyPostsModelFromJson(response.body);

      for (var i in data.data) {
        if (i.postType == 'image') {
          allMYphotos.add(i);
        }
      }
      emit(state.copyWith(allMyPostss: data.data, allMyPhotoss: allMYphotos));
    });
  }

  XFile? profileImage;

  getImageGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final bytes = (await image?.readAsBytes())?.lengthInBytes;
    final kb = bytes! / 1024;
    final mb = kb / 1024;

    print("HelloSize====>$mb ");

    if (mb > 4) {
      Fluttertoast.showToast(msg: "Image size can't be more then 4 mb");
    } else {
      emit(state.copyWith(profileUpdatedImagee: File(image!.path)));
    }

    // emit(state.copyWith(profileUpdatedImagee: File(image!.path)));
  }

  getImageCamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);

    final bytes = (await image?.readAsBytes())?.lengthInBytes;
    final kb = bytes! / 1024;
    final mb = kb / 1024;

    if (mb > 4) {
      Fluttertoast.showToast(msg: "Image size can't be more then 4 mb");
    } else {
      emit(state.copyWith(profileUpdatedImagee: File(image!.path)));
    }
  }

  Future<Null> cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: state.profileUpdatedImage!.path,
      aspectRatioPresets: [CropAspectRatioPreset.square, CropAspectRatioPreset.ratio3x2, CropAspectRatioPreset.original, CropAspectRatioPreset.ratio4x3, CropAspectRatioPreset.ratio16x9],
    );
    emit(state.copyWith(profileUpdatedImagee: File(croppedFile!.path)));
  }

  updateUserProfileImage(String userId, String token, BuildContext context) {
    emit(state.copyWith(isProfileUpdatingg: true));

    repository.editUserProfileImage(userId, File(state.profileUpdatedImage!.path), token).then((response) {
      var dec = json.decode(response.body);
      if (dec['message'] == "Data successfuly save") {
        Fluttertoast.showToast(msg: "Profile Image Updated");
        fetchMyPRofile(userId, token);
        emit(state.copyWith(isProfileUpdatingg: false));
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: "Something Went Wrong Try again!");
      }
    });
  }

  setProfileName(String profileName) {
    emit(state.copyWith(profileNamee: profileName));
  }

  setCityVal(String cityVal) {
    newCityVal = cityVal;
    // emit(state.copyWith(cityy: cityVal));
    print("setted");
  }

  setStateVal(String stateVal) {
    newStateVal = stateVal;
    // emit(state.copyWith(cityy: cityVal));
    print("setted");
  }

  setCountryVal(String countryVal) {
    newCountryVal = countryVal;
    emit(state.copyWith(countryy: countryVal));
  }

  setPhoneNum(String phoneNo) {
    emit(state.copyWith(phoneNoo: phoneNo));
  }

  updateUserProfileInfo(String userId, String accessToken) {
    print(newCityVal);
    print(state.city);
    String height = state.heightInches == null || state.heightInches.toString().isEmpty ? "${state.height} " : "${state.height}.${state.heightInches}";
    print("helloHeight " + height);
    emit(state.copyWith(isProfileUpdatingg: true));
    Map<String, String> map = {'userName': state.profileName!, 'city': newCityVal ?? state.city!, 'country': newCountryVal ?? state.country ?? "", 'phoneNo': state.phoneNo!, 'gender': state.gender!, 'martialStatus': state.relationShip ?? "", 'userId': userId, 'state': newStateVal ?? state.mystate!, 'religion': state.religion.toString(), 'weight': state.weight.toString(), 'height': height};
    repository.updateUserProfileInfo(map, userId, accessToken).then((response) {
      emit(state.copyWith(isProfileUpdatingg: false));
      var dec = json.decode(response.body);
      print(dec);
      if (dec['message'] == 'Data successfuly save') {
        Fluttertoast.showToast(msg: "Profile Update Successfully");
        assignHeightInches("");
        assignHeightFeet("");
      } else {
        Fluttertoast.showToast(msg: "Something went wrong try again");
        assignHeightInches("");
        assignHeightFeet("");
      }
      fetchMyPRofile(userId, accessToken);
    });
  }

  addCovidRecord(String userId, String accressToken) {
    Map<String, dynamic> map = {
      'userId': userId,
      'hospitalName': state.healthHospital!,
      'date': state.healthDate.toString(),
      'covidStatus': state.healthStatus!,
    };
    repository.addCovidRecord(map, userId, accressToken).then((response) {
      print(response.body);
      fetchCovidRecord(userId, accressToken);
    });
  }

  fetchCovidRecord(String userId, String accressToken) {
    repository.fetchCovidRecord(userId, accressToken).then((response) {
      print(response.body);
      print("Covid Data");
      var de = json.decode(response.body);
      if (de['data'] == null || de['data']?.length <= 0) {
        print("DAta khali hai chill kro ");
        emit(state.copyWith(covidRecordListt: []));
      } else {
        print("sub ok hai ");
        var data = covidRecordModelFromJson(response.body);
        emit(state.copyWith(covidRecordListt: data.data));
      }
    });
  }

  assignHospitalName(String val) {
    emit(state.copyWith(healthHospitall: val));
  }

  assignHealthDate(DateTime val) {
    emit(state.copyWith(healthDatee: val));
  }

  assignCovidStatus(String val) {
    emit(state.copyWith(healthStatuss: val));
  }

  playMusic(String url, int length, int index) {
    audioPlayer.play(url);
    emit(state.copyWith(audioPlayerr: audioPlayer, musicLengthh: Duration(milliseconds: length), isPlayingg: true, musicIndexx: index));
    audioPlayer.onDurationChanged.listen((Duration p) => {emit(state.copyWith(progresss: p))});
    // audioPlayer.setNotification(title: state.musicTitle,imageUrl: state.musicImage,duration: state.progress);
    audioPlayer.notificationService.setNotification(title: state.musicTitle, imageUrl: state.musicImage, duration: state.progress, enableNextTrackButton: true, enablePreviousTrackButton: true);
  }

  pauseMusic() {
    audioPlayer.pause();
    emit(state.copyWith(audioPlayerr: audioPlayer));
  }

  resumeMusic() {
    audioPlayer.resume();
    emit(state.copyWith(audioPlayerr: audioPlayer));
  }

  seekMusic(Duration progress) {
    audioPlayer.seek(progress);
    emit(state.copyWith(progresss: progress, audioPlayerr: audioPlayer));
  }

  musicPlayingState(bool val) {
    if (val) {
      audioPlayer.resume();
    } else {
      audioPlayer.pause();
    }
    emit(state.copyWith(isPlayingg: val, audioPlayerr: audioPlayer));
  }

  setCurrentMusicVal(String title, String artist, String image, String url) {
    emit(state.copyWith(musicTitlee: title, musicArtistt: artist, musicUrll: url, musicImagee: image));
  }

  playNextMusic() {
    if (state.musicTrack!.length > state.musicIndex!) {
      var music = state.musicTrack![state.musicIndex! + 1];
      setCurrentMusicVal(music.album!.name!, music.artists![0].name!, music.album!.images![0].url!, music.previewUrl!);
      playMusic(music.previewUrl!, music.durationMs!, state.musicIndex! + 1);
    }
  }

  playPreviousMusic() {
    if (state.musicIndex! > 0) {
      var music = state.musicTrack![state.musicIndex! - 1];
      setCurrentMusicVal(music.album!.name!, music.artists![0].name!, music.album!.images![0].url!, music.previewUrl!);
      playMusic(music.previewUrl!, music.durationMs!, state.musicIndex! - 1);
    }
  }

  replayMusic() {
    audioPlayer.seek(const Duration(seconds: 0));
    emit(state.copyWith(audioPlayerr: audioPlayer));
  }

  getStealthStatus(String userId, String token) {
    repository.getStealthStatus(userId, token, false).then((response) {
      print(response.body);
      var de = json.decode(response.body);
      emit(state.copyWith(stealthModeEnablee: de['data']['isStealth'] == '0' ? false : true, stealthModeTimeLeftt: de['data']['stealthDuration']));
    });
  }

  addRemoveStealthStatus(String userId, String token, String duration) {
    repository.addRemoveStealthStatus(userId, token, state.stealthModeEnable! ? true : false, false, duration).then((response) {
      print(response.body);
      getStealthStatus(userId, token);
    });
    // emit(state.copyWith(stealthModeEnablee: !state.stealthModeEnable!));
  }

  fetchLocationRequest(String userId, String token, bool isMyRequests) {
    repository.fetchLocationRequests(userId, token, isMyRequests ? '1' : '0').then((response) {
      print(response.body);
      var de = json.decode(response.body);
      print(de);
      if (de['message'] == 'Data availabe') {
        var data = requestLocationModelFromJson(response.body);
        if (isMyRequests) {
          emit(state.copyWith(myLocationRequeststoOtherr: data.data));
        } else {
          emit(state.copyWith(otherLocationRequestToMee: data.data));
        }
      } else {
        emit(state.copyWith(myLocationRequeststoOtherr: [], otherLocationRequestToMee: []));
      }
    });
  }

  rejectLocationRequest(String userID, String token, String requestId) {
    repository.rejectLocationRequest(userID, token, requestId).then((response) {
      print(response.body);
      fetchLocationRequest(userID, token, false);
    });
  }

  acceptLocationRequest(String userID, String token, double lat, double long, String? requestId, BuildContext context) async {
    print(requestId);
    print(lat);
    await http.get(Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat},${long}&key=${Utils.placesAPIKey}")).then((value) {
      var de = jsonDecode(value.body);
      print(de);
      var address = de['results'][0]['formatted_address'];
      Map<String, dynamic> map = {
        'address': address,
        'lat': lat.toString(),
        'long': long.toString(),
        'requestId': requestId ?? "",
      };
      repository.acceptLocationRequest(userID, token, map).then((response) {
        print(response.body);
        var de = json.decode(response.body);
        if (de['message'] == 'Data successfuly save') {
          fetchLocationRequest(userID, token, false);
          Fluttertoast.showToast(msg: "Location Shared Successfully");
          Navigator.pop(context);
        } else {
          Fluttertoast.showToast(msg: "Something went wrong try again!");
        }
      });
    });
  }

  requestLocation(String userId, String token, String requesterId, bool isLive) {
    Map<String, dynamic> map = {
      'userId': userId,
      'token': token,
      'requesterId': requesterId,
      'locationType': isLive ? '1' : '0',
      'status': 'pending',
    };
    repository.requestLocation(map).then((response) {
      var de = json.decode(response.body);
      if (de['message'] == 'Data successfuly save') {
        Fluttertoast.showToast(msg: "Location Request Has been sent");
      }
    });
  }

  deleteLocationRequest(String userId, String token, String requestId) {
    repository.deleteLocationRequest(userId, token, requestId).then((response) {
      var de = json.decode(response.body);
      print(de);
      fetchLocationRequest(userId, token, false);
      if (de['message'] == '') {}
    });
  }

  deleteLocationSharingSingle(String userId, String token, String id) {
    print("$deleteLocationRequestUrl$id");
    repository.callDeletApi({'userId': userId, 'token': token}, "$deletLocationSharingUrl$id").then((response) {
      print(response.body);
      var de = json.decode(response.body);
      print(de);
      fetchMyLocationSharing(userId, token, true);
    });
  }

  deleteLocationSharingAll(String userId, String token) {
    // print("$deleteLocationRequestUrl$id");
    repository.callDeletApi({'userId': userId, 'token': token}, "$deletLocationSharingAllUrl$userId").then((response) {
      print(response.body);
      // var de = json.decode(response.body);
      // print(de);
      fetchMyLocationSharing(userId, token, true);
    });
  }

// <============== business ===============>

  fetchMyBusinessProfile(String userId, String token) {
    repository.fetchMyBusinessPRofile(userId, token).then((reponse) {
      print("HelloBusinessProfil==> " + json.encode(reponse.body));
      var data = businessProfileModelFromJson(reponse.body);
      emit(state.copyWith(businessProfilee: data.data));
    });
    // fetchBusinessRating(userId, token,userId);
  }

  updateMyBusinessProfile(String userId, String token, BuildContext context) {
    emit(state.copyWith(isProfileUpdatingg: true));

    repository.editBusinessProfileImage(userId, File(state.coverUpdatedImageBusiness?.path ?? ""), File(state.profileUpdatedImageBusiness?.path ?? ""), token).then((response) {
      var dec = json.decode(response.body);
      if (dec['message'] == "Images updated successfully") {
        Fluttertoast.showToast(msg: "Profile Image Updated");
        fetchMyBusinessProfile(userId, token);
        emit(state.copyWith(isProfileUpdatingg: false));
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: "Something Went Wrong Try again!");
      }
    });
  }

  updateMyBusinessDetail(String userId, String businessName, String ownerName, String contact, BuildContext context, String token) {
    emit(state.copyWith(isProfileUpdatingg: true));

    repository.editBusinessProfileInfo(userId, businessName, ownerName, contact).then((response) {
      var dec = json.decode(response.body);
      if (dec['message'] == "Business hours updated successfully.") {
        Fluttertoast.showToast(msg: "Profile Updated");
        fetchMyBusinessProfile(userId, token);
        emit(state.copyWith(isProfileUpdatingg: false));
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: "Something Went Wrong Try again!");
      }
    });
  }

  updateMyBusinessHour(String userId, String openTime, String closeTime, String hourId, BuildContext context, String token) {
    emit(state.copyWith(isProfileUpdatingg: true));

    repository.editBusinessProfileHour(userId, openTime, closeTime, hourId).then((response) {
      var dec = json.decode(response.body);
      if (dec['message'] == "Business hours updated successfully.") {
        Fluttertoast.showToast(msg: "Business hours updated successfully.");
        fetchMyBusinessProfile(userId, token);
        emit(state.copyWith(isProfileUpdatingg: false));
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: "Something Went Wrong Try again!");
        emit(state.copyWith(isProfileUpdatingg: false));
      }
    });
  }

  fetchOtherBusinessProfile(String userId, String token, String otherId) {
    repository.fetchOtherBusinessProfile(userId, token, otherId).then((reponse) {
      print(reponse.body);
      var data = businessProfileModelFromJson(reponse.body);
      emit(state.copyWith(otherBusinessProfilee: data.data));
    });
     fetchBusinessRating(userId, token,otherId);
  }

  updateRating(double val) {
    print(val);
    emit(state.copyWith(businessRatingValuee: val));
  }

  updateRatingFeedBack(String val) {
    emit(state.copyWith(businessRatingFeedBackk: val));
  }

  fetchMusic() {
    repository.fetchMusic().then((response) {
      print(response.body);
      var data = musicModelFromJson(response.body);
      emit(state.copyWith(musicTrackk: data.tracks));
    });
  }

  fetchBusinessRating(String userId, String token, String bussId) {
    repository.fetchBusinessRating(userId, token, bussId).then((response) {
      print("HelloMyBusinessRating ${response.body}");
      var data = fetchBusinesRatingModelFromJson(response.body);
      emit(state.copyWith(businessRatingg: data.data));
    });
  }

  setOrderLatLong(LatLng lat) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat.latitude, lat.longitude);
    print(placemarks);
    var address = "${placemarks[0].street},${placemarks[0].locality} ${placemarks[0].administrativeArea} ${placemarks[0].country}";
    emit(state.copyWith(orderLatt: lat.latitude, orderLongg: lat.longitude, orderAddresss: address, orderStreett: placemarks[0].street, orderCityy: placemarks[0].locality, orderProvincee: "${placemarks[0].administrativeArea} ${placemarks[0].country}"));
  }

  setAddress(String address) {
    emit(state.copyWith(orderAddresss: address));
  }

  addOrder(String productId, String businessId, String userId, String token, String orderCost, BuildContext context, String productName) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return const AlertDialog(
            content: CupertinoActivityIndicator(),
          );
        });
    Map<String, dynamic> map = {
      'businessId': businessId,
      'userId': userId,
      'productId': productId,
      'orderCost': orderCost,
      'shippingCost': '',
      'shippingAddress': state.orderAddress,
      'token': token,
    };
    businessToolRepository.addOrder(map).then((response) {
      Navigator.pop(context);
      var de = json.decode(response.body);
      print("reesss  ${response.body}");
      if (de['message'] == 'Data successfuly save') {
        registerBloc.pushNotification(userId, token, businessId, "5", "Congrats! you got new order", "$productName ${state.orderAddress}", "5");
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavBar()), (route) => false);
        Future.delayed(Duration(seconds: 1), () {
          nextScreen(context, MyOrdersUser());
        });
      }
    });
  }

  fetchMyOrderUser(String userId, String token) {
    repository.fetchMyOrdersUser(userId, token).then((response) {
      print(response.body);
      var data = userOrdersModelFromJson(response.body);
      emit(state.copyWith(userOrderr: data.data));
    });
  }

  fetchMyLocationSharing(String userId, String token, bool myLocationToOthers) {
    Map<String, dynamic> map = {
      'userId': userId,
      'requestType': myLocationToOthers ? '1' : '0',
      'token': token,
    };
    repository.callPostApiCI(map, fetchMyLocationSharingtoOtherUrl).then((response) {
      print(response.body);
      var data = locationSharToOtherModelFromJson(response.body);
      if (myLocationToOthers) {
        emit(state.copyWith(locationshareToOtherss: data.data));
      } else {
        emit(state.copyWith(locationshareToMee: data.data));
      }
    });
  }

  setIsMapMoving(bool val) {
    emit(state.copyWith(isMapMovingg: val));
  }

  getBusinessProfileImage(bool isCover, bool isCamera) async {
    XFile? image = await ImagePicker().pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);

    final bytes = (await image?.readAsBytes())?.lengthInBytes;
    final kb = bytes! / 1024;
    final mb = kb / 1024;

    if (mb > 4) {
      Fluttertoast.showToast(msg: "Image size can't be more then 4 mb");
    } else {
      if (image != null) {
        cropBusinessProfile(isCover, File(image.path));
      }
    }

    /* if (image != null) {
      cropBusinessProfile(isCover, File(image.path));
    }*/
  }

  Future<void> cropBusinessProfile(bool isCover, File file) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(sourcePath: file.path, aspectRatioPresets: [CropAspectRatioPreset.square, CropAspectRatioPreset.ratio3x2, CropAspectRatioPreset.original, CropAspectRatioPreset.ratio4x3, CropAspectRatioPreset.ratio16x9], cropStyle: isCover ? CropStyle.rectangle : CropStyle.circle);
    if (croppedFile != null) {
      if (isCover) {
        emit(state.copyWith(coverUpdatedImageBusinesss: File(croppedFile.path)));
      } else {
        emit(state.copyWith(profileUpdatedImageBusinesss: File(croppedFile.path)));
      }
    }
  }

  cancelUserOrder(String userId, String token, String orderId, BuildContext context) {
    emit(state.copyWith(isLoadingg: true));
    Map<String, dynamic> body = {
      'userId': userId,
      'token': token,
      'orderId': orderId,
      'status': '3',
    };
    repository.callPostApi(body, cancelOrderUrl).then((response) {
      emit(state.copyWith(isLoadingg: false));
      var de = json.decode(response.body);
      print(response.body);
      if (de['message'] == "Order status updated successfully") {
        Fluttertoast.showToast(msg: "Order Cancelled");
        Navigator.pop(context);
        fetchMyOrderUser(userId, token);
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  List<PaymentCard> card = [];

  fetchPaymentCard(String userId, String token) {
    repository.callGetApi({'token': token, 'userId': userId}, "$fetchCardsUrl$userId").then((response) {
      print(response.body);
      var data = fetchCardModelFromJson(response.body);
      card = data.data;
      if (card.isNotEmpty) {
        card[0].isSelected = true;
        emit(state.copyWith(paymentCardss: card));
        print(state.paymentCards![0].isSelected);
      }
    });
  }

  selectPaymenCard(int ind) {
    print(card[ind].isSelected);
    print(card[ind].isSelected);
    for (var i in card) {
      i.isSelected = false;
    }
    card[ind].isSelected = true;
    emit(state.copyWith(paymentCardss: card));
  }

  addCard(String cardNo, String cardName, String cvc, String expiry, String userId, String token, BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return const AlertDialog(
            content: CupertinoActivityIndicator(),
          );
        });
    print(expiry.substring(0, 2));
    print(expiry.substring(3, 5));
    Map<String, dynamic> body = {
      'card_no': cardNo,
      'expiry_month': expiry.substring(0, 2),
      'cvv': cvc,
      'userId': userId,
      'card_holder_name': cardName,
      'expiry_year': "20${expiry.substring(3, 5)}",
      'token': token,
    };
    repository.callPostApi(body, addCardUrl).then((response) {
      Navigator.pop(context);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Card Added Successfull");
      fetchPaymentCard(userId, token);
    });
  }

  fetchJobs(String userId, String token) {
    repository.callPostApiCI({'userId': userId, 'token': token, 'totalPerPage': '20', 'startFrom': '0'}, fetchJobsUrl).then((value) {
      print(value.body);
      var data = fetchJobsModelFromJson(value.body);
      emit(state.copyWith(jobss: data.data));
    });
  }

  fetchAlbums(String userId, String token) {
    repository.callPostApiCI({
      'userId': userId,
      'token': token,
    }, fetchAlbumUrl).then((value) {
      print(value.body);
      var da = fetchPhotoAlbumFromJson(value.body);
      emit(state.copyWith(photAlbumm: da.data));
    });
  }

  fetchAlbumsImages(String userId, String token, String id) {
    repository.callPostApiCI({'userId': userId, 'token': token, 'albumId': id}, fetchAlbumImagesUrl).then((value) {
      print(value.body);
      var data = fetchAlbumImagesFromJson(value.body);
      emit(state.copyWith(imageAlbumm: data.data));
      // var da = fetchPhotoAlbumFromJson(value.body);
      // emit(state.copyWith(photAlbumm: da.data));
    });
  }

  createAlbum(String userId, String token, String name, BuildContext context) {
    emit(state.copyWith(isLoadingg: true));
    repository.callPostApiCI({'userId': userId, 'token': token, 'albumName': name}, addAlbumUrl).then((value) {
      print(value.body);
      emit(state.copyWith(isLoadingg: false));
      // Navigator.pop(context);
      var de = json.decode(value.body);
      if (de['message'] == "Data successfuly save") {
        Fluttertoast.showToast(msg: "Album created successfully");
        fetchAlbums(userId, token);
      } else {
        Fluttertoast.showToast(msg: "Something went wrong try again");
      }
    });
  }

  addImagesInAlbum(String userId, String token, String albumbId, BuildContext context, String imageId) {
    emit(state.copyWith(isLoadingg: true));
    repository.callPostApiCI({'userId': userId, 'token': token, 'albumId': albumbId, 'imageId': imageId}, addAlbumUrl).then((value) {
      print(value.body);
      emit(state.copyWith(isLoadingg: false));
      // Navigator.pop(context);
      var de = json.decode(value.body);
      if (de['message'] == "Data successfuly save") {
        Fluttertoast.showToast(msg: "Album created successfully");
        fetchAlbums(userId, token);
      } else {
        Fluttertoast.showToast(msg: "Something went wrong try again");
      }
    });
  }

  updateOccupation(String userId, String token, Map<String, dynamic> body, BuildContext context, String occupationId) {
    print("HelloAddOccupationData===> " + json.encode(body));
    String finalUpdateOccupationUrl = "$updateOccupationUrl/$occupationId";
    repository.callPostApiCI(body, finalUpdateOccupationUrl).then((value) {
      print(value.body);
      var de = json.decode(value.body);
      if (de['message'] == 'Occupation updated successfully') {
        Fluttertoast.showToast(msg: "Occupation updated successfully");
        fetchMyPRofile(userId, token);
        fetchOccupationDetail(userId);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  addOcupation(String userId, String token, Map<String, dynamic> body, BuildContext context) {
    print("HelloAddOccupationData===> " + json.encode(body));

    repository.callPostApiCI(body, addOccupationUrl).then((value) {
      var de = json.decode(value.body);
      if (de['message'] == 'Occupations added successfully') {
        fetchMyPRofile(userId, token);
        fetchOccupationDetail(userId);
        Fluttertoast.showToast(msg: "Occupations added successfully");
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  fetchOccupationDetail(String userId) {
    String finalUrl = "$getOccupationUrl/$userId";
    repository.callNewGetApi(finalUrl).then((value) {
      var de = json.decode(value.body);
      var data = occupationDetailModelFromJson(value.body);
      if (de['message'] == 'Occupations fetched successfully') {
        emit(state.copyWith(occupationDetailModell: data));
        // Fluttertoast.showToast(msg: "Occupations fetched successfully");
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  deleteOccupation(String userId, String occupationId, String token) {
    String finalUrl = "$deleteOccupationUrl/$occupationId";

    print("HelloDeletedUser===>" + finalUrl);
    repository.callNewDeleteApi(finalUrl).then((value) {
      var de = json.decode(value.body);
      if (de['message'] == 'Occupation deleted') {
        fetchOccupationDetail(userId);
        fetchMyPRofile(userId, token);
        Fluttertoast.showToast(msg: "Occupation deleted");
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  editEducation(String userId, String token, Map<String, dynamic> body, BuildContext context) {
    repository.callPostApiCI(body, editEducationUrl).then((value) {
      fetchMyPRofile(userId, token);
      var de = json.decode(value.body);
      if (de['message'] == 'Education updated sucessfully') {
        Fluttertoast.showToast(msg: "Education updated Successfully");
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  //This Api is Commented Because this api is not found
  // fetchCard(String userId, String token) {
  //
  //   repository.callGetApiCi({'userId': userId, 'token': token}, fetchCardsUrl).then((value) {
  //     print("cards ${value.body}");
  //     var data = cardDataModelFromJson(value.body);
  //     emit(state.copyWith(cardd: data));
  //   });
  // }

  addImageToAlbum(String userId, String token, String file, String albumId, BuildContext context) {
    showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return const CupertinoAlertDialog(
            content: CupertinoActivityIndicator(),
          );
        });
    repository.uploadAlbumImage(token, userId, file, albumId).then((value) {
      Navigator.pop(context);
      Navigator.pop(context);
      print("cards ${value.body}");
    });
  }

  fetchAlbumImage(
    String albumId,
  ) {
    repository.callGetApiCi({'albumId': albumId}, fetchAlbumImagesUrl).then((value) {
      print(value.body);
    });
  }

  addFavMusic(
    String userId,
    String token,
    String musicId,
  ) {
    repository.callPostApiCI({
      'musicId': musicId,
      'userId': userId,
      'token': token,
    }, addFavMusicUrl).then((value) {
      print(value.body);
      fetchFavMusic(userId, token);
      Fluttertoast.showToast(msg: "Music Added to favorite");
    });
  }

  fetchFavMusic(
    String userId,
    String token,
  ) {
    repository.callPostApiCI({'userId': userId, 'token': token}, fetchFavMusicUrl).then((value) {
      print("fetch music Fav${value.body} $userId");
      var data = favMusicModelFromJson(value.body);
      emit(state.copyWith(favMusicc: data.data));
    });
  }

  addPlace(String userId, String token, String name, String address) async {
    var request = http.MultipartRequest('POST', Uri.parse(addPlaceUrl));
    request.fields['placeName'] = name;
    request.fields['address'] = address;
    request.fields['longitude'] = "";
    request.fields['latitude'] = "";
    request.fields['userId'] = userId;
    request.headers['userId'] = userId;
    request.headers['token'] = token;

    if (state.addPlaceImages != null) {
      for (var i = 0; i < state.addPlaceImages!.length; i++) {
        var imagee = await http.MultipartFile.fromPath('imageUrl[]', state.addPlaceImages![i].path);
        request.files.add(imagee);
      }
    }
    http.Response response = await http.Response.fromStream(await request.send());
    fetchPlace(userId, token);
    print(response.body);
  }

  fetchPlace(String userId, String token) {
    repository.callPostApiCI({'userId': userId, 'token': token}, fetchPlacesUrl).then((value) {
      print(value.body);
      var data = fetchPlacesFromJson(value.body);
      emit(state.copyWith(placess: data.data));
    });
  }

  fetchCoins(String userId, String token) {
    repository.callPostApiCI({'userId': userId, 'token': token}, fetchCoinUrl).then((value) {
      print(value.body);
      var data = coinsModelFromJson(value.body);
      emit(state.copyWith(usersCoinss: data));
    });
  }

  fetchFollowerFollowingList(String userId, String token, String where, bool isMyProfile) {
    //Commneted Becouse api not working
    /* repository.callPostApiCI({
      'userId': userId,
      'token': token,
      'where': '1',
    }, fetchFollowFollowingList).then((value) {
      print(value.body);

      var data = fetchFollowFollowingListFromJson(value.body);

      if (isMyProfile) {
        emit(state.copyWith(myFollowListt: data.data));
      } else {
        emit(state.copyWith(otherFollowListt: data.data));
      }
    });
    repository.callPostApiCI({
      'userId': userId,
      'token': token,
      'where': '2',
    }, fetchFollowFollowingList).then((value) {
      print(value.body);
      var data = fetchFollowFollowingListFromJson(value.body);
      if (isMyProfile) {
        emit(state.copyWith(myFollowingListt: data.data));
      } else {
        emit(state.copyWith(otherFollowingListt: data.data));
      }
    });
    repository.callPostApiCI({
      'userId': userId,
      'token': token,
      'where': '3',
    }, fetchFollowFollowingList).then((value) {
      print(value.body);
      var data = fetchFollowFollowingListFromJson(value.body);
      if (isMyProfile) {
      myFriendsList
        emit(state.copyWith(myFriendListt: data.data));
      } else {
        emit(state.copyWith(otherFriendListt: data.data));
      }
    });*/
  }

  List<TextCompletionData> messages = [];

  var statee = ApiState.notFound;

  getTextCompletion(String query) async {
    addMyMessage(query);

    print(query);
    statee = ApiState.loading;

    try {
      Map<String, String> rowParams = {
        "model": "text-davinci-003",
        "prompt": query,
      };

      final encodedParams = json.encode(rowParams);

      final response = await http.post(
        Uri.parse(endPoint("completions")),
        body: encodedParams,
        headers: headerBearerOption(OPEN_AI_KEY),
      );
      print("Response  body     ${response.body}");
      if (response.statusCode == 200) {
        // messages =
        //     TextCompletionModel.fromJson(json.decode(response.body)).choices;
        //
        addServerMessage(TextCompletionModel.fromJson(json.decode(response.body)).choices);
        statee = ApiState.success;
        emit(state.copyWith(stateee: ApiState.success));
      } else {
        // throw ServerException(message: "Image Generation Server Exception");
        statee = ApiState.error;
        emit(state.copyWith(stateee: ApiState.error));
      }
    } catch (e) {
      print("Errorrrrrrrrrrrrrrr  ");
    } finally {
      // searchTextController.clear();
      // update();
    }
  }

  addServerMessage(List<TextCompletionData> choices) {
    for (int i = 0; i < choices.length; i++) {
      messages.insert(i, choices[i]);
      emit(state.copyWith(messagesss: messages));
    }
  }

  addMyMessage(String messageee) {
    // {"text":":\n\nWell, there are a few things that you can do to increase","index":0,"logprobs":null,"finish_reason":"length"}
    TextCompletionData text = TextCompletionData(text: messageee, index: -999999, finish_reason: "");
    messages.insert(0, text);
    emit(state.copyWith(messagesss: messages));
  }

  createAlbumApi(String userId, String albumName, String token, BuildContext context) {
    repository.createAlbumApi(userId, albumName, token).then((response) {
      var dec = json.decode(response.body);
      if (dec['message'] == "Data successfuly save") {
        Fluttertoast.showToast(msg: "Profile Image Updated");
        emit(state.copyWith(isProfileUpdatingg: false));
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: "Something Went Wrong Try again!");
      }
    });
  }

  TextEditingController searchTextController = TextEditingController();

  addLikeDislike(String userId, String token, String postId, int index, String reciverID) {
    if (state.allMyPosts![index].isLiked == true) {
      state.allMyPosts![index].isLiked = false;
      state.allMyPosts![index].totalLike = (int.parse(state.allMyPosts![index].totalLike) - 1).toString();
    } else {
      state.allMyPosts![index].isLiked = true;
      state.allMyPosts![index].totalLike = (int.parse(state.allMyPosts![index].totalLike) + 1).toString();
      // authBloc.pushNotification(userId, token, reciverID, "2", "liked your post", "${DateTime.now()}", postId);
    }

    emit(state.copyWith(allMyPhotoss: state.allMyPosts));
    repository.addLikeDislike(userId, token, postId, state.allMyPosts![index].postType == 'ad' ? '2' : '1').then((response) {
      print(response.body);
    });
  }

  List<IntrestCategory> inters = [];
  List<IntrestCategory> subIn = [];

  getInterests() {
    repository.getInterests().then((response) {
      final result =  intrestModelFromJson(response.body);
      print(response.body);
      inters = result.data;
      // subIn = result.data;
      print(result.data);
      emit(state.copyWith(intrestt: result.data, subIntres: subIn));
      // print(state.intrest![1].name);
    });
  }

  saveUserIntereseSubCat(String userId,BuildContext context){
    Map<String,dynamic> data = {};
    int i = 0;
    subCatId.forEach((element) {
      String interestSubCategoryId = "${element}";
      data['interestSubCategoryId[$i]'] = interestSubCategoryId.toString();
      i++;
    });
    data['userId'] = userId;
    print("HelloSendData===>  ${json.encode(data)}");
    repository.addSubInterestCat(data).then((value){
      var deco = json.decode(value.body);
      var message = deco['message'];
      if (message == "Data successfuly save") {
        Fluttertoast.showToast(msg: "Interest Saved Successfully");
        fetchInterests(userId);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
      }
    });
    print(data);
  }



  List<String> subCatId = [];
  List<String> isInterseSelect = [];
  List tempList = [];

  onIntrestSelect(int i) {
    inters[i].isSelect = !inters[i].isSelect;
    emit(state.copyWith(subIntres: subIn));
    for(var i in inters){
      if(i.isSelect == true){
        tempList.add(1);
      }else{
        // print("false");
        tempList.clear();
      }
    }
  }

  onSubIntSelect(int i, int j) {
    inters[i].intrestSubCategory[j].isSelect = !inters[i].intrestSubCategory[j].isSelect;
    subCatId.add(inters[i].intrestSubCategory[j].interestSubCategoryId);
    print("HelloTitle"+inters[i].intrestSubCategory[j].interestSubCategoryTitle);
    emit(state.copyWith(intrestt: inters));
  }
}
