import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riderapp/AllWidgets/Divider.dart';

class MainScreen extends StatefulWidget {
  static const String idScreen = "mainScreen";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Completer<GoogleMapController> _controllerGoogleMAp = Completer<GoogleMapController>();
  late GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
          title: Text("Main Screen"),
          ),
          drawer: Container(
            color: Colors.white,
            width: 255.0,
            child: Drawer(
              child: ListView(
                children: [
                  //Drawer Header
                  Container(
                    height: 165.0,
                    child: DrawerHeader(
                      decoration: BoxDecoration(color: Colors.white,),
                      child: Row(
                        children: [
                          Image.asset("images/user_icon.png", height: 65.0, width: 65.0,),
                          SizedBox(width: 16.0,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Profile Name", style: TextStyle(fontSize: 16.0, fontFamily: "Brand Bold"),),
                              SizedBox(height: 6.0,),
                              Text("View Profile"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  DividerWidget(),

                  SizedBox(height: 12.0,),

                  //Drawer Body Controller
                  ListTile(
                    leading: Icon(Icons.history),
                    title: Text("History", style: TextStyle(fontSize: 15.0),),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text("View Profile", style: TextStyle(fontSize: 15.0),),
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text("About", style: TextStyle(fontSize: 15.0),),
                  ),
                ],
              ),
            ),
          ),
          body: Stack(
          children: [
            GoogleMap(mapType: MapType.normal,
            myLocationButtonEnabled: true, initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller){
              _controllerGoogleMAp.complete(controller);
              newGoogleMapController = controller;
              }
            ),

            //Hamburger button for drawer
            Positioned(
              top: 45.0,
              left: 22.0,
              child: GestureDetector(
                onTap: () {
                  scaffoldKey.currentState?.openDrawer();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22.0),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.black,
                       spreadRadius: 0.5,
                       offset: Offset(
                         0.7,
                         0.7
                       ),
                     ),
                   ]
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.menu, color: Colors.white,),
                    radius: 20.0,
                  ),
                ),
              ),
            ),

            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Container(
                height: 320.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.0),
                      topRight: Radius.circular(18.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    )
                  ],
              ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 6.0,),
                      Text("Hi there,",
                        style:
                        TextStyle(fontSize: 12.0,),),
                      Text("Where to?",
                        style: TextStyle(fontSize: 20.0, fontFamily: "Brand Bold"),),
                      SizedBox(height: 20.0,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7, 0.7),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.blueAccent,),
                              SizedBox(width: 10.0,),
                              Text("Search Destination or Drop-off"),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 24.0,),
                      Row(
                        children: [
                          Icon(Icons.home, color: Colors.grey,),
                          SizedBox(width: 12.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Add Home"),
                              SizedBox(height: 4.0,),
                              Text("Your Home Address", style: TextStyle(color: Colors.black54, fontSize: 12.0),),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 10.0,),

                      DividerWidget(),

                      SizedBox(height: 16.0,),

                      Row(
                        children: [
                          Icon(Icons.work, color: Colors.grey,),
                          SizedBox(width: 12.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Add Work"),
                              SizedBox(height: 4.0,),
                              Text("Your Work Address", style: TextStyle(color: Colors.black54, fontSize: 12.0),),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ),
            )],
      ),
    );
  }
}

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
//
// }
//
// class _MainscreenState extends State<MainScreen> {
//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
// //       appBar: AppBar(
//         title: Text("Main Screen"),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(mapType: MapType.normal,
//             myLocationButtonEnabled: true, initialCameraPosition: null,)
//         ],
//       ),
//     );
//   }
// }


// abstract class MainScreen extends StatelessWidget {
//   static const String idScreen = "mainScreen";
// }
//
// class _MainScreenState extends State<MainScreen> {
//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Main Screen"),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(mapType: MapType.normal,
//             myLocationButtonEnabled: true, initialCameraPosition: null,)
//         ],
//       ),
//     );
//   }
// }
