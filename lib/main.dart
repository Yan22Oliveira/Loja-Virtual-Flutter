import 'package:flutter/material.dart';
import 'package:loja_virtual_flutter/models/admin_orders_manager.dart';
import 'package:loja_virtual_flutter/models/cart_manager.dart';
import 'package:loja_virtual_flutter/models/home_manager.dart';
import 'package:loja_virtual_flutter/models/order.dart';
import 'package:loja_virtual_flutter/models/orders_manager.dart';
import 'package:loja_virtual_flutter/models/product_manager.dart';
import 'package:loja_virtual_flutter/models/stores_manager.dart';
import 'package:loja_virtual_flutter/models/user_manager.dart';
import 'package:loja_virtual_flutter/screens/address/address_screen.dart';
import 'package:loja_virtual_flutter/screens/base/base_screen.dart';
import 'package:loja_virtual_flutter/screens/cart/cart_screen.dart';
import 'package:loja_virtual_flutter/screens/checkout/checkout_screen.dart';
import 'package:loja_virtual_flutter/screens/confirmation/confirmation_screen.dart';
import 'package:loja_virtual_flutter/screens/edit_product/edit_product_screen.dart';
import 'package:loja_virtual_flutter/screens/login/login_screen.dart';
import 'package:loja_virtual_flutter/screens/product/product_screen.dart';
import 'package:loja_virtual_flutter/screens/select_product/select_product_screen.dart';
import 'package:loja_virtual_flutter/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';
import 'models/admin_users_manager.dart';
import 'models/product.dart';

void main() async{
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => StoresManager(),
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
          cartManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, OrdersManager>(
          create: (_) => OrdersManager(),
          lazy: false,
          update: (_, userManager, ordersManager) =>
          ordersManager..updateUser(userManager.user),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_, userManager, adminUsersManager) =>
          adminUsersManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminOrdersManager>(
          create: (_) => AdminOrdersManager(),
          lazy: false,
          update: (_, userManager, adminOrdersManager) =>
          adminOrdersManager..updateAdmin(
              adminEnabled: userManager.adminEnabled
          ),
        )
      ],
      child: MaterialApp(
        title: 'Rad Burgers',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 4, 125, 141),
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          appBarTheme: const AppBarTheme(
              elevation: 0
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings){
          switch(settings.name){
            case '/login':
              return MaterialPageRoute(
                  builder: (_) => LoginScreen()
              );
            case '/signup':
              return MaterialPageRoute(
                  builder: (_) => SignUpScreen()
              );
            case '/product':
              return MaterialPageRoute(
                  builder: (_) => ProductScreen(
                      settings.arguments as Product
                  )
              );
            case '/cart':
              return MaterialPageRoute(
                  builder: (_) => CartScreen(),
                  settings: settings
              );
            case '/address':
              return MaterialPageRoute(
                  builder: (_) => AddressScreen()
              );
            case '/checkout':
              return MaterialPageRoute(
                  builder: (_) => CheckoutScreen()
              );
            case '/edit_product':
              return MaterialPageRoute(
                  builder: (_) => EditProductScreen(
                      settings.arguments as Product
                  )
              );
            case '/select_product':
              return MaterialPageRoute(
                  builder: (_) => SelectProductScreen()
              );
            case '/confirmation':
              return MaterialPageRoute(
                  builder: (_) => ConfirmationScreen(
                      settings.arguments as Order
                  )
              );
            case '/':
            default:
              return MaterialPageRoute(
                  builder: (_) => BaseScreen(),
                  settings: settings
              );
          }
        },
      ),
    );
  }
}
