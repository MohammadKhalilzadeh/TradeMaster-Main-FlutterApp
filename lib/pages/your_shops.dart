import 'dart:collection';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trader/components/profile_widgets.dart';
import 'package:trader/controllers/get_connect.dart';
import 'package:trader/models/business.dart';
import 'package:trader/pages/myshop.dart';
import 'package:trader/variables/myvariables.dart';

class YourShops extends StatefulWidget {
  final String userid;
  const YourShops({
    required this.userid,
    Key? key,
  }) : super(key: key);

  @override
  State<YourShops> createState() => _YourShopsState();
}

class _YourShopsState extends State<YourShops> {
  late Future<List<Business>> _businesses;
  Position? currentPosition;
  var geoLocator = Geolocator();
  GoogleMapController? googleMapController;

  Completer<GoogleMapController> completer = Completer<GoogleMapController>();
  static LatLng? initialPosition;

  @override
  void initState() {
    super.initState();
    _businesses = getrequestBusiness(host, "business/mines/" + widget.userid);
    locatePosition();
  }

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLng = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = CameraPosition(target: latLng, zoom: 13);
    googleMapController
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    setState(() {
      initialPosition = latLng;
    });
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      completer.complete(controller);
    });
    locatePosition();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Business>>(
      future: _businesses,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? placeMarkers(snapshot.data!)
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget placeMarkers(List<Business> list) {
    Set<Marker> markers = HashSet<Marker>();

    for (var i = 0; i < list.length; i++) {
      late double markerColor;
      if (list[i].status == 0) {
        markerColor = BitmapDescriptor.hueYellow;
      } else if (list[i].status == 1) {
        markerColor = BitmapDescriptor.hueOrange;
      } else if (list[i].status == 2) {
        markerColor = BitmapDescriptor.hueGreen;
      }
      markers.add(
        Marker(
          markerId: MarkerId(list[i].id),
          icon: BitmapDescriptor.defaultMarkerWithHue(markerColor),
          position: LatLng(
            list[i].latitude,
            list[i].longitude,
          ),
          infoWindow: InfoWindow(
            title: list[i].title,
          ),
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                    color: Color(color41),
                  ),
                  child: ListView(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            list[i].title.toUpperCase(),
                            textDirection: textDirection,
                            style: TextStyle(
                              color: Color(color42),
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            list[i].description,
                            textDirection: textDirection,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 63, 63, 63),
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      bottomSheetBtn(list[i].phone, Icons.phone),
                      bottomSheetBtn(
                          (list[i].email.toLowerCase() + "...")
                                  .substring(0, 15) +
                              "...",
                          Icons.email),
                      bottomSheetBtn(
                          (list[i].address.toLowerCase() + "...")
                                  .substring(0, 10) +
                              "...",
                          Icons.place),
                      bottomSheetBtn(
                        list[i].delivery == 0
                            ? "ارسال رایگان"
                            : list[i].delivery.toString() + " " + "curncy".tr,
                        Icons.delivery_dining,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: myButton(
                          180,
                          "Enter".tr,
                          () async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            Get.to(
                              () => MyShop(
                                id: list[i].id,
                                token: preferences.getString("token")!,
                              ),
                            );
                          },
                          Color(color42),
                          Color(color42),
                          Color(color41),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      );
    }

    return Container(
      child: initialPosition == null
          ? Center(
              child: CircularProgressIndicator(
                color: Color(color21),
              ),
            )
          : GoogleMap(
              mapType: MapType.normal,
              buildingsEnabled: true,
              compassEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              indoorViewEnabled: true,
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: true,
              zoomControlsEnabled: true,
              initialCameraPosition: CameraPosition(
                target: initialPosition!,
                zoom: 13,
              ),
              mapToolbarEnabled: true,
              onMapCreated: _onMapCreated,
              markers: markers,
            ),
    );
  }

  Widget bottomSheetBtn(
    String value,
    IconData iconData,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 15,
          bottom: 5,
          left: 20,
          right: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(color42),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Icon(
                  iconData,
                  size: 35,
                  color: Color(color41),
                ),
              ),
            ),
            Text(
              value,
              textDirection: textDirection,
              style: TextStyle(
                fontSize: 18,
                color: Color(color42),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
