import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:line_icons/line_icons.dart';
import 'package:twitter_login/twitter_login.dart';
class Influencer extends StatefulWidget {
  const Influencer({Key? key}) : super(key: key);

  @override
  State<Influencer> createState() => _InfluencerState();
}

class _InfluencerState extends State<Influencer> {

  Future signInWithTwitter() async {
    // Create a TwitterLogin instance
    final twitterLogin =  TwitterLogin(
        apiKey: 'Ol3bWHIKhhMrMoikknwd2a5QT',
        apiSecretKey: 'HMeyWXAPIdo1pRP7yr2hjbiUOylASFQnmvLEXbbSxtCS3DfF1N',
        redirectURI: 'https://condotwits-9207b.firebaseapp.com/__/auth/handler'
    );

    // Trigger the sign-in flow
    final authResult = await twitterLogin.loginV2();

    print(authResult.user!.email);
    print(authResult.user!.id);
  }

  // Future signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   // FacebookAuth.instance.logOut();
  //   try{
  //     final result = await FacebookAuth.i.login(
  //       permissions: ['name','email', 'public_profile', 'user_friends'],
  //     );
  //     if (result.status == LoginStatus.success) {
  //       final userData = await FacebookAuth.i.getUserData(
  //         fields: "name,email,picture.width(200),friends",
  //       );
  //       print(userData);
  //     }
  //   }catch (e){
  //     print("HelloException"+e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Influencer Signup"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Text("Influencer Plans",style: TextStyle(fontSize: 20),),
              ],
            ),
            SizedBox(height: 20,),
            CarouselSlider(
              items: [
                Card(
                  elevation: 30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Gold",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Text("1k to 10k followers",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Platinum",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Text("10k to 100k followers",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Diamond",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Text("100k to 1M followers",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("VIP/Celebrity",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Text("1M to 5M followers",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ], options: CarouselOptions(
                height: 150.0,aspectRatio: 15/9,
                viewportFraction: 0.6,onPageChanged: (i,v){

            },pauseAutoPlayOnTouch: true),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                // signInWithFacebook();
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
                    Text("Connect Facebook",style: TextStyle(color: Colors.white,fontSize: 18),)
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            InkWell(
              onTap: (){
                signInWithTwitter();
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
                    Text("Connect Twitter",style: TextStyle(color: Colors.white,fontSize: 18),)
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
