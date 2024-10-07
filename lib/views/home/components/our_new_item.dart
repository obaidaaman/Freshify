import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../core/components/product_tile_square.dart';
import '../../../core/components/title_and_action_button.dart';
import '../../../core/routes/app_routes.dart';

class OurNewItem extends StatelessWidget {
  const OurNewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('allProducts').where('category', isEqualTo: 'Fruits').snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return Center(child: Text('Error in Data'),);
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);

        }
        var groceries = snapshot.data!.docs;

        return Column(
          children: [
            TitleAndActionButton(
              title: 'Our New Item',
              onTap: () => Navigator.pushNamed(context, AppRoutes.newItems),
            ),

            Container(
height: 300,
              child: ListView.builder(itemBuilder: (context,index){
                return ProductTileSquare(
                    onTap: (){
                      Navigator.pushNamed(context, AppRoutes.bundleDetailsPage);
                    },
                    data: groceries[index]);
              }, itemCount: groceries.length,
              scrollDirection: Axis.horizontal,),
            )

          ],
        );
      }
    );
  }
}
