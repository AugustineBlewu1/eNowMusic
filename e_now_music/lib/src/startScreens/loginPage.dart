import 'package:e_now_music/src/otherScreens/bottomNavbar.dart';
import 'package:e_now_music/src/services/firebaseAuth.dart';
import 'package:e_now_music/src/startScreens/register.dart';
import 'package:e_now_music/src/utils/customUsage.dart';
import 'package:e_now_music/src/utils/navigators.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isHidden = true;
  List images = ['google.png', 'facebook-f.png', 'twitter.png'];
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        context.push(screen: RegisterScreen());
      };
    final theme = Theme.of(context).textTheme;
    final userCredential =
        Provider.of<FirebaseAuthentication>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/music_headset.png',
                  height: 300.0,
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 180.0),
                        child: Text(
                          'eNow',
                          style: theme.headline2!.copyWith(
                            color: Color(0XFFF32314A),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: textFormField(
                                fieldController: emailController,
                                label: 'Email',
                                hint: 'Enter your email',
                                value: (val) {
                                  if (val!.isEmpty) return validateEmail(val);
                                }),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: textPasswordField(
                                fieldController: passwordController,
                                label: 'Password',
                                hint: 'Enter your password',
                                value: (val) {
                                  if (val!.isEmpty)
                                    return 'Password is required';
                                }),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          loading == true
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 40.0),
                                    child: SizedBox(
                                      height: 35.0,
                                      width: 110.0,
                                      child: ElevatedButton(
                                          style: buttonStyle,
                                          onPressed: () {
                                            context.push(screen: BottomNav());
                                            // if (_formKey.currentState!
                                            //     .validate()) {
                                            //   return login(userCredential);
                                            // } else {
                                            //   return;
                                            // }
                                          },
                                          child: Text(
                                            'Login',
                                          )),
                                    ),
                                  ),
                                )
                        ],
                      )),
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    '-Or-',
                    style: theme.bodyText2,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (var i in images)
                          SizedBox(
                            height: 40.0,
                            width: 45.0,
                            child: ElevatedButton(
                              style: buttonStyle.copyWith(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              child: Image.asset('assets/$i'),
                              onPressed: () {},
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60.0,
                  ),
                  RichText(
                      text: TextSpan(
                          text: 'Already have an account?',
                          style: theme.caption,
                          children: [
                        TextSpan(text: '  '),
                        TextSpan(
                            text: 'Register',
                            style:
                                theme.caption!.copyWith(color: Colors.red[500]),
                            recognizer: onTapRecognizer)
                      ]))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textFormField(
      {TextEditingController? fieldController,
      String? label,
      String? hint,
      String? Function(String?)? value}) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: fieldController,
      validator: value,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget textPasswordField(
      {TextEditingController? fieldController,
      String? label,
      String? hint,
      String? Function(String?)? value}) {
    return TextFormField(
      obscureText: _isHidden,
      controller: fieldController,
      validator: value,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(),
        suffixIcon: Padding(
            padding: EdgeInsetsDirectional.only(end: 12.0),
            child: IconButton(
              onPressed: _toggle,
              icon: _isHidden
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility),
            )),
      ),
    );
  }

  _toggle() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  login(FirebaseAuthentication userCredential) async {
    setState(() {
      loading = true;
    });
    await userCredential
        .login(email: emailController.text, password: passwordController.text)
        .then((value) {
      context.removeUntil(context: context, screen: BottomNav());
      context.showSnackSuccess(message: 'Welcome}');
    }).catchError((err) {
      context.showSnackError(error: err.toString());
    }).whenComplete(() {
      setState(() {
        loading = false;
      });
    });
  }
}
