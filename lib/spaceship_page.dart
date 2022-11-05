import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class Spaceship extends StatefulWidget {
  const Spaceship({Key? key}) : super(key: key);

  @override
  State<Spaceship> createState() => _RocketState();
}

class _RocketState extends State<Spaceship> {
  Artboard? _artboard;
  RiveAnimationController? _naveController;

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/nave.riv').then((data) async {
      final file = RiveFile.import(data);
      final artBoard = file.mainArtboard;
      setState(() => _artboard = artBoard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spaceship Animation'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 250,
            child: _artboard == null
                ? Container()
                : Rive(
                    artboard: _artboard!,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _fly(),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Fly'),
              ),
              ElevatedButton(
                onPressed: () => _spin(),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Spin'),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _fly() async {
    setState(() =>
        _artboard!.addController(_naveController = SimpleAnimation('fly')));
    debugPrint('AA');
  }

  void _spin() async {
    setState(() =>
        _artboard!.addController(_naveController = SimpleAnimation('spin')));
  }
}
