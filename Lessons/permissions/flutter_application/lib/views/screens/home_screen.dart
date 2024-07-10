import 'package:flutter/material.dart';
import 'package:flutter_application/services/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController myController;
  LatLng myLocation = const LatLng(41.2856806, 69.2034646);
  Set<Marker> myMarkers = {};
  Set<Polyline> polylines = {};
  List<LatLng> myPositions = [];
  TextEditingController googleTextEditingController = TextEditingController();
  bool searchedLocation = false;
  LatLng? currentLocation;
  bool isFetchingAddress = false;
  List<String> transportOptions = ['Driving', 'Walking', 'Bicycling'];
  List<String> viewOptions = ['Normal', 'Terrain', 'Sattelite'];
  List<MapType> mapTypeOptions = [
    MapType.normal,
    MapType.terrain,
    MapType.hybrid
  ];
  int mapTypeIndex = 0;

  void transportOptionSelected(String transportOption) async {
    if (myPositions.length >= 2) {
      var points = await LocationService.fetchPolylinePoints(
        myPositions[myPositions.length - 2],
        myPositions[myPositions.length - 1],
        transportOption.toLowerCase(),
      );
      setState(() {
        polylines.add(
          Polyline(
            polylineId: PolylineId(UniqueKey().toString()),
            color: Colors.blue,
            width: 5,
            points: points,
          ),
        );
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    myController = controller;
  }

  @override
  void initState() {
    super.initState();
    isFetchingAddress = true;
    Future.delayed(Duration.zero, () async {
      await LocationService.getCurrentLocation();
      currentLocation = LatLng(LocationService.currentLocation!.latitude!,
          LocationService.currentLocation!.longitude!);
    }).then((_) => setState(() {
          isFetchingAddress = false;
        }));
  }

  void onCameraMove(CameraPosition position) {
    myLocation = position.target;
    setState(() {});
  }

  void addLocationMarker() async {
    setState(() {
      myMarkers.add(
        Marker(
          markerId: MarkerId(UniqueKey().toString()),
          position: myLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );

      myPositions.add(myLocation);

      if (myPositions.length >= 2) {
        transportOptionSelected('driving');
      }
    });
  }

  void _updateLocation(LatLng newLocation) async {
    setState(() {
      myPositions.add(currentLocation!);
      addLocationMarker();
      currentLocation = newLocation;
      myLocation = newLocation;
      myController.animateCamera(CameraUpdate.newLatLng(newLocation));
      addLocationMarker();

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Choose Transport'),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                      'Which transport do you want to use for the trip?'),
                  ...List.generate(transportOptions.length, (int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        transportOptionSelected(
                            transportOptions[index].toLowerCase());
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        height: 50,
                        width: double.infinity,
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black)),
                        child: Text(
                          transportOptions[index],
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ),
                    );
                  })
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Confirm'),
                ),
              ],
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: GooglePlacesAutoCompleteTextFormField(
            keyboardType: TextInputType.text,
            textEditingController: googleTextEditingController,
            decoration: InputDecoration(
              fillColor: const Color.fromARGB(205, 255, 255, 255),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              hintText: "Search location",
            ),
            googleAPIKey: "AIzaSyAwm88ULyquBykcwNDR7t7rCDhvNGstFSo",
            debounceTime: 400,
            isLatLngRequired: true,
            getPlaceDetailWithLatLng: (prediction) {
              if (prediction.lat != null && prediction.lng != null) {
                final newLocation = LatLng(
                  double.parse(prediction.lat!),
                  double.parse(prediction.lng!),
                );
                _updateLocation(newLocation);
              }
            },
            itmClick: (prediction) {
              googleTextEditingController.text = prediction.description!;
              googleTextEditingController.selection =
                  TextSelection.fromPosition(
                TextPosition(offset: prediction.description!.length),
              );
            },
          ),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'Sattelite') {
                  mapTypeIndex = 2;
                } else if (value == 'Terrain') {
                  mapTypeIndex = 1;
                } else {
                  mapTypeIndex = 0;
                }
                setState(() {});
              },
              itemBuilder: (BuildContext context) {
                return viewOptions.map((String option) {
                  return PopupMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList();
              },
              child: Container(
                width: 60,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.green,
                ),
                padding: EdgeInsets.all(10),
                child: Icon(Icons.map, size: 30),
              ),
            ),
            const SizedBox(width: 10)
          ],
        ),
        body: isFetchingAddress
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  GoogleMap(
                    compassEnabled: true,
                    trafficEnabled: true,
                    onMapCreated: _onMapCreated,
                    mapType: mapTypeOptions[mapTypeIndex],
                    initialCameraPosition:
                        CameraPosition(target: currentLocation!, zoom: 15),
                    polylines: polylines,
                    markers: myMarkers,
                    onCameraMove: onCameraMove,
                  ),
                  const Align(
                    child: Icon(
                      Icons.place,
                      color: Colors.blue,
                      size: 60,
                    ),
                  )
                ],
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
            onPressed: addLocationMarker, child: const Icon(Icons.add)));
  }
}
