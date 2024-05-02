import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:line_icons/line_icons.dart';

import '../../logic/register/register_cubit.dart';

class SelectReligion extends StatefulWidget {
  const SelectReligion({Key? key}) : super(key: key);

  @override
  State<SelectReligion> createState() => _SelectReligionState();
}

class _SelectReligionState extends State<SelectReligion> {
  String val = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RegisterCubit>().fetchReligionList();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterCubit>();
    final profile = context.read<ProfileCubit>();
    return BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
              child: const Icon(Icons.arrow_back_rounded,color:Colors.white,)),
          title: const Text("Select Religion",style: TextStyle(color: Colors.white),),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TextField(
            //   enabled: false,
            //   decoration: const InputDecoration(border: InputBorder.none, hintText: "Select Religion", prefixIcon: Icon(Icons.search)),
            //   onChanged: (v) {
            //     setState(
            //           () {
            //         val = v;
            //       },
            //     );
            //   },
            // ),
            state.loadingState ? const Center(child: CircularProgressIndicator()) :
            Expanded(
              child: ListView.builder(
                itemCount: state.religionModel?.data?.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title:  Text(state.religionModel == null ? "No Religion" : state.religionModel!.data![index].name.toString()),
                        onTap: () {
                             profile.setRelegion(state.religionModel!.data![index].name.toString());
                             bloc.setRelegion(state.religionModel!.data![index].name.toString());
                             Navigator.pop(context);
                        },
                      ),
                      const Divider(), // Add a Divider below each ListTile
                    ],
                  );
                },
              ),
            )





            // val == '' ? Container():ListTile(
            //   onTap: (){
            //     bloc.setRelegion(val);
            //     Navigator.pop(context);
            //   },
            //   title: Text(val,style: TextStyle(fontWeight: FontWeight.bold),),
            //   leading: Container(
            //     // width: 30,
            //     decoration:  BoxDecoration(
            //       // border: Border.all(),
            //       shape: BoxShape.circle,
            //       color: Colors.grey[200]!
            //     ),
            //     // padding: EdgeInsets.all(9),
            //     child: Icon(LineIcons.starAndCrescent),
            //   ),
            // )
          ],
        ),
      );
    });
  }
}
