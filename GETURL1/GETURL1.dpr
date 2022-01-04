program GETURL1;

uses
  Forms,
  GET in 'GET.pas' {Form1},
  ATPService in 'ATPService.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
