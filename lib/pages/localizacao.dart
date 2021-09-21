import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';

/*
  Exemplo de utilização do GPS.
  Pacotes necessários:
  location: ^4.3.0
      Utilizado para acessar a localização (GPS do dispositivo)
  
  flutter_map: any
      Utilizado para mostrar um mapa

*/

class Localizacao extends StatefulWidget {
  const Localizacao({Key? key}) : super(key: key);

  @override
  State<Localizacao> createState() => _LocalizacaoState();
}

class _LocalizacaoState extends State<Localizacao> {
  //utilizado para indicar se o serviço de localização
  //está habilitado no dispositivo
  bool _serviceEnabled = false;
  //utilizado para verificar se o usuário deu permissão para
  //acessar o serviço de GPS
  late PermissionStatus _permissionGranted;
  //objeto para acessar a localização
  final location = Location();
  //objeto que representa uma localização. O late
  //indica que será inicializado posteriormente.
  late LocationData _locationData;

  double? latitude = 0.0;
  double? longitude = 0.0;
  double? altitude = 0.0;

  //utilizado para converter a localização atual em um tipo LatLng
  //que é utilizado no mapa.
  LatLng _currentLocation = LatLng(0, 0);

  final MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    //precisa verificar se o usuário deu permissão para o
    //serviço de GPS.
    verificaPermissoes();

    //mudamos o tempo de leitura da mudança de posição,
    //importante para diminuir o consumo de bateria
    location.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 1000,
    );
  }

  //método para verificar e requisitar permissão do usuário
  //para que o app possa utilizar o serviço de GPS.
  verificaPermissoes() async {
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
  }

  //método que acessa o GPS e salva uma nova localização.
  tryGetLocation() async {
    _locationData = await location.getLocation();

    setState(() {
      latitude = _locationData.latitude;
      longitude = _locationData.longitude;
      altitude = _locationData.altitude;
      _currentLocation = LatLng(latitude ?? 0.0, longitude ?? 0.0);
      mapController.move(LatLng(latitude ?? 0.0, longitude ?? 0.0), 18.0);
    });
  }

  //tela que mostra a localização atual
  //bem como um mapa com um pin da localização atual.

  @override
  Widget build(BuildContext context) {
    tryGetLocation();
    return Scaffold(
      appBar: AppBar(
        title: Text('Localização'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Longitude $longitude"),
          Text("Latitude $latitude"),
          Text("Altitude $altitude"),
          ElevatedButton(
            onPressed: tryGetLocation,
            child: Text("Minha localização"),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  center: _currentLocation,
                  zoom: 13.0,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                    attributionBuilder: (_) {
                      return Text("© OpenStreetMap contributors");
                    },
                  ),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: _currentLocation,
                        builder: (ctx) => Container(
                          child: Icon(Icons.location_pin),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
