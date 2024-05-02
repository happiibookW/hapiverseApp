import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happiverse/logic/feeds/feeds_cubit.dart';

import '../../logic/profile/profile_cubit.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import 'other_profile/other_profile_page.dart';

class ImageSearchUsers extends StatefulWidget {
  final String path;
  const ImageSearchUsers({Key? key,required this.path}) : super(key: key);

  @override
  State<ImageSearchUsers> createState() => _ImageSearchUsersState();
}

class _ImageSearchUsersState extends State<ImageSearchUsers> {

  baseImage(String inp){
    // Extract the base64-encoded image data from the URL
    try{
      List<String> parts = inp.split(',');
      String base64Image = parts.length > 1 ? parts[1] : '';

      // Decode the base64-encoded image data
      Uint8List decodedBytes = base64Decode(base64Image);
      return decodedBytes;
    }catch (e){
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    final authB = context.read<RegisterCubit>();
    final bloc = context.read<FeedsCubit>();
    final profileBloc = context.read<ProfileCubit>();
    return BlocBuilder<FeedsCubit, FeedsState>(
      builder: (context, state) {
        return Material(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(File(widget.path))
              )
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: ()=> Navigator.pop(context), icon: Icon(Icons.arrow_back_ios))
                    ],
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top:50.0),
                      child: Card(
                        elevation: 3.0,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            )),
                        child: StatefulBuilder(
                            builder: (context,statee) {
                              return Material(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  elevation: 3,
                                  child: SizedBox(
                                    // height: getHeight(context) / 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: ListView(
                                        children: [
                                          Text("Face Detection Search Results",style: TextStyle(fontSize: 20),),
                                          SizedBox(height: 50,),
                                          state.isSearching || state.imageSearchResult == null ? Center(child: CupertinoActivityIndicator(),) :
                                          state.imageSearchResult!.reverseImageResults.similarImages.isEmpty ? Center(child: Text("No Result Found"),):GridView.builder(
                                            shrinkWrap: true,
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 5,
                                              childAspectRatio: MediaQuery.of(context).size.width /
                                                  (MediaQuery.of(context).size.height / 2),
                                            ),
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: state.imageSearchResult!.reverseImageResults.similarImages.length,
                                            itemBuilder: (ctx,i){
                                              var d = state.imageSearchResult!.reverseImageResults.similarImages[i];
                                              return InkWell(
                                                onTap: (){
                                                  // nextScreen(context, ProductDetailsHapimart(index: i,));
                                                },
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: Colors.transparent,
                                                  ),
                                                  child: ClipRRect(
                                                      borderRadius: const BorderRadius.all(
                                                        Radius.circular(6),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                              height: 160,
                                                              width: 180,
                                                          //     child: Image.memory(baseImage(d.thumbnail,))
                                                          child:AnyLinkPreview(
                                                            removeElevation: true,
                                                            borderRadius: 0,
                                                            link: d.url,
                                                            displayDirection: UIDirection.uiDirectionVertical,
                                                            // showMultimedia: false,
                                                            // bodyMaxLines: 5,
                                                            bodyTextOverflow: TextOverflow.ellipsis,
                                                            errorBody: 'Error While Preview',
                                                            errorTitle: 'Error While Preview',
                                                            errorWidget: Container(
                                                              color: Colors.grey[300],
                                                              child: Text('Oops!'),
                                                            ),
                                                            titleStyle: TextStyle(
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 15,
                                                            ),
                                                            // errorImage: _errorImage,
                                                            bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
                                                          ),
                                                          ),
                                                          // SizedBox(height: 5,),
                                                        ],
                                                      )
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              );
                            }
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
class Base64ImageWidget extends StatelessWidget {
  final String base64Image;

  Base64ImageWidget({required this.base64Image});

  @override
  Widget build(BuildContext context) {
    // Remove any invalid characters from the base64-encoded string
    String sanitizedImage = base64Image.replaceAll(RegExp('[^a-zA-Z0-9+/=]'), '');

    // Add padding characters to make the length multiple of four
    while (sanitizedImage.length % 4 != 0) {
      sanitizedImage += '=';
    }

    // Decode the sanitized base64-encoded image string
    Uint8List bytes = base64.decode(sanitizedImage);

    // Create an Image widget from the decoded bytes
    Image image = Image.memory(bytes);


    return Center(
        child: Container(
        child: image,
    ));
  }
}