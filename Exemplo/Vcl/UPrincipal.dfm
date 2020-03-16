object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Exemplo Firebase Realtime'
  ClientHeight = 490
  ClientWidth = 750
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnPaint = FormPaint
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 88
    Top = 168
    Width = 265
    Height = 113
  end
  object pgControle: TPageControl
    Left = 0
    Top = 0
    Width = 750
    Height = 490
    ActivePage = tbiConsulta
    Align = alClient
    TabOrder = 0
    object tbiConsulta: TTabSheet
      Caption = 'Consulta'
      object pnInferior: TPanel
        Left = 0
        Top = 418
        Width = 742
        Height = 44
        Align = alBottom
        Color = clGray
        ParentBackground = False
        TabOrder = 0
        object btnExcluir: TButton
          AlignWithMargins = True
          Left = 216
          Top = 4
          Width = 96
          Height = 36
          Align = alLeft
          Caption = 'DELETAR'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = btnExcluirClick
        end
        object btnIncluir: TButton
          AlignWithMargins = True
          Left = 114
          Top = 4
          Width = 96
          Height = 36
          Align = alLeft
          Caption = 'INCLUIR'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = btnIncluirClick
        end
        object btnBackup: TButton
          AlignWithMargins = True
          Left = 642
          Top = 4
          Width = 96
          Height = 36
          Align = alRight
          Caption = 'FAZER BACKUP'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          OnClick = btnBackupClick
        end
        object btnLote: TButton
          AlignWithMargins = True
          Left = 540
          Top = 4
          Width = 96
          Height = 36
          Align = alRight
          Caption = 'INSERIR LOTE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          OnClick = btnLoteClick
        end
        object Panel3: TPanel
          AlignWithMargins = True
          Left = 2
          Top = 2
          Width = 108
          Height = 40
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alLeft
          Color = clWhite
          ParentBackground = False
          TabOrder = 4
          object Label1: TLabel
            Left = 1
            Top = 1
            Width = 106
            Height = 13
            Align = alTop
            Alignment = taCenter
            Caption = 'Tabelas'
            Layout = tlCenter
            ExplicitWidth = 37
          end
          object edtTabela: TEdit
            Left = 1
            Top = 14
            Width = 106
            Height = 25
            Align = alClient
            Alignment = taCenter
            CharCase = ecUpperCase
            Color = clGreen
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            Text = 'CONTATOS'
            OnExit = edtTabelaExit
            ExplicitHeight = 21
          end
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 742
        Height = 418
        Align = alClient
        TabOrder = 1
        object DBGrid1: TDBGrid
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 734
          Height = 368
          Align = alClient
          DataSource = ds
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDblClick = DBGrid1DblClick
          OnTitleClick = DBGrid1TitleClick
        end
        object Panel5: TPanel
          AlignWithMargins = True
          Left = 4
          Top = 378
          Width = 734
          Height = 36
          Align = alBottom
          BevelInner = bvSpace
          BevelKind = bkSoft
          TabOrder = 1
          object Label2: TLabel
            Left = 2
            Top = 2
            Width = 66
            Height = 28
            Align = alLeft
            Alignment = taRightJustify
            Caption = 'CONSULTAR'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
            ExplicitHeight = 13
          end
          object edtPesquisar: TEdit
            AlignWithMargins = True
            Left = 71
            Top = 5
            Width = 654
            Height = 22
            Align = alClient
            TabOrder = 0
            TextHint = 'fa'#231'a sua consulta...'
            OnChange = edtPesquisarChange
            ExplicitHeight = 21
          end
        end
      end
    end
    object tbiCadastro: TTabSheet
      Caption = 'Cadastro'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel2: TPanel
        Left = 0
        Top = 418
        Width = 742
        Height = 44
        Align = alBottom
        Color = clGray
        ParentBackground = False
        TabOrder = 0
        object btnCancelar: TButton
          AlignWithMargins = True
          Left = 642
          Top = 4
          Width = 96
          Height = 36
          Align = alRight
          Caption = 'CANCELAR'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = btnCancelarClick
        end
        object btnGravar: TButton
          AlignWithMargins = True
          Left = 540
          Top = 4
          Width = 96
          Height = 36
          Align = alRight
          Caption = 'SALVAR'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = btnGravarClick
        end
      end
      object pnFundo: TPanel
        Left = 115
        Top = 88
        Width = 521
        Height = 233
        BevelInner = bvSpace
        BevelKind = bkSoft
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        object StaticText1: TStaticText
          Left = 111
          Top = 52
          Width = 36
          Height = 17
          Caption = 'Nome'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object StaticText2: TStaticText
          Left = 114
          Top = 108
          Width = 34
          Height = 17
          Caption = 'Email'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
        end
        object StaticText3: TStaticText
          Left = 96
          Top = 164
          Width = 53
          Height = 17
          Caption = 'Telefone'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
        end
        object edtNome: TEdit
          Left = 172
          Top = 49
          Width = 249
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          TextHint = 'Informe um nome'
        end
        object edtEmail: TEdit
          Left = 172
          Top = 105
          Width = 249
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          TextHint = 'Informe um email'
        end
        object edtTelefone: TEdit
          Left = 172
          Top = 162
          Width = 249
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          TextHint = 'infome um telefone'
        end
      end
    end
  end
  object pnAutent: TPanel
    Left = 695
    Top = 46
    Width = 719
    Height = 394
    TabOrder = 1
    Visible = False
    object pnAutenticacao: TPanel
      Left = 178
      Top = 40
      Width = 397
      Height = 321
      Color = clGray
      ParentBackground = False
      TabOrder = 0
      object Panel4: TPanel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 389
        Height = 58
        Align = alTop
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object Label4: TLabel
          Left = 4
          Top = 4
          Width = 115
          Height = 13
          Caption = 'Autentica'#231#227'o de Acesso'
        end
        object btnLoginAnonimo: TButton
          Left = 4
          Top = 23
          Width = 93
          Height = 29
          Caption = 'An'#244'nima'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = btnLoginAnonimoClick
        end
        object btnLoginEmail: TButton
          Left = 99
          Top = 23
          Width = 93
          Height = 29
          Caption = 'Email e Senha'
          TabOrder = 1
          OnClick = btnLoginEmailClick
        end
        object btnLoginChaveSecreta: TButton
          Left = 194
          Top = 23
          Width = 93
          Height = 29
          Caption = 'Chave Secreta'
          TabOrder = 2
          OnClick = btnLoginChaveSecretaClick
        end
        object btnLoginSmartPhone: TButton
          Left = 289
          Top = 23
          Width = 93
          Height = 29
          Caption = 'SmartPhone'
          Enabled = False
          TabOrder = 3
        end
      end
      object pnAnonimo: TPanel
        Left = 1
        Top = 65
        Width = 395
        Height = 255
        Align = alClient
        Color = clSilver
        ParentBackground = False
        TabOrder = 1
        object Label5: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 387
          Height = 16
          Align = alTop
          Caption = 'Api Key'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 49
        end
        object memAnonimoApiKey: TMemo
          AlignWithMargins = True
          Left = 4
          Top = 26
          Width = 387
          Height = 184
          Align = alClient
          TabOrder = 0
        end
        object Button2: TButton
          AlignWithMargins = True
          Left = 4
          Top = 216
          Width = 387
          Height = 35
          Align = alBottom
          Caption = 'Autentica'#231#227'o An'#244'nima'
          TabOrder = 1
          OnClick = Button2Click
        end
      end
      object pnChaveSecreta: TPanel
        Left = 1
        Top = 65
        Width = 395
        Height = 255
        Align = alClient
        Color = clSilver
        ParentBackground = False
        TabOrder = 3
        Visible = False
        object Label9: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 387
          Height = 16
          Align = alTop
          Caption = 'Token'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 38
        end
        object memSecreto: TMemo
          AlignWithMargins = True
          Left = 4
          Top = 26
          Width = 387
          Height = 184
          Align = alClient
          TabOrder = 0
        end
        object Button6: TButton
          AlignWithMargins = True
          Left = 4
          Top = 216
          Width = 387
          Height = 35
          Align = alBottom
          Caption = 'Autenticar'
          TabOrder = 1
          OnClick = Button6Click
        end
      end
      object pnEmailSenha: TPanel
        Left = 1
        Top = 65
        Width = 395
        Height = 255
        Align = alClient
        Color = clSilver
        ParentBackground = False
        TabOrder = 2
        Visible = False
        DesignSize = (
          395
          255)
        object Label6: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 387
          Height = 16
          Align = alTop
          Caption = 'Api Key'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 49
        end
        object Label7: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 82
          Width = 387
          Height = 16
          Align = alTop
          Caption = 'Email'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 32
        end
        object Label8: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 128
          Width = 387
          Height = 16
          Align = alTop
          Caption = 'Senha'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 40
        end
        object memEmailSenhaApiKey: TMemo
          AlignWithMargins = True
          Left = 4
          Top = 26
          Width = 387
          Height = 50
          Align = alTop
          TabOrder = 0
        end
        object Button3: TButton
          AlignWithMargins = True
          Left = 4
          Top = 216
          Width = 110
          Height = 35
          Caption = 'Resetar Senha'
          TabOrder = 1
          OnClick = Button3Click
        end
        object edtEmailSenhaEmail: TEdit
          AlignWithMargins = True
          Left = 4
          Top = 101
          Width = 387
          Height = 21
          Margins.Top = 0
          Align = alTop
          TabOrder = 2
          TextHint = 'Informe seu e-mail aqui'
        end
        object edtEmailSenhaSenha: TEdit
          AlignWithMargins = True
          Left = 4
          Top = 147
          Width = 387
          Height = 21
          Margins.Top = 0
          Align = alTop
          TabOrder = 3
          TextHint = '**********'
        end
        object Button4: TButton
          AlignWithMargins = True
          Left = 120
          Top = 216
          Width = 154
          Height = 35
          Anchors = [akLeft, akRight, akBottom]
          Caption = 'Logar e Continuar'
          TabOrder = 4
          OnClick = Button4Click
        end
        object Button5: TButton
          AlignWithMargins = True
          Left = 280
          Top = 216
          Width = 110
          Height = 35
          Anchors = [akTop, akRight]
          Caption = 'Cadastrar Email'
          TabOrder = 5
          OnClick = Button5Click
        end
      end
    end
  end
  object ds: TDataSource
    DataSet = memContatos
    Left = 188
    Top = 40
  end
  object memContatos: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 132
    Top = 40
    object memContatosCODIGO: TIntegerField
      DisplayWidth = 10
      FieldName = 'CODIGO'
    end
    object memContatosNOME: TStringField
      DisplayWidth = 38
      FieldName = 'NOME'
      Size = 110
    end
    object memContatosEMAIL: TStringField
      DisplayWidth = 26
      FieldName = 'EMAIL'
      Size = 50
    end
    object memContatosTELEFONE: TStringField
      DisplayWidth = 14
      FieldName = 'TELEFONE'
      Size = 50
    end
    object memContatosDATA_CADASTRO: TStringField
      DisplayWidth = 19
      FieldName = 'DATA_CADASTRO'
      Size = 30
    end
  end
end
