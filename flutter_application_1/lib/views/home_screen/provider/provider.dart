// Add this method to your HomeProvider class
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/home_screen/modal/modal.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class HomeProvider with ChangeNotifier {
  List<ContactModal> list = [];
  List<ContactModal> hideList = [];
  int selectedIndex = 0;
  bool ishide = false;

  void addContact(ContactModal model) {
    list.add(model);
    notifyListeners();
  }

  void removeContact() {
    list.removeAt(selectedIndex);
    notifyListeners();
  }

  void removehideContact()
  {
    hideList.removeAt(selectedIndex);
    notifyListeners();
  }

  void getIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void UpdateContact(ContactModal model) {
    list[selectedIndex] = model;
    notifyListeners();
  }

  void hideContact(ContactModal model) {
    hideList.add(model);
    list.removeAt(selectedIndex);
    notifyListeners();
  }

  void unhideContact(ContactModal model)
  {
    list.add(model);
    hideList.removeAt(selectedIndex);
    notifyListeners();
  }

  void HideContactUpdate(ContactModal model) {
    hideList[selectedIndex] = model;
    notifyListeners();
  }

  Future<bool> openlock()
  async {
    LocalAuthentication auth = LocalAuthentication();
         bool isbioAvailable = await auth.canCheckBiometrics;
         bool isdeviceSupported = await auth.isDeviceSupported();

         if(isbioAvailable && isdeviceSupported)
         {
          List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();

          if(availableBiometrics.isEmpty)
          {
            return false;
          }

          else{
            return await auth.authenticate(localizedReason: 'please Enter password');
          }
         }
         else{
          return false;
         }

         notifyListeners();


  }
}
