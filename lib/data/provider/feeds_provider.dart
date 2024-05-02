import '../../utils/business_url.dart';
import '../../utils/user_url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../utils/utils.dart';
class FeedsProvider{

  Future<http.Response> sendFriendRequest(Map<String,Object> body,String accesToken)async{
    http.Response response = await http.post(
        Uri.parse(friendRequestURL),
        body: json.encode(body),
        headers: {
          'Token': Utils.token,
          'Content-Type':'application/json',
          'Authorization' : accesToken
        }
    );
    return response;
  }

  Future<http.Response> searchUser(String keyWord,String userId,String token)async{
    String uri = searchUSersUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'keyword':keyWord,
          'userId':userId,
        },
        headers: {
          // 'token': token,
          'userId': userId,
        }
    );
    return res;
  }

  Future<http.Response> searchBusiness(String keyWord,String distance,String lat,String long,String token,String userId)async{
    String uri = searchBusinessUl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'keyWord':keyWord,
          'distance':distance,
          'latitude':lat,
          'longitude':long,
        },
        headers: {
          'token': token,
          'userId': userId,
        }
    );
    return res;
  }

  Future<http.Response> fetchFeedsPosts(String userId,String token,String limit,String startFrom,String lat,String long)async{
    String uri = feedsPostsUrl;

    print("HelloMyPost===> "+feedsPostsUrl);
    print("HelloMyPost===> "+userId);
    print("HelloMyPost===> "+limit);
    print("HelloMyPost===> "+startFrom);
    print("HelloMyPost===> "+lat);
    print("HelloMyPost===> "+long);
    print("HelloMyPost===> "+token);

    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId':userId,
          'limit':limit,
          'startFrom':startFrom,
          'latitude':lat,
          'longitude': long,
        },
        headers: {
          // 'token': token,
          'userId': userId,
        }
    );

    return res;
  }

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

  Future<http.Response> addStoryComment(String userId,String token,String storyId,String comment)async{
    print("HelloCommentApiCalled===> "+addCommentUrl);
    print("HelloCommentApiCalled===> "+userId);
    print("HelloCommentApiCalled===> "+comment);
    print("HelloCommentApiCalled===> "+storyId);

    String uri = addCommentUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId':userId,
          'postId': storyId,
          'comment':comment
        },
        headers: {
          'token': token,
          'userId': userId,
        }
    );
    return res;
  }

  Future<http.Response> addPostComment(String userId,String token,String postId,String comment)async{
    String uri = addCommentUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId':userId,
          'postId': postId,
          'comment':comment
        },
        headers: {
          'token': token,
          'userId': userId,
        }
    );
    return res;
  }

  Future<http.Response> fetchStory(String userId,String token)async{
    print("fetch other sotry user id $userId");
    print("fetch other sotry toekn id $token");
    String uri = fetchStoryUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId':userId,
        },
        headers: {
          // 'token': token,
          'userId': userId,
        }
    );
    return res;
  }
  Future<http.Response> fetchMyStory(String userId,String token)async{

    print("Fetch My Story===> "+fetchMyStoryUrl);
    print("Fetch My Story===> "+userId);

    String uri = fetchMyStoryUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId':userId,
        },
        headers: {
          // 'token': token,
          'userId': userId,
        }
    );
    return res;
  }

  Future<http.Response> fetchFeedsComment(String userId,String token,String postId)async{
    print("helloPostId "+postId);
    print("helloPostId "+userId);
    String uri = fetchPostCommentUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'postId':postId,
        },
        headers: {
          'token': token,
          'userId': userId,
        }
    );
    return res;
  }

  Future<http.Response> deletePostComment(String userId,String token,String commentId)async{
    String uri = deletePostCommentUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'postCommentId':commentId,
          'userId':userId
        },
        headers: {
          'token': token,
          'userId': userId,
        }
    );
    return res;
  }

  Future<http.Response> fetchSuggestedFriends(String userId,String token,String lat,String lng)async{
    String uri = suggestedFriendsUrl;

    print("HelloSuggestedFriend=====> "+ userId);
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId':userId,
          'latitude':lat,
          'longitude':lng,
        },
        headers: {
          // 'token': token,
          'userId': userId,
        }
    );
    return res;
  }

  Future<http.Response> callPostApi(Map<String,dynamic> map,String url)async{
    http.Response res = await http.post(
        Uri.parse(url),
        body: map,
        headers: {
          'userId': map['userId'],
          'token': map['token'],
        }
    );
    return res;
  }
  Future<http.Response> callGetApi(String url)async{
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        "apikey":"b141b340-233a-11ee-a189-1b06d6860708"
      }
    );
    return response;
  }
}