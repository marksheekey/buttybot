import 'Butty.dart';

class Butties {
  List<Butty> butties;

  void addButties(List<Butty> butties) {
    this.butties = butties;
  }

  List<Butty> getButtiesByUser() {
    return this.butties;
  }
}
