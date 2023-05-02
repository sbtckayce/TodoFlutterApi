import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'coloors.dart';

enum EThemeApp { light, dark }

class ThemeApp {
  static var darkModeAppTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Coloors.whiteColors,
      appBarTheme: const AppBarTheme(
        backgroundColor: Coloors.blackColors,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Coloors.whiteColors,
        ),
      ),
      textTheme:const TextTheme(
        bodyMedium: TextStyle(color: Coloors.blackColors),
        titleMedium:TextStyle(color: Coloors.blackColors),
        titleSmall: TextStyle(color: Coloors.blackColors),
        titleLarge: TextStyle(color: Coloors.blackColors),
      ),
     iconTheme: const IconThemeData(color: Coloors.blackColors),
      brightness: Brightness.dark,
      switchTheme: const SwitchThemeData(
          trackColor: MaterialStatePropertyAll(Coloors.whiteColors),
          thumbColor: MaterialStatePropertyAll(Coloors.purpleColors)),
      dividerColor: Coloors.blackColors,
      primaryColor: Coloors.whiteColors,
     
      checkboxTheme: const CheckboxThemeData(
          checkColor: MaterialStatePropertyAll(Coloors.whiteColors),
          fillColor: MaterialStatePropertyAll(Coloors.blackColors)),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Coloors.greenColors,
      ));

  static var lightModeAppTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Coloors.blackColors,
      appBarTheme: const AppBarTheme(
        backgroundColor: Coloors.whiteColors,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Coloors.blackColors,
        ),
      ),
       
        textTheme:const TextTheme(
        bodyMedium: TextStyle(color: Coloors.whiteColors),
        titleMedium:TextStyle(color: Coloors.whiteColors),
        titleSmall: TextStyle(color: Coloors.whiteColors),
        titleLarge: TextStyle(color: Coloors.whiteColors),
      ),
      iconTheme: const IconThemeData(color: Coloors.whiteColors),
      switchTheme: const SwitchThemeData(
          trackColor: MaterialStatePropertyAll(Coloors.blackColors),
          thumbColor: MaterialStatePropertyAll(Coloors.purpleColors)),
      dividerColor: Coloors.whiteColors,
      checkboxTheme: const CheckboxThemeData(
          checkColor: MaterialStatePropertyAll(Coloors.blackColors),
          fillColor: MaterialStatePropertyAll(Coloors.whiteColors)),
      brightness: Brightness.light,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Coloors.greenColors,
      ));
}

final themeAppProvide  = StateNotifierProvider<ThemeAppProvider,ThemeData>((ref) => ThemeAppProvider());
class ThemeAppProvider extends StateNotifier<ThemeData> {
  EThemeApp _eThemeApp;
  ThemeAppProvider({EThemeApp eThemeApp = EThemeApp.dark})
      : _eThemeApp = eThemeApp,
        super(ThemeApp.darkModeAppTheme){
          getTheme();
        }

  EThemeApp get eThemeApp =>_eThemeApp;

  
  void getTheme()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme');
    if(theme =='light'){
      _eThemeApp = EThemeApp.light;
      state =ThemeApp.lightModeAppTheme;
    }else{
      _eThemeApp= EThemeApp.dark;
      state=ThemeApp.darkModeAppTheme;
    }
  }
  void changeTheme()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(_eThemeApp == EThemeApp.light){
      _eThemeApp = EThemeApp.dark;
      state = ThemeApp.darkModeAppTheme;
      prefs.setString('theme', 'dark');
    }else{
      _eThemeApp = EThemeApp.light;
      state=ThemeApp.lightModeAppTheme;
      prefs.setString('theme', 'light');
    }
  }
}
