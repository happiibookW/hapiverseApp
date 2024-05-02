import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/views/authentication/payment.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:intl/intl.dart';
import '../../logic/register/register_cubit.dart';
import '../../views/components/universal_card.dart';
import 'package:line_icons/line_icons.dart';
import '../../utils/constants.dart';
import '../plans/business_components/global_plan_widget.dart';
import '../plans/business_components/local_plan_widget.dart';
import '../plans/business_components/national_plan_widget.dart';
import '../plans/business_components/regional_plan_widget.dart';
import '../plans/user_components/diamond_plan_widget.dart';
import '../plans/user_components/platinum_plan_widget.dart';
import '../plans/user_components/vip_plan_widget.dart';

class ChoosePlans extends StatefulWidget {
  @override
 _ChoosePlansState createState() => _ChoosePlansState();
}

class _ChoosePlansState extends State<ChoosePlans> {
  bool isBusiness = false;
  int currentIndex = 0;

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

  isBusinessClicked(){
    setState(() {
      isBusiness = !isBusiness;
    });
  }

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

      }, onDone: () async{
        _subscription!.cancel();
        print("Done baba ji");
        ProductDetailsResponse response =
        await _inAppPurchase.queryProductDetails(Set<String>.from(
          _plansList,
        ));
        print("Subscription products detail ${response.productDetails}");

        for(var i in response.productDetails){
          print("Subscription single product ${i.price} ${i.title}");
        }

        print("Subscription error ${response.error}");
      }, onError: (error) {
        print("Subscription error occur $error");
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

  showPlan(){
    showModalBottomSheet(context: context, builder: (c){
      return Material(
        child: _available
            ? SizedBox(
          height: getHeight(context) / 1.2,
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Current Products ${_products.length}'),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _products.length,
                      itemBuilder: (context, index) {
                        return _buildProduct(
                          product: _products[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Past Purchases: ${_purchases.length}'),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _purchases.length,
                      itemBuilder: (context, index) {
                        return _buildPurchase(
                          purchase: _purchases[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
            : const Center(
          child: Text('The Store Is Not Available'),
        ),
      );
    });
  }

  ListTile _buildProduct({required ProductDetails product}) {
    return ListTile(
      leading: Icon(Icons.attach_money),
      title: Text('${product.title} - ${product.price}'),
      subtitle: Text(product.description),
      trailing: ElevatedButton(
        onPressed: () {
          // _subscribe(product: product);
        },
        child: Text(
          'Subscribe',
        ),
      ),
    );
  }

  ListTile _buildPurchase({required PurchaseDetails purchase}) {
    if (purchase.error != null) {
      return ListTile(
        title: Text('${purchase.error}'),
        subtitle: Text(purchase.status.toString()),
      );
    }

    String? transactionDate;
    if (purchase.status == PurchaseStatus.purchased) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(
        int.parse(purchase.transactionDate!),
      );
      transactionDate = ' @ ' + DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
    }

    return ListTile(
      title: Text('${purchase.productID} ${transactionDate ?? ''}'),
      subtitle: Text(purchase.status.toString()),
    );
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
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text("Choose Plan",style: TextStyle(color: Colors.white)),
      ),
      body: UniversalCard(
        widget: SingleChildScrollView(
          child: Column(
            children: [
              // TextButton(onPressed:()=> showPlan(), child: Text("Show")),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: ()=>isBusinessClicked(),
                    child: Row(
                      children: [
                        Icon(isBusiness == false ? LineIcons.dotCircle : LineIcons.circle),
                        const Text("Individual")
                      ],
                    ),
                  ),
                  const SizedBox(width: 10,),
                  InkWell(
                    onTap: ()=>isBusinessClicked(),
                    child: Row(
                      children: [
                        Icon(isBusiness ? LineIcons.dotCircle : LineIcons.circle),
                        const Text("Business")
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Choose your subscription plan",style: TextStyle(fontSize: 20),),
              const SizedBox(height: 20,),
              isBusiness ? Column(
                children: [
                  CarouselSlider(
                    items: [
                      LocalBusinessPlanWidget(button: (){
                        bloc.isBusinessClicked(true);
                        if(Platform.isIOS){
                          _subscribe('1',true,product: _products[2]);
                        }else{
                          nextScreen(context,SignUpPayment(amount: '100',isBusiness: true,planID: '1',));
                        }

                      }),
                      RegionalBusinessPlanWidget(button: () {
                        // SignUpPayment(amount: '200000',isBusiness: true,);
                        bloc.isBusinessClicked(true);
                        // bloc.addUserPlanSignUp("2");
                        // nextScreen(context, SignUpBusiness());
                        if(Platform.isIOS){
                          _subscribe('2',true,product: _products[5]);
                        }else{
                          nextScreen(context,SignUpPayment(amount: '250',isBusiness: true,planID: '2',));
                        }
                      }),
                      NationalBusinessPlanWidget(button: () {
                        bloc.isBusinessClicked(true);
                        // bloc.addUserPlanSignUp("3");
                        // nextScreen(context, SignUpBusiness());
                        if(Platform.isIOS){
                          _subscribe('3',true,product: _products[3]);
                        }else{
                          nextScreen(context,SignUpPayment(amount: '500',isBusiness: true,planID: '3',));
                        }
                      }),
                      GlobalBusinessPlanWidget(button: () {
                        bloc.isBusinessClicked(true);
                        // bloc.addUserPlanSignUp("4");
                        // nextScreen(context, SignUpBusiness());
                        if(Platform.isIOS){
                          _subscribe('4',true,product: _products[1]);
                        }else{
                          nextScreen(context,SignUpPayment(amount: '1000',isBusiness: true,planID: '4',));
                        }
                      }),
                    ], options: CarouselOptions(
                      height: 400.0,autoPlay: true,aspectRatio: 16/9,
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
              ):
              Column(
                children: [
                  CarouselSlider(
                    items: [
                      // GoldUserPlanWidget(button: ()=>nextScreen(context, PlansCheckOut())),
                      PlatinumPlanWidget(button: (){
                        bloc.isBusinessClicked(false);
                        // bloc.addUserPlanSignUp("6");
                        // nextScreen(context, SignUpUser());
                        if(Platform.isIOS){
                        _subscribe('6',false,product: _products[4]);
                        }else{
                        nextScreen(context, SignUpPayment(amount: '5.99',isBusiness: false,planID: '6',));
                        }
                        // nextScreen(context, SignUpUser());
                      }),
                      DiamondUserPlanWidget(button: () {
                        bloc.isBusinessClicked(false);
                        // bloc.addUserPlanSignUp("29.99");
                        if(Platform.isIOS){
                          // for(var i in _products){
                          //   if(i.title == )
                          // }
                        _subscribe('7',false,product: _products[0]);
                        }else{
                        nextScreen(context,SignUpPayment(amount: '19.99',isBusiness: false,planID: '7',));
                        }
                      }),
                      VipUserPlanWidget(button: () {
                        bloc.isBusinessClicked(false);
                        // bloc.addUserPlanSignUp("79.99");
                        if(Platform.isIOS){
                        _subscribe('8',false,product: _products[6]);
                        }else{
                        nextScreen(context,SignUpPayment(amount: '29.99',isBusiness: false,planID: '8',));
                        }
                      }),
                    ], options: CarouselOptions(
                      autoPlay: true,
                      height: 500.0,aspectRatio: 16/9,
                      viewportFraction: 1.0,onPageChanged: (i,v){
                    setState(() {
                      currentIndex = i;
                    });
                  },pauseAutoPlayOnTouch: true),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.circle,size: currentIndex == 0 ? 15 : 10,color: currentIndex == 0 ? Colors.black : Colors.grey,),
                      const SizedBox(width: 5,),
                      Icon(Icons.circle,size: currentIndex == 1 ? 15 : 10,color: currentIndex == 1 ? Colors.black :Colors.grey,),
                      const SizedBox(width: 5,),
                      Icon(Icons.circle,size: currentIndex == 2 ? 15 : 10,color: currentIndex == 2 ? Colors.black :Colors.grey,),
                      // SizedBox(width: 5,),
                      // Icon(Icons.circle,size: currentIndex == 3 ? 15 : 10,color: currentIndex == 3 ? Colors.black :Colors.grey,),
                    ],
                  ),
                  SizedBox(height: 100,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
