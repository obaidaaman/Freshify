import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import 'components/profile_header.dart';
import 'components/profile_menu_options.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  FirebaseFirestore userData = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Map<String,dynamic>? documentId;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocument();
  }

  Future<void> getDocument() async{

    try{
      DocumentSnapshot documentSnapshot = await userData.collection('users').doc(auth.currentUser!.uid).get();
      if(documentSnapshot.exists){
        setState(() {
          documentId = documentSnapshot.data() as Map<String,dynamic>;
          isLoading = !isLoading;
        });
      }
      else {
        print('Document does not exist');
      }
    } catch (e){
      print('Error reading document: $e');
    }
  }
  @override
  Widget build(BuildContext context) {

    return !isLoading ? const Center(child: CircularProgressIndicator()) : Container(
      color: AppColors.cardColor,
      child:  Column(
        children: [
          ProfileHeader(documentId: documentId!,),
          ProfileMenuOptions(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    isLoading = false;
  }
}
