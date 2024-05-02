import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

import 'package:happiverse/utils/constants.dart';
import 'package:happiverse/views/business_tools/influencers/add_card.dart';

class InfluencersBusiness extends StatefulWidget {
  const InfluencersBusiness({Key? key}) : super(key: key);

  @override
  State<InfluencersBusiness> createState() => _InfluencersBusinessState();
}

class _InfluencersBusinessState extends State<InfluencersBusiness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_backspace,color: Colors.white),
        ),
        title: const Text("Influencers Account",style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CarouselSlider(
              items: [
                Card(
                  elevation: 30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Gold",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10,),
                        const Text("\$10.00 Introductory annual then \$10.00 month",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10,),
                        MaterialButton(
                          color: Colors.blue,
                          shape: const StadiumBorder(),
                          onPressed: (){
                            nextScreen(context, const AddCardBusinessInfluencers());
                          },
                          child: Text("Buy Now"),
                        )
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Platinum",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Text("\$50.00 Introductory annual then \$50.00 month",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        MaterialButton(
                          color: Colors.blue,
                          shape: StadiumBorder(),
                          onPressed: (){
                            nextScreen(context, AddCardBusinessInfluencers());
                          },
                          child: Text("Buy Now"),
                        )
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Diamond",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Text("\$100.00 Introductory annual then \$100.00 month",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        MaterialButton(
                          color: Colors.blue,
                          shape: StadiumBorder(),
                          onPressed: (){
                            nextScreen(context, AddCardBusinessInfluencers());
                          },
                          child: Text("Buy Now"),
                        )
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("VIP/Celebrity",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Text("\$200.00 Introductory annual then \$200.00 month",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        MaterialButton(
                          color: Colors.blue,
                          shape: StadiumBorder(),
                          onPressed: (){
                            nextScreen(context, AddCardBusinessInfluencers());
                          },
                          child: Text("Buy Now"),
                        )
                      ],
                    ),
                  ),
                ),
              ],
              options: CarouselOptions(
                height: 220.0,
                aspectRatio: 15/9,
                viewportFraction: 0.7,
                onPageChanged: (i,v){},
                pauseAutoPlayOnTouch: true,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Influencers List"),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: const [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("https://media.istockphoto.com/id/1338134336/photo/headshot-portrait-african-30s-man-smile-look-at-camera.jpg?b=1&s=170667a&w=0&k=20&c=j-oMdWCMLx5rIx-_W33o3q3aW9CiAWEvv9XrJQ3fTMU="),
                    ),
                    title: Text("Andy Denal"),
                    subtitle: Text("100k Followers"),
                    trailing: Text("Gold"),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("https://www.goodmorningimagesdownload.com/wp-content/uploads/2021/12/Best-Quality-Profile-Images-Pic-Download-2023.jpg"),
                    ),
                    title: Text("Will Pryor"),
                    subtitle: Text("290k Followers"),
                    trailing: Text("Platinum"),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("https://media.licdn.com/dms/image/D4D08AQE0CXu4hnoe7g/croft-frontend-shrinkToFit1024/0/1646754728586?e=2147483647&v=beta&t=ADkOVwOwmP-4rCH4y0g2_OBFlsszl01TpQPhCgt5SSc"),
                    ),
                    title: Text("Jake Bobs"),
                    subtitle: Text("120k Followers"),
                    trailing: Text("Gold"),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("https://expertphotography.b-cdn.net/wp-content/uploads/2018/10/cool-profile-pictures-retouching-1.jpg"),
                    ),
                    title: Text("Laura Addi"),
                    subtitle: Text("3M Followers"),
                    trailing: Text("VIP/Celebrity"),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("https://expertphotography.b-cdn.net/wp-content/uploads/2020/08/social-media-profile-photos-3.jpg"),
                    ),
                    title: Text("Adam D."),
                    subtitle: Text("557k Followers"),
                    trailing: Text("Diamond"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
