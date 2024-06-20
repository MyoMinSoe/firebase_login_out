import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "User Login",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              //Email
              SizedBox(
                width: 300,
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    label: Text('Username'),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              //Password
              SizedBox(
                width: 300,
                child: TextField(
                  obscureText: isHidden,
                  controller: passwordController,
                  decoration: InputDecoration(
                    label: const Text('Password'),
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(
                          () {
                            isHidden = !isHidden;
                          },
                        );
                      },
                      icon: isHidden
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (c) => const Home(),
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                      showDialog(
                        context: context,
                        builder: (c) => const AlertDialog(
                          content: Text('The password provided is too weak.'),
                        ),
                      );
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                      showDialog(
                        context: context,
                        builder: (c) => const AlertDialog(
                          content: Text(
                              'The account already exists for that email.'),
                        ),
                      );
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text('Sign Up'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (c) => const Home(),
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    showDialog(
                        context: context,
                        builder: (c) => AlertDialog(
                              content: Text(e.code),
                            ));
                    print('e for that email.${e.code}');
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                    }
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
