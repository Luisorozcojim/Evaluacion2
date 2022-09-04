import 'package:evaluacion/screens/descubre/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Descubre extends StatefulWidget {
  const Descubre({Key? key}) : super(key: key);

  @override
  _DescubreState createState() => _DescubreState();
}

class _DescubreState extends State<Descubre> {

  List<String> chapalaImg = ['images/chapala1.jpg', 'images/chapala2.jpg', 'images/chapala3.jpg'];
  List<String> barrancaImg = ['images/barranca1.jpg', 'images/barranca2.jpg', 'images/barranca3.jpg'];
  List<String> tequilaImg = ['images/tequila1.jpg', 'images/tequila2.jpg', 'images/tequila3.jpg'];
  List<String> vallartaImg = ['images/vallarta1.jpg', 'images/vallarta2.jpg', 'images/vallarta3.jpg'];


  String chapala = 'Chapala es una ciudad mexicana, cabecera del municipio homónimo, en el estado de Jalisco. Se ubica a orillas del lago de Chapala, perteneciendo a la región Sureste. Su población en 2020 fue de 24 352 habitantes.';
  String tequila = 'Tequila es una ciudad del estado de Jalisco, en el centro de México. Es conocida por la producción de tequila. La ciudad está cerca de los pies del volcán de Tequila y la rodean campos del ingrediente principal de este licor, la planta del agave azul. El proceso de producción se puede observar en varias destilerías y haciendas. El Museo Nacional del Tequila y el Museo Los Abuelos tienen exhibiciones sobre la historia de esta bebida.';
  String barranca = 'La Barranca de Huentitán; también llamada Barranca de Oblatos, es un cañón y un área natural protegida en el estado de Jalisco, México, al norte del municipio de Guadalajara, en los límites de los municipios de Tonalá, Zapotlanejo, Ixtlahuacán del Río y Zapopan en la zona metropolitana de Guadalajara.';
  String vallarta = 'Puerto Vallarta es un balneario en la costa del Pacífico de México, en el estado de Jalisco. Es famoso por sus playas, los deportes acuáticos y la vida nocturna. En el centro con adoquines, se encuentra la adornada iglesia de Nuestra Señora de Guadalupe, además de tiendas de moda y una variedad de restaurantes y bares. El Malecón es un paseo costero con esculturas contemporáneas, bares, salones y clubes nocturnos.';


  LatLng latlngTequila = LatLng(20.880441, -103.841037);
  LatLng latlngBarranca = LatLng(20.706117053570296, -103.2830265448516);
  LatLng latlngVallarta = LatLng(20.653547778643226, -105.22744508253008);
  LatLng latlngChapala = LatLng(20.303834179116794, -103.20054871299978);





  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Text('Discover new destinations from Jalisco',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(height: 50,),

                tile('Tequila', tequilaImg, tequila, latlngTequila),
                tile('Chapala', chapalaImg, chapala, latlngChapala),
                tile('Vallarta', vallartaImg, vallarta, latlngVallarta),
                tile('Barranca', barrancaImg, barranca, latlngBarranca),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
