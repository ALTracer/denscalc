unit Unit6;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TFComplex }

  TFComplex = class(TForm)
    CBCompute : TButton;
    EditdV : TEdit;
    EditdM : TEdit;
    EditV : TEdit;
    EditM : TEdit;
    Image1 : TImage;
    Label1 : TLabel;
    Label2 : TLabel;
    Label3 : TLabel;
    Label4 : TLabel;
    Lbl_dRho : TLabel;
    LblDensity : TLabel;
    Lbl_eps : TLabel;
    Lbl_devRho : TLabel;
    Lbl_devRhorel : TLabel;
    Lbl_found : TLabel;
    procedure CBComputeClick(Sender : TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FComplex : TFComplex;

implementation
uses Unit1;

{$R *.lfm}

{ TFComplex }

procedure TFComplex.CBComputeClick(Sender : TObject);
var
  m,V,Rho:Single;
  dM,dV,dRho,eps,RhoUp,RhoDown,epsM,epsV:Double;
  rmin:Single;
  i,imin,valcode:LongInt;
  s:AnsiString;
begin
  Val(EditV.Text,V,valcode);
  if V=0 then V:=0.0000001;  //shouldn't divide by zero
  V:=V/1000000; //from milli-liters to cubic meters
  Val(EditM.Text,m,valcode);
  m:=m/1000;  //from grams to kilograms
  Rho:=m/V;
  Str(Rho:0:3,s);  //I assume 3 digits are enough now
  LblDensity.Caption:='Получена плотность ' + s + ' кг/м3';

  Val(EditdV.Text,dV,valcode);
  dV:=dV/1000000;
//  epsV:=dV/V;
  Val(EditdM.Text,dM,valcode);
  dM:=dM/1000;
  //epsM:=dM/m;
  eps:=dV/V + dM/M;
  RhoUp:=(m+dM)/(V-dV);
  RhoDown:=(m-Dm)/(V+dV);
  dRho:=(RhoUp-RhoDown)/2;
  //dRho:=dM+dV;
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
  Lbl_found.Caption:='Ближайший известный материал - ' + dt[imin].name + ' (' + s + ')';
  Str(Rho - dt[imin].d :0:3,s);
  Lbl_devRho.Caption:='Абсолютное отклонение Δρ=' + s;
  Str((Rho - dt[imin].d)/dt[imin].d *100 :0:2,s);
  Lbl_devRhorel.Caption:='Относительное отклонение ε=' + s + ' %';
  end;
end;

end.

