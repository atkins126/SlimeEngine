program SlimeEDIT;

uses
  Vcl.Forms,
  SlimeEditor in 'SlimeEditor.pas' {Form7},
  slimeengine in 'slimeengine.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm7, Form7);
  Application.Run;
end.
