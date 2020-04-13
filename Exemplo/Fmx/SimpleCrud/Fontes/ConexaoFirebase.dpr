program ConexaoFirebase;

uses
  System.StartUpCopy,
  FMX.Forms,
  U_Principal in 'U_Principal.pas' {Frm_Principal};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrm_Principal, Frm_Principal);
  Application.Run;
end.
