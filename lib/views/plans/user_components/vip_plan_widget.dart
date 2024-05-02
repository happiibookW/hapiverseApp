import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
class VipUserPlanWidget extends StatelessWidget {
  final VoidCallback button;
  const VipUserPlanWidget({Key? key,required this.button}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      color: Colors.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Text("Vip/Celebrity Plan",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
            const Text("\$29.99/Year",style: TextStyle(fontSize: 17,color: Colors.white,fontFamily: ""),),
            const SizedBox(height: 20,),
            const Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.circle,size: 6,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Location Based Info's",style: TextStyle(color: Colors.white,fontSize: 11),)),
              ],
            ),
            const SizedBox(height: 6,),
            const Row(
              children: [
                Icon(Icons.circle,size: 6,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Public & Private Groups",style: TextStyle(color: Colors.white,fontSize: 11),)),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.circle,size: 6,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Push Notificaions Alerts",style: TextStyle(color: Colors.white,fontSize: 11),)),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.circle,size: 6,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Multi Language",style: TextStyle(color: Colors.white,fontSize: 11),)),
              ],
            ),
            const SizedBox(height: 10,),
            const Row(
              children: [
                Icon(Icons.circle,size: 6,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Matching Algorithem",style: TextStyle(color: Colors.white,fontSize: 11),)),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.circle,size: 6,color: Colors.white,),
                SizedBox(width: 6,),
                Expanded(child: Text("Video Audio Voice Text Chat",style: TextStyle(color: Colors.white,fontSize: 11),)),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.circle,size: 6,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Profile Avatar",style: TextStyle(color: Colors.white,fontSize: 11),)),
              ],
            ),
            const SizedBox(height: 10,),
            const Row(
              children: [
                Icon(Icons.circle,size: 6,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Rate / Review",style: TextStyle(color: Colors.white,fontSize: 11),)),
              ],
            ),
            const SizedBox(height: 10,),
            const Row(
              children: [
                Icon(Icons.circle,size: 6,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Customer Loyalty Program",style: TextStyle(color: Colors.white,fontSize: 11),)),
              ],
            ),
            const SizedBox(height: 10,),
            const Row(
              children: [
                Icon(Icons.circle,size: 6,color: Colors.white,),
                SizedBox(width: 10,),
                Expanded(child: Text("Photo Album Stealth and ghosting",style: TextStyle(color: Colors.white,fontSize: 11),)),
              ],
            ),
            const Spacer(),
            MaterialButton(
              minWidth: getWidth(context) / 2,
              shape: const StadiumBorder(),
              color: Colors.white,
              onPressed: button,
              child: const Text("Buy Now"),
            ),
          ],
        ),
      ),
    );
  }
}
