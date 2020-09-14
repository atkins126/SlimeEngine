program Project1;

uses
  Vcl.Forms,
  Tri in 'Tri.pas' {Form1},
  slimeengine in 'slimeengine.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
