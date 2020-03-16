unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, System.Json,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, Datasnap.DBClient, Datasnap.Provider,
  FireDAC.Stan.StorageJSON, Firebase;

type
  TForm2 = class(TForm)
    Image1: TImage;
    pgControle: TPageControl;
    tbiConsulta: TTabSheet;
    DBGrid1: TDBGrid;
    pnInferior: TPanel;
    btnExcluir: TButton;
    btnIncluir: TButton;
    btnBackup: TButton;
    btnLote: TButton;
    Panel3: TPanel;
    Label1: TLabel;
    edtTabela: TEdit;
    tbiCadastro: TTabSheet;
    Panel2: TPanel;
    btnCancelar: TButton;
    btnGravar: TButton;
    pnFundo: TPanel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    edtNome: TEdit;
    edtEmail: TEdit;
    edtTelefone: TEdit;
    ds: TDataSource;
    memContatos: TFDMemTable;
    memContatosCODIGO: TIntegerField;
    memContatosNOME: TStringField;
    memContatosEMAIL: TStringField;
    memContatosTELEFONE: TStringField;
    memContatosDATA_CADASTRO: TStringField;
    pnAutent: TPanel;
    pnAutenticacao: TPanel;
    Panel4: TPanel;
    Label4: TLabel;
    btnLoginAnonimo: TButton;
    btnLoginEmail: TButton;
    btnLoginChaveSecreta: TButton;
    btnLoginSmartPhone: TButton;
    pnAnonimo: TPanel;
    Label5: TLabel;
    memAnonimoApiKey: TMemo;
    Button2: TButton;
    pnEmailSenha: TPanel;
    Label6: TLabel;
    memEmailSenhaApiKey: TMemo;
    Button3: TButton;
    Label7: TLabel;
    edtEmailSenhaEmail: TEdit;
    edtEmailSenhaSenha: TEdit;
    Label8: TLabel;
    Button4: TButton;
    Button5: TButton;
    pnChaveSecreta: TPanel;
    Label9: TLabel;
    memSecreto: TMemo;
    Button6: TButton;
    Panel1: TPanel;
    Panel5: TPanel;
    Label2: TLabel;
    edtPesquisar: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnBackupClick(Sender: TObject);
    procedure btnLoteClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure edtTabelaExit(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure rtErrorOccurred(Sender: TComponent; Codigo: Integer; Erro: string);
    procedure FormResize(Sender: TObject);
    procedure btnLoginAnonimoClick(Sender: TObject);
    procedure btnLoginEmailClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure btnLoginChaveSecretaClick(Sender: TObject);
    procedure edtPesquisarChange(Sender: TObject);
  private
    FCodigo : String;
    procedure listar;
    procedure cadastroLimpar;
  public
    { Public declarations }
    rt : TFBRealTime;
    procedure posicionarEdicao;

    procedure abrirPrograma;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.abrirPrograma;
begin
  pnAutent.Visible      := false;
  pgControle.ActivePage := tbiConsulta;
  listar;
end;

procedure TForm2.btnBackupClick(Sender: TObject);
Var arquivo : String;
begin
  arquivo := ExtractFilePath(Application.ExeName) +'bk_Completo.json';

  if (rt.Download( arquivo )) then
     showMessage('Backup realizado com sucesso!' +sLineBreak+sLineBreak+ 'Caminho: '+arquivo);
end;

procedure TForm2.btnCancelarClick(Sender: TObject);
begin
  listar;
end;

procedure TForm2.btnExcluirClick(Sender: TObject);
begin
  if (memContatosCODIGO.AsString <> '') then
  begin
     if (rt.Collection( edtTabela.Text ).Key( memContatosCODIGO.AsString ).Delete.StatusCommunication = TResponseStatus.rsSucess) then
     begin
        memContatos.Delete;
        showMessage('Registro deletado com sucesso!');
     end;
  end;
end;

procedure TForm2.btnGravarClick(Sender: TObject);
Var novoRegistro : Boolean;

  rtr : TFBRealTimeResponse;
begin
  if (edtNome.Text = '') then
  begin
     showMessage('Informe um nome para proseguir!');
     edtNome.SetFocus;
     exit;
  end else if (edtEmail.Text = '') then
  begin
     showMessage('Informe um email para proseguir!');
     edtEmail.SetFocus;
     exit;
  end else if (edtTelefone.Text = '') then
  begin
     showMessage('Informe um telefone para proseguir!');
     edtTelefone.SetFocus;
     exit;
  end;


  if (FCodigo = '-1') then //INSERINDO NOVO REGISTRO
  begin
     FCodigo      := IntToStr(strToInt(rt.Collection( edtTabela.Text ).getLastRecord('CODIGO')) + 1);
     novoRegistro := true;
  end else
     novoRegistro := false;

  if (rt.Collection( edtTabela.Text ).Key( FCodigo )
        .Field('CODIGO', FCodigo)
        .Field('NOME', edtNome.Text)
        .Field('TELEFONE', edtTelefone.Text)
        .Field('EMAIL', edtEmail.Text)
        .Field('DATA_CADASTRO', rt.getServerDateTime)
        .Add.StatusCommunication = TResponseStatus.rsSucess) then
  begin
     if (novoRegistro) then
       showMessage('Contato '+ edtNome.Text +' inserido com sucesso!')
    else
       showMessage('Contato '+ edtNome.Text +' atualizado com sucesso!');
    listar;
  end;
end;

procedure TForm2.btnIncluirClick(Sender: TObject);
begin
  posicionarEdicao;
  pgControle.ActivePage := tbiCadastro;
  cadastroLimpar;
  edtNome.SetFocus;
end;

procedure TForm2.btnLoginAnonimoClick(Sender: TObject);
begin
  btnLoginAnonimo.Font.Style := [fsBold];
  btnLoginEmail.Font.Style := [];
  btnLoginChaveSecreta.Font.Style := [];
  btnLoginSmartPhone.Font.Style := [];

  pnAnonimo.Visible    := true;
  pnEmailSenha.Visible := false;
  pnChaveSecreta.Visible := false;
end;

procedure TForm2.btnLoginChaveSecretaClick(Sender: TObject);
begin
  btnLoginChaveSecreta.Font.Style := [fsBold];
  btnLoginEmail.Font.Style := [];
  btnLoginAnonimo.Font.Style := [];
  btnLoginSmartPhone.Font.Style := [];

  pnChaveSecreta.Visible := true;
  pnEmailSenha.Visible := false;
  pnAnonimo.Visible    := false;
end;

procedure TForm2.btnLoginEmailClick(Sender: TObject);
begin
  btnLoginEmail.Font.Style := [fsBold];
  btnLoginAnonimo.Font.Style := [];
  btnLoginChaveSecreta.Font.Style := [];
  btnLoginSmartPhone.Font.Style := [];

  pnEmailSenha.Visible := true;
  pnAnonimo.Visible    := false;
  pnChaveSecreta.Visible := false;
end;

procedure TForm2.btnLoteClick(Sender: TObject);
Var int : Integer;
begin
  rt.Collection( edtTabela.Text );
  FCodigo      := IntToStr(strToInt(rt.Collection( edtTabela.Text ).getLastRecord('CODIGO')));
  rt.Batch_StartInsertion;
  Try
    for int := 0 to 15 do
    begin
        FCodigo := intToStr(strToInt(FCodigo) + 1);
        rt.Key( FCodigo )
          .Field('CODIGO', FCodigo)
          .Field('NOME',     'Teste_'+ intToStr(int))
          .Field('TELEFONE', '(51)99550263'+ intToStr(int))
          .Field('EMAIL',    'teste_'+intToStr(int)+'@gmail.com')
          .Field('DATA_CADASTRO', dateTimeToStr(now))
        .Batch_AddRegistration;
    end;
    rt.Batch_FinishInsertion;
  Finally
    rt.Batch_CancelInsertion;
  End;

  listar;
end;

procedure TForm2.Button2Click(Sender: TObject);
Var resultado : String;
begin
  rt.Authentication.Anonymous.ApiKey := memAnonimoApiKey.Lines.Text;

  resultado := rt.Authentication.Anonymous.CreateAnonymousUser.toJsonString;
  if (resultado.Contains('idToken')) then
  begin
     showMessage('Autenticação realizada com sucesso.'+ sLineBreak + resultado);
     abrirPrograma;
  end else
     showMessage('Autenticação negada.'+ sLineBreak + resultado);
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  rt.Authentication.EmailPassword.ApiKey   := memEmailSenhaApiKey.Lines.Text;
  rt.Authentication.EmailPassword.Email    := edtEmailSenhaEmail.Text;
  rt.Authentication.EmailPassword.Password := edtEmailSenhaSenha.Text;

  showMessage('Resultado: '+ sLineBreak+
              rt.Authentication.EmailPassword.SendResetPassword(rt.Authentication.EmailPassword.Email).toJsonString );
end;

procedure TForm2.Button4Click(Sender: TObject);
Var resultado : String;
begin
  rt.Authentication.EmailPassword.ApiKey   := memEmailSenhaApiKey.Lines.Text;
  rt.Authentication.EmailPassword.Email    := edtEmailSenhaEmail.Text;
  rt.Authentication.EmailPassword.Password := edtEmailSenhaSenha.Text;

  resultado := rt.Authentication.EmailPassword.LoginWithEmailAndPassword(rt.Authentication.EmailPassword.Email,
                                                                         rt.Authentication.EmailPassword.Password).toJsonString;
  if (resultado.Contains('idToken')) then
  begin
     showMessage('Autenticação realizada com sucesso!'+ sLineBreak + resultado);
     abrirPrograma;
  end else
     raise Exception.Create('Erro na autenticação:'+ sLineBreak+ resultado);
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
  rt.Authentication.EmailPassword.ApiKey   := memEmailSenhaApiKey.Lines.Text;
  rt.Authentication.EmailPassword.Email    := edtEmailSenhaEmail.Text;
  rt.Authentication.EmailPassword.Password := edtEmailSenhaSenha.Text;



  showMessage('Resultado: '+ sLineBreak+
               rt.Authentication.EmailPassword.CreateUserWithEmailAndPassword(rt.Authentication.EmailPassword.Email,
                                                                              rt.Authentication.EmailPassword.Password)
               .toJsonString
              );
end;

procedure TForm2.Button6Click(Sender: TObject);
begin
  rt.Authentication.SecretKey.Token := memSecreto.Lines.Text;

  if (trim(memSecreto.Lines.Text) <> '') then
  begin
     showMessage('Este tipo de autenticação só é validada no momento do consumo de dados do banco de dados.');
     abrirPrograma;
  end else
     raise Exception.Create('Nenhum token informado.');
end;

procedure TForm2.cadastroLimpar;
begin
  edtNome.Text     := '';
  edtEmail.Text    := '';
  edtTelefone.Text := '';
  FCodigo          := '-1';
end;

procedure TForm2.DBGrid1DblClick(Sender: TObject);
Var rtr : TFBRealTimeResponse;
begin
  if not (memContatos.IsEmpty) then
  begin
     Try
//       CAREGAR CONTATOS DO FIREBASE
         rtr := rt.Collection( edtTabela.Text ).Key( memContatosCODIGO.AsString ).Get;
         if (rt.LoadItemsWithJson( rtr.toJson )) then
         begin
            cadastroLimpar;

            FCodigo               := memContatosCODIGO.AsString;
            edtNome.Text          := rt.Items.getField('NOME');
            edtEmail.Text         := rt.Items.getField('EMAIL');
            edtTelefone.Text      := rt.Items.getField('TELEFONE');
            posicionarEdicao;
            pgControle.ActivePage := tbiCadastro;
         end;
     Finally
         if (Assigned(rtr)) then
         begin
            rtr.Destroy;
            rtr := nil;
         end;
     End;
  end;
end;

procedure TForm2.DBGrid1TitleClick(Column: TColumn);
begin
  memContatos.IndexFieldNames := Column.Field.FieldName;
end;

procedure TForm2.edtPesquisarChange(Sender: TObject);
begin
  if (Trim(edtPesquisar.Text) <> '') then
  begin
     memContatos.Filter   := '';
     Try
       strToInt( edtPesquisar.Text );
       memContatos.Filter   := 'CODIGO = '+ quotedStr(edtPesquisar.Text);
     Except End;

     if (trim(memContatos.Filter) <> '') then
        memContatos.Filter := memContatos.Filter + ' OR NOME LIKE ''%'+ edtPesquisar.Text + '%'''
     else
        memContatos.Filter := memContatos.Filter + 'NOME LIKE ''%'+ edtPesquisar.Text + '%''';
     memContatos.Filter := memContatos.Filter + ' OR TELEFONE LIKE ''%'+ edtPesquisar.Text + '%''';

     memContatos.Filtered := true;
  end else
     memContatos.Filtered := false;
end;

procedure TForm2.edtTabelaExit(Sender: TObject);
begin
  listar;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  memContatos.Active := true;
  memContatos.EmptyDataSet;

  rt                     := TFBRealTime.Create(self);
  rt.ProjectCode         := 'exemplofbrealtime';
  rt.OnGetData.MemTable  := memContatos;
  rt.onErrorOccurred     := rtErrorOccurred;
  pnAutent.Visible       := true;
end;

procedure TForm2.FormPaint(Sender: TObject);
begin
  posicionarEdicao;
end;

procedure TForm2.FormResize(Sender: TObject);
begin
  pnAutent.Left   := 0;
  pnAutent.Top    := 0;
  pnAutent.Width  := Self.ClientWidth;
  pnAutent.Height := Self.ClientHeight;

  pnAutenticacao.Left    := Trunc((Self.ClientWidth / 2) - (pnAutenticacao.Width / 2));
  pnAutenticacao.Top     := Trunc((Self.ClientHeight / 2) - (pnAutenticacao.Height / 2));
end;

procedure TForm2.listar;
begin
   rt.Collection( edtTabela.Text ).Key('').Get;
   if not (pgControle.ActivePage = tbiConsulta) then
      pgControle.ActivePage := tbiConsulta;
end;

procedure TForm2.posicionarEdicao;
begin
  pnFundo.Top  := Trunc((pgControle.Height / 2) - (pnFundo.Height / 2) - pnInferior.Height);
  pnFundo.Left := Trunc((pgControle.Width / 2) - (pnFundo.Width / 2));
end;

procedure TForm2.rtErrorOccurred(Sender: TComponent; Codigo: Integer; Erro: string);
begin
    showMessage('Firebase erro: '+ Erro);
end;

end.
