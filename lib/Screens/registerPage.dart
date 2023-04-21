import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../model/profile.dart';
import 'loginPage.dart';
import 'welcomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                resizeToAvoidBottomInset: false,
                body: SizedBox(
                    height: size.height,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Form(
                          key: formKey,
                          child: Stack(children: <Widget>[
                            const Positioned(
                              top: 240,
                              left: 50,
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Positioned(
                              top: 290,
                              left: 50,
                              child: SizedBox(
                                width: 300,
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5.0),
                                    labelText: 'Email',
                                  ),
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "Please fill your email"),
                                    EmailValidator(
                                        errorText:
                                            "Your email format is not match")
                                  ]),
                                  keyboardType: TextInputType.emailAddress,
                                  onSaved: (String? email) {
                                    profile.email = email;
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              top: 370,
                              left: 50,
                              child: SizedBox(
                                width: 300,
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5.0),
                                    labelText: 'Password',
                                  ),
                                  validator: RequiredValidator(
                                      errorText: "Please fill your password"),
                                  onSaved: (String? password) {
                                    profile.password = password;
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 300,
                              right: 45,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    try {
                                      await FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                              email: profile.email!,
                                              password: profile.password!)
                                          .then((value) {
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return LoginPage();
                                        }));
                                      });
                                    } on FirebaseAuthException catch (e) {
                                      Fluttertoast.showToast(
                                          msg: e.message!,
                                          gravity: ToastGravity.CENTER);
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 255, 191, 0),
                                ),
                                child: const Text(
                                  'Register',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ]),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Image.asset(
                            'assets/bg/EllipseTop.png',
                            width: size.width * 0.4,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          top: 525,
                          child: Image.asset(
                            'assets/bg/Ellipsebottom.png',
                            width: size.width * 0.5,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 90,
                          child: Image.asset(
                            'assets/bg/EllipseTR.png',
                            width: size.width * 0.3,
                          ),
                        ),
                        Positioned(
                          top: 100,
                          left: 70,
                          child: Image.asset(
                            'assets/bg/logo.png',
                            width: size.width * 0.65,
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const WelcomeScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 255, 191, 0),
                            ),
                            child: const Text(
                              'Back',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    )));
          }
          return const Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        });
  }
}
