import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ✅ Provider that holds your Privacy Policy HTML content
final privacyPolicyHtmlProvider = StateProvider<String>((ref) {
  return """
  <p>
    Welcome to <b>Jimmy Sir App</b>! Your privacy is important to us. 
    This Privacy Policy explains how we handle your information when you use our app.
  </p>

  <h3>1. Information We Collect</h3>
  <ul>
    <li><b>Personal Data:</b> Name, email, and other contact information.</li>
    <li><b>Usage Data:</b> How you interact with our app.</li>
  </ul>

  <h3>2. How We Use Your Information</h3>
  <p>We use the collected data to:</p>
  <ul>
    <li>Improve user experience and app performance.</li>
    <li>Provide customer support.</li>
    <li>Send important updates or notifications.</li>
  </ul>

  <h3>3. Data Protection</h3>
  <p>
    We take reasonable precautions to protect your data, 
    but no online service is completely secure.
  </p>

  <h3>4. Your Rights</h3>
  <ul>
    <li>Access and update your information.</li>
    <li>Request data deletion.</li>
    <li>Withdraw consent at any time.</li>
  </ul>

  <h3>5. Contact Us</h3>
  <p>
    If you have any questions, reach out at 
    <a href='mailto:support@jimmysirapp.com'>support@jimmysirapp.com</a>.
  </p>

  <p style='text-align:center; font-style:italic; color:#888;'>
    Last Updated: October 2025
  </p>
  """;
});
