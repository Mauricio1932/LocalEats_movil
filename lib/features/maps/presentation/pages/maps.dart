import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localeats/features/maps/domain/entities/entities.dart';
import 'package:localeats/features/maps/presentation/bloc/bloc_maps/maps_event.dart';

import '../bloc/bloc_maps/Mapsbloc.dart';
// import '../bloc/bloc_maps/maps_event.dart';
import '../bloc/bloc_maps/maps_state.dart';

import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoicGl0bWFjIiwiYSI6ImNsY3BpeWxuczJhOTEzbnBlaW5vcnNwNzMifQ.ncTzM4bW-jpq-hUFutnR1g';

class MapScreen extends StatefulWidget {
  final int id2;

  const MapScreen(this.id2, {Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late double latitud;
  late double longitud;

  void getCurrentLocation() async {
    Position position = await determinePosition();
    setState(() {
      myPosition = LatLng(latitud, longitud);
      // myPosition = LatLng(position.latitude, position.longitude);
      print(myPosition);
    });
  }

  LatLng? myPosition;

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    var location = "";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ubicacion"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<MapsBloc, MapsState>(
        builder: (context, state) {
          if (state.ubicacionStatus == MapRequest.requestInProgress) {
            // Esta parte se ejecutará después de un retraso de 1 segundo
            return const CircularProgressIndicator();
          }

          if (state.ubicacionStatus == MapRequest.requestFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Problem loading products'),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        List<Maps> maps = [
                          Maps(id: widget.id2, ubicacion: ""),
                        ];
                        context.read<MapsBloc>().add(MapViewRequest(maps[0]));
                        print("estatus ${state.ubicacionStatus}");
                      },
                      child: const Text('Try again'))
                ],
              ),
            );
          }

          if (state.ubicacionStatus == MapRequest.requestSuccess) {
            // return const CircularProgressIndicator();
            location = state.ubicacion[0].ubicacion;

            List<String> ubicacionSplit = location.split(', ');

            latitud = double.parse(ubicacionSplit[0]);
            longitud = double.parse(ubicacionSplit[1]);
            getCurrentLocation();
          }
          if (state.ubicacionStatus == MapRequest.unknown) {
            // return const CircularProgressIndicator();

            List<Maps> userData = [
              Maps(id: widget.id2, ubicacion: ""),
            ];
            context.read<MapsBloc>().add(MapViewRequest(userData[0]));
          }
          // return Text("Nombre: ${state.ubicacion[0].ubicacion}");
          // return Text("Ubicación: ${widget.id2}");

          return myPosition == null
              ? const CircularProgressIndicator()
              : FlutterMap(
                  options: MapOptions(
                      center: myPosition, minZoom: 5, maxZoom: 25, zoom: 18),
                  nonRotatedChildren: [
                    TileLayer(
                      urlTemplate:
                          'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                      additionalOptions: const {
                        'accessToken': MAPBOX_ACCESS_TOKEN,
                        'id': 'mapbox/streets-v12'
                      },
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: myPosition!,
                          builder: (context) {
                            return Container(
                              child: const Icon(
                                Icons.person_pin,
                                color: Colors.blueAccent,
                                size: 40,
                              ),
                            );
                          },
                        )
                      ],
                    )
                  ],
                );
        },
      ),
    );
  }
}
