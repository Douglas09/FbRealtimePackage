object Form2: TForm2
  Left = 0
  Top = 0
  ActiveControl = pgControle
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
  OnShow = FormShow
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
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 742
        Height = 418
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
      object pnInferior: TPanel
        Left = 0
        Top = 418
        Width = 742
        Height = 44
        Align = alBottom
        Color = clGray
        ParentBackground = False
        TabOrder = 1
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
    end
    object tbiCadastro: TTabSheet
      Caption = 'Cadastro'
      ImageIndex = 1
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
    object TabSheet1: TTabSheet
      Caption = 'teste'
      ImageIndex = 2
      object Label2: TLabel
        Left = 56
        Top = 91
        Width = 33
        Height = 13
        Caption = 'Coluna'
      end
      object Label3: TLabel
        Left = 56
        Top = 118
        Width = 24
        Height = 13
        Caption = 'Valor'
      end
      object memRes: TMemo
        Left = 0
        Top = 248
        Width = 742
        Height = 214
        Align = alBottom
        Lines.Strings = (
          'memRes')
        TabOrder = 2
      end
      object btnEqual: TButton
        Left = 25
        Top = 160
        Width = 75
        Height = 25
        Caption = 'EQUAL_TO'
        TabOrder = 3
        OnClick = btnEqualClick
      end
      object edtValor: TEdit
        Left = 105
        Top = 115
        Width = 121
        Height = 21
        TabOrder = 1
      end
      object edtColuna: TEdit
        Left = 105
        Top = 88
        Width = 121
        Height = 21
        TabOrder = 0
      end
      object btnStart: TButton
        Left = 101
        Top = 160
        Width = 75
        Height = 25
        Caption = 'START_AT'
        TabOrder = 4
        OnClick = btnStartClick
      end
      object btnEnd: TButton
        Left = 177
        Top = 160
        Width = 75
        Height = 25
        Caption = 'END_AT'
        TabOrder = 5
        OnClick = btnEndClick
      end
      object Button1: TButton
        Left = 401
        Top = 160
        Width = 121
        Height = 25
        Caption = 'SEND RECAPTCHA'
        TabOrder = 6
        OnClick = Button1Click
      end
      object Edit1: TEdit
        Left = 401
        Top = 133
        Width = 121
        Height = 21
        TabOrder = 7
        Text = '+5551995502636'
      end
    end
  end
  object ds: TDataSource
    DataSet = memContatos
    Left = 404
    Top = 72
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
    Left = 348
    Top = 80
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
  object rt: TFBRealTime
    CaseSensitive = False
    OnGetData.MemTable = memContatos
    onErrorOccurred = rtErrorOccurred
    Left = 284
    Top = 144
  end
end
