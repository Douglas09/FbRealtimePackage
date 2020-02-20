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
    pgControle: TPageControl;
    tbiConsulta: TTabSheet;
    tbiCadastro: TTabSheet;
    ds: TDataSource;
    DBGrid1: TDBGrid;
    pnInferior: TPanel;
    btnExcluir: TButton;
    btnIncluir: TButton;
    Panel2: TPanel;
    btnCancelar: TButton;
    btnGravar: TButton;
    btnBackup: TButton;
    btnLote: TButton;
    Image1: TImage;
    memContatos: TFDMemTable;
    memContatosCODIGO: TIntegerField;
    memContatosNOME: TStringField;
    memContatosEMAIL: TStringField;
    memContatosTELEFONE: TStringField;
    memContatosDATA_CADASTRO: TStringField;
    Panel3: TPanel;
    edtTabela: TEdit;
    Label1: TLabel;
    pnFundo: TPanel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    edtNome: TEdit;
    edtEmail: TEdit;
    edtTelefone: TEdit;
    TabSheet1: TTabSheet;
    memRes: TMemo;
    btnEqual: TButton;
    rt: TFBRealTime;
    edtValor: TEdit;
    edtColuna: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    btnStart: TButton;
    btnEnd: TButton;
    Button1: TButton;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
    procedure btnEqualClick(Sender: TObject);
    procedure rtErrorOccurred(Sender: TComponent; Codigo: Integer;
      Erro: string);
    procedure btnStartClick(Sender: TObject);
    procedure btnEndClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FCodigo : String;
    procedure listar;
    procedure cadastroLimpar;
  public
    { Public declarations }
    procedure posicionarEdicao;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

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

procedure TForm2.btnStartClick(Sender: TObject);
Var filtro : TFBFilter;
begin
  filtro := TFBFilter.Create(self);
  filtro.Where( edtColuna.Text ).StartAt( edtValor.Text );

  memRes.Lines.Clear;
  memRes.Lines.Add( rt.Collection('CONTATOS').Get(filtro).ToJson );
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  rt.Authentication.Smartphone.ApiKey := 'AIzaSyBGYBGGge9yRqXILP-vCh6_GPaXykp5CzU';
end;

procedure TForm2.btnEndClick(Sender: TObject);
Var filtro : TFBFilter;
begin
  filtro := TFBFilter.Create(self);
  filtro.Where( edtColuna.Text ).EndAt( edtValor.Text );

  memRes.Lines.Clear;
  memRes.Lines.Add( rt.Collection('CONTATOS').Get(filtro).ToJson );
end;

procedure TForm2.btnEqualClick(Sender: TObject);
Var filtro : TFBFilter;
begin
  filtro := TFBFilter.Create(self).Where( edtColuna.Text ).EqualTo( edtValor.Text );
  
  memRes.Lines.Clear;
  memRes.Lines.Add( rt.Collection('CONTATOS').Get(filtro).ToJson );
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
//         CAREGAR CONTATOS DO FIREBASE
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

procedure TForm2.edtTabelaExit(Sender: TObject);
begin
  listar;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  memContatos.Active := true;
  memContatos.EmptyDataSet;
end;

procedure TForm2.FormPaint(Sender: TObject);
begin
  posicionarEdicao;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  pgControle.ActivePage := tbiConsulta;
  listar;
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
