unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Unit2,Unit3,Unit4,Unit5,Unit6;

const
  filename='density_table_en.csv';

type
  {  UT8FString=type AnsiString(CP_UTF8);}
  UT8FString=UTF8String;
  price=Record
   d:Single;
   name:UT8FString;
  end;

  { TFShapePicker }

  TFShapePicker = class(TForm)
    BGetDataTable: TButton;
    BPickSphere: TButton;
    BPickCylinder: TButton;
    BPickCube: TButton;
    BPick3DBar: TButton;
    BPickComplex: TButton;
    LblInstruction: TLabel;
    procedure BGetDataTableClick(Sender: TObject);
    procedure BPick3DBarClick(Sender: TObject);
    procedure BPickComplexClick(Sender : TObject);
    procedure BPickCubeClick(Sender: TObject);
    procedure BPickSphereClick(Sender:TObject);
    procedure BPickCylinderClick(Sender:TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }

  end;

var
  FShapePicker: TFShapePicker;
  dt:array of Price;
  buf,strmaterialdens,materialname:UT8FString;
  materialdens:Single;
  namelen,sci:Word;
  n:LongInt;
  F:System.Text;

implementation
procedure TFShapePicker.BPickSphereClick(Sender:TObject);
begin
     FSphere.Show;
end;

procedure FindTableBound(var F:Text);
var buf:String;
    i:LongInt;
    Ftmp:Text;
begin
     System.Assign(Ftmp,'temp.csv');

     Reset(F);
     i:=0;
     while not EOF(F) do
     begin
          Readln(F,buf);
          Inc(i);
     end;
     ReWrite(Ftmp);
     WriteLn(Ftmp,i);
     Reset(F);
     while not EOF(F) do
     begin
          ReadLn(F,buf);
          WriteLn(Ftmp,buf);
     end;
     Close(Ftmp);
     Close(F);
     RenameFile(filename,filename+'.old');
     RenameFile('temp.csv',filename);
end;

procedure ReadDTableData;
begin
    if FileExists(filename) then
  begin
       System.Assign(F,filename);
       Reset(F);
       ReadLn(F,buf);
       Val(buf,n,valcode);
       if (n<0) or (valcode<>0) then FindTableBound(F);

       Reset(F);
       ReadLn(F,buf);
       Val(buf,n,valcode);

       SetLength(dt,n+1);
       dt[0].d:=0;

       for i:=1 to n do
       begin
            ReadLn(F,buf);
            sci:=Pos(';',buf); {first semicolon index}
            strmaterialdens:=Copy(buf,1,sci-1);
            namelen:=Length(buf)-sci; {material label length}
            materialname:=Copy(buf,sci+1,namelen);
            Val(strmaterialdens,materialdens,valcode);
            dt[i].d:=materialdens;
            dt[i].name:=materialname;
            {TODO: push it into an array}
       end;
  end else
  begin
       ShowMessage('Resource not found near the exe, using embedded restricted set');
       {TODO Init da table with code data}
  end;
end;

procedure TFShapePicker.BGetDataTableClick(Sender: TObject);
begin
  ReadDTableData;
end;

procedure TFShapePicker.BPick3DBarClick(Sender: TObject);
begin
  FBar.Show;
end;

procedure TFShapePicker.BPickComplexClick(Sender : TObject);
begin
  FComplex.Show;
end;

procedure TFShapePicker.BPickCubeClick(Sender: TObject);
begin
  FCube.Show;
end;

procedure TFShapePicker.BPickCylinderClick(Sender:TObject);
begin
     FCylinder.Show;
end;

procedure TFShapePicker.FormCreate(Sender: TObject);
begin
  SetLength(dt,2);
  dt[0].d:=-1;
end;

{$R *.lfm}

{ TFShapePicker }

end.

