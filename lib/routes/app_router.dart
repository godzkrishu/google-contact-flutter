import 'package:go_router/go_router.dart';
import 'package:google_contact/features/contacts/presentation/screens/add_edit_contact_page.dart';
import 'package:google_contact/features/contacts/presentation/screens/contact_detail_page.dart';
import 'package:google_contact/features/contacts/presentation/screens/contact_page.dart';
import 'package:google_contact/features/contacts/presentation/screens/favorite_contact_page.dart';
import 'package:google_contact/features/contacts/presentation/screens/splash_screen.dart';
import '../features/contacts/domain/enitities/contact_entity.dart';
import '../features/contacts/presentation/screens/home_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: SplashScreen.routePath,
  routes: [
    GoRoute(
      path: SplashScreen.routePath,
      name: SplashScreen.routeName,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: HomePage.routePath,
      name: HomePage.routeName,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AddEditContactPage.routePath,
      name: AddEditContactPage.routeName,

      builder: (context, state) {

        final contact =
        state.extra as ContactEntity?;

        return AddEditContactPage(
          contact: contact,
        );
      },
    ),

    GoRoute(
      path: ContactDetailsPage.routePath,
      name: ContactDetailsPage.routeName,
      builder: (context, state) {
        final contact = state.extra as ContactEntity;
        return ContactDetailsPage(contact: contact);
      },
    ),
    GoRoute(
      path: ContactsPage.routePath,
      name: ContactsPage.routeName,
      builder: (context, state) {
        return const ContactsPage();
      },
    ),
    GoRoute(
      path: FavoriteContactsPage.routePath,
      name: FavoriteContactsPage.routeName,
      builder: (context, state) {
        return FavoriteContactsPage();
      },
    ),
  ],
);
