import 'package:flutter/material.dart';
import 'package:lesson74_yandexmap/services/location_services.dart';
import 'package:lesson74_yandexmap/services/yandex_map_service.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    LocationService.getCurrentLocation().then((value) {
      if (value != null) {
        setState(() {
          myCurrentLocation = Point(
            latitude: double.parse(value.latitude.toString()),
            longitude: double.parse(value.longitude.toString()),
          );
          exactCurrentLocation = Point(
            latitude: double.parse(value.latitude.toString()),
            longitude: double.parse(value.longitude.toString()),
          );
        });
        mapController.moveCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target:
                  myCurrentLocation ?? const Point(latitude: 0, longitude: 0),
              zoom: 20,
            ),
          ),
        );
      }
    });
  }

  TextEditingController textEditingController = TextEditingController();
  late YandexMapController mapController;
  List<MapObject>? polylines;
  List<SearchItem> searchResults = [];
  Point? myCurrentLocation;
  Point? exactCurrentLocation;

  Point najotTalim = const Point(
    latitude: 41.2856806,
    longitude: 69.2034646,
  );

  void centerLocation() {
    mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target:
              exactCurrentLocation ?? const Point(latitude: 0, longitude: 0),
          zoom: 20,
        ),
      ),
      animation:
          const MapAnimation(type: MapAnimationType.smooth, duration: 1.5),
    );
  }

  void onMapCreated(YandexMapController controller) {
    mapController = controller;
    mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: myCurrentLocation ?? const Point(latitude: 0, longitude: 0),
          zoom: 20,
        ),
      ),
    );
    setState(() {});
  }

  void searchLocation(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    try {
      final searchResultWithSession = await YandexSearch.searchByText(
        searchText: query,
        geometry: Geometry.fromBoundingBox(
          const BoundingBox(
            northEast: Point(latitude: 55.771899, longitude: 37.632206),
            southWest: Point(latitude: 55.771000, longitude: 37.631000),
          ),
        ),
        searchOptions: const SearchOptions(),
      );

      final searchResult = await searchResultWithSession.$2;

      setState(() {
        searchResults = searchResult.items ?? [];
      });
    } catch (e) {
      setState(() {
        searchResults = [];
      });
    }
  }

  void onCameraPositionChanged(
    CameraPosition position,
    CameraUpdateReason reason,
    bool finished,
  ) async {
    myCurrentLocation = position.target;

    setState(() {});
  }

  void selectLocation(SearchItem item) async {
    final Point selectedLocation = item.geometry[0].point!;

    polylines = await YandexMapService.getDirection(
        myCurrentLocation!, selectedLocation);

    setState(() {
      myCurrentLocation = selectedLocation;
      mapController.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: selectedLocation,
            zoom: 20,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          YandexMap(
            nightModeEnabled: true,
            onMapCreated: onMapCreated,
            onCameraPositionChanged: onCameraPositionChanged,
            mapType: MapType.vector,
            mapObjects: [
              PlacemarkMapObject(
                mapId: const MapObjectId("najotTalim"),
                point: najotTalim,
                icon: PlacemarkIcon.single(
                  PlacemarkIconStyle(
                    image: BitmapDescriptor.fromAssetImage(
                      "assets/route_start.png",
                    ),
                  ),
                ),
              ),
              ...?polylines,
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        mapController.moveCamera(CameraUpdate.zoomIn());
                      },
                      onLongPress: () {
                        mapController.moveCamera(CameraUpdate.zoomIn());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        width: 57,
                        height: 57,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFF191F1D)),
                        child: const Icon(
                          Icons.add,
                          color: Color(0xFFCCCCCE),
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        mapController.moveCamera(CameraUpdate.zoomOut());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        width: 57,
                        height: 57,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFF191F1D)),
                        child: const Icon(
                          Icons.remove,
                          color: Color(0xFFCCCCCE),
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () => centerLocation(),
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        width: 57,
                        height: 57,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFF191F1D)),
                        child: const Icon(
                          Icons.navigation_rounded,
                          color: Color(0xFF3D7DFF),
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10)
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF111111),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                    controller: textEditingController,
                    onChanged: searchLocation,
                    onSubmitted: (value) {
                      if (searchResults.isNotEmpty) {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              padding: const EdgeInsets.only(top: 12),
                              decoration: const BoxDecoration(
                                  color: Color(0xFF1B1C1F),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: searchResults.length,
                                      itemBuilder: (context, index) {
                                        final item = searchResults[index];
                                        return ListTile(
                                          title: Text(
                                            item.name,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          onTap: () {
                                            selectLocation(item);
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter location to search',
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Align(
            child: Icon(
              Icons.place,
              size: 60,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
