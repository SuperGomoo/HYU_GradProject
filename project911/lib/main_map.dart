import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';

void main() {
  runApp(MainMap());
}

class MainMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // GlobalKey 생성

class _MapScreenState extends State<MapScreen> {
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();
  late GoogleMapController _mapController;
  LatLng? _currentLatLng;
  String _currentAddress = "Fetching location...";
  Marker? _currentMarker;
  List<Marker> _markers = [];
  bool _showOptions = true; // 옵션 버튼 표시 여부
  bool _erLocations = false;
  bool _isneurology = false;
  bool _isneurosurgery = false;
  bool _isburns = false;
  bool _istrauma = false;
  bool _iscardiology = false;
  bool _isthoracic = false;
  bool _ispediatric = false;
  bool _isdeliveryRoom = false;
  bool _isoperatingRoom = false;
  bool _istraumaDedicated = false;
  bool _isCT = false;
  bool _isMRI = false;
  bool _isangiography = false;
  bool _isventilator = false;
  List<String> searchDetail = [];

  // 패널 컨트롤러
  final SlidingUpPanelController _panelController = SlidingUpPanelController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 위치 서비스 활성화 여부 확인
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // 위치 서비스가 비활성화된 경우
      setState(() {
        _currentAddress = "위치 서비스가 비활성화되어 있습니다.";
      });
      return;
    }

    // 위치 권한 확인 및 요청
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _currentAddress = "위치 권한이 거부되었습니다.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _currentAddress = "위치 권한이 영구적으로 거부되었습니다.";
      });
      return;
    }

    // 현재 위치 가져오기
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLatLng = LatLng(position.latitude, position.longitude);
      _addMarker(_currentLatLng!);
    });
    // API 호출해서 장소 마커 추가
    await _fetchNearbyPlaces();
  }

  // API 호출해서 장소 데이터 받아오기
  Future<void> _fetchNearbyPlaces() async {
    // 예시 API URL (실제로는 구글 Places API 등을 사용)
    final String apiUrl =
        'http://apis.data.go.kr/B552657/ErmctInfoInqireService/getEgytLcinfoInqireWGS84_LAT=${_currentLatLng!.latitude}&WGS84_LON=${_currentLatLng!.longitude}&pageNo=1&numOfRows=10&Servicekey=o6QdRHx5EjRpijD40C%2BwPguFWSege4mpICPd17sU0Lw7PA0SVocGHZvyM%2BJFKbf9TkYgbrqCHUuG5z4ukEWjXQ%3D%3D';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List places = json.decode(response.body);

      // 받은 장소 목록을 마커로 지도에 표시
      setState(() {
        _markers = places.map((place) {
          return Marker(
            markerId: MarkerId(place['id'].toString()),
            position: LatLng(place['lat'], place['lng']),
            infoWindow: InfoWindow(title: place['name']),
          );
        }).toList();
      });
    } else {
      throw Exception('Failed to load places');
    }
  }

  // 현재 위치로 이동하는 함수
  void _goToCurrentLocation() {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _currentLatLng!,
          zoom: 14.0,
        ),
      ),
    );
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _currentAddress =
          "${place.street}, ${place.subLocality}, ${place.locality}";
        });
      }
    } catch (e) {
      setState(() {
        _currentAddress = "Failed to fetch address.";
      });
    }
  }

  void _addMarker(LatLng position) {
    setState(() {
      _currentMarker = Marker(
        markerId: MarkerId("currentLocation"),
        position: position,
        infoWindow: InfoWindow(title: "Your Location", snippet: _currentAddress),
      );
    });
    _mapController.animateCamera(CameraUpdate.newLatLngZoom(position, 15.0));
  }
  // 초기 카메라 위치 설정 (샘플 위치: 서울)
  final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(37.5665, 126.9780), // 서울의 위도와 경도
    zoom: 12.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Scaffold에 키 설정
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                leading: Icon(
                  Icons.stars,
                  color: Color(0xffAD0000),
                ),
                title: Text("즐겨찾기",),
                textColor: Colors.white,
                tileColor: Color(0xffB67B7B),
                onTap: () {
                  Navigator.pop(context); // Drawer 닫기
                  // 원하는 동작 추가
                },
              ),
              ListTile(
                leading: Icon(Icons.pin_drop_rounded),
                title: Text("내 주변 응급실 찾기"),
                textColor: Colors.white,
                tileColor: Color(0xffD0C1C1),
                onTap: () {
                  Navigator.pop(context); // Drawer 닫기
                  // 원하는 동작 추가
                },
              ),
              ListTile(
                leading: Icon(Icons.pin_drop_rounded),
                title: Text("비상진료 문 여는 병원 찾기"),
                textColor: Colors.white,
                tileColor: Color(0xffD0C1C1),
                onTap: () {
                  Navigator.pop(context); // Drawer 닫기
                  // 원하는 동작 추가
                },
              ),
              ListTile(
                title: Text("응급실조건검색"),
                onTap: () {
                  Navigator.pop(context);
                  _panelController.expand();// Drawer 닫기
                  // 원하는 동작 추가
                },
              ),
              ListTile(
                title: Text("업무포탈(의료인)AED관리"),
                onTap: () {
                  Navigator.pop(context); // Drawer 닫기
                  // 원하는 동작 추가
                },
              ),
              ListTile(
                title: Text("공지사항"),
                onTap: () {
                  Navigator.pop(context); // Drawer 닫기
                  // 원하는 동작 추가
                },
              ),
              ListTile(
                title: Text("푸쉬알람 설정"),
                onTap: () {
                  Navigator.pop(context); // Drawer 닫기
                  // 원하는 동작 추가
                },
              ),
            ],
          ),
        )
      ),
      body: Stack(
        children: [
          // Google Map 위젯
          GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            markers: _currentMarker != null ? {_currentMarker!} : {},
          ),
          // 검색창이 포함된 AppBar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                color: Color(0xffAD0000),
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                height: 90.0, // AppBar 높이 조절
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.more_vert),
                      iconSize: 50,
                      color: Colors.white,
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();  // 설정된 scaffoldkey를 활용하여 Drawer 열기
                      },
                    ),
                    // 검색창
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search, // 검색창 내부 아이콘
                            color: Colors.black54,
                            size: 28.0,
                          ),
                          hintText: '질병, 진료과, 병원을 검색해보세요.',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 16.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0), // 원형 테두리
                            borderSide: BorderSide.none, // 테두리 제거
                          ),
                        ),
                        onSubmitted: (value) {
                          _searchLocation(value);
                        },
                      ),
                    ),
                    // 닫기 아이콘
                    if (_isSearching)
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.black54,
                        ),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _isSearching = false;
                          });
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 170,
            left: 23,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              child: Column(
                children: [
                  Icon(Icons.location_on,
                    color: Color(0xffAD0000),
                  ),
                  Text(
                      '현재위치',
                      style: TextStyle(fontSize: 10))
                ],
              ),
              onPressed: () {
                _goToCurrentLocation();
                },
            ),
          ),
          Positioned(
            top: 240,
            left: 23,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              child: Column(
                children: [
                  Icon(Icons.minor_crash,
                    color: Color(0xffAD0000),
                  ),
                  Text(
                      '내손안에',
                      style: TextStyle(fontSize: 10)
                  ),
                  Text(
                      '응급실',
                      style: TextStyle(fontSize: 10)
                  )
                ],
              ),
              onPressed: () {
              },
            ),
          ),
      // 좌측 하단의 옵션 버튼
      Positioned(
          bottom: _showOptions ? 100.0 : 200.0,
          left: _showOptions ? 5.0 : 20.0, // 확장 여부에 따라 위치 변경
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 메인 옵션 버튼
              FloatingActionButton.extended(
                  label: Text(
                    _showOptions ? "옵션닫기" : "옵션열기",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  heroTag: "mainOption",
                  onPressed: () {
                    setState(() {
                      _showOptions = !_showOptions; // 옵션 버튼 표시/숨기기
                    });
                  },
                  backgroundColor: Color(0xffB97469),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )
              ),
              if (_showOptions)
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // 메뉴 아이콘
                    // 옵션 버튼들 (조건별 마커 추가)
                      FloatingActionButton.large(
                        heroTag: "er",
                        onPressed: () {
                          setState(() {
                            _erLocations = !_erLocations;
                          });
                          _fetchNearbyPlaces(); // 옵션에 따라 장소 받아오기
                        },
                        backgroundColor: Colors.white,
                        child: Column(
                          children: [
                            Icon(
                              Icons.medical_services,
                              size: 70,
                              color: _erLocations ? Color(0xffAD0000) : Color(0xff707070)
                            ),
                            Text(
                              '응급실',
                              style: TextStyle(
                                color: _erLocations ? Color(0xffAD0000) : Color(0xff707070),
                                fontSize: 11
                              ),
                            )
                          ],
                        ),
                      ),
                      FloatingActionButton.large(
                        heroTag: "children",
                        onPressed: (){},
                        backgroundColor: Colors.white,
                        child: Column(
                          children: [
                            Icon(
                              Icons.child_care,
                              size: 70,
                              color: Color(0xff707070)
                            ),
                            Text(
                              '달빛어린이병원',
                              style: TextStyle(
                                color: Color(0xff707070),
                                fontSize: 11
                              ),
                            )
                          ],
                        ),
                      ),
                      FloatingActionButton.large(
                        heroTag: "aed",
                        onPressed: (){},
                        backgroundColor: Colors.white,
                        child: Column(
                          children: [
                            Icon(
                              Icons.monitor_heart,
                              size: 60,
                              color: Color(0xff707070)
                            ),
                            Text(
                              'AED',
                              style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 11
                              ),
                            ),
                            Text(
                              '자동심장충격기',
                              style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 11
                              ),
                            )
                          ],
                        )
                      ),
                      FloatingActionButton.large(
                        heroTag: "filter",
                        onPressed: (){
                          _panelController.expand();
                        },
                        backgroundColor: Colors.white,
                        child: Column(
                          children: [
                            Icon(
                              Icons.manage_search,
                              size: 70,
                              color: Color(0xff707070)
                            ),
                            Text(
                              '응급실조건검색',
                              style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 11
                              ),
                            )
                          ],
                        )
                      ),
                  ],
              )
            ],
          )
      ),
          // Sliding Up Panel
          SlidingUpPanelWidget(
            panelController: _panelController, // 패널 컨트롤러
            controlHeight: 50.0, // 최대 높이
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0),
              decoration: ShapeDecoration(
                color: Colors.white,
                shadows: [BoxShadow(blurRadius: 5.0,spreadRadius: 2.0,color: const Color(0x11000000))],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    )
                ),
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 350,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    child: Text(
                      '종별전체',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                      textAlign: TextAlign.center,
                    )
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 175,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                        child: Text(
                          '전국',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 175,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                        child: Text(
                          '전체',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _isneurology,
                          onChanged: (value) {
                            setState(() {
                              _isneurology = value!;
                            });
                          },
                        ),
                        Text("전체")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _isneurology,
                          onChanged: (value) {
                            setState(() {
                              _isneurology = value!;
                              checkedList(_isneurology, '신경과');
                            });
                          },
                        ),
                        Text("신경과중환자실")
                      ],
                    ),
                  ),
                  Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _isneurosurgery,
                        onChanged: (value) {
                          setState(() {
                            _isneurosurgery = value!;
                            checkedList(_isneurosurgery, '신경외과');
                          });
                        },
                      ),
                      Text("신경외과중환자실")
                    ],
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _isburns,
                          onChanged: (value) {
                            setState(() {
                              _isburns = value!;
                              checkedList(_isburns, '화상');
                            });
                          },
                        ),
                        Text("화상중환자실")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _istrauma,
                          onChanged: (value) {
                            setState(() {
                              _istrauma = value!;
                              checkedList(_istrauma, '외상');
                            });
                          },
                        ),
                        Text("외상중환자실")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _iscardiology,
                          onChanged: (value) {
                            setState(() {
                              _iscardiology = value!;
                              checkedList(_iscardiology, '심장내과');
                            });
                          },
                        ),
                        Text("심장내과중환자실")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _isthoracic,
                          onChanged: (value) {
                            setState(() {
                              _isthoracic = value!;
                              checkedList(_isthoracic, '흉부외과');
                            });
                          },
                        ),
                        Text("흉부외과중환자실")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _ispediatric,
                          onChanged: (value) {
                            setState(() {
                              _ispediatric = value!;
                              checkedList(_ispediatric, '소아응급');
                            });
                          },
                        ),
                        Text("소아응급전용 중환자실")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _isdeliveryRoom,
                          onChanged: (value) {
                            setState(() {
                              _isdeliveryRoom = value!;
                              checkedList(_isdeliveryRoom, '분만실');
                            });
                          },
                        ),
                        Text("분만실")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _isoperatingRoom,
                          onChanged: (value) {
                            setState(() {
                              _isoperatingRoom = value!;
                              checkedList(_isoperatingRoom, '수술실');
                            });
                          },
                        ),
                        Text("수술실")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _istraumaDedicated,
                          onChanged: (value) {
                            setState(() {
                              _istraumaDedicated = value!;
                              checkedList(_istraumaDedicated, '외상전용');
                            });
                          },
                        ),
                        Text("외상전용 응급실")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _isCT,
                          onChanged: (value) {
                            setState(() {
                              _isCT = value!;
                              checkedList(_isCT, 'CT');
                            });
                          },
                        ),
                        Text("CT")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _isMRI,
                          onChanged: (value) {
                            setState(() {
                              _isMRI = value!;
                              checkedList(_isMRI, 'MRI');
                            });
                          },
                        ),
                        Text("MRI")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _isangiography,
                          onChanged: (value) {
                            setState(() {
                              _isangiography = value!;
                              checkedList(_isangiography, '혈관촬영기');
                            });
                          },
                        ),
                        Text("혈관촬영기")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _isventilator,
                          onChanged: (value) {
                            setState(() {
                              _isventilator = value!;
                              checkedList(_isventilator, '인공호흡기');
                            });
                          },
                        ),
                        Text("인공호흡기")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
    ])
    );
  }

  void checkedList(bool isCheck, String name) {
    if (isCheck) {
      searchDetail.add(name);
    }
  }

  // 위치 검색 메서드 (검색어를 기반으로 지도 이동)
  Future<void> _searchLocation(String query) async {
      // TODO: 검색 기능 구현 (예: Geocoding API 사용)
      print('Searching for: $query');

      // 검색 결과를 기반으로 카메라 이동 (샘플: 서울)
      if (query.toLowerCase() == "seoul") {
        _mapController.animateCamera(
          CameraUpdate.newLatLng(LatLng(37.5665, 126.9780)), // 서울 위치로 이동
        );
      } else {
        // 예외 처리 (검색 결과가 없을 때)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No results for "$query"')),
        );
      }
  }
}