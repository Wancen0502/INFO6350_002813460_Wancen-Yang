import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Hero Animations Demo';
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HeroAnimationSelector(),
    );
  }
}

class HeroAnimationSelector extends StatelessWidget {
  const HeroAnimationSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Animation Demo'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Plese select a kind of hero animation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RadialHeroDemo()),
                );
              },
              child: const Text('radial hero animation'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StandardHeroDemo()),
                );
              },
              child: const Text('standard hero animation'),
            ),
          ],
        ),
      ),
    );
  }
}


class RadialHeroDemo extends StatelessWidget {
  const RadialHeroDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('radial hero animation'),
      ),
      body: const HeroAnimationRouteA(),
    );
  }
}

class HeroAnimationRouteA extends StatelessWidget {
  const HeroAnimationRouteA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        children: <Widget>[
          InkWell(
            child: Hero(
              tag: "avatar",
              child: ClipOval(
                child: Image.asset(
                  "assets/images/demoImg.png",
                  width: 100.0,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(context, PageRouteBuilder(
                pageBuilder: (
                    BuildContext context,
                    animation,
                    secondaryAnimation,
                    ) {
                  return FadeTransition(
                    opacity: animation,
                    child: Scaffold(
                      body: const HeroAnimationRouteB(),
                    ),
                  );
                },
              ));
            },
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
          )
        ],
      ),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  const HeroAnimationRouteB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Center(
        child: Hero(
          tag: "avatar",
          child: Image.asset("assets/images/demoImg.png"),
        ),
      ),
    );
  }
}

class StandardHeroDemo extends StatelessWidget {
  const StandardHeroDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('standard hero animation'),
      ),
      body: Center(
        child: PhotoHero(
          photo: 'assets/images/demoImg.png',
          width: 300.0,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute<void>(
                builder: (context) {
                  return Scaffold(
                    body: Container(
                      color: Colors.blue,
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.topLeft,
                      child: PhotoHero(
                        photo: 'assets/images/demoImg.png',
                        width: 100.0,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  );
                }
            ));
          },
        ),
      ),
    );
  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero({
    super.key,
    required this.photo,
    this.onTap,
    required this.width,
  });

  final String photo;
  final VoidCallback? onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.asset(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}