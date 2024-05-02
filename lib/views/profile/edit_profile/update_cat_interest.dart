import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import '../../../logic/profile/profile_cubit.dart';
import '../../../routes/routes_names.dart';
import '../../../utils/constants.dart';

class UpdateCategoryIntrest extends StatefulWidget {
  const UpdateCategoryIntrest({Key? key}) : super(key: key);

  @override
  _UpdateCategoryIntrestState createState() => _UpdateCategoryIntrestState();
}

class _UpdateCategoryIntrestState extends State<UpdateCategoryIntrest> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getInterests();
  }

  String search = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(
              Icons.keyboard_backspace,
              color: Colors.white,
            ),
          ),
          title: const Text(
            "Update Interests",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pushNamed(context, updateSubCatInterset),
              child: const Text(
                "Next",
              ),
            )
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Card(
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: state.intrest == null || state.intrest!.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: search == ''
                            ? GridView.builder(
                                itemCount: state.intrest!.length,
                                shrinkWrap: true,
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200, childAspectRatio: 2.5 / 2.3, crossAxisSpacing: 20, mainAxisSpacing: 20),
                                itemBuilder: (ctx, i) {
                                  return InkWell(
                                    onTap: () => context.read<ProfileCubit>().onIntrestSelect(i),
                                    child: Stack(
                                      children: [
                                        Card(
                                          color: state.intrest![i].isSelect ? Colors.grey[300] : Colors.white,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                          child: Column(
                                            children: [Image.network(state.intrest![i].interestImage, height:getHeight(context) / 7, width: getWidth(context) / 2, fit: BoxFit.cover), Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                              child: Text(state.intrest![i].intrestCategoryTitle,overflow: TextOverflow.ellipsis,),
                                            )],
                                          ),
                                        ),
                                        state.intrest![i].isSelect
                                            ? const Align(
                                                alignment: Alignment.center,
                                                child: Icon(
                                                  LineIcons.check,
                                                  size: 50,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                  );
                                },
                              )
                            : GridView.builder(
                                itemCount: state.intrest!.length,
                                shrinkWrap: true,
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200, childAspectRatio: 2.5 / 2.3, crossAxisSpacing: 20, mainAxisSpacing: 20),
                                itemBuilder: (ctx, i) {
                                  if (state.intrest![i].intrestCategoryTitle.toLowerCase().contains(search.toLowerCase())) {
                                    return InkWell(
                                      onTap: () => context.read<ProfileCubit>().onIntrestSelect(i),
                                      child: Stack(
                                        children: [
                                          Card(
                                            color: state.intrest![i].isSelect ? Colors.grey[300] : Colors.white,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                            child: Column(
                                              children: [Image.network(state.intrest![i].interestImage, height:getHeight(context) / 7, width: getWidth(context) / 2, fit: BoxFit.cover), Text(state.intrest![i].intrestCategoryTitle)],
                                            ),
                                          ),
                                          state.intrest![i].isSelect
                                              ? const Align(
                                                  alignment: Alignment.center,
                                                  child: Icon(
                                                    LineIcons.check,
                                                    size: 50,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : Container()
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                      ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
