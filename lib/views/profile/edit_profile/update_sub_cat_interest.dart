import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import '../../../logic/register/register_cubit.dart';

class UpdateInterestSubCat extends StatefulWidget {
  const UpdateInterestSubCat({Key? key}) : super(key: key);

  @override
  _InterestSubCatState createState() => _InterestSubCatState();
}

class _InterestSubCatState extends State<UpdateInterestSubCat> {
  @override
  Widget build(BuildContext context) {

    final bloc =  context.read<RegisterCubit>();

    return BlocBuilder<ProfileCubit,ProfileState>(
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: const Icon(Icons.keyboard_backspace,color: Colors.white,),
            ),
            title: const Text("Update Interests",style: TextStyle(color: Colors.white)),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  context.read<ProfileCubit>().saveUserIntereseSubCat(bloc.userID!,context);
                },
                child: const Text(
                  "Done",
                ),
              )
            ],
          ),
          body: Column(
            children: [
              const SizedBox(height: 20,),
              Expanded(
                child: Card(
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 10,),
                          Text("Let's Get more specific. Which topics intrest you"),
                          SizedBox(height: 20,),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.intrest!.length,
                            itemBuilder: (ctx,i){
                              if(state.intrest![i].isSelect){
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Popular in ${state.intrest![i].intrestCategoryTitle}",style: TextStyle(fontSize: 17),),
                                    ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state.intrest![i].intrestSubCategory.length,
                                      itemBuilder: (ctx,j){
                                        return Column(
                                          children: [
                                            const SizedBox(height: 10,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(state.intrest![i].intrestSubCategory[j].interestSubCategoryTitle,style: const TextStyle(color: Colors.black),),
                                                Checkbox(
                                                    value: state.intrest![i].intrestSubCategory[j].isSelect,
                                                    onChanged: (v)=>context.read<ProfileCubit>().onSubIntSelect(i, j),
                                                )
                                              ],
                                            ),
                                            const Divider(),
                                          ],
                                        );
                                      },
                                    )
                                  ],
                                );
                              }
                              return Container();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
