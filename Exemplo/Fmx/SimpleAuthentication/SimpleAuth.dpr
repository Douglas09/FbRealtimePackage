program SimpleAuth;

uses
  System.StartUpCopy,
  FMX.Forms,
  UPrincipalAuth in 'UPrincipalAuth.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
