import 'package:flutter/material.dart';
import 'package:happiverse/utils/utils.dart';
import 'package:happiverse/views/components/universal_card.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class InviteFriends extends StatefulWidget {
  const InviteFriends({Key? key}) : super(key: key);

  @override
  State<InviteFriends> createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {

  void launchMethod(String url)async{
    try {
      bool launched = await launch(url, forceSafariVC: false);

      if (!launched) {
        await launch(url, forceSafariVC: false);
      }
    } catch (e) {
      await launch(url, forceSafariVC: false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invite Friends"),
      ),
      body: UniversalCard(
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Invite Friends on social platfroms"),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                launchMethod(Utils.facebookLink);
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xff3b5998),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(LineIcons.facebook,color: Colors.white,),
                    SizedBox(width: 5,),
                    Text("Facebook",style: TextStyle(color: Colors.white,fontSize: 18),)
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                launchMethod(Utils.instagramLink);
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Color(0xffd62976),
                    borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff405DE6),
                      Color(0xff5851DB),
                      Color(0xff833AB4),
                      Color(0xffC13584),
                      Color(0xffE1306C),
                      Color(0xffF77737),
                      Color(0xffFCAF45),
                      // Color(0xffFFDC80),
                    ]
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(LineIcons.instagram,color: Colors.white,),
                    SizedBox(width: 5,),
                    Text("Instagram",style: TextStyle(color: Colors.white,fontSize: 18),)
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                launchMethod(Utils.twitterLink);
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Color(0xff1DA1F2),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(LineIcons.twitter,color: Colors.white,),
                    SizedBox(width: 5,),
                    Text("Twitter",style: TextStyle(color: Colors.white,fontSize: 18),)
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                launchMethod(Utils.tiktokLink);
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network("https://seeklogo.com/images/T/tiktok-logo-1F4A5DCD45-seeklogo.com.png",height: 30,),
                    SizedBox(width: 5,),
                    Text("Tiktok",style: TextStyle(color: Colors.white,fontSize: 18),)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
