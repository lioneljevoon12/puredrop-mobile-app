import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// ── Route paths ───────────────────────────────────────────────────────────────
class Routes {
  Routes._();

  static const login      = '/login';
  static const dashboard  = '/';
  static const aiHealth   = '/ai-health';
  static const membership = '/membership';
  static const addBottle  = '/membership/add-bottle';
  static const history    = '/history';
  static const profile    = '/profile';
}

// ── Router provider ───────────────────────────────────────────────────────────
final appRouterProvider = Provider<GoRouter>((ref) {
  // TODO Fase 1: watch authNotifierProvider untuk auth redirect
  // final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: Routes.dashboard,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      // TODO Fase 1: aktifkan auth guard setelah authNotifier siap
      // final isLoggedIn = authState.isAuthenticated;
      // final goingToLogin = state.matchedLocation == Routes.login;
      // if (!isLoggedIn && !goingToLogin) return Routes.login;
      // if (isLoggedIn && goingToLogin) return Routes.dashboard;
      return null;
    },
    routes: [
      // ── Login (luar shell, tidak ada bottom nav) ──────────────────────
      GoRoute(
        path: Routes.login,
        name: 'login',
        builder: (context, state) => const _PlaceholderScreen(label: 'Login'),
      ),

      // ── Shell: semua screen yang punya bottom nav ─────────────────────
      ShellRoute(
        builder: (context, state, child) => _MainShell(child: child),
        routes: [
          GoRoute(
            path: Routes.dashboard,
            name: 'dashboard',
            builder: (context, state) =>
                const _PlaceholderScreen(label: 'Dashboard'),
          ),
          GoRoute(
            path: Routes.aiHealth,
            name: 'ai-health',
            builder: (context, state) =>
                const _PlaceholderScreen(label: 'Analisis AI'),
          ),
          GoRoute(
            path: Routes.membership,
            name: 'membership',
            builder: (context, state) =>
                const _PlaceholderScreen(label: 'Membership'),
            routes: [
              GoRoute(
                path: 'add-bottle',
                name: 'add-bottle',
                builder: (context, state) =>
                    const _PlaceholderScreen(label: 'Tambah Botol'),
              ),
            ],
          ),
          GoRoute(
            path: Routes.history,
            name: 'history',
            builder: (context, state) =>
                const _PlaceholderScreen(label: 'Riwayat'),
          ),
          GoRoute(
            path: Routes.profile,
            name: 'profile',
            builder: (context, state) =>
                const _PlaceholderScreen(label: 'Profil'),
          ),
        ],
      ),
    ],
  );
});

// ── Main Shell (Bottom Nav) ────────────────────────────────────────────────────
// TODO Fase 2: ganti _PlaceholderScreen dengan screen aslinya
class _MainShell extends StatelessWidget {
  const _MainShell({required this.child});
  final Widget child;

  static const _tabs = [
    Routes.dashboard,
    Routes.aiHealth,
    Routes.membership,
    Routes.history,
    Routes.profile,
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final idx = _tabs.indexWhere((t) => location.startsWith(t) && t != '/' ||
        location == '/' && t == '/');
    return idx < 0 ? 0 : idx;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFFDCF0FB))),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex(context),
          onTap: (i) => context.go(_tabs[i]),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.water_drop_outlined),
              activeIcon: Icon(Icons.water_drop),
              label: 'Hidrasi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.monitor_heart_outlined),
              activeIcon: Icon(Icons.monitor_heart),
              label: 'AI',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.credit_card_outlined),
              activeIcon: Icon(Icons.credit_card),
              label: 'Member',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              activeIcon: Icon(Icons.receipt_long),
              label: 'Riwayat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}

// ── Placeholder sementara ─────────────────────────────────────────────────────
// Hapus ini setelah screen asli dibuat fase per fase
class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          label,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
