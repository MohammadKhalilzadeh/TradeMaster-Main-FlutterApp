// it's okay
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trader/components/alerts.dart';
import 'package:trader/pages/new_shop_form.dart';
import 'package:trader/variables/myvariables.dart';
import 'package:get/get.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  Position? currentPosition;
  var geoLocator = Geolocator();
  GoogleMapController? googleMapController;

  Completer<GoogleMapController> completer = Completer<GoogleMapController>();
  static LatLng? initialPosition;
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
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

  addMarker(coordinates) {
    markers.clear();
    int id = Random().nextInt(2000000);
    setState(() {
      markers.add(Marker(
        markerId: MarkerId(id.toString()),
        position: coordinates,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(color42),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Color(color41),
        ),
        title: Text(
          "cl".tr,
          style: TextStyle(
            color: Color(color41),
            fontFamily: fontfamily,
          ),
        ),
      ),
      body: initialPosition == null
          ? Center(
              child: CircularProgressIndicator(
                color: Color(color42),
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
                zoom: 12,
              ),
              mapToolbarEnabled: true,
              onMapCreated: _onMapCreated,
              onLongPress: (coordinates) {
                addMarker(coordinates);
              },
              markers: markers.toSet(),
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            if (markers.isEmpty) {
              showMyDialog(context, "err".tr, "اول یک مکان انتخاب کن");
            } else {
              Get.to(
                () => NewShopForm(
                  latLng: markers[0].position,
                ),
              );
            }
          },
          backgroundColor: Color(color42),
          child: Text(
            "nxt".tr,
            style: TextStyle(
              color: Color(color41),
              fontFamily: fontfamily,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
