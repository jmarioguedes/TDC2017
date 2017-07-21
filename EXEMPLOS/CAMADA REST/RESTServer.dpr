program RESTServer;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {Form1},
  Regras in 'Regras.pas' {dmRegras: TDataModule},
  ExemploClasseRemota in 'ExemploClasseRemota.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TdmRegras, dmRegras);
  Application.Run;
end.
