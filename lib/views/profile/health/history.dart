import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../utils/constants.dart';
import 'package:intl/intl.dart';
import '../../../utils/config/assets_config.dart';
class CovidHistory extends StatefulWidget {
  const CovidHistory({Key? key}) : super(key: key);

  @override
  _CovidHistoryState createState() => _CovidHistoryState();
}

class _CovidHistoryState extends State<CovidHistory> {
  @override
  Widget build(BuildContext context) {
    final format = DateFormat('dd MMM yyyy');
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(Icons.keyboard_backspace,color: Colors.white,),
        ),
        title: Text("Match Alert History",style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Expanded(
            child: Card(
              color: Colors.white.withOpacity(0.8),
              shape: cardRadius,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Match Alert History",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text("Match Alert",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Image.network("https://static.vecteezy.com/system/resources/previews/009/889/707/original/wedding-couple-and-married-character-free-png.png",height: getWidth(context) / 4,),
                              Text("Married Match Alert",textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Image.network("https://purepng.com/public/uploads/large/love-hearts-4ss.png",height: getWidth(context) / 4,),
                              Text("In Love \nMatch Alert",textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Image.network("https://zeevector.com/wp-content/uploads/Wedding-Ring-PNG-HD@ZEEVECTOR.COM_.png",height: getWidth(context) / 4,),
                              Text("Engaged Match",textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Card(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (ctx,i){
                          return Padding(
                            padding: const EdgeInsets.only(left:8.0,top: 8,bottom: 8),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(state.covidRecordList![i].covidStatus!,style: TextStyle(fontSize: 18),),
                                        Text("${getTranslated(context, 'EXPIRE_ON_19_MARCH')!} ${format.format(state.covidRecordList![i].date!)}",style: TextStyle(fontSize: 12,color: Colors.grey),)
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(),
                              ],
                            ),
                          );
                        },
                        itemCount: state.covidRecordList!.length,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  },
);
  }
}
