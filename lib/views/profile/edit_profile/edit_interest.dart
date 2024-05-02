import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/routes/routes_names.dart';
import 'package:happiverse/utils/constants.dart';

import '../../../logic/register/register_cubit.dart';

class EditInterests extends StatefulWidget {
  const EditInterests({Key? key}) : super(key: key);

  @override
  State<EditInterests> createState() => _EditInterestsState();
}

class _EditInterestsState extends State<EditInterests> {
  bool isLoading = false;



  @override
  Widget build(BuildContext context) {
    final authB = context.read<RegisterCubit>();
    final bloc = context.read<ProfileCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.keyboard_backspace,color: Colors.white,),
            ),
            title: const Text(
              "Edit Interests",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              isLoading
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CupertinoActivityIndicator(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, updateCatInterest);
                        /*setState(() {
                          isLoading = true;
                        });
                        Future.delayed(const Duration(seconds: 3), () {
                          setState(() {
                            isLoading = false;
                          });
                          Fluttertoast.showToast(msg: "Interest Updated Successfully");
                        });*/
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(color: kSecendoryColor),
                      ))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                state.userInterest == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.userInterest!.length,
                        itemBuilder: (c, i) {
                          return ListTile(
                              // onTap: () {
                              //   bloc.selectUnselectInterests(i);
                              // },
                              // leading: const CircleAvatar(),
                              title: Text(state.userInterest![i].interestSubCategoryTitle),
                              trailing: InkWell(onTap: () {
                                bloc.deleteInterests(state.userInterest![i].mstUserInterestId,context,authB.userID!);
                              }, child: const Icon(Icons.delete,color: Colors.red,))
                              // trailing: state.userInterest![i].isSelected ? Icon(Icons.check) : Text(""),
                              );
                        },
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}
