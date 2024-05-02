import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happiverse/data/model/story_id.dart';
import 'package:happiverse/utils/user_url.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/model/feeds_post_model.dart';
import '../../data/model/fetch_my_story_model.dart';
import '../../data/model/image_search_model.dart';
import '../../data/model/post_comment_model.dart';
import '../../data/model/search_business_model.dart';
import '../../data/model/suggested_friend_model.dart';
import '../../data/model/video_play_model.dart';
import '../../data/repository/feeds_repository.dart';
import '../../logic/profile/profile_cubit.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_view/story_view.dart';
import 'package:translator/translator.dart';
import '../../data/model/search_user_model.dart';
import '../../data/model/story_api_model.dart';
import '../../data/model/story_model.dart';
import 'package:http/http.dart' as http;

import '../../views/feeds/image_search.dart';

part 'feeds_state.dart';

class FeedsCubit extends Cubit<FeedsState> {
  FeedsCubit() : super(FeedsState(searchController: searchController, isSearching: false, isStoryLoading: true, temperaryCommentList: [], searchText: ""));

  static TextEditingController searchController = TextEditingController();

  final repository = FeedsRepository();

  sendFriendRequest(String userId, String targetID, String token) {
    Map<String, Object> map = {"userId": userId, "friendRequestById": targetID, "active": true, "id": 0};
    repository.sendFriendRequest(map, token).then((response) {
      print(response.body);
    });
  }

  final translator = GoogleTranslator();

  String? languageCode;

  getSharedLanguageCode() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    var cLan = pre.getInt('language');
    if (cLan == 0) {
      languageCode = 'en';
    } else if (cLan == 1) {
      languageCode = 'zh';
    } else if (cLan == 2) {
      languageCode = 'ar';
    } else if (cLan == 3) {
      languageCode = 'ur';
    } else if (cLan == 4) {
      languageCode = 'hi';
    } else if (cLan == 5) {
      languageCode = 'es';
    }
  }

  translateText(String text) {
    print(text);
    try {
      translator.translate(text, to: languageCode!).then((translated) {
        print(translated);
        emit(state.copyWith(translatedTextt: translated.text, searchControllerr: TextEditingController(text: text)));
      });
    } catch (e) {
      print(e);
    }
  }

  assignSearchText(String searchVal) {
    print("assign called");
    searchController = TextEditingController(text: searchVal);
    print(searchController.text);
    emit(state.copyWith(searchControllerr: searchController));
    emit(state.copyWith(searchTextt: searchVal));
  }

  assignSearchNull() {
    emit(state.copyWith(searchTextt: "", searchControllerr: TextEditingController(text: "")));
  }

  addSearchText(String val) {
    emit(state.copyWith(searchTextt: val, searchControllerr: TextEditingController(text: val)));
  }

  searchUser(String userId, String token) {
    emit(state.copyWith(isSearchingg: true));
    repository.searchUser(state.searchController.text, userId, token).then((response) {
      print("search response === ${response.body}");
      var data = searchUserModelFromJson(response.body);
      emit(state.copyWith(searchedUsersListt: data.data, isSearchingg: false));
      // emit(state.copyWith(searchTextt: searchVal));
    });
  }

  String lat = '';
  String long = '';

  getLocation() async {
    await Geolocator.requestPermission();
    Geolocator.checkPermission().then((value) {
      print("perssmsmmsmsmsm ${value.name}");
      if(value.name == "deniedForever"){
        Geolocator.openLocationSettings();
      }
    });
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high,timeLimit:Duration(seconds: 3) ).then((value) {
      lat = value.latitude.toString();
      long = value.longitude.toString();
      // Fluttertoast.showToast(msg: lat+"====="+long);
      // print("helloLatLong===> "+lat);
      // print("helloLatLong===> "+long);
    },onError: (error){
      // Fluttertoast.showToast(msg: error.toString());
    });

  }

//Commented Becouse thi code not working sometime
/*  getLocation() async {
    print("Hello Lat Long1===>");
    if (await Permission.location.isDenied || await Permission.location.isRestricted) {
      Permission.location;
      Geolocator.requestPermission();
      Geolocator.getCurrentPosition().then((value) {
        lat = value.latitude.toString();
        long = value.longitude.toString();
        print("Hello Lat Long2===> $long $lat");
      });
    } else {
      Permission.location;
      Geolocator.requestPermission();
      Geolocator.getCurrentPosition().then((value) {
        lat = value.latitude.toString();
        long = value.longitude.toString();
        print("Hello Lat Long3===> $long $lat");
      });
    }
  }*/

  searchBusiness(String userId, String token) {
    getLocation();
    emit(state.copyWith(isSearchingg: true));
    repository
        .searchBusiness(
      state.searchController.text,
      '',
      '',
      '',
      token,
      userId,
    )
        .then((response) {
      print(response.body);
      var data = searchBusinessModelFromJson(response.body);
      print(data.data);
      emit(state.copyWith(searchedBusinesss: data.data, isSearchingg: false));
      // emit(state.copyWith(searchTextt: searchVal));
    });
  }

  List<FeedsPosts>? feedsPosttt = [];
  List<VideoPlayModel> videoPlayControllers = [];

  Future<void> fetchFeedsPosts(String userId, String token, String limit, String startFrom) async {

    if(startFrom == '0'){
      feedsPosttt?.clear();
      videoPlayControllers.clear();
    }

    repository.fetchFeedsPost(userId, token, limit, startFrom, lat.toString(), long.toString()).then((response) {
      print("post Feed Data ${response.body}");
      var data = feedsPostsModelFromJson(response.body);
      feedsPosttt = feedsPosttt! + data.data;
      print("Manish============== ${feedsPosttt?.length}");
      emit(state.copyWith(feedsPostt: feedsPosttt, videoListt: videoPlayControllers));
      // initStories();
    });
  }

  final authBloc = RegisterCubit();
  final profileC = ProfileCubit();

  addLikeDislike(String userId, String token, String postId, int index, String reciverID) {
    if (feedsPosttt![index].isLiked == true) {
      feedsPosttt![index].isLiked = false;
      feedsPosttt![index].totalLike = (int.parse(feedsPosttt![index].totalLike!) - 1).toString();
    } else {
      feedsPosttt![index].isLiked = true;
      feedsPosttt![index].totalLike = (int.parse(feedsPosttt![index].totalLike!) + 1).toString();
      authBloc.pushNotification(userId, token, reciverID, "2", "liked your post", "${DateTime.now()}", postId);
    }
    emit(state.copyWith(feedsPostt: feedsPosttt));
    repository.addLikeDislike(userId, token, postId, feedsPosttt![index].postType == 'ad' ? '2' : '1').then((response) {
      print(response.body);
      profileC.fetchAllMyPosts(token,userId);
    });
  }

  addMyLikePost(
    String userId,
    String token,
    String postId,
  ) {
    repository.addLikeDislike(userId, token, postId, '1').then((response) {
      print(response.body);
    });
  }

  hidePost(int index) {
    feedsPosttt!.removeAt(index);
    Fluttertoast.showToast(msg: "Post Hided");
    emit(state.copyWith(feedsPostt: feedsPosttt));
  }

  static List<Color> pageColors = [Colors.redAccent, Colors.green, Colors.brown, Colors.purpleAccent, Colors.deepPurpleAccent];

  Color getTextColor(int textIndex) {
    switch (textIndex) {
      case 0:
        return Colors.redAccent;
      case 1:
        return Colors.green;
      case 2:
        return Colors.brown;
      case 3:
        return Colors.purpleAccent;
      default:
        return Colors.deepPurpleAccent;
    }
  }

  TextStyle getFontFamily(int index) {
    switch (index) {
      case 0:
        return GoogleFonts.montserrat(fontSize: 30, color: Colors.white);
      case 1:
        return GoogleFonts.quintessential(fontSize: 30, color: Colors.white);
      case 2:
        return GoogleFonts.playfairDisplay(fontSize: 30, color: Colors.white);
      case 3:
        return GoogleFonts.nunitoSans(fontSize: 30, color: Colors.white);
      case 4:
        return GoogleFonts.zenKakuGothicAntique(fontSize: 30, color: Colors.white);
      case 5:
        return GoogleFonts.josefinSans(fontSize: 30, color: Colors.white);
      default:
        return GoogleFonts.montserrat(fontSize: 30, color: Colors.white);
    }
  }

  List<StoryAPI> storyApiList = [];

  fetchStory(String userId, String token) {
    print("Fetch Story Api");
    repository.fetchStory(userId, token).then((response) {
      var de = json.decode(response.body);
      print("other story  -------------- ${response.body}");
      if (de['message'] == 'Data not availabe') {
        storyApiList = [];
        emit(state.copyWith(storyApiListt: [], isStoryLoadingg: false));
      } else {
        var data = storyApiModelFromJson(response.body);
        storyApiList = data.data;
        emit(state.copyWith(storyApiListt: data.data, isStoryLoadingg: false));
        initStories();
      }
    });
  }

  FetchMyStory? myStory;

  fetchMyStory(String userId, String token) {
    emit(state.copyWith(myStoryy: null));
    myStory = null;
    repository.fetchMyStory(userId, token).then((response) {
      print("Fetching Story Again");
      var de = json.decode(response.body);
      print("Fetching Story Again ${response.body}");
      if (de['message'] == "Data not availabe") {
        myStory = null;
        emit(state.copyWith(myStoryy: null));
        initMyStory();
      } else {
        var data = fetchMyStoryModelFromJson(response.body);
        myStory = data.data;
        emit(state.copyWith(myStoryy: data.data));
        initMyStory();
      }
    });
  }

  List<StoryModel> storyList = [];
  List<StoryItem> storyItem = [];
  List<StoryIdModel> storyIdModel = [];
  StoryController controller = StoryController();

  initStories() {
    storyList.clear();
    storyItem.clear();
    storyIdModel.clear();
    for (int i = 0; i < storyApiList.length; i++) {
      print("Uper Lenght ${storyApiList.length}");
      storyItem = [];
      for (int j = 0; j < storyApiList[i].storyItem.length; j++) {
        print("filee lemggth ${storyApiList[i].storyItem.length}");
        storyIdModel.add(StoryIdModel(index: i, storyId: storyApiList[i].storyItem[j].postId!));
        storyItem.add(
          storyApiList[i].storyItem[j].postType! == 'text'
              ? StoryItem.text(textStyle: getFontFamily(int.parse(storyApiList[i].storyItem[j].fontColor.toString())), backgroundColor: getTextColor(int.parse(storyApiList[i].storyItem[j].textBackGround.toString())), title: storyApiList[i].storyItem[j].caption!)
              : storyApiList[i].storyItem[j].postType! == 'image'
                  ? StoryItem.pageImage(url: storyApiList[i].storyItem[j].postFiles!.isEmpty ? "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg" : "${Utils.baseImageUrl}${storyApiList[i].storyItem[j].postFiles![0].postFileUrl}", controller: controller, caption: Text("${storyApiList[i].storyItem[j].caption}"))
                  : storyApiList[i].storyItem[j].postType! == 'video'
                      ? StoryItem.pageVideo("${storyApiList[i].storyItem[j].postFiles![0].postFileUrl}", controller: controller, caption: Text("${storyApiList[i].storyItem[j].caption}"))
                      : StoryItem.pageImage(url: "${storyApiList[i].storyItem[j].postFiles![0].postFileUrl}", controller: controller, caption: Text("${storyApiList[i].storyItem[j].caption}")),
        );
      }
      storyList.add(StoryModel(
        storyIdModel: storyIdModel,
        controller: controller,
        storyItem: storyItem,
        profileImage: "${storyApiList[i].profileImageUrl}",
        date: Jiffy(storyApiList[i].storyItem[0].postedDate, "MM dd, yyyy at hh:mm a").fromNow().toString(),
        title: storyApiList[i].userName,
      ));
      emit(state.copyWith(storylistt: storyList));
      print(storyList[0].storyItem.length);
    }
  }

  final List<StoryModel> myStoryList = [];
  final List<StoryItem> myStoryItem = [];
  final List<StoryIdModel> myStoryIdModel = [];
  StoryController myController = StoryController();

  initMyStory() {
    myStoryList.clear();
    myStoryItem.clear();
    myStoryIdModel.clear();
    emit(state.copyWith(myStoryShoww: []));

    if(myStory != null){
      for (var i = 0; i < myStory!.storyItem.length; i++) {
        print("My Story Length ${myStory!.storyItem.length}");



        myStoryIdModel.add(StoryIdModel(index: i, storyId: myStory!.storyItem[i].postId!));
        myStoryItem.add(
          myStory!.storyItem[i].postType! == 'text'
              ? StoryItem.text(
              textStyle: getFontFamily(
                int.parse(myStory!.storyItem[i].fontColor == null || myStory!.storyItem[i].fontColor == "" ? "0" : myStory!.storyItem[i].fontColor!),
              ),
              backgroundColor: getTextColor(int.parse(myStory!.storyItem[i].textBackGround.toString())),
              title: myStory!.storyItem[i].caption ?? "")
              : myStory!.storyItem[i].postType! == 'video'
              ? StoryItem.pageVideo("${myStory?.storyItem[i].postFiles?[0].postFileUrl}", controller: myController)
              : myStory!.storyItem[i].postType! == 'image'
              ? StoryItem.pageImage(url: "${myStory?.storyItem[i].postFiles?[0].postFileUrl}", controller: myController)
              : StoryItem.text(textStyle: getFontFamily(int.parse(myStory!.storyItem[i].fontColor.toString()),),
              backgroundColor: getTextColor(int.parse(myStory!.storyItem[i].textBackGround.toString())),
              title: myStory!.storyItem[i].caption!),
        );
      }
      print("MY story item ${myStory!.profileImageUrl}");
      print("MY story item ${myStoryItem.length}");
      // print(myStory!.storyItem[storyItem.length].postedDate);
      myStoryList.add(StoryModel(
        storyIdModel: myStoryIdModel,
        controller: myController,
        storyItem: myStoryItem,
        profileImage: myStory!.profileImageUrl,
        title: myStory!.userName,
        // date: '3.',
        date: Jiffy(myStory!.storyItem[0].postedDate, "MM dd, yyyy at hh:mm a").fromNow().toString(),
      ));
      emit(state.copyWith(myStoryShoww: myStoryList));



      print("HelloMYStory==>  ${myStoryList}");

    }
  }

  fetchFeedsComments(String userId, String token, String postId) {
    repository.fetchFeedsComment(userId, token, postId).then((response) {
      print(response.body);
      var data = postCommentModelFromJson(response.body);
      emit(state.copyWith(postCommentMapp: data.data));
    });
  }

  List temperaryMessageList = [];

  addPostComment(
    String userId,
    String token,
    String postId,
    String message,
    String reciverID,
  ) {
    // temperaryMessageList.add(message);
    // emit(state.copyWith(temperaryCommentListt: temperaryMessageList));
    repository.addPostComment(userId, token, postId, message).then((response) {
      print(response.body);


      fetchFeedsComments(userId, token, postId);
      authBloc.pushNotification(userId, token, reciverID, likeNotificationID, "commented on your post", "${DateTime.now()}", postId);
    });
  }

  unfollow(int ind, String userName) {
    feedsPosttt![ind].isFriend = 'default';
    emit(state.copyWith(feedsPostt: feedsPosttt));
    Fluttertoast.showToast(msg: "You Unfollow $userName");
  }

  deleteComment(String userId, String token, String commentID, String postId) {
    repository.deleteComment(userId, token, commentID).then((value) {
      print(value.body);
      fetchFeedsComments(userId, token, postId);
      Fluttertoast.showToast(msg: "Comment Deleted");
    });
  }

  List<SuggestedFriends> suggestedFriends = [];

  fetchSuggestedFriends(String userId, String token) async {
    // await getLocation();
    //
    // String lattitude =  lat.toString().isNotEmpty ? lat.toString() : '30.6762084' ;
    // String longitude = long.toString().isNotEmpty ? long.toString() : '76.7404683';

    repository.fetchSuggestedFriends(userId, token, '30.6762084','76.7404683').then((response) {
      print(response.body);
      print("HelloSuggestedFriend ${response.body}");
      // Fluttertoast.showToast(msg: response.body);
      var data = suggestedFriendModelFromJson(response.body);
      suggestedFriends = data.data;
      emit(state.copyWith(sugeestedFriendss: suggestedFriends));
    });
  }

  removeFriendSuggestion(int index) {
    suggestedFriends[index].isDeleted = !suggestedFriends[index].isDeleted;
    emit(state.copyWith(sugeestedFriendss: suggestedFriends));
  }

  followUnfollowFriendSuggestion(int index) {
    suggestedFriends[index].isFollowed = !suggestedFriends[index].isFollowed;
    emit(state.copyWith(sugeestedFriendss: suggestedFriends));
  }

  addViewAd(String userId, String adId, String token, bool isClick) {
    Geolocator.getCurrentPosition().then((value) {
      Map<String, dynamic> body = {
        'latitude': value.latitude.toString(),
        'longitude': value.longitude.toString(),
        'isClick': isClick ? '1' : '0',
        'deviceType': 'Mobile',
        'adsId': adId,
        'userId': userId,
        'token': token,
      };
      repository.callPostApi(body, addViewAdUrl).then((value) {
        print("ad response ${value.body}");
      });
    });
  }

  searchImage(int source, String userId, String token, BuildContext context) async {
    XFile? image = await ImagePicker().pickImage(source: source == 1 ? ImageSource.camera : ImageSource.gallery);
    emit(state.copyWith(imageSearchResultt: null, isSearchingg: true));
    if (image != null) {
      var url = Uri.parse("${Utils.baseUrl}user/ImageUpload/"); // Replace with your API endpoint
      var request = http.MultipartRequest('POST', url);

      // Attach the image file to the request
      request.files.add(
        await http.MultipartFile.fromPath('image', image.path),
      );

      // var response = await request.send();
      http.Response response = await http.Response.fromStream(await request.send());
      print(response.body);
      // var jsonResponse = await response.stream.bytesToString();
      var data = jsonDecode(response.body);
      print(data);
      String imageUrl = data['image_path'];

      nextScreen(
          context,
          ImageSearchUsers(
            path: image.path,
          ));
      print("${Utils.baseImageUrl}ci_api/user_search_image/${imageUrl}");
      repository.callGetApi("https://app.zenserp.com/api/v2/search?q=face&image_url=${Utils.baseImageUrl}ci_api/user_search_image/${imageUrl}").then((value) {
        print(value.body);
        var data = imageSearchModelFromJson(value.body);
        emit(state.copyWith(imageSearchResultt: data, isSearchingg: false));
      });
    }
  }

  void resetToDefault() {
    feedsPosttt?.clear();
    videoPlayControllers.clear();
  }
}
