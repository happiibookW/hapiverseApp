import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

import '../../logic/register/register_cubit.dart';

class SelectOccupation extends StatefulWidget {
  const SelectOccupation({Key? key}) : super(key: key);

  @override
  State<SelectOccupation> createState() => _SelectOccupationState();
}

class _SelectOccupationState extends State<SelectOccupation> {
  String val = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RegisterCubit>().fetchOccupationList();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterCubit>();
    return BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
              child: const Icon(Icons.keyboard_backspace_sharp,color: Colors.white)),
          title: const Text("Select Occupation",style: TextStyle(color: Colors.white),),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            state.loadingState ? const Center(child: CircularProgressIndicator()) :
            Expanded(
              child: ListView.builder(
                itemCount: state.occupationModel?.data?.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title:  Text(state.occupationModel == null ? "No Occupation" : state.occupationModel!.data![index].name.toString()),
                        onTap: () {
                          bloc.setOccupationType(state.occupationModel!.data![index].name.toString(),state.occupationModel!.data![index].id.toString());
                          Navigator.pop(context);
                        },
                      ),
                      const Divider(), // Add a Divider below each ListTile
                    ],
                  );
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
