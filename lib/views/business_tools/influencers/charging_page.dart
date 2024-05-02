import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:happiverse/utils/constants.dart';
import 'package:happiverse/views/business_bottom.dart';
class ChargingPage extends StatefulWidget {
  const ChargingPage({Key? key}) : super(key: key);

  @override
  State<ChargingPage> createState() => _ChargingPageState();
}

class _ChargingPageState extends State<ChargingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
      nextScreen(context, BusinessBottomBar());
      Fluttertoast.showToast(msg: "Plan Purchased Successfully");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoActivityIndicator(),
            SizedBox(height: 20,),
            Text("Please wait while we charging and redirecting to your plan")
          ],
        ),
      ),
    );
  }
}
