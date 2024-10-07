import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/constants/app_icons.dart';

import '../../core/constants/app_defaults.dart';
import '../../core/routes/app_routes.dart';
import 'components/ad_space.dart';
import 'components/our_new_item.dart';
import 'components/popular_packs.dart';

class HomePage extends StatefulWidget {
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final List<String> categories = [
    "Vegetables",
    "Meat and Fish",
    "Baby Care",
    "Office Supplies",
    "Beauty",
    "Gym Equipment",
    "Eye Wears",
    // Add more categories here
  ];

  var groceries = [
    {
      "name": "Apple",
      "category": "Fruits",
      "price": 100,
      "imageUrl": "https://example.com/apple.jpg",
      "availability": true,
      "description": "Fresh red apples"
    },
    {
      "name": "Milk",
      "category": "Dairy",
      "price": 50,
      "imageUrl": "https://example.com/milk.jpg",
      "availability": true,
      'description': "Organic full cream milk"
    }, {
      "name": "Mangoes",
      "category": "Fruits",
      "price": 50,
      "imageUrl": "https://example.com/milk.jpg",
      "availability": true,
      "description": "Organic full cream milk"
    },
    {
      "name": "Banana",
      "category": "Fruits",
      "price": 50,
      "imageUrl": "https://example.com/milk.jpg",
      "availability": true,
      "description": "Organic full cream milk"
    },
    {
      "name": "Guava",
      "category": "Fruits",
      "price": 50,
      "imageUrl": "https://example.com/milk.jpg",
      "availability": true,
      "description": "Organic full cream milk"
    },
    {
      "name": "Kiwi",
      "category": "Fruits",
      "price": 50,
      "imageUrl": "https://example.com/milk.jpg",
      "availability": true,
      "description": "Organic full cream milk"
    },
    {
      "name": "Cauliflower",
      "category": "Vegetables",
      "price": 50,
      "imageUrl": "https://example.com/milk.jpg",
      "availability": true,
      "description": "Organic full cream milk"
    },
    {
      "name": "Potato",
      "category": "Vegetables",
      "price": 50,
      "imageUrl": "https://example.com/milk.jpg",
      "availability": true,
      "description": "Organic full cream milk"
    },
    {
      "name": "Tomato",
      "category": "Vegetables",
      "price": 50,
      "imageUrl": "https://example.com/milk.jpg",
      "availability": true,
      "description": "Organic full cream milk"
    },
    {
      "name": "Potato",
      "category": "Vegetables",
      "price": 50,
      "imageUrl": "https://example.com/milk.jpg",
      "availability": true,
      "description": "Organic full cream milk"
    },
    {
      "name": "Bringle",
      "category": "Vegetables",
      "price": 50,
      "imageUrl": "https://example.com/milk.jpg",
      "availability": true,
      "description": "Organic full cream milk"
    }
    // Add more grocery items here...
  ];

  Future<void> uploadCategories() async {
    try {
      CollectionReference categoriesCollection = FirebaseFirestore.instance.collection('categories');
      for (String category in categories) {
        await categoriesCollection.add({
          'name': category,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Categories uploaded successfully on page load!')),
      );
    } catch (e) {
      print('Error uploading categories: $e');
    }
  } Future<void> uploadProducts() async {
    try {
      CollectionReference categoriesCollection = FirebaseFirestore.instance.collection('allProducts');

       for(var products in groceries){
         await categoriesCollection.add(products);
       }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Groceries uploaded successfully on page load!')),
      );
    } catch (e) {
      print('Error uploading categories: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  uploadCategories();
  //   uploadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [

            // app bar
            SliverAppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.drawerPage);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF2F6F3),
                    shape: const CircleBorder(),
                  ),
                  child: SvgPicture.asset(AppIcons.sidebarIcon),
                ),
              ),
              floating: true,


              title: SvgPicture.asset(
                "assets/images/app_logo.svg",
                height: 32,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8, top: 4, bottom: 4),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.search);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF2F6F3),
                      shape: const CircleBorder(),
                    ),
                    child: SvgPicture.asset(AppIcons.search),
                  ),
                ),
              ],
            ),

            // free deliveryDisplay Image
            const SliverToBoxAdapter(
              child: AdSpace(),
            ),
            const SliverToBoxAdapter(
              child: PopularPacks(),
            ),
            const SliverPadding(
              padding: EdgeInsets.symmetric(vertical: AppDefaults.padding),
              sliver: SliverToBoxAdapter(
                child: OurNewItem(),
              ),
            ),

            SliverPadding(padding: EdgeInsets.symmetric(vertical: AppDefaults.padding),
            sliver: SliverToBoxAdapter(
              child: Container(
                width: double.maxFinite,
                height: 150,
                color: Colors.grey.shade50,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text('Your Last Minute App', style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                        child: Text('Freshify',style: TextStyle(fontSize: 16,fontStyle: FontStyle.italic)))
                  ],),
                ),
              ),
            ),)
          ],
        ),
      ),
    );
  }
}
