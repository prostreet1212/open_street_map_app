import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  //final _mapController=MapController.withPosition(initPosition: GeoPoint(latitude: 1,longitude: 2));
   MapController _mapController = MapController
       .withUserPosition(
      trackUserLocation: UserTrackingOption(
        enableTracking: true,
        unFollowUser: true,
      ),
   );

   @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _mapController.listenerMapSingleTapping.addListener(()async {
        var position=_mapController.listenerMapSingleTapping.value;
        if(position!=null){
          await _mapController.addMarker(position,markerIcon: MarkerIcon(
            icon: Icon(Icons.pin_drop,color:Colors.blue,size: 48 ,),
          ));
        }

      });
    });
  }

  @override
  void dispose() {
  _mapController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return  OSMFlutter(
      controller: _mapController,
      osmOption: OSMOption(
        /*zoomOption: ZoomOption(
          initZoom: 12,
          minZoomLevel: 4,
          maxZoomLevel: 14,
          stepZoom: 1,
        ),*/
       /* userLocationMarker: UserLocationMaker(
          personMarker: MarkerIcon(
            icon: Icon(
              Icons.personal_injury,
              color: Colors.black,
              size: 48,),
          ),
          directionArrowMarker: MarkerIcon(
            icon: Icon(
              Icons.location_on,
              color: Colors.black,
              size: 48,
            ),
          ),

        ),
        markerOption: MarkerOption(
          defaultMarker: MarkerIcon(
            icon: Icon(Icons.person_pin_circle,
              color: Colors.black,size: 48,),
          ),
        ),
        roadConfiguration: RoadOption(
          roadColor: Colors.blueGrey
        )*/
      ),
      /*onMapIsReady: (isReady)async{
        if(isReady){
          await Future.delayed(Duration(seconds: 1),()async{
           await _mapController.currentLocation();
           GeoPoint b=await _mapController.getCurrentPositionAdvancedPositionPicker();
           print('LOCATION: ${b.latitude}:${b.longitude}');
          });


        }
      },*/
      mapIsLoading: Center(child: CircularProgressIndicator()),

    );




      /*FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(51.509364, -0.128928),
          initialZoom: 9.2,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),*/

  }
}



