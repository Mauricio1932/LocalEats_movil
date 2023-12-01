import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localeats/features/maps/domain/entities/entities.dart';
import 'package:localeats/features/maps/presentation/bloc/bloc_maps/maps_event.dart';
import 'package:location/location.dart';

import '../bloc/bloc_maps/Mapsbloc.dart';
// import '../bloc/bloc_maps/maps_event.dart';
import '../bloc/bloc_maps/maps_state.dart';

import 'package:geolocator/geolocator.dart';
// import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;

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
  String location = "";
  Completer<GoogleMapController> _controller = Completer();
  LocationData? _locationData;
  Set<Polyline> _polylines = Set<Polyline>();
  bool _isFetchingData = false;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    try {
      _locationData = await location.getLocation();
    } catch (e) {
      print('Error obteniendo la ubicación: $e');
      return;
    }

    if (!mounted) return;

    setState(() {
      _isFetchingData = true;
    });

    await _addPolyline(); // Asegúrate de que se llame aquí

    setState(() {
      _isFetchingData = false;
    });
  }

  Future<void> _addPolyline() async {
    if (_locationData == null ||
        _locationData!.latitude == null ||
        _locationData!.longitude == null) {
      print('Error: _locationData no está inicializado correctamente.');
      return;
    }

    final String apiKey = 'AIzaSyDT9EQipVS1JsJAX5iM3vbGmtm_eMFk5_Q';
    final String origin =
        '${_locationData!.latitude},${_locationData!.longitude}';
    final String destination = '16.614466,-93.092170';
    final String apiUrl =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$location&key=$apiKey';

    try {
      final http.Response response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'OK') {
          final List<LatLng> polylinePoints =
              _decodePolyline(data['routes'][0]['overview_polyline']['points']);
          _polylines.add(Polyline(
            polylineId: PolylineId('ruta'),
            points: polylinePoints,
            color: Colors.blue,
            width: 5,
          ));
          print('Polilínea agregada correctamente.');
        } else {
          print(
              'Error en la respuesta de la API de direcciones: ${data['status']}');
        }
      } else {
        print('Error al obtener la ruta: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la solicitud HTTP: $e');
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0;
    int len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1e5, lng / 1e5));
    }

    return points;
  }

  @override
  Widget build(BuildContext context) {
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
            // getCurrentLocation();
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

          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(0.0, 0.0), // Latitud y Longitud iniciales.
              zoom: 15.0,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              // Puedes realizar operaciones adicionales cuando se crea el mapa.
            },
            markers: {
              // Marker(
              //   markerId: MarkerId("ubicacion_actual"),
              //   position: LatLng(
              //     _locationData!.latitude!,
              //     _locationData!.longitude!,
              //   ),
              //   infoWindow: InfoWindow(title: "Tu ubicación actual"),
              // ),
              Marker(
                markerId: MarkerId("punto_destino"),
                position: LatLng(
                  latitud,
                  longitud,
                ),
                infoWindow: InfoWindow(title: "Punto de destino"),
              ),
            },
            polylines: _polylines,
          );
        },
      ),
    );
  }
}
