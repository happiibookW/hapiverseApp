import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/config/assets_config.dart';
import '../../utils/constants.dart';
import '../../views/authentication/sign_up_check.dart';
import 'package:line_icons/line_icons.dart';
import 'forgot_password.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<RegisterCubit>().initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          leading: Container(),
          backgroundColor: const Color(0xffEEF1F8),
          title: const Text(
            "Sign In",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  AssetConfig.kSigninVector,
                  height: 200,
                  width: 200,
                ),
              ),
              DraggableScrollableSheet(
                minChildSize: 0.5,
                initialChildSize: 0.6,
                maxChildSize: 1.0,
                // snap: true,
                // expand: true,
                builder: (context, scrollController) => Card(
                  elevation: 3.0,
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
                  child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      elevation: 3,
                      child: Container(
                        decoration: kContainerDecoration,
                        padding: const EdgeInsets.all(25),
                        child: Form(
                          key: globalKey,
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              children: [
                                // IconButton(onPressed: (){}, icon: Icon(Icons.arrow_upward_sharp)),
                                Text(
                                  state.errorMessage,
                                  style: TextStyle(color: Colors.red),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (val) {
                                    context.read<RegisterCubit>().assignEmail(val);
                                  },
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Email is required";
                                    } else if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(val)) {
                                      return 'Please enter a valid email Address';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Email Address',
                                      // hintText: "Email Address",
                                      suffixIcon: Icon(LineIcons.envelope)),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Please Enter Password";
                                    } else if (val.length < 6) {
                                      return "Password must be 6 characters";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (val) {
                                    context.read<RegisterCubit>().assignPassword(val);
                                  },
                                  cursorColor: kUniversalColor,
                                  decoration: const InputDecoration(
                                    labelText: "Password",
                                    suffixIcon: Icon(LineIcons.lock),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: kUniversalColor,
                                      ),
                                      onPressed: () {
                                        nextScreen(context, ForgotPassword());
                                      },
                                      child: const Text("Forgot your password?"),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                state.loadingState
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : MaterialButton(
                                        minWidth: 140,
                                        shape: const StadiumBorder(),
                                        onPressed: () {
                                          if (globalKey.currentState!.validate()) {
                                            context.read<RegisterCubit>().loginUser(context);
                                          }
                                        },
                                        color: kSecendoryColor,
                                        child: const Text(
                                          "Sign In",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: const [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Divider(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Text("Or"),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Divider(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: const [
                                //     CircleAvatar(
                                //       backgroundColor: Colors.deepOrange,
                                //       child: Icon(
                                //         LineIcons.googleLogo,
                                //         color: Colors.white,
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: 10,
                                //     ),
                                //     CircleAvatar(
                                //       backgroundColor: Colors.blueAccent,
                                //       child: Icon(
                                //         LineIcons.facebookF,
                                //         color: Colors.white,
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: 10,
                                //     ),
                                //     CircleAvatar(
                                //       backgroundColor: Colors.lightBlueAccent,
                                //       child: Icon(
                                //         LineIcons.twitter,
                                //         color: Colors.white,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Don't have account?",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: kUniversalColor,
                                        ),
                                        onPressed: () => nextScreen(context, SignUpCheck()),
                                        child: const Text("Sign Up"))
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () async {
                                          await context.read<RegisterCubit>().signInWithGoogle(context);
                                        },
                                        child: Image.asset('assets/images/google.png', width: 40)),
                                    const SizedBox(width: 20),
                                    InkWell(
                                        onTap: () async {
                                          await context.read<RegisterCubit>().handleFacebookLogin(context);
                                        },
                                        child: Image.asset('assets/images/facebook.png', width: 40)),
                                    const SizedBox(width: 20),

                                    Platform.isAndroid ?  InkWell(
                                        onTap: () async {
                                          await context.read<RegisterCubit>().handleTwitterLogin(context);
                                        },
                                        child: Image.asset('assets/images/twitter.png', width: 40)) : Container(),

                                    Platform.isIOS ? InkWell(
                                        onTap: () async {
                                          await context.read<RegisterCubit>().signInWithApple(context);
                                        },
                                        child: Image.asset('assets/images/apple.png', width: 40)) : Container()
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
