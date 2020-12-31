/*
    Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License")
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'dart:convert' show json;
import 'package:flutter/foundation.dart' show required;
import 'package:huawei_awareness/constants/param.dart';

class BarrierQueryRequest {
  String _type;
  List<String> _barrierKeys;

  BarrierQueryRequest.all() {
    _type = Param.queryTypeAll;
  }

  BarrierQueryRequest.forBarriers({@required List<String> barrierKeys}) {
    _barrierKeys = barrierKeys;
    _type = Param.queryTypeKey;
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        Param.queryType: _type == null ? null : _type,
        Param.barrierKeys: _barrierKeys == null
            ? null
            : List<String>.from(_barrierKeys.map((x) => x)),
      };
}
