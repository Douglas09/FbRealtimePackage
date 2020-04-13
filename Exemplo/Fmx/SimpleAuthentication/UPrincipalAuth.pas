unit UPrincipalAuth;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Firebase,
  FMX.TabControl, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, System.Json,
  FMX.Objects, FMX.Edit, FMX.StdCtrls;

type
  TForm2 = class(TForm)
    TabControl1: TTabControl;
    memAut: TMemo;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    FBRealTime1: TFBRealTime;
    Text1: TText;
    mAnApiKey: TMemo;
    Rectangle1: TRectangle;
    Text2: TText;
    Button1: TButton;
    eProjectCode: TEdit;
    mEsApiKey: TMemo;
    Text3: TText;
    Text4: TText;
    mEsEmail: TEdit;
    mEsSenha: TEdit;
    Text5: TText;
    Rectangle2: TRectangle;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    mCsToken: TMemo;
    Text6: TText;
    Button5: TButton;
    Text7: TText;
    mSApiKey: TMemo;
    mSNumero: TEdit;
    Text8: TText;
    mSCodigoVerificacao: TEdit;
    Text9: TText;
    Rectangle3: TRectangle;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Text10: TText;
    mSRecaptcha: TEdit;
    mSSession: TEdit;
    Text11: TText;
    Text12: TText;
    procedure FBRealTime1AfterAuthenticating(Sender: TComponent; token,
      resultJson: string; AutenticationType: TFBAuthType);
    procedure ButtonClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FBRealTime1ErrorOccurred(Sender: TComponent; Code: Integer;
      Error: string);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure forcarAutenticacao;
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}


procedure TForm2.ButtonClick(Sender: TObject);
begin
  //CÓDIGO DO PROJETO
  FBRealTime1.ProjectCode := eProjectCode.Text;

  //API KEY DA TUA CONTA NO FIREBASE
  FBRealTime1.Authentication.Anonymous.ApiKey := mAnApiKey.Lines.Text;

  forcarAutenticacao;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  //CÓDIGO DO PROJETO
  FBRealTime1.ProjectCode                           := eProjectCode.Text;

  //DADOS INFORMADOS PELO USUÁRIO DINAMICAMENTE
  FBRealTime1.Authentication.EmailPassword.ApiKey   := mEsApiKey.Lines.Text;
  FBRealTime1.Authentication.EmailPassword.Email    := mEsEmail.Text;
  FBRealTime1.Authentication.EmailPassword.Password := mEsSenha.Text;

  //RESETANDO A SENHA DO E-MAIL (RECEBE 1 Email solicitando a nova senha)
  memAut.Lines.Add('Resetando Senha = '+ sLineBreak+
              FBRealTime1.Authentication.EmailPassword.SendResetPassword(FBRealTime1.Authentication.EmailPassword.Email).toJsonString );
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  //CÓDIGO DO PROJETO
  FBRealTime1.ProjectCode                           := eProjectCode.Text;

  //DADOS INFORMADOS PELO USUÁRIO DINAMICAMENTE
  FBRealTime1.Authentication.EmailPassword.ApiKey   := mEsApiKey.Lines.Text;
  FBRealTime1.Authentication.EmailPassword.Email    := mEsEmail.Text;
  FBRealTime1.Authentication.EmailPassword.Password := mEsSenha.Text;

  //CASO O E-MAIL AINDA NÃO ESTÁ CADASTRADO, AQUI É FEITO O CADASTRO DE UM NOVO USUÁRIO NO SITE
  memAut.Lines.Add('Resultado: '+ sLineBreak+
               FBRealTime1.Authentication.EmailPassword.CreateUserWithEmailAndPassword(FBRealTime1.Authentication.EmailPassword.Email,
                                                                              FBRealTime1.Authentication.EmailPassword.Password)
               .toJsonString
              );
end;

procedure TForm2.Button4Click(Sender: TObject);
Var resultado : String;
begin
  //CÓDIGO DO PROJETO
  FBRealTime1.ProjectCode                           := eProjectCode.Text;

  //DADOS INFORMADOS PELO USUÁRIO DINAMICAMENTE
  FBRealTime1.Authentication.EmailPassword.ApiKey   := mEsApiKey.Lines.Text;
  FBRealTime1.Authentication.EmailPassword.Email    := mEsEmail.Text;
  FBRealTime1.Authentication.EmailPassword.Password := mEsSenha.Text;

  //EFETUANDO O LOGIN/AUTENTICAÇÃO FIA E-MAIL E SENHA
  resultado := FBRealTime1.Authentication.EmailPassword.LoginWithEmailAndPassword(FBRealTime1.Authentication.EmailPassword.Email,
                                                                         FBRealTime1.Authentication.EmailPassword.Password).toJsonString;

  if (resultado.Contains('idToken')) then
     memAut.Lines.Add('Autenticação realizada com sucesso!'+ sLineBreak + resultado)
  else
     memAut.Lines.Add('Erro na autenticação:'+ sLineBreak+ resultado);
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
  //CÓDIGO DO PROJETO
  FBRealTime1.ProjectCode                    := eProjectCode.Text;

  //CAMPO ONDE É INFORMADO A CHAVE SECRETA PEGA NO PAINEL DO FIREBASE ( configurações -> Contas de Serviço -> Chave secreta do banco de dados )
  FBRealTime1.Authentication.SecretKey.Token := mCsToken.Lines.Text;

  forcarAutenticacao;
end;

procedure TForm2.Button6Click(Sender: TObject);
Var res : String;
    objResultado : TJSONObject;
begin
  //CÓDIGO DO PROJETO
  FBRealTime1.ProjectCode := eProjectCode.Text;

  FBRealTime1.Authentication.Smartphone.ApiKey           := mSApiKey.Lines.Text;
  FBRealTime1.Authentication.Smartphone.Number           := mSNumero.Text;
  FBRealTime1.Authentication.Smartphone.CodeVerification := mSCodigoVerificacao.Text;

  //FAZ REQUISIÇÃO NO FIREBASE PARA CAPTURAR O RECAPTCHA TOKEN
  res := FBRealTime1.Authentication.Smartphone.getRecaptchaParam.toJsonString;

  //COM O RETORNO DA REQUISIÇÃO É CRIADO UM JSON E CAPTURADO A PROPRIEDADE "recaptchaStoken"
  Try
     objResultado     := TJSONObject.Create;
     objResultado     := (TJSONObject.ParseJSONValue( res ) as TJSONObject);
     mSRecaptcha.Text := objResultado.Get('recaptchaStoken').JsonValue.Value;
  Finally
     objResultado.Free;
  End;
end;

procedure TForm2.Button7Click(Sender: TObject);
Var resultadoStr : String;
    objResultado : TJSONObject;
begin
  //CÓDIGO DO PROJETO
  FBRealTime1.ProjectCode := eProjectCode.Text;

  FBRealTime1.Authentication.Smartphone.ApiKey           := mSApiKey.Lines.Text;
  FBRealTime1.Authentication.Smartphone.Number           := mSNumero.Text;
  FBRealTime1.Authentication.Smartphone.CodeVerification := mSCodigoVerificacao.Text;

  resultadoStr := FBRealTime1.Authentication.Smartphone.verifyRecaptchaCode(FBRealTime1.Authentication.Smartphone.CodeVerification, MSSession.text).toJsonString;

  forcarAutenticacao;
end;

procedure TForm2.Button8Click(Sender: TObject);
Var resultadoStr : String;
    objResultado : TJSONObject;
begin
  //CÓDIGO DO PROJETO
  FBRealTime1.ProjectCode := eProjectCode.Text;

  FBRealTime1.Authentication.Smartphone.ApiKey           := mSApiKey.Lines.Text;
  FBRealTime1.Authentication.Smartphone.Number           := mSNumero.Text;
  FBRealTime1.Authentication.Smartphone.CodeVerification := mSCodigoVerificacao.Text;

  resultadoStr := FBRealTime1.Authentication.Smartphone.sendRecaptchaCode(FBRealTime1.Authentication.Smartphone.Number, mSRecaptcha.Text).toJsonString;

  Try
     Try
       objResultado     := TJSONObject.Create;
       objResultado     := (TJSONObject.ParseJSONValue( resultadoStr ) as TJSONObject);
       mSSession.text   := objResultado.Get('sessionInfo').JsonValue.Value;
       memAut.Lines.Add('SessionInfo: '+ mSSession.text);
     Except
       showMessage( resultadoStr );
     End;
  Finally
     objResultado.Free;
  End;
end;

procedure TForm2.FBRealTime1AfterAuthenticating(Sender: TComponent; token, resultJson: string; AutenticationType: TFBAuthType);
begin
  //EVENTO DISPARADO APÓS A AUTENTICAÇÃO SER REALIZADA NO FIREBASE
  if (AutenticationType <> TFBAuthType.fbaNone) then
  begin
     memAut.Lines.Clear;
     memAut.Lines.Add('Código do Projeto: '+ FBRealTime1.ProjectCode);
     memAut.Lines.Add('Token: '+ token);
     if (AutenticationType = TFBAuthType.fbaAnonymous) then
        memAut.Lines.Add('Tipo: Anônima')
     else if (AutenticationType = TFBAuthType.fbaSecretKey) then
        memAut.Lines.Add('Tipo: Chave Secreta')
     else if (AutenticationType = TFBAuthType.fbaSmartphone) then
        memAut.Lines.Add('Tipo: SmartPhone')
     else if (AutenticationType = TFBAuthType.fbaEmailPassword) then
        memAut.Lines.Add('Tipo: Email e senha');
     memAut.Lines.Add('Result: '+ resultJson);
  end;
end;

procedure TForm2.FBRealTime1ErrorOccurred(Sender: TComponent; Code: Integer; Error: string);
begin
  {CASO OCORRER ALGUM ERRO DENTRO DO COMPONENTE, ELE SERÁ DISPONIBILIZADO NESTA FUNÇÃO}

  memAut.Lines.Add('ERROR: '+ Code.ToString +' - '+ Error);
end;

procedure TForm2.forcarAutenticacao;
begin
  {
    FUNÇÃO PARA FORÇAR A AUTENTICAÇÃO DO USUÁRIO
    POIS ALGUNS TIPOS DE AUTENTICAÇÃO COMO:
      - Anônimo
      - Chave Secreta
    SÓ SÃO AUTENTICADOS AO CONSUMIR DA API
  }
  memAut.Lines.Add('--------------------------------------');
  memAut.Lines.Add('--------------------------------------');
  memAut.Lines.Add( 'RESULTADO: '+ FBRealTime1.Collection('CONTATOS').Key(1).Get().ToJson );
  memAut.Lines.Add('--------------------------------------');
  memAut.Lines.Add('--------------------------------------');
end;

end.
