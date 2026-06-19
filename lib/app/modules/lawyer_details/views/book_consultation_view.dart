import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import '../controllers/book_consultation_controller.dart';
import '../widgets/booking_lawyer_card.dart';
import '../widgets/booking_date_selector.dart';
import '../widgets/booking_time_selector.dart';
import '../widgets/booking_mode_selector.dart';

class BookConsultationView extends GetView<BookConsultationController> {
  const BookConsultationView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? kDarkBg : kLightBg;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final secondaryText = isDark ? kDarkTextSecondary : kLightTextSecondary;
    final cardBg = isDark ? kDarkCard : kLightCard;
    final dividerColor = isDark ? kDarkDivider : kLightDivider;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: Text(
          'Book Consultation',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w700,
            color: primaryText,
            fontSize: 18,
          ),
        ),
        backgroundColor: bg,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: primaryText, size: 18),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Lawyer brief card
                    BookingLawyerCard(lawyer: controller.lawyer),
                    const SizedBox(height: 24),

                    // 2. Select Date
                    _buildSectionTitle('Select Date', primaryText),
                    const SizedBox(height: 12),
                    const BookingDateSelector(),
                    const SizedBox(height: 24),

                    // 3. Select Time Slot
                    _buildSectionTitle('Select Time Slot', primaryText),
                    const SizedBox(height: 12),
                    const BookingTimeSelector(),
                    const SizedBox(height: 24),

                    // 4. Consultation Mode
                    _buildSectionTitle('Consultation Mode', primaryText),
                    const SizedBox(height: 12),
                    const BookingModeSelector(),
                    const SizedBox(height: 24),

                    // 5. Describe legal issue
                    _buildSectionTitle('Describe your legal issue', primaryText),
                    const SizedBox(height: 12),
                    TextField(
                      controller: controller.issueController,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: primaryText,
                      ),
                      decoration: InputDecoration(
                        hintText:
                            'Provide context so the lawyer can prepare for your consultation...',
                        hintStyle: GoogleFonts.outfit(
                          fontSize: 14,
                          color: secondaryText.withValues(alpha: 0.6),
                        ),
                        filled: true,
                        fillColor: cardBg,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: dividerColor.withValues(alpha: 0.5),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: dividerColor.withValues(alpha: 0.5),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: kPrimaryBlue,
                            width: 1.5,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 6. Fee details card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: dividerColor.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Consultation Fee:',
                                style: GoogleFonts.outfit(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: primaryText,
                                ),
                              ),
                              Obx(() {
                                final feeStr = controller.consultationFee.value;
                                return Text(
                                  '$feeStr BDT',
                                  style: GoogleFonts.outfit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: primaryText,
                                  ),
                                );
                              }),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'A standard hourly fee will be charged for this session. Upgrade to Premium to unlock unlimited free bookings!',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              height: 1.4,
                              fontWeight: FontWeight.w500,
                              color: secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // 7. Confirm Booking Pinned Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: controller.confirmBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Confirm Booking',
                        style: GoogleFonts.outfit(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color textColor) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
    );
  }
}
