unit Unit5;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

const
  filename='density_table_en.csv';

type

  { TFCube }

  { TFBar }

  TFBar = class(TForm)
    CBCompute: TButton;
    EditA: TEdit;
    EditB: TEdit;
    EditC: TEdit;
    EditM: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
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
  FBar: TFBar;
  a,b,c,V,m,Rho,rmin:Real;
  s:String;
  imin,i,valcode:Longint;

implementation
uses Unit1;

{$R *.lfm}

{ TFSphere }

procedure TFBar.CBComputeClick(Sender: TObject);
begin
     Val(EditA.Text,a,valcode);
     if a=0 then a:=0.0000001;
     a:=a/1000;
     Val(EditB.Text,b,valcode);
     if b=0 then b:=0.0000001;
     b:=b/1000;
     Val(EditC.Text,c,valcode);
     if c=0 then c:=0.0000001;
     c:=c/1000;
     Val(EditM.Text,m,valcode);
     m:=m/1000;
     V:=a*b*c;
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
