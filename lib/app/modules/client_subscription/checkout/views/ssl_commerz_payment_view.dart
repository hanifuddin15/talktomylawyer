import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/models/client_models/subscription_model.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:talktomylawyer/app/core/config/api_constant.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import 'package:talktomylawyer/app/core/services/api_communication.dart';
import 'package:talktomylawyer/app/repository/client_auth_repository.dart';
import 'package:talktomylawyer/app/core/services/caching_service.dart';

class SslCommerzPaymentView extends StatefulWidget {
  final int subscriptionId;
  const SslCommerzPaymentView({super.key, required this.subscriptionId});

  @override
  State<SslCommerzPaymentView> createState() => _SslCommerzPaymentViewState();
}

class _SslCommerzPaymentViewState extends State<SslCommerzPaymentView> {
  late final WebViewController _webViewController;
  bool _isLoading = true;
  String? _errorMessage;
  // States: 'initiating', 'webview', 'success', 'failure'
  String _currentState = 'initiating';

  @override
  void initState() {
    super.initState();
    _initiatePayment();
  }

  Future<void> _initiatePayment() async {
    setState(() {
      _currentState = 'initiating';
      _errorMessage = null;
    });

    try {
      final response = await ApiCommunication.instance.doPostRequest(
        apiEndPoint: 'payments/initiate',
        requestData: {
          'paymentable_type': 'subscription',
          'paymentable_id': widget.subscriptionId,
        },
        responseDataKey: ApiConstant.fullResponse,
        enableLoading: false,
      );

      if (response.isSuccessful && response.data != null) {
        final Map<String, dynamic> responseData =
            response.data as Map<String, dynamic>;

        // Handle Laravel standard initiate response mapping
        final String? status = responseData['status'] as String?;
        final String? gatewayUrl = responseData['gateway_url'] as String?;

        if (status == 'success' &&
            gatewayUrl != null &&
            gatewayUrl.isNotEmpty) {
          _setupWebViewController(gatewayUrl);
          return;
        }
      }

      setState(() {
        _currentState = 'failure';
        _errorMessage =
            response.errorMessage ?? 'Failed to initiate payment gateway';
      });
    } catch (e) {
      setState(() {
        _currentState = 'failure';
        _errorMessage = e.toString();
      });
    }
  }

  void _setupWebViewController(String url) {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
            _checkPaymentStatus(url);
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
            _checkPaymentStatus(url);
          },
          onNavigationRequest: (NavigationRequest request) {
            _checkPaymentStatus(request.url);
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

    setState(() {
      _currentState = 'webview';
      _isLoading = false;
    });
  }

  void _checkPaymentStatus(String url) {
    final lowercaseUrl = url.toLowerCase();
    if (lowercaseUrl.contains('success')) {
      _handlePaymentSuccess();
    } else if (lowercaseUrl.contains('fail') ||
        lowercaseUrl.contains('cancel')) {
      _handlePaymentFailure();
    }
  }

  void _handlePaymentSuccess() async {
    try {
      final clientAuth = ClientAuthRepository.instance;
      final currentClient = clientAuth.getClientData();
      if (currentClient != null) {
        if (currentClient.subscription != null) {
          currentClient.subscription!.status = 'active';
        } else {
          currentClient.subscription = SubscriptionModel(status: 'active');
        }
        await CachingService.instance.saveClientUser(currentClient.toJson());
      }
    } catch (_) {}

    if (mounted) {
      setState(() {
        _currentState = 'success';
      });
    }
  }

  void _handlePaymentFailure() {
    if (mounted) {
      setState(() {
        _currentState = 'failure';
        _errorMessage = 'Payment was failed or cancelled.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? kDarkBg : kLightBg;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final secondaryText = isDark ? kDarkTextSecondary : kLightTextSecondary;
    final cardColor = isDark ? kDarkCard : kLightCard;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: Text(
          _currentState == 'success'
              ? 'Payment Success'
              : _currentState == 'failure'
              ? 'Payment Failed'
              : 'SSLCommerz Payment',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w700,
            color: primaryText,
            fontSize: 18,
          ),
        ),
        backgroundColor: bg,
        elevation: 0,
        centerTitle: true,
        leading: _currentState == 'webview'
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: primaryText,
                  size: 18,
                ),
                onPressed: () {
                  Get.back();
                },
              )
            : const SizedBox.shrink(),
      ),
      body: SafeArea(child: _buildBody(cardColor, primaryText, secondaryText)),
    );
  }

  Widget _buildBody(Color cardColor, Color primaryText, Color secondaryText) {
    switch (_currentState) {
      case 'initiating':
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: kPrimaryBlue),
              const SizedBox(height: 18),
              Text(
                'Initiating secure payment...',
                style: GoogleFonts.outfit(
                  color: secondaryText,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );

      case 'webview':
        return Stack(
          children: [
            WebViewWidget(controller: _webViewController),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(color: kPrimaryBlue),
              ),
          ],
        );

      case 'success':
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: kSuccess.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    color: kSuccess,
                    size: 80,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Payment Successful',
                  style: GoogleFonts.outfit(
                    color: primaryText,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Thank you for subscribing! Your Premium features are now fully unlocked.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    color: secondaryText,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => Get.offAllNamed('/client_dashboard'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Go back to Home',
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

      case 'failure':
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: kError.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.cancel_rounded,
                    color: kError,
                    size: 80,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Payment Failed',
                  style: GoogleFonts.outfit(
                    color: primaryText,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _errorMessage ??
                      'An error occurred during payment processing.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    color: secondaryText,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _initiatePayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFB300), // Gold/Orange
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Retry Payment',
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0A1128),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: () => Get.offAllNamed('/client_dashboard'),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: secondaryText.withValues(alpha: 0.3),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Go back to Home',
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: primaryText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
