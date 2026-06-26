/// Semua endpoint API PUREDROP.
/// Prefix /api/app/* → endpoint khusus mobile (Sanctum auth).
class Endpoints {
  Endpoints._();

  // ── Auth ──────────────────────────────────────────────────────────────────
  static const login  = '/api/app/auth/login';
  static const logout = '/api/app/auth/logout';

  // ── User / Profil ─────────────────────────────────────────────────────────
  static const user = '/api/app/user'; // GET & PUT

  // ── Hydration ─────────────────────────────────────────────────────────────
  static const hydrationToday   = '/api/app/hydration/today';
  static const hydrationHistory = '/api/app/hydration/history';

  // ── Membership & Botol ────────────────────────────────────────────────────
  static const membership     = '/api/app/membership';
  static const activateBottle = '/api/app/bottles/activate';

  // ── Riwayat ───────────────────────────────────────────────────────────────
  static const fills        = '/api/app/fills';
  static const transactions = '/api/app/transactions';
}
