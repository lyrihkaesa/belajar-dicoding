// import 'dart:io';

// void main() {
//   for (int i = 1; i <= 3; i++) {
//     for (int j = 1; j <= i; j++) {
//       stdout.write(j);
//     }
//   }
// }

// num product(int firstNumber, double secondNumber) {
//   return firstNumber * secondNumber;
// }

void main() {
  print('Fetching username...');
  fetchUsername().then((value) {
    print('You are logged in as $value');
  }).whenComplete(() {
    print('Welcome!');
  });
}

Future<String> fetchUsername() {
  return Future.delayed(Duration(seconds: 3), () => 'DartUser');
}
