import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery/views/home/popular_pack_page.dart';

import '../../../core/components/bundle_tile_square.dart';
import '../../../core/components/title_and_action_button.dart';
import '../../../core/constants/constants.dart';
import '../../../core/routes/app_routes.dart';

class PopularPacks extends StatefulWidget {
  const PopularPacks({
    super.key,
  });

  @override
  State<PopularPacks> createState() => _PopularPacksState();
}

class _PopularPacksState extends State<PopularPacks> {

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('allProducts').snapshots(),
      builder: (context, snapshot) {
       if(snapshot.hasError){
         return Center(child: Text('Error'),);
       }
       if(snapshot.connectionState == ConnectionState.waiting){
         return Center(child: CircularProgressIndicator(),);
       }

       final groceries = snapshot.data!.docs;
       return Column(
         children: [
           TitleAndActionButton(
             title: 'Popular Packs',
             onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PopularPackPage(allPacks: groceries)))),
           
           SizedBox(
             height: 250,
             child: ListView.builder(itemBuilder:(context, index) {
               return BundleTileSquare(data: groceries[index]);
             },scrollDirection:  Axis.horizontal,
               itemCount: groceries.length,),
           )
         ],
       );

      }
    );
  }
}
