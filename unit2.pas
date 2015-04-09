unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TFSphere }

  TFSphere = class(TForm)
    CBCompute: TButton;
    EditD: TEdit;
    EditdM : TEdit;
    EditdD : TEdit;
    EditM: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3 : TLabel;
    Label4 : TLabel;
    Lbl_found: TLabel;
    Lbl_eps: TLabel;
    Lbl_dRho: TLabel;
    LblDensity: TLabel;
    procedure CBComputeClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FSphere: TFSphere;
  d,V,m,Rho,rmin:Real;
  s:String;
  imin,i,valcode:Longint;

implementation
uses Unit1;

{$R *.lfm}

{ TFSphere }

procedure TFSphere.CBComputeClick(Sender: TObject);
var
  m,V,Rho:Single;
  dM,dD,dV,dRho,eps,RhoUp,RhoDown,epsM,epsD,epsV:Double;
  rmin:Single;
  i,imin,valcode:LongInt;
  s:AnsiString;
begin
     Val(EditD.Text,D,valcode); //Считываем диаметр из текстового поля EditD в переменную d;
     if d=0 then d:=0.0000001;  //нельзя делить на ноль
     d:=d/1000;                 // переводим милииметры в метры
     Val(EditM.Text,m,valcode); //Считываем массу шара из текстового поля EditM в переменную m;
     m:=m/1000;                 // граммы в килограммы
     V:=D*D*D*Pi/6;             //формула объёма шара
     Rho:=m/V;                  //формула плотности
     Str(Rho:0:3,s);            // формируем строку из значения плотности
     LblDensity.Caption:='Получена плотность ' + s + ' кг/м3'; //вывод ответа в поле LblDensity

     Val(EditdD.Text,dD,valcode);//Читаем абс погрешность измерения диаметра
     dD:=dD/1000;                // не в мм, а в метрах
     //epsD:=dD/D;
     Val(EditdM.Text,dM,valcode);
     dM:=dM/1000;
     //epsM:=dM/m;

     dV:=3*D*D*dD*Pi/6;
     epsV:=3*dV/V;               // отн погр объёма

  dRho:=(m*dV+V*dm)/V/V;
  eps:=dm/m+dV/V;

  Str(dRho:0:3,s);
  Lbl_dRho.Caption:='Абсолютная погрешность Δρ=±' + s + ' кг/м3';
  Str(eps:0:3,s);
  Lbl_eps.Caption:='Относительная погрешность ε=±' + s + ' %';

     rmin:=30000;
     imin:=1;
     for i:=1 to n do
     begin
          if Abs(rho-dt[i].d)<rmin then
          begin
               rmin:=Abs(rho-dt[i].d);
               imin:=i;
          end;
     end;

     if dt[0].d=-1 then Lbl_found.caption:=('База плотностей не считана с диска.')
     else begin
     Str(dt[imin].d:0:3,s);
     Lbl_found.Caption:='Материал детали - ' + dt[imin].name + ' (' + s + ')';
     end;
end;

begin
end.
