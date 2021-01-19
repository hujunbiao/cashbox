import 'package:services/services.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    setUp(() {

    });

    test('First Test', () async {
      var refresh = ReFreshParameter(ConnectParameter("host", 100), (p) async {
        return ConnectParameter("new", 200);
      });

      refresh.resetConnectParameter();
      refresh.refreshParameter();
      var parameter = refresh.connectParameter;
      expect(true, parameter == null);
      await ()async{};
      parameter = refresh.connectParameter;
      expect(true, parameter != null);

      refresh.resetConnectParameter();
      await refresh.refreshParameter();
      parameter = refresh.connectParameter;
      expect(true, parameter != null);
    });
  });
}