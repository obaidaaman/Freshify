import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../../core/routes/app_routes.dart';
import 'components/category_tile.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(

        builder: (context,snapshot) {
          if(snapshot.hasError){
            return Center(child: Text('Error in Data'),);
          }
          else if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return Column(
            children: [
              const SizedBox(height: 32),
              Text(
                'Choose a category',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
               CateogoriesGrid(listOfDocs: snapshot.data!.docs,)
            ],
          );
    }, stream: FirebaseFirestore.instance.collection('categories').snapshots(),

      ),

    );
  }
}

class CateogoriesGrid extends StatefulWidget {
  final List<QueryDocumentSnapshot> listOfDocs;
  const CateogoriesGrid({
    super.key, required this.listOfDocs,
  });

  @override
  State<CateogoriesGrid> createState() => _CateogoriesGridState();
}

class _CateogoriesGridState extends State<CateogoriesGrid> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: widget.listOfDocs.length,
         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemBuilder: (BuildContext context, int index) {
           return CategoryTile(
             imageLink: 'https://i.imgur.com/m65fusg.png',
             label: widget.listOfDocs[index].get('name'),
             onTap: () {
               Navigator.pushNamed(context, AppRoutes.categoryDetails);
             },
           );
      },

      ),
    );
  }
}
