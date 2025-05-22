import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/Home/HomeViewmodel.dart';
import '../../widgets/card/StatusCard.dart';
import 'HomeDrawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: const _HomeScreenBody(),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final userLocation = viewModel.userLocation;
    final markers = viewModel.locations;

    return Scaffold(
      drawer: const HomeDrawer(),
      body: Stack(
        children: [
          if (userLocation != null)
            FlutterMap(
              options: MapOptions(
                center: userLocation,
                zoom: 18,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                  userAgentPackageName: 'com.example.tacotaco',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: userLocation,
                      width: 40,
                      height: 40,
                      builder: (_) => const Icon(Icons.person_pin_circle, color: Colors.blue, size: 36),
                    ),
                    ...markers.map(
                          (e) => Marker(
                        point: e.toLatLng(),
                        width: 40,
                        height: 40,
                        builder: (_) => const Icon(Icons.location_on, color: Colors.red, size: 36),
                      ),
                    )
                  ],
                ),
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
