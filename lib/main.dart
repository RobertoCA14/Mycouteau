import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart'; // Importa la biblioteca url_launcher

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Toolset App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToolsetPage(),
    );
  }
}

class ToolsetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toolset App'),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Navegar a la página de determinar género
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GenderPredictorPage()),
              );
            },
            child: Text('Determinar Género'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navegar a la página de determinar edad
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EdadPage()),
              );
            },
            child: Text('Determinar Edad'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navegar a la página de universidades
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UniversidadesPage()),
              );
            },
            child: Text('Universidades'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navegar a la página de clima
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClimaPage()),
              );
            },
            child: Text('Clima'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navegar a la página de noticias
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NoticiasPage()),
              );
            },
            child: Text('Noticias'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navegar a la página de Acerca de
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
            child: Text('Acerca de'),
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.network(
            'data:image/jpeg;base64,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',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Contenido de la página debajo de la AppBar
        ],
      ),
    );
  }
}

class GenderPredictorPage extends StatefulWidget {
  @override
  _GenderPredictorPageState createState() => _GenderPredictorPageState();
}

class _GenderPredictorPageState extends State<GenderPredictorPage> {
  String _name = '';
  String _gender = '';
  Color _backgroundColor = Colors.white; // Color de fondo predeterminado

  Future<void> fetchGender(String name) async {
    final response = await http.get(Uri.parse('https://api.genderize.io/?name=$name'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _gender = data['gender'];
        // Establecer el color de fondo según el género
        _backgroundColor = _gender == 'male' ? Colors.blue : Colors.pink;
      });
    } else {
      throw Exception('Failed to fetch gender');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Determinar Género'),
      ),
      body: Container(
        color: _backgroundColor, // Establecer el color de fondo dinámicamente
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Nombre',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  fetchGender(_name); // Llamar al método para predecir el género
                },
                child: Text('Predecir Género'),
              ),
              SizedBox(height: 20.0),
              _gender.isNotEmpty
                  ? Text(
                      'El género de $_name es $_gender',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}


class EdadPage extends StatefulWidget {
  @override
  _EdadPageState createState() => _EdadPageState();
}

class _EdadPageState extends State<EdadPage> {
  String _name = '';
  int _age = 0;
  String _ageGroup = '';
  String _imageUrl = '';

  Future<void> fetchAge(String name) async {
    final response = await http.get(Uri.parse('https://api.agify.io/?name=$name'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _age = data['age'];
        _ageGroup = _getAgeGroup(_age);
        _imageUrl = _getImageUrl(_ageGroup);
      });
    } else {
      throw Exception('Failed to fetch age');
    }
  }

  String _getAgeGroup(int age) {
    if (age < 18) {
      return 'Joven';
    } else if (age >= 18 && age < 60) {
      return 'Adulto';
    } else {
      return 'Anciano';
    }
  }

  String _getImageUrl(String ageGroup) {
    switch (ageGroup) {
      case 'Joven':
        return 'https://via.placeholder.com/150?text=Joven';
      case 'Adulto':
        return 'https://via.placeholder.com/150?text=Adulto';
      case 'Anciano':
        return 'https://via.placeholder.com/150?text=Anciano';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Determinar Edad'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Nombre',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  fetchAge(_name); // Llamar al método para determinar la edad
                },
                child: Text('Determinar Edad'),
              ),
              SizedBox(height: 20.0),
              _ageGroup.isNotEmpty
                  ? Column(
                      children: [
                        Text(
                          'La edad de $_name es $_age y pertenece al grupo $_ageGroup',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        _imageUrl.isNotEmpty
                            ? Image.network(
                                _imageUrl,
                                width: 150.0,
                                height: 150.0,
                              )
                            : SizedBox(),
                      ],
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}


class UniversidadesPage extends StatefulWidget {
  @override
  _UniversidadesPageState createState() => _UniversidadesPageState();
}

class _UniversidadesPageState extends State<UniversidadesPage> {
  String _country = '';
  List<dynamic> _universities = [];

  Future<void> fetchUniversities(String country) async {
    final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=$country'));
    if (response.statusCode == 200) {
      setState(() {
        _universities = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to fetch universities');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universities'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _country = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Nombre del país',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                fetchUniversities(_country);
              },
              child: Text('Buscar Universidades'),
            ),
            SizedBox(height: 20.0),
            _universities.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _universities.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_universities[index]['name']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Dominio: ${_universities[index]['domains'][0]}'),
                              Text('Página Web: ${_universities[index]['web_pages'][0]}'),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}



class ClimaPage extends StatefulWidget {
  @override
  _ClimaPageState createState() => _ClimaPageState();
}

class _ClimaPageState extends State<ClimaPage> {
  String _apiKey = '5de77c96e1c5661906021fd2782e1532';
  String _city = 'Santo Domingo';
  Map<String, dynamic>? _weatherData;

  Future<void> fetchWeatherData() async {
    final response = await http.get(Uri.parse('https://openweathermap.org/city/3492908'));
    if (response.statusCode == 200) {
      setState(() {
        _weatherData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                fetchWeatherData();
              },
              child: Text('Obtener Clima de Santo Domingo'),
            ),
            SizedBox(height: 20.0),
            _weatherData != null
                ? Column(
                    children: [
                      Text('Temperatura: ${_weatherData!['main']['temp']}°C'),
                      Text('Humedad: ${_weatherData!['main']['humidity']}%'),
                      Text('Descripción: ${_weatherData!['weather'][0]['description']}'),
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

  


 class NoticiasPage extends StatefulWidget {
  @override
  _NoticiasPageState createState() => _NoticiasPageState();
}

class _NoticiasPageState extends State<NoticiasPage> {
  late List<dynamic> _posts;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    final response = await http.get(Uri.parse('https://videos.marca.com/v/0_vcia58by-nba-resumen-spurs-102-112-warriors?count=0'));
    if (response.statusCode == 200) {
      setState(() {
        _posts = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WordPress News'),
      ),
      body: _posts != null
          ? ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                return ListTile(
                  leading: Image.network('https://videos.marca.com/v/0_vcia58by-nba-resumen-spurs-102-112-warriors?count=0'), // Cambia la URL a la de tu logo
                  title: Text(post['title']['rendered']),
                  subtitle: Text(post['excerpt']['rendered']),
                  onTap: () {
                    String postUrl = post['link'];
                    // Aquí puedes agregar la lógica para abrir el enlace de la noticia
                    // Puedes utilizar el paquete url_launcher para abrir el enlace en el navegador
                  },
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Me'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage('foto 2x2.png'),
            ),
            SizedBox(height: 20),
            Text(
              'Roberto Cuevas',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Desarrolador de Software',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              '8096987898',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Robel@example.com',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Teléfono: +1234567890',
              style: TextStyle(fontSize: 18),
            ),
            // Agrega más información de contacto según sea necesario
          ],
        ),
      ),
    );
  }
}
