import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/views/components/secondry_button.dart';

import '../../../logic/register/register_cubit.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';

class EditBusinessProfileCover extends StatefulWidget {
  const EditBusinessProfileCover({Key? key}) : super(key: key);

  @override
  State<EditBusinessProfileCover> createState() => _EditBusinessProfileCoverState();
}

class _EditBusinessProfileCoverState extends State<EditBusinessProfileCover> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final autBloc = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
            ),
            title: Text("Edit Logo Cover Image",style: TextStyle(color: Colors.white),),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: getHeight(context) / 2.5,
                    child: Stack(
                      children: [
                        state.coverUpdatedImageBusiness != null
                            ? Container(
                                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(20), image: state.coverUpdatedImageBusiness != null ? DecorationImage(fit: BoxFit.cover, image: FileImage(state.coverUpdatedImageBusiness!)) : null),
                                height: getHeight(context) / 3,
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (c) {
                                          return AlertDialog(
                                            content: SizedBox(
                                              height: 80,
                                              child: Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      bloc.getBusinessProfileImage(true, true);
                                                    },
                                                    child: const Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(Icons.camera_alt),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text("Camera")
                                                      ],
                                                    ),
                                                  ),
                                                  const Divider(),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      bloc.getBusinessProfileImage(true, false);
                                                    },
                                                    child: const Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(Icons.image),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text("Gallary")
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [Text("Change Cover Image"), Icon(Icons.add)],
                                  ),
                                ),
                              )
                            : state.businessProfile!.featureImageUrl == null || state.businessProfile!.featureImageUrl == ""
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    height: getHeight(context) / 3,
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (c) {
                                                return AlertDialog(
                                                  content: SizedBox(
                                                    height: 80,
                                                    child: Column(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(context);
                                                            bloc.getBusinessProfileImage(true, true);
                                                          },
                                                          child: const Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Icon(Icons.camera_alt),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text("Camera")
                                                            ],
                                                          ),
                                                        ),
                                                        const Divider(),
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(context);
                                                            bloc.getBusinessProfileImage(true, false);
                                                          },
                                                          child: const Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Icon(Icons.image),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text("Gallary")
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        child: const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [Text("Add Cover Image"), Icon(Icons.add)],
                                        ),
                                      ),
                                    ),
                                  )
                                : Center(
                                  child: InkWell(
                                    onTap: (){
                                      print("hello Pressed");
                                      showDialog(
                                          context: context,
                                          builder: (c) {
                                            return AlertDialog(
                                              content: SizedBox(
                                                height: 80,
                                                child: Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        bloc.getBusinessProfileImage(true, true);
                                                      },
                                                      child: const Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Icon(Icons.camera_alt),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text("Camera")
                                                        ],
                                                      ),
                                                    ),
                                                    const Divider(),
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        bloc.getBusinessProfileImage(true, false);
                                                      },
                                                      child: const Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Icon(Icons.image),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text("Gallary")
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(20), image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(state.businessProfile!.featureImageUrl == null || state.businessProfile!.featureImageUrl == "" ? "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg" : "${state.businessProfile!.featureImageUrl}"))),
                                        height: getHeight(context) / 3,
                                      ),
                                  ),
                                ),


                        Align(
                          alignment: Alignment.bottomCenter,
                          child: state.profileUpdatedImageBusiness != null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage: FileImage(state.profileUpdatedImageBusiness!),
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage("${state.businessProfile!.logoImageUrl}"),
                                ),
                        ),




                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 90.0),
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (c) {
                                      return AlertDialog(
                                        content: SizedBox(
                                          height: 80,
                                          child: Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  bloc.getBusinessProfileImage(false, true);
                                                },
                                                child: const Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.camera_alt),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text("Camera")
                                                  ],
                                                ),
                                              ),
                                              Divider(),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  bloc.getBusinessProfileImage(false, false);
                                                },
                                                child: const Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.image),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text("Gallary")
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                  padding: const EdgeInsets.all(8),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 20,
                                  )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                SecendoryButton(text: "Update", onPressed: () {
                  bloc.updateMyBusinessProfile(autBloc.userID!, autBloc.accesToken!, context);


                })
              ],
            ),
          ),
        );
      },
    );
  }
}
