import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../../logic/profile/profile_cubit.dart';
import '../../utils/constants.dart';
import '../../views/components/universal_card.dart';
import '../../views/plans/business_components/global_plan_widget.dart';
import '../../views/plans/business_components/local_plan_widget.dart';
import '../../views/plans/business_components/national_plan_widget.dart';
import '../../views/plans/business_components/regional_plan_widget.dart';
import '../../views/plans/plans_checkout.dart';
import '../../views/plans/user_components/diamond_plan_widget.dart';
import '../../views/plans/user_components/gold_plan_widget.dart';
import '../../views/plans/user_components/platinum_plan_widget.dart';
import '../../views/plans/user_components/vip_plan_widget.dart';

import '../../utils/utils.dart';

class UserPlans extends StatefulWidget {
  const UserPlans({Key? key}) : super(key: key);

  @override
  _UserPlansState createState() => _UserPlansState();
}

class _UserPlansState extends State<UserPlans> {
  int currentIndex = 0;
  bool restored = false;


  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  static final String platinum = 'platinum_plan';
  static final String diamond = 'diamond_plan';
  static final String vipcelebrity = 'vip_plan';
  static final String localplan = 'local_plan';
  static final String regional = 'regional_plan';
  static final String national = 'national_plan';
  static final String global = 'global_plan';

  bool _available = true;
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];

  List<String> _plansList = [
    platinum,
    diamond,
    vipcelebrity,
    localplan,
    regional,
    national,
    global
  ];
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  subscription()async{
    print("Called");
    try{
      final Stream<List<PurchaseDetails>> purchaseUpdated =
          _inAppPurchase.purchaseStream;

      _subscription = purchaseUpdated.listen((purchaseDetailsList) async{
        print(purchaseDetailsList[0].productID);
        setState(() {
          _purchases.addAll(purchaseDetailsList);
          print(_purchases);
          _listenToPurchaseUpdated(purchaseDetailsList);
        });
        ProductDetailsResponse response =
        await _inAppPurchase.queryProductDetails(Set<String>.from(
          _plansList,
        ));
        response.productDetails.map((e){
          print(e.title);
        });
        for (var _purchaseDetails in _purchases) {
          if (_purchaseDetails.pendingCompletePurchase) {
            await _inAppPurchase.completePurchase(_purchaseDetails);
          }
        }
        print("response sss ${response.productDetails}");
        print("sdfdfsfsdfdsfds ${response.error}");
        print("sdfdfsf ${response.productDetails}");
        print("sdfdfsf ${response.error}");
      }, onDone: () async{
        _subscription!.cancel();
        print("Done baba ji");
        ProductDetailsResponse response =
        await _inAppPurchase.queryProductDetails(Set<String>.from(
          _plansList,
        ));
        print("response sss ${response.productDetails}");
        print("sdfdfsfsdfdsfds ${response.error}");
        for(var i in response.productDetails){
          print("sdfdfsf ${i.price} ${i.title}");
        }
        print("sdfdfsf ${response.error}");
      }, onError: (error) {
        print("Error  baba ji ${error}");
        _subscription!.cancel();
      });
    }catch (e){
      print("Error Payment $e");
    }
    ProductDetailsResponse response =
    await _inAppPurchase.queryProductDetails( Set<String>.from(
      _plansList,
    ));
    print("response sss ${response.productDetails}");
    print("sdfdfsfsdfdsfds ${response.error}");
    print("sdfdfsf ${response.productDetails}");
    print("sdfdfsf ${response.error}");
    _initialize();
  }

  void _initialize() async {
    _available = await _inAppPurchase.isAvailable();
    List<ProductDetails> products = await _getProducts(
      productIds: Set<String>.from(
        _plansList,
      ),
    );

    setState(() {
      for(var p in products){
        print(p.title);
        print(p.id);
      }
      _products.addAll(products);
      print("producs $products");
    });

    // showModalBottomSheet(context: context, builder: (c){
    //   return Material(
    //     child: _available
    //         ? SizedBox(
    //       height: getHeight(context) / 1.2,
    //           child: Column(
    //       children: [
    //           Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Text('Current Products ${_products.length}'),
    //               SizedBox(
    //                 height: 200,
    //                 child: ListView.builder(
    //                   shrinkWrap: true,
    //                   itemCount: _products.length,
    //                   itemBuilder: (context, index) {
    //                     return _buildProduct(
    //                       product: _products[index],
    //                     );
    //                   },
    //                 ),
    //               ),
    //             ],
    //           ),
    //           Column(
    //             // mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Text('Past Purchases: ${_purchases.length}'),
    //               SizedBox(
    //                 height: 200,
    //                 child: ListView.builder(
    //                   shrinkWrap: true,
    //                   itemCount: _purchases.length,
    //                   itemBuilder: (context, index) {
    //                     return _buildPurchase(
    //                       purchase: _purchases[index],
    //                     );
    //                   },
    //                 ),
    //               ),
    //             ],
    //           ),
    //       ],
    //     ),
    //     )
    //         : const Center(
    //       child: Text('The Store Is Not Available'),
    //     ),
    //   );
    // });
  }
  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      print("Purchase Details ${purchaseDetails}");
      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
        //  _showPendingUI();
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
        // bool valid = await _verifyPurchase(purchaseDetails);
        // if (!valid) {
        //   _handleInvalidPurchase(purchaseDetails);
        // }
          break;
        case PurchaseStatus.error:
          print(purchaseDetails.error!);
          // _handleError(purchaseDetails.error!);
          break;
        default:
          break;
      }
      if (purchaseDetails.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchaseDetails);
      }
    });
  }

  Future<List<ProductDetails>> _getProducts(
      {required Set<String> productIds}) async {
    ProductDetailsResponse response =
    await _inAppPurchase.queryProductDetails(productIds);

    return response.productDetails;
  }


  void _subscribe(String planId,bool isBusiness,{required ProductDetails product}) async{
    showCupertinoDialog(context: context,barrierDismissible: false, builder: (context){
      return CupertinoAlertDialog(
        title: Text("Please wait while its processing"),
        content: CupertinoActivityIndicator(),
      );
    });
    final pro = context.read<RegisterCubit>();
    try{

      final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
      _inAppPurchase.buyNonConsumable(
        purchaseParam: purchaseParam,
      );
      _inAppPurchase.purchaseStream.listen((event) {
        print("purchase status ${event[0].status}");
        if(event[0].status == PurchaseStatus.purchased){
          print(event[0].transactionDate);
          print("purhcase id ${event[0].purchaseID}");
          print("Done");
          // Navigator.pop(context);
          pro.addUserPlanSignUp(planId,context,isBusiness);
        }else if(event[0].status == PurchaseStatus.canceled){
          Navigator.pop(context);
          showCupertinoDialog(context: context,barrierDismissible: false, builder: (context){
            return CupertinoAlertDialog(
              title: Text("Payment Error"),
              content: Text("Please Purchase plan to continue"),
              actions: [
                CupertinoDialogAction(child: Text("Back"),onPressed: ()=> Navigator.pop(context),)
              ],
            );
          });
        }
      });
    }catch (e){
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    subscription();
  }
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: const Icon(Icons.keyboard_backspace_sharp,color: Colors.white)),
            title: const Text("Upgrade Hapiverse",style: TextStyle(color: Colors.white),),
          ),
          body: UniversalCard(
            widget: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage("${state.profileImage}"),
                        ),
                      ),
                      SizedBox(width: 20,),
                      restored ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Current Plan"),
                          Text("${bloc.planID == 8 ? "VIP/Celebrity for \$29.99/Month" : bloc.planID == 7 ? "Diamond for \$19.99/Month" :bloc.planID == 6 ? "Platinum for \$5.99/Month" : "Gold/Basic for Free"}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                        ],
                      ):Container()
                    ],
                  ),
                  SizedBox(height: 20,),
                  CupertinoButton(
                    child: Text("Restore Purchase"),
                    onPressed: (){
                      showDialog(context: context, builder: (context){
                        return CupertinoAlertDialog(
                          title: Text("Checking Past Purchase"),
                          content: CupertinoActivityIndicator(),
                        );
                      });
                      print("PLAN");
                      Future.delayed(Duration(seconds: 3),(){
                        Navigator.pop(context);
                        setState(() {
                          restored = true;
                        });
                        // Phoenix.rebirth(context);
                        showDialog(context: context, builder: (context){
                          return CupertinoAlertDialog(
                            title: Text("Purchase Restore found"),
                            content: Text("Plan Name ${bloc.planID == 8 ? "VIP/Celebrity for \$29.99/Month" : bloc.planID == 7 ? "Diamond for \$19.99/Month" :bloc.planID == 6 ? "Platinum for \$5.99/Month" : "Gold/Basic for Free"}. Plan Restored Successfully"),
                            actions: [
                              CupertinoDialogAction(child: Text("Back"),onPressed: ()=> Navigator.pop(context),)
                            ],
                          );
                        });
                      });
                    },
                    color: Colors.red,
                  ),
                  SizedBox(height: 20,),
                  Text("Or Upgrade your subscription plan",style: TextStyle(fontSize: 20),),
                  SizedBox(height: 20,),
                  CarouselSlider(
                    items: [
                      // GoldUserPlanWidget(button: ()=>nextScreen(context, PlansCheckOut(amount: '0',))),
                      PlatinumPlanWidget(button: (){
                        if(Platform.isIOS){
                          showDialog(context: context, builder: (context){
                            return CupertinoAlertDialog(
                              title: Text("Upgrading Subscription Plan"),
                              content: Text("You are currently subscribed to ${bloc.planID == 8 ? "VIP/Celebrity for \$29.99/Month" : bloc.planID == 7 ? "Diamond for \$19.99/Month" :bloc.planID == 6 ? "Platinum for \$5.99/Month" : "Gold/Basic for Free"}. your subscription plan will be replaced. Do you want to replace?"),
                              actions: [
                                CupertinoDialogAction(child: Text("No"),onPressed: ()=> Navigator.pop(context),),
                                CupertinoDialogAction(child: Text("Upgrade"),onPressed: (){
                                  _subscribe('6',false,product: _products[4]);
                                },),
                              ],
                            );
                          });
                        }else{
                          nextScreen(context, PlansCheckOut(amount: '5.99',planId: '6',));
                        }

                      }),
                      DiamondUserPlanWidget(button: (){
                        if(Platform.isIOS){
                          showDialog(context: context, builder: (context){
                            return CupertinoAlertDialog(
                              title: Text("Upgrading Subscription Plan"),
                              content: Text("You are currently subscribed to ${bloc.planID == 8 ? "VIP/Celebrity for \$29.99/Month" : bloc.planID == 7 ? "Diamond for \$19.99/Month" :bloc.planID == 6 ? "Platinum for \$5.99/Month" : "Gold/Basic for Free"}. your subscription plan will be replaced. Do you want to replace?"),
                              actions: [
                                CupertinoDialogAction(child: Text("No"),onPressed: ()=> Navigator.pop(context),),
                                CupertinoDialogAction(child: Text("Upgrade"),onPressed: (){
                                  _subscribe('7',false,product: _products[0]);
                                },),
                              ],
                            );
                          });
                        }else{
                          nextScreen(context, PlansCheckOut(amount: '19.99',planId: '7',));
                        }

                      }),
                      VipUserPlanWidget(button: (){
                        if(Platform.isIOS){
                          showDialog(context: context, builder: (context){
                            return CupertinoAlertDialog(
                              title: Text("Upgrading Subscription Plan"),
                              content: Text("You are currently subscribed to ${bloc.planID == 8 ? "VIP/Celebrity for \$29.99/Month" : bloc.planID == 7 ? "Diamond for \$19.99/Month" :bloc.planID == 6 ? "Platinum for \$5.99/Month" : "Gold/Basic for Free"}. your subscription plan will be replaced. Do you want to replace?"),
                              actions: [
                                CupertinoDialogAction(child: Text("No"),onPressed: ()=> Navigator.pop(context),),
                                CupertinoDialogAction(child: Text("Upgrade"),onPressed: (){
                                  _subscribe('8',false,product: _products[6]);
                                },),
                              ],
                            );
                          });
                        }else{
                          nextScreen(context, PlansCheckOut(amount: '29.99',planId: '8',));
                        }
                      }),
                    ], options: CarouselOptions(
                      height: 400.0,aspectRatio: 16/9,
                      viewportFraction: 1.0,onPageChanged: (i,v){
                    setState(() {
                      currentIndex = i;
                    });
                  },pauseAutoPlayOnTouch: true),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.circle,size: currentIndex == 0 ? 15 : 10,color: currentIndex == 0 ? Colors.black : Colors.grey,),
                      SizedBox(width: 5,),
                      Icon(Icons.circle,size: currentIndex == 1 ? 15 : 10,color: currentIndex == 1 ? Colors.black :Colors.grey,),
                      SizedBox(width: 5,),
                      Icon(Icons.circle,size: currentIndex == 2 ? 15 : 10,color: currentIndex == 2 ? Colors.black :Colors.grey,),
                      SizedBox(width: 5,),
                      Icon(Icons.circle,size: currentIndex == 3 ? 15 : 10,color: currentIndex == 3 ? Colors.black :Colors.grey,),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
