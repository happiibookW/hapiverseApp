import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/logic/register/register_cubit.dart';
import 'package:happiverse/utils/utils.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routes/routes_names.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  bool agreed = false;
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Deleting your account"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage("${Utils.baseImageUrl}${bloc.isBusinessShared! ? state.businessProfile!.logoImageUrl : state.profileImage}"),
                ),
                SizedBox(height: 20,),
                Text("Deleting your account permanent?",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text("Deleting your account will be permanent delete your all informations from Hapiverse.",style: TextStyle(),),
                SizedBox(height: 10,),
                ListTile(
                  leading: Icon(LineIcons.user),
                  title: Text("Profile Informations"),
                  subtitle: Text("All of your profile informations will be deleted permanently after deleting your account (eg profile name image personal informations)"),
                ),
                ListTile(
                  leading: Icon(LineIcons.photoVideo),
                  title: Text("Posts Videos Photos Texts"),
                  subtitle: Text("All of your post thorugh hapiverse photos videos and text posts will be deleted permanently "),
                ),
                ListTile(
                  leading: Icon(LineIcons.user),
                  title: Text("Groups"),
                  subtitle: Text("All of your joined groups you will removed from all and your all posts from groups will be deleted"),
                ),
                ListTile(
                  leading: Icon(CupertinoIcons.chat_bubble),
                  title: Text("Chats"),
                  subtitle: Text("All of your Chats include media will be deleted permanently and can't be access after delete account"),
                ),
                Spacer(),
                Row(
                  children: [
                    Checkbox(value: agreed, onChanged: (v){
                      setState(() {
                        agreed = v!;
                      });
                    }),
                    Expanded(child: Text("I am agree to delete my account permanently and all of my informations on Hapiverse."))
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                    child: CupertinoButton(child: Text("Delete Account"), onPressed: !agreed ? null : (){
                      showCupertinoDialog(context: context, builder: (context){
                        return CupertinoAlertDialog(
                          title: Text("Are you sure you want to delete your account permanently?"),
                          content: Text("Permanet deleting account can't be access or activate after delete your all subscriptions will be removed"),
                          actions: [
                            CupertinoDialogAction(child: Text("Delete Account",style: TextStyle(color: Colors.red),),onPressed: ()async{
                              SharedPreferences pre = await SharedPreferences.getInstance();
                              pre.clear();
                              Navigator.pushNamedAndRemoveUntil(context, splashNormal, (route) => false);
                            },),
                            CupertinoDialogAction(child: Text("Don't Delete"),onPressed: (){
                              Navigator.pop(context);
                            },),
                          ],
                        );
                      });
                    },color: Colors.red,))
              ],
            ),
          ),
        );
      },
    );
  }
}
