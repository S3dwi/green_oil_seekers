import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/image_picker');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    // Mock the platform channel
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'pickImage') {
        if (methodCall.arguments['source'] == ImageSource.camera.index) {
          return '/mock/camera_image.png'; // Simulate a camera image path
        } else if (methodCall.arguments['source'] ==
            ImageSource.gallery.index) {
          return '/mock/gallery_image.png'; // Simulate a gallery image path
        }
      }
      return null; // Return null if the method call doesn't match
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null); // Clean up after tests
  });

  test('Should pick image from camera', () async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);

    // Verify the result
    expect(pickedFile?.path, '/mock/camera_image.png');
  });

  test('Should pick image from gallery', () async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    // Verify the result
    expect(pickedFile?.path, '/mock/gallery_image.png');
  });
}
