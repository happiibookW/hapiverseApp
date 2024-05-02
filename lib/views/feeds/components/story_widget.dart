import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../logic/feeds/feeds_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../views/authentication/scale_navigation.dart';
import '../../../views/feeds/story/my_story_widget.dart';
import '../../../views/feeds/story/story_view.dart';
import '../../../utils/constants.dart';

class StoryWidget extends StatelessWidget {
  final String title;
  final String image;
  final int index;
  final bool isMyStory;

  // ignore: prefer_const_constructors_in_immutables
  StoryWidget({required this.image, required this.title, required this.index, required this.isMyStory, Key? key});

  @override
  Widget build(BuildContext context) {
    final postBloc = context.read<FeedsCubit>();
    final authB = context.read<RegisterCubit>();

    return InkWell(
      onTap: () {
        if (isMyStory) {
          print("HelloOherHerer1"+   image);
          // postBloc.fetchMyStory(authB.userID!, authB.accesToken!);
          Navigator.push(context, ScaleRoute(page: MyStoryWidgetPage(index : index)));
        } else {
          print("HelloOherHerer2"+image);
          Navigator.push(
            context, ScaleRoute(page: StoryViewPage(index: index,),
            ),
          );
        }
      },

      child: Column(
        children: [
          Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 3, color: kUniversalColor),
                ),
                child: Hero(
                  // tag: 'My Story${index}',
                  tag: DateTime.now().millisecondsSinceEpoch + Random().nextInt(9999),
                  child: Container(
                    height: 63,
                    width: 63,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              image,
                            ))),
                  ),
                ),
              )),
          Text(title, style:  TextStyle(fontSize: 7.sp), overflow: TextOverflow.ellipsis,maxLines: 1)
        ],
      ),
    );
  }
}
