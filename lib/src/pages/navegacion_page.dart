import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class NavegacionPage extends StatelessWidget {
   
  const NavegacionPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NotificationProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Text('Notification page'),
        ),
        floatingActionButton: _BotonFlotante(),
        bottomNavigationBar: _BottomNavigation(),
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<_NotificationProvider>(context);
    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: Colors.pink,
      items: [
        const BottomNavigationBarItem(
          label: 'Bones',
          icon: FaIcon(FontAwesomeIcons.bone)
        ),
        BottomNavigationBarItem(
          label: 'Notifications',
          icon: Stack(
            children: [
              const FaIcon(FontAwesomeIcons.bell),
              Positioned(
                right: 0,
                child: BounceInDown(
                  animate: (notificationProvider.numero > 0 ) ? true : false,
                  from: 20,
                  child: Bounce(
                    duration: const Duration(milliseconds: 500),
                    from: 10,
                    controller: (controller) {
                      notificationProvider.controller = controller;
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.pink,
                        shape: BoxShape.circle
                      ),
                      child: Text(
                        '${notificationProvider.numero}',
                        style: const TextStyle(color: Colors.white, fontSize: 9), 
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ),
        const BottomNavigationBarItem(
          label: 'Poto',
          icon: FaIcon(FontAwesomeIcons.cat)
        ),
      ],
    );
  }
}

class _BotonFlotante extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<_NotificationProvider>(context);
    return FloatingActionButton(
      backgroundColor: Colors.pink,
      onPressed: () {
        notificationProvider.numero = notificationProvider.numero + 1;
        if(notificationProvider.numero >= 2){
          final controller = notificationProvider.controller;
          controller.forward(from: 0);
        }
      },
      child: const FaIcon(FontAwesomeIcons.play),
    );
  }
}

class _NotificationProvider extends ChangeNotifier {
  int _numero = 0;
  late AnimationController controller;

  int get numero => _numero;

  set numero(int numero){
    _numero = numero;
    notifyListeners();
  }
}