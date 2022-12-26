import 'package:assignment/view/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() async {
    setState(() {
      loading = true;
    });
    try {
      _auth
          .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text.toString())
          .then((value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeView()));
        setState(() {
          loading = false;
        });
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Incorrect Email/Password"),
              );
            });
        setState(() {
          loading = false;
        });
      });
    } on FirebaseAuthException catch (e) {
      null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.password),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter password';
                      } else {
                        return null;
                      }
                    },
                  )
                ],
              )),
          SizedBox(
            height: 30,
          ),
          MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              elevation: 10,
              child: Text(
                'Login',
              ),
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  login();
                }
              }),
        ],
      ),
    );
  }
}
