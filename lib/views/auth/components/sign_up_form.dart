import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery/core/routes/app_routes.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/validators.dart';
import 'already_have_accout.dart';
import 'sign_up_button.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDefaults.margin),
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppDefaults.boxShadow,
        borderRadius: AppDefaults.borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Name"),
          const SizedBox(height: 8),
          TextFormField(
            controller: nameController,
            validator: Validators.requiredWithFieldName('Name').call,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppDefaults.padding),
          const Text("email"),
          const SizedBox(height: 8),
          TextFormField(
            controller: emailController,
            textInputAction: TextInputAction.next,
            validator: Validators.required.call,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: AppDefaults.padding),
          const Text("Password"),
          const SizedBox(height: 8),
          TextFormField(
            controller: passController,
            validator: Validators.required.call,
            textInputAction: TextInputAction.next,
            obscureText: true,
            decoration: InputDecoration(
              suffixIcon: Material(
                color: Colors.transparent,
                child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    AppIcons.eye,
                    width: 24,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: AppDefaults.padding * 2),
            child: Row(
              children: [
                Text(
                  'Sign Up',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    auth
                        .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passController.text)
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Account Created")));
                      var user =  FirebaseFirestore.instance.collection('users');
                      user.doc(auth.currentUser!.uid).set({
                        'name' : nameController.text,
                        'email' : emailController.text,
                        'password' : passController.text,
                        'imageUrl' : '',
                        'uid' : auth.currentUser!.uid

                      });
                      Navigator.pushNamed(context, AppRoutes.entryPoint);
                    });
                  },
                  style: ElevatedButton.styleFrom(elevation: 1),
                  child: SvgPicture.asset(
                    AppIcons.arrowForward,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const AlreadyHaveAnAccount(),
          const SizedBox(height: AppDefaults.padding),
        ],
      ),
    );
  }
}
