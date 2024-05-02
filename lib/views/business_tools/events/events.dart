import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/business_product/business_product_cubit.dart';
import '../../../views/business_tools/business_tools.dart';
import '../../../views/business_tools/events/add_events.dart';
import '../../../views/components/universal_card.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../../../logic/register/register_cubit.dart';
import '../../../utils/config/assets_config.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../add_product/add_collection.dart';

class BusinessEvents extends StatefulWidget {
  const BusinessEvents({Key? key}) : super(key: key);

  @override
  _BusinessEventsState createState() => _BusinessEventsState();
}

class _BusinessEventsState extends State<BusinessEvents> {
  @override
  void initState() {
    super.initState();
    final authb = context.read<RegisterCubit>();
    final bloc = context.read<BusinessProductCubit>();
    bloc.fetchBusinessEvent(authb.userID!, authb.accesToken!);
  }

  DateFormat dateFormat = DateFormat('dd MMM yyyy');
  DateFormat timeFormat = DateFormat('hh:mm a');

  @override
  Widget build(BuildContext context) {
    final authb = context.read<RegisterCubit>();
    final bloc = context.read<BusinessProductCubit>();
    return BlocBuilder<BusinessProductCubit, BusinessProductState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Events",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: UniversalCard(
            widget: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  onTap: () {
                    nextScreen(context, const AddEvents());
                  },
                  leading: Container(
                    width: 70,
                    decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Icon(LineIcons.plusCircle),
                    ),
                  ),
                  title: const Text("Add New Event"),
                  dense: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                state.businessEvent == null
                    ? const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : state.businessEvent!.isEmpty
                        ? const Center(
                            child: Text("No Events"),
                          )
                        : Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.businessEvent!.length,
                              itemBuilder: (ctx, i) {
                                var data = state.businessEvent![i];
                                return Card(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    elevation: 5.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CarouselSlider(
                                            options: CarouselOptions(
                                              autoPlay: true,
                                              height: getWidth(context) / 3,
                                              aspectRatio: 16 / 9,
                                              enlargeCenterPage: true,
                                            ),
                                            items: data.images?.map((url) {
                                              return Builder(
                                                builder: (BuildContext context) {
                                                  return Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                    ),
                                                    child: Image.network(
                                                      data.images == null || data.images!.isEmpty ? "" : "${Utils.baseImageUrl2}${url.imageUrl}",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  );
                                                },
                                              );
                                            }).toList(),
                                          ),

                                          // Container(
                                          //   height: getWidth(context) / 3,
                                          //   width:  getWidth(context),
                                          //   child: FadeInImage(
                                          //     image: NetworkImage(
                                          //       data.images == null || data.images!.isEmpty ? "" : "${Utils.baseImageUrl}${data.images![0].imageUrl!}",
                                          //     ),
                                          //     placeholder: const AssetImage("assets/images/placeholder.jpeg"),
                                          //     imageErrorBuilder: (context, error, stackTrace) {
                                          //       return Image.asset('assets/images/notfound.png', fit: BoxFit.cover,);
                                          //     },
                                          //     fit: BoxFit.cover,
                                          //   ),
                                          //
                                          //   // This is old code commented by Geeks
                                          //   /*decoration: BoxDecoration(
                                          //       borderRadius: BorderRadius.circular(10),
                                          //       image: DecorationImage(
                                          //           fit: BoxFit.cover,
                                          //           image: NetworkImage(data.images == null || data.images!.isEmpty ? "":
                                          //             "${Utils.baseImageUrl}${data.images![0].imageUrl!}",
                                          //           )
                                          //       )
                                          //   ),*/
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${dateFormat.format(data.eventDate!)} at ${data.eventTime}",
                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                                                ),
                                                Text(
                                                  data.eventName ?? "",
                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                ),
                                                // Text(data.eventName!,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                Container(
                                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                                  child: Text(
                                                    data.eventDescription ?? "",
                                                    style: TextStyle(fontSize: 14, color: Colors.grey),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: getWidth(context),
                                                  child: OutlinedButton(
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (c) {
                                                              return AlertDialog(
                                                                title: const Text("Do you want to delete event?"),
                                                                actions: [
                                                                  TextButton(onPressed: () => Navigator.pop(context), child: Text("No")),
                                                                  TextButton(
                                                                      onPressed: () {
                                                                        Navigator.pop(context);
                                                                        bloc.deleteEvent(authb.userID!, authb.accesToken!, data.eventId!);
                                                                      },
                                                                      child: Text(
                                                                        "Yes",
                                                                        style: TextStyle(color: Colors.red),
                                                                      )),
                                                                ],
                                                              );
                                                            });
                                                      },
                                                      child: Text(
                                                        "Delete Event",
                                                        style: TextStyle(color: Colors.red),
                                                      )),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ));
                              },
                            ),
                          )
              ],
            ),
          ),
        );
      },
    );
  }
}
