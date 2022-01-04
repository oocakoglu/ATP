object DMATP: TDMATP
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 330
  Width = 682
  object ADOConnection: TADOConnection
    ConnectionString = 
      'Provider=SQLNCLI11.1;Integrated Security=SSPI;Persist Security I' +
      'nfo=False;User ID="";Initial Catalog=ATP;Data Source=.;Initial F' +
      'ile Name="";Server SPN=""'
    LoginPrompt = False
    Provider = 'SQLNCLI11.1'
    Left = 56
    Top = 32
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 152
    Top = 32
    PixelsPerInch = 120
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = TURKISH_CHARSET
      Font.Color = clDefault
      Font.Height = -11
      Font.Name = 'Calibri'
      Font.Style = []
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = 15658734
      Font.Charset = TURKISH_CHARSET
      Font.Color = clDefault
      Font.Height = -11
      Font.Name = 'Calibri'
      Font.Style = []
    end
    object cxStyle3: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = TURKISH_CHARSET
      Font.Color = clDefault
      Font.Height = -11
      Font.Name = 'Calibri'
      Font.Style = []
    end
    object cxStyle4: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 6908265
      Font.Charset = TURKISH_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      TextColor = clWhite
    end
    object cxStyle5: TcxStyle
      AssignedValues = [svColor]
      Color = clMaroon
    end
    object StyleAdet1: TcxStyle
      AssignedValues = [svColor]
      Color = 16574680
    end
    object StyleAdet2: TcxStyle
      AssignedValues = [svColor]
      Color = 9743605
    end
    object styleTutar1: TcxStyle
      AssignedValues = [svColor]
      Color = 10997163
    end
    object styleTutar2: TcxStyle
      AssignedValues = [svColor]
      Color = 8757491
    end
    object styleKurFiyat: TcxStyle
      AssignedValues = [svColor]
      Color = 13427150
    end
    object styleTLFiyat: TcxStyle
      AssignedValues = [svColor]
      Color = 13032904
    end
    object styleKarFiyat: TcxStyle
      AssignedValues = [svColor]
      Color = 12310461
    end
    object styleSatisFiyat: TcxStyle
      AssignedValues = [svColor]
      Color = 11653556
    end
    object cxStyle6: TcxStyle
      AssignedValues = [svColor]
      Color = 15451300
    end
    object cxStyle7: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 16247513
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TextColor = clBlack
    end
    object cxStyle8: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 16247513
      TextColor = clBlack
    end
    object cxStyle9: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 16247513
      TextColor = clBlack
    end
    object cxStyle10: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 14811135
      TextColor = clBlack
    end
    object cxStyle11: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 14811135
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = clNavy
    end
    object cxStyle12: TcxStyle
      AssignedValues = [svColor]
      Color = 14872561
    end
    object cxStyle13: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 4707838
      TextColor = clBlack
    end
    object cxStyle14: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 12937777
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = clWhite
    end
    object cxStyle15: TcxStyle
      AssignedValues = [svColor]
      Color = 15451300
    end
    object cxStyle16: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 4707838
      TextColor = clBlack
    end
    object cxStyle17: TcxStyle
      AssignedValues = [svColor]
      Color = 15451300
    end
    object cxStyle18: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 14811135
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = clNavy
    end
    object cxStyle19: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 12937777
      TextColor = clWhite
    end
    object GriTema: TcxGridTableViewStyleSheet
      Styles.Content = cxStyle1
      Styles.ContentEven = cxStyle2
      Styles.ContentOdd = cxStyle3
      Styles.Selection = cxStyle5
      Styles.Header = cxStyle4
      BuiltIn = True
    end
    object DevExpressTema: TcxGridTableViewStyleSheet
      Caption = 'DevExpress'
      Styles.Background = cxStyle6
      Styles.Content = cxStyle7
      Styles.ContentEven = cxStyle8
      Styles.ContentOdd = cxStyle9
      Styles.FilterBox = cxStyle10
      Styles.Inactive = cxStyle15
      Styles.IncSearch = cxStyle16
      Styles.Selection = cxStyle19
      Styles.Footer = cxStyle11
      Styles.Group = cxStyle12
      Styles.GroupByBox = cxStyle13
      Styles.Header = cxStyle14
      Styles.Indicator = cxStyle17
      Styles.Preview = cxStyle18
      BuiltIn = True
    end
  end
  object cxEditRepository1: TcxEditRepository
    Left = 56
    Top = 88
    object rpstyIller: TcxEditRepositoryLookupComboBoxItem
      Properties.KeyFieldNames = 'Ilkodu'
      Properties.ListColumns = <
        item
          Caption = 'Il Adi'
          FieldName = 'IlAdi'
        end>
      Properties.ListSource = dsIl
    end
    object rpstyFirmalar: TcxEditRepositoryLookupComboBoxItem
      Properties.KeyFieldNames = 'FirmaId'
      Properties.ListColumns = <
        item
          Caption = 'Firma Adi'
          Width = 150
          FieldName = 'FirmaAdi'
        end
        item
          Caption = 'Sekt'#246'r'
          Width = 100
          FieldName = 'FirmaSektor'
        end>
      Properties.ListSource = dsFirma
    end
    object rpstyYetkililer: TcxEditRepositoryLookupComboBoxItem
      Properties.KeyFieldNames = 'YetkiliId'
      Properties.ListColumns = <
        item
          Width = 200
          FieldName = 'Yetkili'
        end>
      Properties.ListSource = dsYetkili
    end
    object rpstyUnvanlar: TcxEditRepositoryLookupComboBoxItem
      Properties.KeyFieldNames = 'UnvanId'
      Properties.ListColumns = <
        item
          FieldName = 'UnvanAdi'
        end>
      Properties.ListSource = dsUnvanlar
    end
    object rpstyKurumlar: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownWidth = 350
      Properties.KeyFieldNames = 'KurumId'
      Properties.ListColumns = <
        item
          Width = 250
          FieldName = 'KurumAdi'
        end
        item
          Caption = 'Kurum Yetkilisi'
          Width = 100
          FieldName = 'KurumYetkilisi'
        end>
      Properties.ListSource = dsKurum
    end
    object rpstyKurlar: TcxEditRepositoryLookupComboBoxItem
      Properties.DropDownWidth = 174
      Properties.KeyFieldNames = 'DovizId'
      Properties.ListColumns = <
        item
          Width = 34
          FieldName = 'Kisaltma'
        end
        item
          Width = 140
          FieldName = 'Isim'
        end>
      Properties.ListSource = dsKurlar
    end
  end
  object conADOCon_Attach: TADOConnection
    ConnectionString = 
      'Provider=SQLNCLI.1;Password=111222333;Persist Security Info=True' +
      ';User ID=sa;Initial Catalog=master;Data Source=.\TUKETICI2013'
    LoginPrompt = False
    Provider = 'SQLNCLI.1'
    Left = 264
    Top = 32
  end
  object sflthm1: TsuiFileTheme
    Ready = False
    Left = 152
    Top = 88
  end
  object qryIl: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from Il')
    Left = 64
    Top = 168
  end
  object dsIl: TDataSource
    DataSet = qryIl
    Left = 64
    Top = 240
  end
  object qryFirma: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT FirmaId, FirmaAdi, FirmaSektor FROM Firma')
    Left = 136
    Top = 168
  end
  object dsFirma: TDataSource
    DataSet = qryFirma
    Left = 136
    Top = 240
  end
  object qryYetkili: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT YetkiliId, YetkiliAdi + '#39' '#39' + YetkiliSoyadi as Yetkili FR' +
        'OM Yetkili')
    Left = 208
    Top = 168
  end
  object dsYetkili: TDataSource
    DataSet = qryYetkili
    Left = 208
    Top = 240
  end
  object qryUnvanlar: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT UnvanId, UnvanAdi FROM Unvan')
    Left = 280
    Top = 168
  end
  object dsUnvanlar: TDataSource
    DataSet = qryUnvanlar
    Left = 280
    Top = 236
  end
  object qryKurum: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT KurumId, KurumAdi, KurumYetkilisi FROM Kurum')
    Left = 352
    Top = 168
  end
  object dsKurum: TDataSource
    DataSet = qryKurum
    Left = 352
    Top = 232
  end
  object XMLDocument1: TXMLDocument
    Left = 264
    Top = 88
    DOMVendorDesc = 'MSXML'
  end
  object qryKurlar: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT DovizId, Kisaltma, Isim FROM DovizKurlari WHERE Aktif = 1')
    Left = 424
    Top = 168
  end
  object dsKurlar: TDataSource
    DataSet = qryKurlar
    Left = 424
    Top = 232
  end
end
