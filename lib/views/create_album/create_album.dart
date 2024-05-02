import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:happiverse/logic/create_album/create_album_cubit.dart';

import '../../logic/register/register_cubit.dart';
import '../../utils/constants.dart';
import '../common/submit_button.dart';

class CreateAlbum extends StatefulWidget {
  const CreateAlbum({super.key});

  @override
  State<CreateAlbum> createState() => _CreateAlbumState();
}

class _CreateAlbumState extends State<CreateAlbum> {
  String dropdownValue = 'Public';

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateAlbumCubit>();
    final authB = context.read<RegisterCubit>();

    return BlocBuilder<CreateAlbumCubit, CreateAlbumState>(builder: (context, state) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              "Create Album",
              style: TextStyle(color: Colors.black),
            ),
            leading: const BackButton(
              color: Colors.black,
            ),
            actions: [TextButton(onPressed: () {}, child: const Text("Create"))],
          ),
          body: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Public', 'Private'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                const Text("Album Name", style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                TextField(
                  onChanged: (val){
                    bloc.assignName(val);
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter name',
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SubmitButton(
                  onPressed: () {
                    print("helloHerer");
                    if( state.albumName.isNullOrEmpty){
                       Fluttertoast.showToast(msg: "Please enter album name");
                    }else{
                      bloc.createAlbumApi(authB.userID!,state.albumName.toString() ,authB.accesToken!, context);
                    }
                  },
                  title: getTranslated(context, 'CREATE_ALBUM')!,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
