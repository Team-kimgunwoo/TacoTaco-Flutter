import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tacotaco_flutter/widgets/card/StatusCard.dart';
import 'package:tacotaco_flutter/views/home/HomeDrawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      body: Stack(
        children: [
          // flutter_map 지도
          FlutterMap(
            options: MapOptions(
              center: LatLng(37.5665, 126.9780),
              zoom: 18.0,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.tacotaco',
              ),
            ],
          ),


          // 오른쪽 상단 프로필 버튼
          Positioned(
            top: 40,
            right: 20,
            child: Builder(
              builder: (context) => GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: const CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
            ),
          ),

          // 유저 위치 마커 예시 (flutter_map Marker로 변경 가능)
          Positioned(
            top: 300,
            left: 150,
            child: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150'), // 유저 프로필 이미지 URL
            ),
          ),

          // 하단 카드
          const Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: StatusCard(),
          ),
        ],
      ),
    );
  }
}
