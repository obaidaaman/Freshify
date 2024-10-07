import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/components/network_image.dart';
import '../../../core/constants/constants.dart';
import 'profile_header_options.dart';

class ProfileHeader extends StatefulWidget {
 final Map<String,dynamic> documentId;
   const ProfileHeader({
    super.key, required this.documentId,
  });

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Background
        Image.asset('assets/images/profile_page_background.png'),

        /// Content
        Column(
          children: [
            AppBar(
              title: const Text('Profile'),
              elevation: 0,
              backgroundColor: Colors.transparent,
              titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
             _UserData(documentId: widget.documentId,),
            const ProfileHeaderOptions()
          ],
        ),
      ],
    );
  }
}

class _UserData extends StatefulWidget {

  Map<String, dynamic> documentId;
   _UserData({
    required this.documentId,
});

  @override
  State<_UserData> createState() => _UserDataState();
}

class _UserDataState extends State<_UserData> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Row(
        children: [
          const SizedBox(width: AppDefaults.padding),
          const SizedBox(
            width: 100,
            height: 100,
            child: ClipOval(
              child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: NetworkImageWithLoader(
                      'https://images.unsplash.com/photo-1628157588553-5eeea00af15c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80')),
            ),
          ),
          const SizedBox(width: AppDefaults.padding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.documentId['name'],
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                widget.documentId['email'],
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
