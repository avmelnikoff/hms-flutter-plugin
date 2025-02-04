/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

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

import 'package:flutter/material.dart';
import 'package:huawei_ml_image/huawei_ml_image.dart';
import 'package:huawei_ml_image_example/utils/constants.dart';
import 'package:huawei_ml_image_example/utils/utils.dart';

class ClassificationExample extends StatefulWidget {
  const ClassificationExample({Key? key}) : super(key: key);

  @override
  State<ClassificationExample> createState() => _ClassificationExampleState();
}

class _ClassificationExampleState extends State<ClassificationExample>
    with DemoMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final MLImageClassificationAnalyzer _analyzer =
      MLImageClassificationAnalyzer();
  final List<String?> names = <String?>[];
  final List<dynamic> possibilities = <dynamic>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: demoAppBar('Classification Demo'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            resultBox(
              classificationNames,
              names,
              context,
            ),
            Container(
              color: kGrayColor,
              margin: context.paddingLow,
              width: context.highValue,
              height: context.highValue,
              child: Image.asset(addImage),
            ),
            resultBox(
              possibility,
              possibilities,
              context,
            ),
            containerElevatedButton(
              context,
              ElevatedButton(
                style: buttonStyle,
                onPressed: () => pickerDialog(_key, context, analyseFrame),
                child: const Text(startClassificationText),
              ),
            ),
            containerElevatedButton(
              context,
              ElevatedButton(
                style: buttonStyle,
                onPressed: () => pickerDialog(_key, context, asyncAnalyseFrame),
                child: const Text(startAsyncClassificationText),
              ),
            ),
            containerElevatedButton(
              context,
              ElevatedButton(
                style: dangerbuttonStyle,
                onPressed: stop,
                child: const Text(stopText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Future<void> analyseFrame(String? path) async {
    if (path != null) {
      try {
        final MLClassificationAnalyzerSetting setting =
            MLClassificationAnalyzerSetting.create(
          path: path,
          isRemote: false,
        );
        final List<MLImageClassification> list =
            await _analyzer.analyseFrame(setting);
        for (MLImageClassification element in list) {
          setState(() {
            names.add(element.name);
            possibilities.add(element.possibility);
          });
        }
      } catch (e) {
        exceptionDialog(context, '$e');
      }
    }
  }

  @override
  Future<void> asyncAnalyseFrame(String? path) async {
    if (path != null) {
      try {
        final MLClassificationAnalyzerSetting setting =
            MLClassificationAnalyzerSetting.create(
          path: path,
          isRemote: false,
        );
        final List<MLImageClassification> list =
            await _analyzer.asyncAnalyseFrame(setting);
        for (MLImageClassification element in list) {
          setState(() {
            names.add(element.name);
            possibilities.add(element.possibility);
          });
        }
      } catch (e) {
        exceptionDialog(context, '$e');
      }
    }
  }

  @override
  Future<void> stop() async {
    try {
      await _analyzer.stop();
    } catch (e) {
      exceptionDialog(context, '$e');
    }
  }
}
