import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/profile/profile_cubit.dart';
import 'package:happiverse/views/profile/profile_more/chatGPT/widgets/serach_text_Field.dart';
import 'package:happiverse/views/profile/profile_more/chatGPT/widgets/text_cards.dart';

import '../../../../utils/constants.dart';

class ChatGPT extends StatefulWidget {
  const ChatGPT({Key? key}) : super(key: key);

  @override
  State<ChatGPT> createState() => _ChatGPTState();
}

class _ChatGPTState extends State<ChatGPT> {
  TextEditingController text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Hapi AI Chat"),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: state.messages == null ? 0:state.messages!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final textData = state.messages![index];
                    return textData.index == -999999
                        ? MyTextCard(textData: textData)
                        : TextCard(textData: textData);
                  },
                ),
              ),
              state.statee == ApiState.loading
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox(),
              const SizedBox(height: 12),
              SearchTextFieldWidget(
                  color: Colors.green.withOpacity(0.8),
                  textEditingController: text,
                  onTap: () {
                    bloc.getTextCompletion(
                        text.text);
                    text.clear();
                  }),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
