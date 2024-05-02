import 'package:flutter/material.dart';
import 'package:happiverse/views/business_tools/influencers/influencers.dart';
import '../../utils/constants.dart';
import '../../views/business_tools/ads_manager/ads_manager.dart';
import '../../views/business_tools/events/events.dart';
import '../../views/business_tools/orders/orders_dashboard.dart';
import '../../views/business_tools/product_discount/product_discount.dart';
import '../../views/business_tools/product_page.dart';
import '../../views/business_tools/reward_center/reward_center.dart';
import '../../views/components/universal_card.dart';
import 'package:line_icons/line_icons.dart';

class BusinessTools extends StatefulWidget {
  const BusinessTools({Key? key}) : super(key: key);

  @override
  _BusinessToolsState createState() => _BusinessToolsState();
}

class _BusinessToolsState extends State<BusinessTools> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text("Business Tools",style: TextStyle(color: Colors.white),),
      ),
      body: UniversalCard(
        widget: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // height: 100,
                child: ListTile(
                  onTap: (){
                    nextScreen(context, ProductsPage());
                  },
                  leading: Container(
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Center(
                      child: Icon(LineIcons.plusCircle),
                    ),
                  ),
                  title: const Text("Add Products"),
                  dense: true,
                ),
              ),
              const SizedBox(height: 10,),
              ListTile(
                onTap: ()=>nextScreen(context, const BusinessEvents()),
                leading: Container(
                  width: 70,
                  // height: 100,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Center(
                    child: Icon(LineIcons.plusCircle),
                  ),
                ),
                title: const Text("Add Event"),
                dense:true,
              ),
              // SizedBox(height: 10,),
              Container(
                // height: 100,
                child: ListTile(
                  onTap: ()=> nextScreen(context, OrdersDashboard()),
                  leading: Container(
                    width: 70,
                    // height: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Center(
                      child: Icon(LineIcons.boxes,color: Colors.blue,),
                    ),
                  ),
                  title: Text("Orders",style: TextStyle(color: Colors.blue),),
                  subtitle: Text("Track or deliver your orders"),
                  dense:true,
                ),
              ),
              // SizedBox(height: 10,),
              Container(
                // height: 100,
                child: ListTile(
                  onTap: ()=> nextScreen(context, AdsManager()),
                  leading: Container(
                    width: 70,
                    // height: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Center(
                      child: Icon(LineIcons.ad,color: Colors.orange,),
                    ),
                  ),
                  title: Text("Ads Manager",style: TextStyle(),),
                  subtitle: Text("Manage or create your business ads products ads"),
                  dense:true,
                ),
              ),
              SizedBox(height: 10,),
              Container(
                // height: 100,
                child: ListTile(
                  onTap: ()=> nextScreen(context, RewardCenter()),
                  leading: Container(
                    width: 70,
                    // height: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Icon(LineIcons.gift,color: Colors.green,),
                    ),
                  ),
                  title: Text("Reward Center"),
                  subtitle: Text("Give Discount to your customers on diffirent products"),
                  dense:true,
                ),
              ),
              SizedBox(height: 10,),
              Container(
                // height: 100,
                child: ListTile(
                  onTap: ()=> nextScreen(context, ProductDiscount()),
                  leading: Container(
                    width: 70,
                    // height: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Center(
                      child: Icon(LineIcons.tags,color: Colors.orangeAccent,),
                    ),
                  ),
                  title: Text("Product Discount",style: TextStyle(color: Colors.blue),),
                  subtitle: Text("Give Discount to your customers on diffirent products"),
                  dense:true,
                ),
              ),
              SizedBox(height: 10,),
              Container(
                // height: 100,
                child: ListTile(
                  onTap: ()=> nextScreen(context, InfluencersBusiness()),
                  leading: Container(
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Center(
                      child: Icon(LineIcons.infinity,color: Colors.blueAccent,),
                    ),
                  ),
                  title:const Text("Influencers Account",style: TextStyle(color: Colors.black),),
                  subtitle:const Text("Access list of influencers for grow more business."),
                  dense:true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
