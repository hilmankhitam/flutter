import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:submission_fundamental_1/bloc/blocs.dart';
import 'package:submission_fundamental_1/helper/helpers.dart';
import 'package:submission_fundamental_1/models/models.dart';
import 'package:submission_fundamental_1/providers/providers.dart';
import 'package:submission_fundamental_1/services/services.dart';
import 'package:submission_fundamental_1/shared/shared.dart';
import 'package:submission_fundamental_1/ui/widgets/widgets.dart';


part 'home_page.dart';
part 'splash_screen.dart';
part 'wrapper.dart';
part 'detail_restaurant_page.dart';
part 'restaurant_page.dart';
part 'setting_page.dart';
part 'search_page.dart';
part 'favorite_page.dart';