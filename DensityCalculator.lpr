program DensityCalculator;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Dialogs, Forms, Unit1, Unit2, Unit3, Unit4, Unit5, Unit6;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TFShapePicker, FShapePicker);
  Application.CreateForm(TFSphere, FSphere);
  Application.CreateForm(TFCylinder, FCylinder);
  Application.CreateForm(TFCube, FCube);
  Application.CreateForm(TFBar, FBar);
  Application.CreateForm(TFComplex, FComplex);
  Application.Run;
end.

