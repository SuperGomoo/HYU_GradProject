import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MainMap());
}

class MainMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  // 지도 초기 위치
  final LatLng _center = const LatLng(37.5665, 126.9780); // 서울 위치

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0), // AppBar 높이 조절
        child: AppBar(
          title: Text('질병, 진료과, 병원을 검색해보세요.'),
            backgroundColor: Color(0xffAD0000),
            leading: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
              // 메뉴 아이콘 클릭 시 동작
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // 검색 아이콘 클릭 시 동작
                },
              ),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  // 설정 아이콘 클릭 시 동작
                },
              ),
            ],
          ),
        ),
      body: GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 11.0,
      ),
    ),
    );
  }
}