import 'dart:convert';
import 'dart:io';

import '../../utils/business_url.dart';
import '../../utils/user_url.dart';
import '../../utils/utils.dart';
import 'package:http/http.dart' as http;

class ProfileProvider{

  Future<http.Response> addLikeDislike(String userId,String token,String postId,String type)async{
    String uri = addLikeDislikeUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId':userId,
          'postId': postId,
          'likeType': type,
        },
        headers: {
          'token': token,
          'userId': userId,
        }
    );
    return res;
  }


  Future<http.Response> getMyProfile(String userID,String token)async{
    String uri = getProfileURL;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'myId': userID,
          'userId': userID,
        },
        headers: {
          // 'token': token,
          'userId': userID,
        }
    );
    return res;
  }

  Future<http.Response> getOtherProfile(String myUserId,String userId,String token)async{

    print("HelloUserData====> " + userId);
    print("HelloUserData====> " + getProfileURL);
    print("HelloUserData====> " + myUserId);
    String uri = getProfileURL;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId': userId,
          'myId':myUserId,
        },
        headers: {
          'token': token,
          'userId': myUserId,
        }
    );
    return res;
  }

  Future<http.Response> getOtherAllPosts(String myUserId,String userId,String token)async{
    String uri = getMyAllPostsUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId': userId,
        },
        headers: {
          // 'token': token,
          'userId': myUserId,
        }
    );
    return res;
  }

  Future<http.Response> addFollower(String myUserId,String followerId,String token)async{
    print("HelloAdFollower===> "+addFollowerUrl);
    print("HelloAdFollower===> "+followerId);
    print("HelloAdFollower===> "+myUserId);


    String uri = addFollowerUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId':followerId ,
          'followerId': myUserId,
        },
        headers: {
          'token': token,
          'userId': myUserId,
        }
    );
    return res;
  }

  Future<http.Response> fetchMyPosts(String myUserId,String token)async{
    String uri = getMyAllPostsUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId': myUserId,
        },
        headers: {
          // 'token': token,
          'userId': myUserId,
        }
    );
    return res;
  }

  Future<http.Response> fetchUserInterest(String userId)async{

    print("HelloFetchInterest=====>  "+fetchUserSavedInterest);
    print("HelloFetchInterest=====>  "+userId);


    String uri = fetchUserSavedInterest;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId': userId,
        },
        headers: {
          // 'token': token,
          'userId': userId,
        }
    );
    return res;
  }

  Future<http.Response> deleteUserSavedInterest(String mstUserInterestId)async{
    print("HelloFetchInterest=====>  "+deleteUserSavedInterestUrl);
    print("HelloFetchInterest=====>  "+mstUserInterestId);

    String uri  = "${deleteUserSavedInterestUrl}/${mstUserInterestId}";
    http.Response res = await http.delete(Uri.parse(uri),);
    return res;
  }









  Future<http.Response> getFriendList(String userID,String accesToken)async{
    String uri = "$getFriendListUrl?Userid=$userID";
    http.Response response = await http.get(
        Uri.parse(uri),
        headers: {
          'Token': Utils.token,
          'Content-Type':'application/json',
          'Authorization' : accesToken
        }
    );
    return response;
  }



  Future<http.Response> editProfileInfo(Map<String,String> map,String userId,String token)async{
    String uri = updateMyProfileUrl;
    print("HelloUrl===> $updateMyProfileUrl");
    http.Response res = await http.post(
        Uri.parse(uri),
        body: map,
        headers: {
          'token': token,
          'userId': userId,
        }
    );
    return res;
  }

  Future<http.Response> getMyFriends(String userID,String token)async{
    String uri = fetchFriendUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId': userID,
        },
        headers: {
          // 'token': token,
          'userId': userID,
        }
    );
    return res;
  }

  Future<http.Response> getStealthStatus(String userID,String token,bool isBusiness)async{
    String uri = getStealthStatusUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId': userID,
        },
        headers: {
          'token': token,
          'userId': userID,
        }
    );
    return res;
  }

  Future<http.Response> addRemoveStealthStatus(String userID,String token,bool isRemove,bool isBusiness,String duration)async{
    String uri = addRemoveAccountStealthUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId': userID,
          'isStealth': isRemove ? '0':'1',
          'stealthDuration': duration,
          'accountType': isBusiness ? '2':'1',
        },
        headers: {
          'token': token,
          'userId': userID,
        }
    );
    return res;
  }

  Future<http.Response> requestLocation(Map<String,dynamic> map)async{
    String uri = requestLocationUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId': map['requesterId'],
          'requesterId': map['userId'],
          'locationType': map['locationType'],
          'status': map['status'],
        },
        headers: {
          'token': map['token'],
          'userId': map['userId'],
        }
    );
    return res;
  }

  Future<http.Response> fetchOtherFriend(String userID,String token,String otherId)async{
    String uri = fetchFriendUrl;

    print("HelloFetchFrieds==> "+fetchFriendUrl);
    print("HelloFetchFrieds==> "+otherId);

    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId': otherId,
        },
        headers: {
          // 'token': token,
          'userId': userID,
        }
    );
    return res;
  }

  Future<http.Response> fetchLocationRequests(String userID,String token,String type)async{
    String uri = fetchLocationRequestUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId': userID,
          'requestType': type,
        },
        headers: {
          'token': token,
          'userId': userID,
        }
    );
    return res;
  }

  Future<http.Response> deleteLocationRequest(String userID,String token,String requestId)async{
    String uri = deleteLocationRequestUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'requestId': requestId,
        },
        headers: {
          'token': token,
          'userId': userID,
        }
    );
    return res;
  }

  Future<http.Response> rejectLocationRequest(String userID,String token,String requestId)async{
    String uri = rejectLocationRequestUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId': userID,
          'requestId': requestId,
          'status': 'rejected',
        },
        headers: {
          'token': token,
          'userId': userID,
        }
    );
    return res;
  }

  Future<http.Response> acceptLocationRequest(String userID,String token,Map<String,dynamic> map)async{
    String uri = acceptLocationRequestUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId': userID,
          'requestId': map['requestId'],
          'status': 'accepted',
          'lat': map['lat'],
          'long': map['long'],
          'address': map['address'],
        },
        headers: {
          'token': token,
          'userId': userID,
        }
    );
    return res;
  }


  Future<http.Response> fetchCovidRecord(String userID,String token)async{
    String uri = getHealthRecordUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId': userID,
        },
        headers: {
          // 'token': token,
          'userId': userID,
        }
    );
    return res;
  }

  Future<http.Response> addCovidRecord(Map<String,dynamic> map,String userID,String token)async{
    String uri = addHealthRecordUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: map,
        headers: {
          'token': token,
          'userId': userID,
        }
    );
    return res;
  }


  // <============== business APIs Start here ===============>

  Future<http.Response> fetchMyBusinessProfile(String userID,String token)async{
    String uri = fetchBusinessProfileUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId': userID,
        },
        headers: {
          'token': token,
          'userId': userID,
        }
    );
    return res;
  }


  Future<http.Response> editProfileImage(String userId,File image,String token)async{
    print("HelloProfileUpdateUrl===>  "+updateMyProfileUrl);
    print("HelloProfileUpdateUrl===>  "+image.path);
    print("HelloProfileUpdateUrl===>  "+userId);

    var request =  http.MultipartRequest('POST',Uri.parse(updateMyProfileUrl));
    var imagee = await http.MultipartFile.fromPath('profileImageUrl', image.path);
    request.fields['userId'] = userId;
    request.files.add(imagee);
    request.headers['userId'] = userId;
    // request.headers['token'] = token;
    http.Response response = await http.Response.fromStream(await request.send());
    return response;
  }


  Future<http.Response> editBusinessProfileImage(String userId,File cover,File profile,String token)async{
      var request =  http.MultipartRequest('POST',Uri.parse(editBusinessProfileImageUrl));
      if(cover.path.toString().isNotEmpty){
        var imagee1 = await http.MultipartFile.fromPath('featureImageUrl', cover.path);
        request.files.add(imagee1);
      }
      if(profile.path.toString().isNotEmpty){
        var imagee2 = await http.MultipartFile.fromPath('logoImageUrl', profile.path);
        request.files.add(imagee2);
      }

      request.fields['businessId'] = userId;
      // request.headers['userId'] = userId;
      // request.headers['token'] = token;
      http.Response response = await http.Response.fromStream(await request.send());
      return response;

  }

  Future<http.Response> editBusinessProfileInfo(String userId,String businessName,String ownerName,String contact)async{
    print("Hello==>   "+editBusinessProfileInfoUrl);
    String uri = editBusinessProfileInfoUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'businessId': userId,
          'businessName': businessName,
          'ownerName':ownerName,
          'businessContact':contact
        },
        headers: {
          // 'token': token,
          // 'userId': userID,
        }
    );
    return res;
  }


  Future<http.Response> editBusinessProfileHour(String userId,String openTime,String closeTime,String hourId)async{
    print("HelloeditBusinessProfileInfoUrl==>   "+editBusinessProfileHourUrl);
    print("HelloeditBusinessProfileInfoUrl==>   "+userId);
    print("HelloeditBusinessProfileInfoUrl==>   "+openTime);
    print("HelloeditBusinessProfileInfoUrl==>   "+closeTime);
    print("HelloeditBusinessProfileInfoUrl==>   "+hourId);
    String uri = editBusinessProfileHourUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'businessId': userId,
          'openTime': openTime,
          'closeTime':closeTime,
          'hoursId':hourId
        },
        headers: {
          // 'token': token,
          // 'userId': userID,
        }
    );
    return res;
  }





  Future<http.Response> fetchOtherBusinessProfile(String userID,String token,String myUserId)async{
    String uri = fetchBusinessProfileUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId': userID,
          'myId': myUserId,
        },
        headers: {
          'token': token,
          'userId': userID,
        }
    );
    return res;
  }

  Future<http.Response> fetchMusic()async{
    String uri = fetchMusicUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
    );
    return res;
  }

  Future<http.Response> fetchBusinessRating(String userID,String token,String businesSID)async{
    // print("HelloMyBusinessRating  " +fetchBusinessRatingUrl);
    // print("HelloMyBusinessRating  " +businesSID);
    // print("HelloMyBusinessRating  " +userID);

    String uri = fetchBusinessRatingUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId': userID,
        },
        headers: {
          // 'token': token,
          'userId': businesSID,
        }
    );
    return res;
  }

  Future<http.Response> addRating(String userID,String token,String rating,String comment)async{
    String uri = fetchBusinessRatingUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId': userID,
        },
        headers: {
          // 'token': token,
          'userId': userID,
        }
    );
    return res;
  }

  Future<http.Response> fetchMyOrderUser(String userID,String token)async{
    String uri = fetchMyOrderUserUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId': userID,
        },
        headers: {
          // 'token': token,
          'userId': userID,
        }
    );
    return res;
  }

  Future<http.Response> callPostApi(Map<String,dynamic> map,String url)async{
    http.Response res = await http.post(
        Uri.parse(url),
        body: map,
        headers: {
          'Authorization': "Bearer ${map['token']}",
        }
    );
    return res;
  }

  Future<http.Response> callPostApiCI(Map<String,dynamic> map,String url)async{

    print("Hello API Called====>  "+url);
    print("Hello API Called====> "+json.encode(map));

    http.Response res = await http.post(
        Uri.parse(url),
        body: map,
        headers: {
          'userId': map['userId'],
          // 'token': map['token'],
        }
    );
    return res;
  }


  Future<http.Response> callNewGetApi(String url)async{
    print("HelloApiUrl===> "+url);

    http.Response res = await http.get(
        Uri.parse(url),
        headers: {

        }
    );
    return res;
  }



  Future<http.Response> callGetApi(Map<String,dynamic> map,String url)async{
    print("HelloApiUrl===> "+url);
    print("HelloApiUrl===> "+json.encode(map));

    http.Response res = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': ""
              " ${map['token']}",
        }
    );
    return res;
  }

  Future<http.Response> callGetApiCi(Map<String,dynamic> map,String url)async{

    http.Response res = await http.get(
        Uri.parse(url),
        headers: {
          'userId': map['userId'],
          'token': map['token'],
        }
    );
    return res;
  }

  Future<http.Response> callDeleteApi(Map<String,dynamic> map,String url)async{
    http.Response res = await http.delete(
        Uri.parse(url),
        body: map,
        headers: {
          'Authorization': "Bearer ${map['token']}",
        }
    );
    return res;
  }

  Future<http.Response> callNewDeleteApi(String url)async{


    http.Response res = await http.delete(
        Uri.parse(url),
    );
    return res;
  }


  Future<http.Response> uploadAlumbImage(
      String accesToken,
      String userID,
      String file,
      String almumId,
      ) async {
    var request = http.MultipartRequest('POST', Uri.parse(addAlbumImageUrl));
    request.fields['userId'] = userID;
    request.fields['albumId'] = almumId;
    print(file);
    print(almumId);
    var multipartFile =
    await http.MultipartFile.fromPath("imageUrl", file);
    request.files.add(multipartFile);
    request.headers['userId'] = userID;
    // request.headers['token'] = accesToken;
    http.Response response =
    await http.Response.fromStream(await request.send());
    print(response.body);
    return response;
  }


  Future<http.Response> createAlbumApi(String userId,String albumName,String token)async{
    print("HelloProfileUpdateUrl===>  "+createAlbum);
    var request =  http.MultipartRequest('POST',Uri.parse(createAlbum));
    request.fields['userId'] = userId;
    request.fields['album_name'] = albumName;
    request.headers['userId'] = userId;
    request.headers['token'] = token;

    http.Response response = await http.Response.fromStream(await request.send());
    return response;
  }


  Future<http.Response> fetchAlbumApi(String userId,String token) async {
    // Construct the URL with query parameters
    var url = Uri.parse('$fetchAlbum?userId=$userId');
    // Send the GET request with headers
    http.Response response = await http.get(
      url,
      headers: {
        'userId': userId,
        'token': token,
      },
    );

    return response;
  }


  Future<http.Response> fetchAlbumPhotoApi(String userId,String albumId,String token) async {
    // Construct the URL with query parameters
    var url = Uri.parse('$fetchAlbumPhotoUrl?userId=$userId&albumId=$albumId');
    // Send the GET request with headers
    http.Response response = await http.get(
      url,
      headers: {
        'userId': userId,
        'token': token,
      },
    );

    return response;
  }


  Future<http.Response> getCategory() async {
    http.Response response = await http.post(Uri.parse(getInterestUrl));
    return response;
  }

  Future<http.Response> addSubCatInterest(Map<String, dynamic> map) async {
    http.Response response = await http.post(Uri.parse(addSubCatURl), body: map);
    return response;
  }

}