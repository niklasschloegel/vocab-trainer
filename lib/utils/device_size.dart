/// Categorizes the size of the device.
///
/// Similar to Bootstraps Breaktpoints (see [https://getbootstrap.com/docs/5.1/layout/breakpoints/])
/// the const values describe the minimum pixel width to fall into a size category.
/// E.g. a device with a width ≥ 576 would be size s (small), stepping over the 768px border
/// would categorize the device as size m (and so on...).
class DeviceSize {
  static const s = 576.0;
  static const m = 768.0;
  static const l = 992.0;
  static const xl = 1200.0;
  static const xxl = 1400.0;
}
