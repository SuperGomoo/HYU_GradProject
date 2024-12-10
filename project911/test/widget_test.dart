// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:project911/main.dart';
import 'package:xml/xml.dart';

void main() {

  final bookshelfXml = '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<response>
    <header>
        <resultCode>00</resultCode>
        <resultMsg>NORMAL SERVICE.</resultMsg>
    </header>
    <body>
        <items>
            <item>
                <dutyName>의료법인강릉동인병원</dutyName>
                <dutyTel3>033-650-6105</dutyTel3>
                <hpid>A2200005</hpid>
                <hv2>0</hv2>
                <hv29>1</hv29>
                <hv30>2</hv30>
                <hv35>2</hv35>
                <hv40>1</hv40>
                <hv5>Y</hv5>
                <hv7>Y</hv7>
                <hvamyn>Y</hvamyn>
                <hvangioayn>Y</hvangioayn>
                <hvcrrtayn>Y</hvcrrtayn>
                <hvctayn>Y</hvctayn>
                <hvec>10</hvec>
                <hvecmoayn>N1</hvecmoayn>
                <hvgc>62</hvgc>
                <hvhypoayn>N1</hvhypoayn>
                <hvicc>0</hvicc>
                <hvidate>20241202143244</hvidate>
                <hvincuayn>N1</hvincuayn>
                <hvmriayn>Y</hvmriayn>
                <hvoc>4</hvoc>
                <hvoxyayn>N1</hvoxyayn>
                <hvs01>17</hvs01>
                <hvs03>1</hvs03>
                <hvs04>2</hvs04>
                <hvs06>12</hvs06>
                <hvs17>12</hvs17>
                <hvs18>2</hvs18>
                <hvs22>5</hvs22>
                <hvs24>141</hvs24>
                <hvs27>2</hvs27>
                <hvs28>1</hvs28>
                <hvs29>1</hvs29>
                <hvs30>14</hvs30>
                <hvs33>1</hvs33>
                <hvs38>248</hvs38>
                <hvventiayn>Y</hvventiayn>
                <hvventisoayn>N1</hvventisoayn>
                <phpid>A2200005</phpid>
                <rnum>1</rnum>
            </item>
            <item>
                <dutyName>강원특별자치도강릉의료원</dutyName>
                <dutyTel3>033-610-1234</dutyTel3>
                <hpid>A2200011</hpid>
                <hv26>20</hv26>
                <hv30>1</hv30>
                <hv41>3</hv41>
                <hv5>Y</hv5>
                <hvamyn>Y</hvamyn>
                <hvangioayn>N1</hvangioayn>
                <hvcrrtayn>N1</hvcrrtayn>
                <hvctayn>Y</hvctayn>
                <hvec>3</hvec>
                <hvecmoayn>N1</hvecmoayn>
                <hvgc>30</hvgc>
                <hvhypoayn>N1</hvhypoayn>
                <hvicc>3</hvicc>
                <hvidate>20241202143001</hvidate>
                <hvincuayn>N1</hvincuayn>
                <hvmriayn>Y</hvmriayn>
                <hvoc>1</hvoc>
                <hvoxyayn>N1</hvoxyayn>
                <hvs01>5</hvs01>
                <hvs04>1</hvs04>
                <hvs17>8</hvs17>
                <hvs22>2</hvs22>
                <hvs25>3</hvs25>
                <hvs27>1</hvs27>
                <hvs28>1</hvs28>
                <hvs30>4</hvs30>
                <hvs38>122</hvs38>
                <hvs58>20</hvs58>
                <hvventiayn>Y</hvventiayn>
                <hvventisoayn>N1</hvventisoayn>
                <phpid>A2200011</phpid>
                <rnum>2</rnum>
            </item>
            <item>
                <dutyName>강릉아산병원</dutyName>
                <dutyTel3>033-610-3333</dutyTel3>
                <hpid>A2200008</hpid>
                <hv10>Y</hv10>
                <hv11>Y</hv11>
                <hv17>0</hv17>
                <hv18>2</hv18>
                <hv2>1</hv2>
                <hv28>3</hv28>
                <hv29>2</hv29>
                <hv3>2</hv3>
                <hv30>2</hv30>
                <hv31>3</hv31>
                <hv36>27</hv36>
                <hv42>Y</hv42>
                <hv5>Y</hv5>
                <hv7>Y</hv7>
                <hvamyn>Y</hvamyn>
                <hvangioayn>Y</hvangioayn>
                <hvcrrtayn>Y</hvcrrtayn>
                <hvctayn>Y</hvctayn>
                <hvec>12</hvec>
                <hvecmoayn>Y</hvecmoayn>
                <hvgc>112</hvgc>
                <hvhypoayn>Y</hvhypoayn>
                <hvidate>20241202143115</hvidate>
                <hvincuayn>Y</hvincuayn>
                <hvmriayn>Y</hvmriayn>
                <hvncc>8</hvncc>
                <hvoc>10</hvoc>
                <hvoxyayn>Y</hvoxyayn>
                <hvs01>23</hvs01>
                <hvs02>3</hvs02>
                <hvs03>2</hvs03>
                <hvs04>3</hvs04>
                <hvs05>18</hvs05>
                <hvs06>14</hvs06>
                <hvs07>16</hvs07>
                <hvs08>13</hvs08>
                <hvs19>38</hvs19>
                <hvs22>15</hvs22>
                <hvs26>2</hvs26>
                <hvs27>4</hvs27>
                <hvs28>3</hvs28>
                <hvs29>4</hvs29>
                <hvs30>33</hvs30>
                <hvs31>6</hvs31>
                <hvs32>12</hvs32>
                <hvs33>7</hvs33>
                <hvs34>6</hvs34>
                <hvs35>1</hvs35>
                <hvs37>2</hvs37>
                <hvs38>552</hvs38>
                <hvs50>1</hvs50>
                <hvs51>6</hvs51>
                <hvventiayn>Y</hvventiayn>
                <hvventisoayn>Y</hvventisoayn>
                <phpid>A2200008</phpid>
                <rnum>3</rnum>
            </item>
            <item>
                <dutyName>근로복지공단동해병원</dutyName>
                <dutyTel3>033-530-3119</dutyTel3>
                <hpid>A2200038</hpid>
                <hv29>1</hv29>
                <hv35>1</hv35>
                <hv5>Y</hv5>
                <hvamyn>Y</hvamyn>
                <hvangioayn>N1</hvangioayn>
                <hvcrrtayn>N1</hvcrrtayn>
                <hvctayn>Y</hvctayn>
                <hvec>7</hvec>
                <hvecmoayn>N1</hvecmoayn>
                <hvgc>61</hvgc>
                <hvhypoayn>N1</hvhypoayn>
                <hvicc>0</hvicc>
                <hvidate>20241202143000</hvidate>
                <hvincuayn>N1</hvincuayn>
                <hvmriayn>Y</hvmriayn>
                <hvoc>1</hvoc>
                <hvoxyayn>N1</hvoxyayn>
                <hvs01>7</hvs01>
                <hvs03>1</hvs03>
                <hvs17>7</hvs17>
                <hvs18>1</hvs18>
                <hvs22>2</hvs22>
                <hvs27>1</hvs27>
                <hvs28>1</hvs28>
                <hvs30>8</hvs30>
                <hvs38>239</hvs38>
                <hvventiayn>Y</hvventiayn>
                <hvventisoayn>N1</hvventisoayn>
                <phpid>A2200038</phpid>
                <rnum>4</rnum>
            </item>
            <item>
                <dutyName>의료법인동해동인병원</dutyName>
                <dutyTel3>033-530-0129</dutyTel3>
                <hpid>A2200003</hpid>
                <hv30>1</hv30>
                <hv35>1</hv35>
                <hv40>56</hv40>
                <hv5>Y</hv5>
                <hvamyn>Y</hvamyn>
                <hvangioayn>N1</hvangioayn>
                <hvcrrtayn>N1</hvcrrtayn>
                <hvctayn>Y</hvctayn>
                <hvec>6</hvec>
                <hvecmoayn>N1</hvecmoayn>
                <hvgc>27</hvgc>
                <hvhypoayn>N1</hvhypoayn>
                <hvicc>10</hvicc>
                <hvidate>20241202143156</hvidate>
                <hvincuayn>N1</hvincuayn>
                <hvmriayn>Y</hvmriayn>
                <hvoc>0</hvoc>
                <hvoxyayn>N1</hvoxyayn>
                <hvs01>10</hvs01>
                <hvs04>1</hvs04>
                <hvs17>19</hvs17>
                <hvs18>1</hvs18>
                <hvs22>2</hvs22>
                <hvs24>110</hvs24>
                <hvs27>1</hvs27>
                <hvs28>1</hvs28>
                <hvs30>7</hvs30>
                <hvs38>178</hvs38>
                <hvventiayn>Y</hvventiayn>
                <hvventisoayn>N1</hvventisoayn>
                <phpid>A2200003</phpid>
                <rnum>5</rnum>
            </item>
            <item>
                <dutyName>강원특별자치도삼척의료원</dutyName>
                <dutyTel3>033-570-7431</dutyTel3>
                <hpid>A2200007</hpid>
                <hv11>Y</hv11>
                <hv28>2</hv28>
                <hv29>2</hv29>
                <hv30>1</hv30>
                <hv41>3</hv41>
                <hv42>Y</hv42>
                <hv5>Y</hv5>
                <hvamyn>Y</hvamyn>
                <hvangioayn>N1</hvangioayn>
                <hvcrrtayn>N1</hvcrrtayn>
                <hvctayn>Y</hvctayn>
                <hvec>14</hvec>
                <hvecmoayn>N1</hvecmoayn>
                <hvgc>58</hvgc>
                <hvhypoayn>N1</hvhypoayn>
                <hvicc>0</hvicc>
                <hvidate>20241202143002</hvidate>
                <hvincuayn>Y</hvincuayn>
                <hvmriayn>Y</hvmriayn>
                <hvoc>2</hvoc>
                <hvoxyayn>N1</hvoxyayn>
                <hvs01>15</hvs01>
                <hvs02>2</hvs02>
                <hvs03>2</hvs03>
                <hvs04>1</hvs04>
                <hvs17>6</hvs17>
                <hvs22>2</hvs22>
                <hvs25>4</hvs25>
                <hvs26>1</hvs26>
                <hvs27>1</hvs27>
                <hvs28>1</hvs28>
                <hvs30>3</hvs30>
                <hvs32>3</hvs32>
                <hvs38>138</hvs38>
                <hvventiayn>Y</hvventiayn>
                <hvventisoayn>N1</hvventisoayn>
                <phpid>A2200007</phpid>
                <rnum>6</rnum>
            </item>
            <item>
                <dutyName>강원특별자치도속초의료원</dutyName>
                <dutyTel3>033-630-6036</dutyTel3>
                <hpid>A2200012</hpid>
                <hv10>Y</hv10>
                <hv11>Y</hv11>
                <hv29>2</hv29>
                <hv30>1</hv30>
                <hv42>Y</hv42>
                <hv5>Y</hv5>
                <hvamyn>Y</hvamyn>
                <hvangioayn>N1</hvangioayn>
                <hvcrrtayn>N1</hvcrrtayn>
                <hvctayn>Y</hvctayn>
                <hvec>17</hvec>
                <hvecmoayn>N1</hvecmoayn>
                <hvgc>98</hvgc>
                <hvhypoayn>N1</hvhypoayn>
                <hvicc>0</hvicc>
                <hvidate>20241202143001</hvidate>
                <hvincuayn>Y</hvincuayn>
                <hvmriayn>Y</hvmriayn>
                <hvoc>3</hvoc>
                <hvoxyayn>N1</hvoxyayn>
                <hvs01>17</hvs01>
                <hvs03>2</hvs03>
                <hvs04>1</hvs04>
                <hvs17>8</hvs17>
                <hvs22>3</hvs22>
                <hvs26>2</hvs26>
                <hvs27>1</hvs27>
                <hvs28>1</hvs28>
                <hvs30>7</hvs30>
                <hvs31>1</hvs31>
                <hvs32>1</hvs32>
                <hvs38>177</hvs38>
                <hvventiayn>Y</hvventiayn>
                <hvventisoayn>Y</hvventisoayn>
                <phpid>A2200012</phpid>
                <rnum>7</rnum>
            </item>
            <item>
                <dutyName>의료법인보광의료재단속초보광병원</dutyName>
                <dutyTel3>033-639-8988</dutyTel3>
                <hpid>A2200046</hpid>
                <hv30>1</hv30>
                <hv40>20</hv40>
                <hv5>Y</hv5>
                <hvamyn>Y</hvamyn>
                <hvangioayn>N1</hvangioayn>
                <hvcrrtayn>N1</hvcrrtayn>
                <hvctayn>Y</hvctayn>
                <hvec>8</hvec>
                <hvecmoayn>N1</hvecmoayn>
                <hvgc>59</hvgc>
                <hvhypoayn>N1</hvhypoayn>
                <hvicc>1</hvicc>
                <hvidate>20241202143159</hvidate>
                <hvincuayn>N1</hvincuayn>
                <hvmriayn>Y</hvmriayn>
                <hvoc>4</hvoc>
                <hvoxyayn>N1</hvoxyayn>
                <hvs01>9</hvs01>
                <hvs04>1</hvs04>
                <hvs17>15</hvs17>
                <hvs22>4</hvs22>
                <hvs24>59</hvs24>
                <hvs27>1</hvs27>
                <hvs28>1</hvs28>
                <hvs30>4</hvs30>
                <hvs38>219</hvs38>
                <hvventiayn>Y</hvventiayn>
                <hvventisoayn>N1</hvventisoayn>
                <phpid>A2200046</phpid>
                <rnum>8</rnum>
            </item>
            <item>
                <dutyName>의료법인성심의료재단양구성심병원</dutyName>
                <dutyTel3>033-480-8816</dutyTel3>
                <hpid>A2200037</hpid>
                <hv11>Y</hv11>
                <hv29>1</hv29>
                <hv42>Y</hv42>
                <hv5>Y</hv5>
                <hvamyn>Y</hvamyn>
                <hvangioayn>N1</hvangioayn>
                <hvcrrtayn>N1</hvcrrtayn>
                <hvctayn>Y</hvctayn>
                <hvec>7</hvec>
                <hvecmoayn>N1</hvecmoayn>
                <hvgc>26</hvgc>
                <hvhypoayn>N1</hvhypoayn>
                <hvidate>20241202143148</hvidate>
                <hvincuayn>Y</hvincuayn>
                <hvmriayn>N1</hvmriayn>
                <hvoxyayn>N1</hvoxyayn>
                <hvs01>9</hvs01>
                <hvs03>1</hvs03>
                <hvs26>1</hvs26>
                <hvs27>1</hvs27>
                <hvs30>1</hvs30>
                <hvs32>1</hvs32>
                <hvs38>52</hvs38>
                <hvventiayn>Y</hvventiayn>
                <hvventisoayn>N1</hvventisoayn>
                <phpid>A2200037</phpid>
                <rnum>9</rnum>
            </item>
            <item>
                <dutyName>강원특별자치도영월의료원</dutyName>
                <dutyTel3>033-370-9129</dutyTel3>
                <hpid>A2200002</hpid>
                <hv11>Y</hv11>
                <hv27>1</hv27>
                <hv35>0</hv35>
                <hv41>0</hv41>
                <hv42>Y</hv42>
                <hv5>Y</hv5>
                <hvamyn>Y</hvamyn>
                <hvangioayn>N1</hvangioayn>
                <hvcrrtayn>N1</hvcrrtayn>
                <hvctayn>Y</hvctayn>
                <hvec>8</hvec>
                <hvecmoayn>N1</hvecmoayn>
                <hvgc>29</hvgc>
                <hvhypoayn>N1</hvhypoayn>
                <hvicc>0</hvicc>
                <hvidate>20241202143002</hvidate>
                <hvincuayn>Y</hvincuayn>
                <hvmriayn>Y</hvmriayn>
                <hvoc>2</hvoc>
                <hvoxyayn>N1</hvoxyayn>
                <hvs01>9</hvs01>
                <hvs17>10</hvs17>
                <hvs18>2</hvs18>
                <hvs22>2</hvs22>
                <hvs25>2</hvs25>
                <hvs26>1</hvs26>
                <hvs27>1</hvs27>
                <hvs28>1</hvs28>
                <hvs30>7</hvs30>
                <hvs32>3</hvs32>
                <hvs38>174</hvs38>
                <hvs59>1</hvs59>
                <hvventiayn>Y</hvventiayn>
                <hvventisoayn>N1</hvventisoayn>
                <phpid>A2200002</phpid>
                <rnum>10</rnum>
            </item>
        </items>
        <numOfRows>10</numOfRows>
        <pageNo>1</pageNo>
        <totalCount>412</totalCount>
    </body>
</response>''';

  test('실시간 병상 수 통계', () {
    final document = XmlDocument.parse(bookshelfXml);
    final items = document.findAllElements('item');
    items.forEach((node) {
      node.findAllElements('dutyTel3').map((e) => e.text).forEach(print);
      // print(node);
    });
  });
}