unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TFCylinder }

  TFCylinder = class(TForm)
    CBCompute: TButton;
    EditD: TEdit;
    EditH: TEdit;
    EditM: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LblDensity: TLabel;
    Lbl_dRho: TLabel;
    Lbl_eps: TLabel;
    Lbl_found: TLabel;
    procedure CBComputeClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FCylinder: TFCylinder;
  D,H,m,V,Rho,rmin:Single;
  valcode:Integer;
  imin,i:Longint;
  s:String;

implementation
uses Unit1;

{$R *.lfm}

{ TFCylinder }

procedure TFCylinder.CBComputeClick(Sender: TObject);
begin
     Val(EditD.Text,D,valcode);
     if d=0 then d:=0.0000001;
     d:=d/1000;
     Val(EditH.Text,H,Valcode);
     if h=0 then h:=0.0000001;
     h:=h/1000;
     Val(EditM.Text,m,valcode);
     m:=m/1000;
     V:=Pi*D*D*H/4;
     Rho:=m/V;
     Str(Rho:0:3,s);
     LblDensity.Caption:='Получена плотность ' + s + ' кг/м3';

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
     Str(Rho - dt[imin].d :0:3,s);
     Lbl_dRho.Caption:='Абсолютная погрешность Δρ=' + s;
     Str((Rho - dt[imin].d)/dt[imin].d *100 :0:2,s);
     Lbl_eps.Caption:='Относительная погрешность ε=' + s + ' %';
     end;
end;

end.

