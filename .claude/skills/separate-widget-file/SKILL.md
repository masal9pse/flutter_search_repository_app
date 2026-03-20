---
name: separate-widget-file
description: Flutterのウィジェットを分割して管理するためのガイドライン
---

# Separate Widget

Widgetを分割する際は、プライベートWidgetを作成して、親Widgetから呼び出す形で管理することが推奨されます。これにより、コードの可読性と再利用性が向上します。
この際、part,part ofを活用してファイル分割を行ってください。
これにより、ウィジェットをファイル分割しつつも、プライベートに保つことができます。
またVRTを記載する際は、@visibleForTestingを活用してください。

## 使用例
./examples.mdを参照してください。
