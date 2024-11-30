import 'package:flutter_test/flutter_test.dart';
import 'package:green_oil_seekers/support_screen/delete_account.dart';
import 'package:green_oil_seekers/support_screen/help_card.dart';
import 'package:green_oil_seekers/support_screen/support_screen.dart';

void main() {
  testWidgets('HelpCard Tapping Navigates Properly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SupportScreen());

    // Find the HelpCard for "Change My Password"
    final changePasswordCard =
        find.widgetWithText(HelpCard, 'Change My Password');

    // Tap the card and check if the ChangePasswordScreen is pushed
    await tester.tap(changePasswordCard);
    await tester.pumpAndSettle();

    // Verify ChangePasswordScreen is displayed
    expect(find.text('Change Password'), findsOneWidget);
  });

  testWidgets('Delete Account Confirmation Dialog',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SupportScreen());

    // Find the Delete Account button and tap it
    final deleteAccountButton =
        find.widgetWithText(DeleteAccount, 'Delete Account');
    await tester.tap(deleteAccountButton);
    await tester.pumpAndSettle();

    // Verify the confirmation dialog title
    expect(find.text('Delete Account'), findsOneWidget);

    // Find the "Cancel" button
    final cancelButton = find.text('Cancel');
    expect(cancelButton, findsOneWidget);

    // Find the "Delete Account" button
    final deleteAccountConfirmationButton = find.text('Delete Account');
    expect(deleteAccountConfirmationButton, findsOneWidget);
  });
}
