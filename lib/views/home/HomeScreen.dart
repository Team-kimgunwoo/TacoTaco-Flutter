import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:tacotaco_flutter/viewmodels/home/HomeViewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel()
        ..updateUserLocation()
        ..fetchServerLocation()
        ..sendFCMTokenToServer()
        ..getEmotion(),
      child: const _HomeScreenBody(),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody();

  String _emotionMessage(String emotionType) {
    switch (emotionType) {
      case 'WAR':
        return '계엄령 선포!!';
      case 'BASEBALL':
        return '야구할 사람 찾는중...';
      case 'MART':
        return '마트갈 사람 찾는중...';
      case 'OUTING':
        return '외출중...';
      case 'COUNSEL':
        return '상담 하는중...';
      case 'DROP':
        return '자퇴 고민중...';
      default:
        return emotionType;
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final markers = viewModel.annotationItems.map((item) => Marker(
      point: LatLng(item.latitude, item.longitude),
      width: 40,
      height: 40,
      builder: (_) => Icon(
        item.isUserLocation ? Icons.person_pin_circle : Icons.location_on,
        color: item.isUserLocation ? Colors.blue : Colors.red,
        size: 36,
      ),
    )).toList();

    final user = viewModel.annotationItems.firstWhere(
          (item) => item.isUserLocation,
      orElse: () => CoordinateItem(latitude: 0, longitude: 0, isUserLocation: true),
    );

    return Scaffold(
      body: Stack(
        children: [
          if (viewModel.annotationItems.isNotEmpty)
            FlutterMap(
              options: MapOptions(
                center: LatLng(user.latitude, user.longitude),
                zoom: 18,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                  userAgentPackageName: 'com.example.tacotaco_flutter',
                ),
                MarkerLayer(markers: markers),
              ],
            )
          else
            const Center(child: CircularProgressIndicator()),

          // 프로필 버튼
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

          // 하단 카드
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("지금 건우는?", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.blue)),
                      const SizedBox(height: 4),
                      Text(_emotionMessage("알 수 없음"), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: viewModel.sendTouchRequest,
                        icon: const Icon(Icons.touch_app, color: Colors.black),
                      ),
                      IconButton(
                        onPressed: viewModel.makeCall,
                        icon: const Icon(Icons.phone, color: Colors.black),
                      ),
                      IconButton(
                        onPressed: viewModel.sendMessage,
                        icon: const Icon(Icons.message, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      drawer: const Drawer(child: Center(child: Text("MypageView Placeholder"))),
    );
  }
}
