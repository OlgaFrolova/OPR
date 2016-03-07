//Динамическая загрузка DLL для калькулятора,в особенности тригонометрические функции
library Trigonom;
uses
  SysUtils,
  Classes;
  function SINUS(X:real):real; StdCall;
begin
 Result:=sin(x);
end;
exports SINUS;

function COSINUS(X:real):real; StdCall;
begin
 Result:=cos(x);
end;
exports COSINUS;

function TANGENS(X:real):real; StdCall;
begin
 Result:=tan(x);
end;
exports TANGENS;
{$R *.res}
begin
end.
//**********Подключение библиотеки
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg, Buttons,Math, Menus;
type TAddReals=function(p1:real):real; stdcall;
type
  TForm1 = class(TForm)
    Image1: TImage;
    Edit1: TEdit;
    Image2: TImage;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;//...........
   
   private
  SINUS: TAddReals;
  COSINUS: TAddReals;
  TANGENS: TAddReals;

    { Private declarations }
  public
    { Public declarations }
  end;
  var
  Form1: TForm1;
  a,b,c:extended;
  d: char;
implementation

procedure TForm1.SpeedButton24Click(Sender: TObject);
  var
 r:real;
 Handle:LongWord;
 k:real;
begin
if edit1.Text<>'' then  k:=strtofloat(Edit1.Text);
 Handle:=LoadLibrary('Trigonom.dll');//Загрузка библиотеки
 if (Handle=0) then
 begin
 ShowMessage('Библиотека Trigonom.dll не найдена');
 Halt;
 end;
 @SINUS:=GetProcAddress(Handle,'SINUS');// получение указателя на функцию
 r:=Sin(k);// вызов функции
  edit1.Text:=floattostr(r);// преобразование типа и вывод рез-та
 FreeLibrary(Handle);// выгрузка библиотеки
end;
