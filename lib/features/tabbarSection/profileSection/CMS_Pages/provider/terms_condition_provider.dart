import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ✅ Provider that holds your Terms & Conditions HTML content
final termsConditionsHtmlProvider = StateProvider<String>((ref) {
  return """
  <p>
    Welcome to <b>Jimmy Sir App</b>. By accessing or using our app, you agree to comply with and be bound by the following terms and conditions.
  </p>

  <h3>1. Acceptance of Terms</h3>
  <p>
    By using this app, you agree to these Terms and our Privacy Policy. 
    If you do not agree, please discontinue using the app.
  </p>

  <h3>2. User Responsibilities</h3>
  <ul>
    <li>You must use the app in compliance with all applicable laws.</li>
    <li>Do not misuse or attempt to disrupt the app’s functionality.</li>
    <li>You are responsible for maintaining the confidentiality of your account.</li>
  </ul>

  <h3>3. Intellectual Property</h3>
  <p>
    All app content, logos, and materials are the property of Jimmy Sir App 
    and may not be used without prior written consent.
  </p>

  <h3>4. Limitation of Liability</h3>
  <p>
    We are not responsible for any direct, indirect, or incidental damages 
    resulting from your use or inability to use the app.
  </p>

  <h3>5. Modifications to Terms</h3>
  <p>
    We may update these Terms from time to time. Continued use of the app 
    after changes constitutes your acceptance of the revised Terms.
  </p>

  <h3>6. Contact Us</h3>
  <p>
    If you have any questions about these Terms, please contact us at 
    <a href='mailto:support@jimmysirapp.com'>support@jimmysirapp.com</a>.
  </p>

  <p style='text-align:center; font-style:italic; color:#888;'>
    Last Updated: October 2025
  </p>
  """;
});
