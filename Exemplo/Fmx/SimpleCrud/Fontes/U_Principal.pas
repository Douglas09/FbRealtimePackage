unit U_Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Ani,
  FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.Effects,
  FMX.Layouts, FMX.TabControl, System.Actions, FMX.ActnList, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FMX.ScrollBox, FMX.Memo, Firebase;

type
  TFrm_Principal = class(TForm)
    FundoAcesso: TRectangle;
    DadosAut: TRectangle;
    SombraDadosAut: TShadowEffect;
    Edt_CodigoProjeto: TEdit;
    edt_ChaveSecreta: TEdit;
    Btn_Acessar: TSpeedButton;
    Rect_Acessar: TRectangle;
    LogoApp: TCircle;
    Sombra_LogoApp: TShadowEffect;
    Text1: TText;
    TBC_Principal: TTabControl;
    TB_Acesso: TTabItem;
    TB_Listagem: TTabItem;
    TB_Cadastro: TTabItem;
    Lyt_Acesso: TLayout;
    FundoListagem: TRectangle;
    FundoCadastro: TRectangle;
    Lyt_Listagem: TLayout;
    ToolBar_Listagem: TRectangle;
    SombraToolBarListagem: TShadowEffect;
    TextoToolBarListagem: TLabel;
    Novo: TCircle;
    VoltarListagem: TCircle;
    MolduraLista: TRectangle;
    SombraListagem: TShadowEffect;
    AcoesTab: TActionList;
    Goto_TabAcesso: TChangeTabAction;
    Goto_TabListagem: TChangeTabAction;
    Goto_TabCadastro: TChangeTabAction;
    LV_Contatos: TListView;
    ToolBar_Cadastro: TRectangle;
    SombraToolBarCadastro: TShadowEffect;
    TextoToolBarCadastro: TLabel;
    VoltarCadastro: TCircle;
    Excluir: TCircle;
    ImgVoltarListagem: TImage;
    ImgVoltarCadastro: TImage;
    ImgDeletar: TImage;
    ImgNovoCadastro: TImage;
    MolduraCadastro: TRectangle;
    SombraMolduraCadastro: TShadowEffect;
    Foto: TCircle;
    SombraFoto: TShadowEffect;
    Lyt_Cadastro: TLayout;
    Edt_Nome: TEdit;
    Edt_EmailCadastro: TEdit;
    Edt_Telefone: TEdit;
    Confirmar: TRectangle;
    BtnConfirmar: TSpeedButton;
    AbreFoto: TOpenDialog;
    FotoDefault: TImage;
    rt: TFBRealTime;
    Lyt_Aguarde: TLayout;
    FundoTelaAguarde: TRectangle;
    RetAguarde: TRectangle;
    Animacao: TCircle;
    AnimaAguarde: TBitmapListAnimation;
    TextoAguarde: TText;
    VertScrollBox1: TVertScrollBox;
    Layout1: TLayout;
    Edt_ApiKey: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Btn_AcessarClick(Sender: TObject);
    procedure VoltarListagemClick(Sender: TObject);
    procedure VoltarCadastroClick(Sender: TObject);
    procedure NovoClick(Sender: TObject);
    procedure FotoClick(Sender: TObject);
    procedure BtnConfirmarClick(Sender: TObject);
    procedure LV_ContatosItemClickEx(const Sender: TObject; ItemIndex: Integer; const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure ExcluirClick(Sender: TObject);
    procedure VoltarListagemMouseEnter(Sender: TObject);
    procedure VoltarListagemMouseLeave(Sender: TObject);
    procedure rtErrorOccurred(Sender: TComponent; Codigo: Integer; Erro: string);
  private
    procedure aoEncerrarGravacaoDoContato(Senter : TOBject);
    procedure Aguarde_Mostrar(Mensagem : String);
    procedure Aguarde_Esconder;
  public
    FCodigo : String;
    FCaminhoFoto : String;
    mensagemAguarde : String;
    Procedimento : TProc;

    procedure listarContatos;
    procedure ThreadExecute(onFinished : TNotifyEvent);
  end;

var
  Frm_Principal: TFrm_Principal;

implementation

uses System.netEncoding;

{$R *.fmx}

function Base64ToStream(imagem: String): TMemoryStream;
var Base64 : TBase64Encoding;
    bytes : tBytes;
begin
  Base64 := TBase64Encoding.Create;
  Try
    bytes  := Base64.DecodeStringToBytes(imagem);
    result := TBytesStream.Create(bytes);
    result.Seek(0, 0);
  Finally
    FreeAndNil(Base64);
    SetLength(bytes, 0);
  End;
end;

function Base64ToBitmap(imagem: String): TBitmap;
Var sTream : TMemoryStream;
begin
  result := nil;
  if (trim(imagem) = '') then
    exit;

  sTream := nil;
  Try
    sTream := Base64ToStream(imagem);
    result := TBitmap.CreateFromStream(sTream);
  Finally
    sTream.DisposeOf;
  end;
end;

procedure TFrm_Principal.Aguarde_Esconder;
begin
  Lyt_Aguarde.Visible := false;
end;

procedure TFrm_Principal.Aguarde_Mostrar(Mensagem: String);
begin
  TextoAguarde.Text   := Mensagem;
  Lyt_Aguarde.Visible := true;
end;

procedure TFrm_Principal.aoEncerrarGravacaoDoContato(Senter: TOBject);
begin
  VoltarCadastroClick(VoltarCadastro);
end;

procedure TFrm_Principal.BtnConfirmarClick(Sender: TObject);
begin
  Procedimento := procedure
  begin
    if (FCodigo = '-1') then
      FCodigo := rt.Collection('CONTATOS').getNextRecord('CODIGO');

    rt.Collection('CONTATOS')
      .Key(FCodigo)
      .Field('CODIGO', FCodigo)
      .Field('NOME', Edt_Nome.Text)
      .Field('EMAIL', Edt_EmailCadastro.Text)
      .Field('TELEFONE', Edt_Telefone.Text)
      .Add;

    if (FCaminhoFoto <> '') then
      rt.Collection('ARQUIVOS/CONTATOS').Key( FCodigo ).FieldFile('FOTO_PERFIL', FCaminhoFoto).Add;
  end;
  mensagemAguarde := 'Registrando contato...';
  ThreadExecute(aoEncerrarGravacaoDoContato);
end;

procedure TFrm_Principal.Btn_AcessarClick(Sender: TObject);
begin
  rt.ProjectCode                     := Edt_CodigoProjeto.Text;
  rt.Authentication.Anonymous.ApiKey := Edt_ApiKey.Text;
  rt.Authentication.SecretKey.Token  := edt_ChaveSecreta.Text;

  Goto_TabListagem.ExecuteTarget(Self);
  listarContatos;
end;

procedure TFrm_Principal.ExcluirClick(Sender: TObject);
begin
  rt.Collection('ARQUIVOS/CONTATOS').Key( FCodigo ).Delete;
  rt.Collection('CONTATOS').Key( FCodigo ).Delete;
  VoltarCadastroClick(VoltarCadastro);
end;

procedure TFrm_Principal.FormCreate(Sender: TObject);
begin
  Procedimento := procedure begin end;

  TBC_Principal.TabPosition := TTabPosition.None;
  TBC_Principal.ActiveTab   := TB_Acesso;
end;

procedure TFrm_Principal.FotoClick(Sender: TObject);
begin
  if (AbreFoto.Execute) then
  begin
    if (AbreFoto.FileName = '') then
      exit;

    FCaminhoFoto := AbreFoto.FileName;
    Foto.Fill.Bitmap.Bitmap.LoadFromFile(FCaminhoFoto);
  end;
end;

procedure TFrm_Principal.listarContatos;
begin
  Procedimento := procedure
    Var ItemAdd : TListViewItem;
        rtr : TFBRealTimeResponse;
    begin
      rtr := nil;
      Try
        TThread.Synchronize(nil, procedure
          begin
            LV_Contatos.Items.Clear;
          end);

        rtr := rt.Collection('CONTATOS').Key('').Get;
        if (rt.LoadItemsWithJson( rtr.toJson )) then
        begin
          TThread.Synchronize(nil, procedure
            begin
              LV_Contatos.BeginUpdate;
            end);

          while not (rt.Items.Eof) do
          begin
            ItemAdd := LV_Contatos.Items.Add;
            ItemAdd.Data['prCodigo'] := rt.Items.getField('CODIGO');
            ItemAdd.Data['prNome']   := rt.Items.getField('NOME');

            rt.Items.Next;
          end;

          TThread.Synchronize(nil, procedure
            begin
              LV_Contatos.EndUpdate;
            end);
        end;
      Finally
        {$IFDEF MSWINDOWS}
          FreeAndNil(rtr);
        {$ELSE}
          rtr.DisposeOf;
        {$ENDIF}
      end;
    end;
  mensagemAguarde := 'Buscando contatos...';
  ThreadExecute(nil);
end;

procedure TFrm_Principal.LV_ContatosItemClickEx(const Sender: TObject; ItemIndex: Integer; const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
begin
   Procedimento := procedure
   Var rtr : TFBRealTimeResponse;
       codigo : String;
   begin
     rtr := nil;
     Try
       codigo := LV_Contatos.Items[ItemIndex].Data['prCodigo'].ToString;
       rtr := rt.Collection('CONTATOS').Key( codigo ).Get;

       if (rt.LoadItemsWithJson( rtr.toJson )) then
       begin
         FCodigo                := codigo;
         Edt_EmailCadastro.Text := rt.Items.getField('email');
         Edt_Nome.Text          := rt.Items.getField('nome');
         Edt_Telefone.Text      := rt.Items.getField('telefone');

         rtr := rt.Collection('ARQUIVOS/CONTATOS').Key( FCodigo ).Get;
         if (rt.LoadItemsWithJson(rtr.toJson)) then
           Foto.Fill.Bitmap.Bitmap := Base64ToBitmap( rt.Items.getFileField('FOTO_PERFIL') )
         else
           Foto.Fill.Bitmap.Bitmap := FotoDefault.Bitmap;

         TThread.Queue(nil, procedure
           begin
             Excluir.Visible        := true;
             Goto_TabCadastro.ExecuteTarget(Self);
           end);
       end
       else
       begin
         TThread.Queue(nil, procedure begin showMessage('Desculpe, nenhum contato encontrado com o código: '+ codigo); end);
         listarContatos;
       end;
     Finally
       {$IFDEF MSWINDOWS}
         FreeAndNil(rtr);
       {$ELSE}
         rtr.DisposeOf;
       {$ENDIF}
     end;
   end;
   mensagemAguarde := 'Buscando registro...';
   ThreadExecute(nil);
end;

procedure TFrm_Principal.NovoClick(Sender: TObject);
begin
  // Configura a tela de cadastro
  Foto.Fill.Bitmap.Bitmap := FotoDefault.Bitmap;
  Edt_EmailCadastro.Text  := '';
  Edt_Nome.Text           := '';
  Edt_Telefone.Text       := '';
  FCodigo                 := '-1';
  FCaminhoFoto            := '';

  Excluir.Visible         := false;
  Goto_TabCadastro.ExecuteTarget(Self);
end;

procedure TFrm_Principal.rtErrorOccurred(Sender: TComponent; Codigo: Integer; Erro: string);
begin
  TThread.Queue(nil, procedure
    begin
      showMessage('Firebase gerou uma mensagem: '+ Erro);
    end);
end;

procedure TFrm_Principal.ThreadExecute(onFinished : TNotifyEvent);
Var thr : TThread;
begin
  if not (assigned(Procedimento)) then
    exit;

  thr := TThread.CreateAnonymousThread(procedure
    begin
      thr.Queue(nil, procedure
        begin
          Aguarde_Mostrar( self.mensagemAguarde );
        end);

      if (assigned(procedimento)) then
        procedimento;

      thr.Queue(nil, procedure
        begin
          Aguarde_Esconder;
        end);
    end);
  thr.FreeOnTerminate := true;
  thr.OnTerminate     := onFinished;
  thr.Start;
end;

procedure TFrm_Principal.VoltarCadastroClick(Sender: TObject);
begin
  Goto_TabListagem.ExecuteTarget(Self);
  listarContatos;
end;

procedure TFrm_Principal.VoltarListagemClick(Sender: TObject);
begin
  Goto_TabAcesso.ExecuteTarget(Self);
end;

procedure TFrm_Principal.VoltarListagemMouseEnter(Sender: TObject);
begin
  if (Sender is TCircle) then
    TCircle(Sender).Opacity := 0.5;
end;

procedure TFrm_Principal.VoltarListagemMouseLeave(Sender: TObject);
begin
  if (Sender is TCircle) then
    TCircle(Sender).Opacity := 1;
end;

end.
