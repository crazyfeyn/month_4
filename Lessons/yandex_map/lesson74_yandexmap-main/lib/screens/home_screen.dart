import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:lesson74_yandexmap/services/yandex_map_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();
  late YandexMapController mapController;
  List<MapObject>? polylines;
  List<SearchItem> searchResults = [];

  Point myCurrentLocation = const Point(
    latitude: 41.2856806,
    longitude: 69.9034646,
  );

  Point najotTalim = const Point(
    latitude: 41.2856806,
    longitude: 69.2034646,
  );

  void onMapCreated(YandexMapController controller) {
    mapController = controller;
    mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: najotTalim,
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
          BoundingBox(
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
      print('Error retrieving search results: $e');
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

  void selectLocation(SearchItem item) {
    print(item.geometry);
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
                        padding: EdgeInsets.all(7),
                        width: 57,
                        height: 57,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFF191F1D)),
                        child: Icon(
                          Icons.add,
                          color: Color(0xFFCCCCCE),
                          size: 30,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        mapController.moveCamera(CameraUpdate.zoomOut());
                      },
                      child: Container(
                        padding: EdgeInsets.all(7),
                        width: 57,
                        height: 57,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFF191F1D)),
                        child: Icon(
                          Icons.remove,
                          color: Color(0xFFCCCCCE),
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10)
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF111111),
                  ),
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                    controller: textEditingController,
                    onChanged: searchLocation,
                    onSubmitted: (value) {
                      if (searchResults.isNotEmpty) {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: searchResults.length,
                                    itemBuilder: (context, index) {
                                      final item = searchResults[index];
                                      return ListTile(
                                        title: Text(
                                          item.name,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        onTap: () {
                                          selectLocation(item);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
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



//  padding: EdgeInsets.only(top: 12),
//                               decoration: BoxDecoration(
//                                   color: Color(0xFF1B1C1F),
//                                   borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(20),
//                                       topRight: Radius.circular(20))),