import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmvibes/reusable/reusable_widgets.dart';
import 'package:filmvibes/screens/admin.dart';
import 'package:filmvibes/screens/home/home_screen.dart';
import 'package:filmvibes/screens/signup_screen.dart';
import 'package:filmvibes/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String _errorMessage = '';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  User? _currentUser;
  Future<bool> checkIfUserIsAdmin(String? userId) async {
    bool isAdmin = false;

    if (userId != null) {
      try {
        CollectionReference<Map<String, dynamic>> rolesCollection =
            FirebaseFirestore.instance.collection('role');

        QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await rolesCollection.where('user', isEqualTo: userId).get();

        if (querySnapshot.docs.isNotEmpty) {
          isAdmin = querySnapshot.docs.first.data()['isAdmin'] ?? true;
        }
      } catch (error) {
        print("Error checking user role: $error");
      }
    }

    return isAdmin;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        hexStringToColor("B8B7AB"),
        hexStringToColor("6E6D63"),
        hexStringToColor("2B2B26")
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.fromLTRB(
            20, MediaQuery.of(context).size.height * 0.2, 20, 0),
        child: Column(
          children: <Widget>[
            logoWidget("assets/images/logo1.png"),
            const SizedBox(
              height: 30,
            ),
            reusableTextField("Enter Email", Icons.verified_user, false,
                _emailTextController),
            const SizedBox(
              height: 20,
            ),
            reusableTextField("Enter Password", Icons.lock_outline, true,
                _passwordTextController),
            const SizedBox(
              height: 20,
            ),
            Text(
              _errorMessage,
              style: const TextStyle(color: Colors.black),
            ),
            signInSignUpButton(context, true, () async {
              BuildContext storedContext = context;

              try {
                UserCredential userCredential =
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: _emailTextController.text,
                  password: _passwordTextController.text,
                );

                String? userId = userCredential.user?.uid;
                bool isAdmin = await checkIfUserIsAdmin(userId);

                if (isAdmin) {
                  print("Navigating to AdminScreen");
                  Navigator.pushReplacement(
                    storedContext,
                    MaterialPageRoute(builder: (context) => AdminScreen()),
                  );
                } else {
                  print("Navigating to HomeScreen");
                  Navigator.pushReplacement(
                    storedContext,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                }
              } catch (error) {
                setState(() {
                  _currentUser = null;
                  _errorMessage = 'Invalid email or password';
                });
                print("Error ${error.toString()}");
              }
            }),
            signUpOption()
          ],
        ),
      )),
    ));
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
