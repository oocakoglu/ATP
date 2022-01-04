object frmDovizKurlari: TfrmDovizKurlari
  Left = 0
  Top = 0
  Caption = 'D'#246'viz Kurlar'#305
  ClientHeight = 451
  ClientWidth = 663
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 416
    Width = 663
    Height = 35
    Align = alBottom
    TabOrder = 1
    object btnGuncelle: TButton
      Left = 8
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Guncelle'
      TabOrder = 0
    end
  end
  object grdDovizKurlari: TcxGrid
    Left = 0
    Top = 0
    Width = 663
    Height = 416
    Align = alClient
    TabOrder = 0
    ExplicitLeft = -152
    ExplicitTop = -6
    ExplicitWidth = 607
    ExplicitHeight = 374
    object grdTVDovizKurlariTV: TcxGridDBTableView
      NavigatorButtons.ConfirmDelete = False
      DataController.DataSource = dsDovizKurlari
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Styles.StyleSheet = DMATP.GriTema
      object grdclmTVDovizKurlariTVAktif: TcxGridDBColumn
        DataBinding.FieldName = 'Aktif'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Width = 52
      end
      object grdclmTVDovizKurlariTVDovizId: TcxGridDBColumn
        DataBinding.FieldName = 'DovizId'
        Visible = False
      end
      object grdclmTVDovizKurlariTVIsim: TcxGridDBColumn
        DataBinding.FieldName = 'Isim'
        Options.Editing = False
        Options.Filtering = False
        Options.FilteringFilteredItemsList = False
        Options.FilteringMRUItemsList = False
        Options.FilteringPopup = False
        Options.FilteringPopupMultiSelect = False
        Options.Focusing = False
        Options.GroupFooters = False
        Options.Grouping = False
        Width = 321
      end
      object grdclmTVDovizKurlariTVForexBuying: TcxGridDBColumn
        Caption = 'Al'#305#351
        DataBinding.FieldName = 'ForexBuying'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Options.Editing = False
        Options.Filtering = False
        Options.FilteringFilteredItemsList = False
        Options.FilteringMRUItemsList = False
        Options.FilteringPopup = False
        Options.FilteringPopupMultiSelect = False
        Options.Focusing = False
        Options.GroupFooters = False
        Options.Grouping = False
        Width = 68
      end
      object grdclmTVDovizKurlariTVForexSelling: TcxGridDBColumn
        Caption = 'Sat'#305#351
        DataBinding.FieldName = 'ForexSelling'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Options.Editing = False
        Options.Filtering = False
        Options.FilteringFilteredItemsList = False
        Options.FilteringMRUItemsList = False
        Options.FilteringPopup = False
        Options.FilteringPopupMultiSelect = False
        Options.Focusing = False
        Options.GroupFooters = False
        Options.Grouping = False
        Width = 68
      end
      object grdclmTVDovizKurlariTVBanknoteBuying: TcxGridDBColumn
        Caption = 'Banka Al'#305#351
        DataBinding.FieldName = 'BanknoteBuying'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Options.Editing = False
        Options.Filtering = False
        Options.FilteringFilteredItemsList = False
        Options.FilteringMRUItemsList = False
        Options.FilteringPopup = False
        Options.FilteringPopupMultiSelect = False
        Options.Focusing = False
        Options.GroupFooters = False
        Options.Grouping = False
        Width = 67
      end
      object grdclmTVDovizKurlariTVBanknoteSelling: TcxGridDBColumn
        Caption = 'Banka Sat'#305#351
        DataBinding.FieldName = 'BanknoteSelling'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Options.Editing = False
        Options.Filtering = False
        Options.FilteringFilteredItemsList = False
        Options.FilteringMRUItemsList = False
        Options.FilteringPopup = False
        Options.FilteringPopupMultiSelect = False
        Options.Focusing = False
        Options.GroupFooters = False
        Options.Grouping = False
        Width = 68
      end
      object grdclmTVDovizKurlariTVCrossRateEuro: TcxGridDBColumn
        DataBinding.FieldName = 'CrossRateEuro'
        Visible = False
      end
    end
    object grdDovizKurlariLV: TcxGridLevel
      GridView = grdTVDovizKurlariTV
    end
  end
  object qryDovizKurlari: TADOQuery
    Connection = DMATP.ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM DovizKurlari ORDER BY Aktif DESC, DovizId')
    Left = 88
    Top = 216
  end
  object dsDovizKurlari: TDataSource
    DataSet = qryDovizKurlari
    Left = 88
    Top = 272
  end
end
