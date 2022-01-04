unit untTeklifDetay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, SUIForm, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxLabel, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Menus,
  cxCalendar, StdCtrls, cxButtons, cxPC, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxGroupBox,
  Buttons, cxImageComboBox, ADODB, DBClient, cxCheckBox, cxCurrencyEdit, ExtDlgs,
  cxMemo, cxSplitter, DBCtrls, cxRadioGroup;

type
  TfrmTeklifDetay = class(TForm)
    pnl2: TPanel;
    qryFirmaYetkili: TADOQuery;
    dsFirmaYetkili: TDataSource;
    suiForm1: TsuiForm;
    pnl1: TPanel;
    grp1: TcxGroupBox;
    btn1: TSpeedButton;
    cxlbl6: TcxLabel;
    txtIsinAdi: TcxTextEdit;
    cxlbl7: TcxLabel;
    lkpKurumAdi: TcxLookupComboBox;
    cxlbl12: TcxLabel;
    cxlbl13: TcxLabel;
    cbimgIhaleUsulu: TcxImageComboBox;
    cbimgTeklifMektubu: TcxImageComboBox;
    grp2: TcxGroupBox;
    lkpTeklifFirma: TcxLookupComboBox;
    cxlbl1: TcxLabel;
    cxlbl2: TcxLabel;
    lkpYetkili1: TcxLookupComboBox;
    cxlbl3: TcxLabel;
    lkpYetkili2: TcxLookupComboBox;
    cxlblUnvan1: TcxLabel;
    cxlblUnvan2: TcxLabel;
    grp3: TcxGroupBox;
    cxlbl8: TcxLabel;
    cxlbl9: TcxLabel;
    cxlbl10: TcxLabel;
    cxlbl11: TcxLabel;
    dteIhaleTarihi: TcxDateEdit;
    txtIhaleKayitNo: TcxTextEdit;
    txtOpsiyonSuresi: TcxTextEdit;
    txtTeslimSuresi: TcxTextEdit;
    cxlbl4: TcxLabel;
    cxlbl5: TcxLabel;
    txtSevkiyatEmirNo: TcxTextEdit;
    txtProformaNo: TcxTextEdit;
    pageTeklifDetay: TcxPageControl;
    tsMalKalemleri: TcxTabSheet;
    pnl3: TPanel;
    btnMalKalemiEkle: TcxButton;
    btnMalKalemiSil: TcxButton;
    btnMalKalemiDosyadanGetir: TcxButton;
    grdMalKalem: TcxGrid;
    grdMalKalemTV: TcxGridDBTableView;
    grdMalKalemLV: TcxGridLevel;
    tsMaliyetTablosu: TcxTabSheet;
    grdMaliyetAna: TcxGrid;
    grdMaliyetAnaTV: TcxGridDBTableView;
    grdMaliyetAnaLV: TcxGridLevel;
    btnKaydet: TcxButton;
    tsTanimEkstra: TcxTabSheet;
    cdsEktralar: TClientDataSet;
    dsEktralar: TDataSource;
    cxGroupBox1: TcxGroupBox;
    grdEktralarTV: TcxGridDBTableView;
    grdEktralarLV: TcxGridLevel;
    grdEktralar: TcxGrid;
    cxGroupBox2: TcxGroupBox;
    cxGroupBox3: TcxGroupBox;
    cdsEktralarExtraAdi: TStringField;
    cdsEktralarExtraTutar: TFloatField;
    grdEktralarTVExtraId: TcxGridDBColumn;
    grdEktralarTVTeklifId: TcxGridDBColumn;
    grdEktralarTVExtraAdi: TcxGridDBColumn;
    grdEktralarTVExtraTutar: TcxGridDBColumn;
    cdsEktralarKurId: TIntegerField;
    grdEktralarTVKurId: TcxGridDBColumn;
    cxLabel1: TcxLabel;
    lkpIhaleKur: TcxLookupComboBox;
    cdsHedefKur: TClientDataSet;
    dsHedefKur: TDataSource;
    cdsHedefKurKurId: TIntegerField;
    cdsHedefKurGuncelKur: TFloatField;
    cdsHedefKurHedefKur: TFloatField;
    grdHedefKur: TcxGrid;
    grdHedefKurTV: TcxGridDBTableView;
    grdHedefKurLV: TcxGridLevel;
    grdHedefKurTVKurId: TcxGridDBColumn;
    grdHedefKurTVGuncelKur: TcxGridDBColumn;
    grdHedefKurTVHedefKur: TcxGridDBColumn;
    cdsOnDegerler: TClientDataSet;
    dsOnDegerler: TDataSource;
    cdsOnDegerlerDegerAdi: TStringField;
    cdsOnDegerlerDegerOran: TFloatField;
    grdOnDegerler: TcxGrid;
    grdOnDegerlerTV: TcxGridDBTableView;
    grdOnDegerlerLV: TcxGridLevel;
    grdOnDegerlerTVId: TcxGridDBColumn;
    grdOnDegerlerTVDegerAdi: TcxGridDBColumn;
    grdOnDegerlerTVDegerTutar: TcxGridDBColumn;
    btnOnDegerlereDon: TButton;
    rdExtraKarlilikDahil: TcxRadioButton;
    rdExtraKarlilikHaric: TcxRadioButton;
    cxRadioGroup1: TcxRadioGroup;
    cxLabel2: TcxLabel;
    txtKarOrani: TcxCurrencyEdit;
    grdMalKalemTVKalemAdi: TcxGridDBColumn;
    grdMalKalemTVKalemBirimi: TcxGridDBColumn;
    grdMalKalemTVListeFiyati: TcxGridDBColumn;
    grdMalKalemTVIndirimOrani: TcxGridDBColumn;
    grdMalKalemTVKalemMiktar: TcxGridDBColumn;
    grdMalKalemTVBirimMaliyetKur: TcxGridDBColumn;
    grdMalKalemTVToplamMaliyeKur: TcxGridDBColumn;
    grdMalKalemTVKurId: TcxGridDBColumn;
    grdMalKalemTVBirimMaliyetTL: TcxGridDBColumn;
    grdMalKalemTVToplamMaliyetTL: TcxGridDBColumn;
    grdMalKalemTVExtraDahil: TcxGridDBColumn;
    cxSplitter1: TcxSplitter;
    grdMaliyetDetay: TcxGrid;
    grdMaliyetDetayTV: TcxGridDBTableView;
    grdMaliyetDetayLV: TcxGridLevel;
    grdMaliyetDetayTVAltKalemAdi: TcxGridDBColumn;
    grdMaliyetDetayTVAltKalemBirimi: TcxGridDBColumn;
    grdMaliyetDetayTVAltKalemMiktar: TcxGridDBColumn;
    grdMaliyetDetayTVAltKalemBirimMaliyetKur: TcxGridDBColumn;
    grdMaliyetDetayTVAltKalemToplamMaliyetKur: TcxGridDBColumn;
    grdMaliyetDetayTVAltKalemKurId: TcxGridDBColumn;
    grdMaliyetDetayTVAltKalemBirimMaliyetTL: TcxGridDBColumn;
    grdMaliyetDetayTVAltKalemToplamMaliyetTL: TcxGridDBColumn;
    btnAltKalem: TcxButton;
    pnlAltKalem: TPanel;
    btnMalDetayEkle: TcxButton;
    btnMalDetaySil: TcxButton;
    qryTempTeklifMalKalem: TADOQuery;
    dsTempTeklifMalKalem: TDataSource;
    grdMaliyetAnaTVId: TcxGridDBColumn;
    grdMaliyetAnaTVTempTeklifId: TcxGridDBColumn;
    grdMaliyetAnaTVKalemAdi: TcxGridDBColumn;
    grdMaliyetAnaTVBirimi: TcxGridDBColumn;
    grdMaliyetAnaTVMiktar: TcxGridDBColumn;
    grdMaliyetAnaTVListeFiyati: TcxGridDBColumn;
    grdMaliyetAnaTVIndirimOrani: TcxGridDBColumn;
    grdMaliyetAnaTVBirimMaliyetdoKur: TcxGridDBColumn;
    grdMaliyetAnaTVToplamMaliyetdoKur: TcxGridDBColumn;
    grdMaliyetAnaTVDoKurId: TcxGridDBColumn;
    grdMaliyetAnaTVDoKurTutar: TcxGridDBColumn;
    grdMaliyetAnaTVToKurId: TcxGridDBColumn;
    grdMaliyetAnaTVToKurTutar: TcxGridDBColumn;
    grdMaliyetAnaTVBirimMaliyettoKur: TcxGridDBColumn;
    grdMaliyetAnaTVToplamMaliyettoKur: TcxGridDBColumn;
    grdMaliyetAnaTVAltMaliyetToplamtoKur: TcxGridDBColumn;
    grdMaliyetAnaTVExtraHaricSonToplam: TcxGridDBColumn;
    grdMaliyetAnaTVExtraTutar: TcxGridDBColumn;
    grdMaliyetAnaTVExtraDurum: TcxGridDBColumn;
    grdMaliyetAnaTVExtraAgirligi: TcxGridDBColumn;
    grdMaliyetAnaTVExtraDahilSonToplam: TcxGridDBColumn;
    grdMaliyetAnaTVExtraDahilSonBirim: TcxGridDBColumn;
    grdMaliyetAnaTVExtraKarlilikDurum: TcxGridDBColumn;
    grdMaliyetAnaTVKarOrani: TcxGridDBColumn;
    grdMaliyetAnaTVBirimSatisFiyat: TcxGridDBColumn;
    grdMaliyetAnaTVToplamSatisFiyat: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure lkpFirmaPropertiesEditValueChanged(Sender: TObject);
    procedure lkpYetkili1PropertiesEditValueChanged(Sender: TObject);
    procedure btnMalKalemiSilClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnMalDetayEkleClick(Sender: TObject);
    procedure btnMalDetaySilClick(Sender: TObject);
    procedure pageTeklifDetayChange(Sender: TObject);
    procedure dsMalKalemleriDataChange(Sender: TObject; Field: TField);
    procedure btn1Click(Sender: TObject);
    procedure btnOnDegerlereDonClick(Sender: TObject);
    procedure cdsMalKalemKarOraniChange(Sender: TField);
    procedure pageTeklifDetayPageChanging(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
    procedure txtKarOraniPropertiesEditValueChanged(Sender: TObject);
    procedure btnMalKalemiEkleClick(Sender: TObject);
    procedure btnAltKalemClick(Sender: TObject);
    procedure qryTempTeklifMalKalemAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
    AktifTeklifId : Integer;
    function  GetYetkiliUnvan(FirmaYetkiliId : Integer): string;
    function  KurHesabiYap(MevcutKurId : Integer; HedefKurId : Integer; Tutar : Double):Double;
    procedure MaliyetHesap();
  public
    { Public declarations }
    procedure GetTeklifBilgileri(TeklifId : Integer);
    procedure TeklifDetaySil(TeklifId : Integer);
    procedure YeniTeklifOlustur();
  end;

var
  frmTeklifDetay: TfrmTeklifDetay;

implementation

uses DM, untKurumDetay;

{$R *.dfm}





{$REGION 'Form Events'}
procedure TfrmTeklifDetay.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmTeklifDetay.FormCreate(Sender: TObject);
begin
  AktifTeklifId := 0;
end;

procedure TfrmTeklifDetay.FormShow(Sender: TObject);
begin
  //** Firma
  DMATP.qryFirma.Close;
  DMATP.qryFirma.Open;

  //** Kurumlar
  DMATP.qryKurum.Close;
  DMATP.qryKurum.Open;

  cxlblUnvan1.Caption := '';
  cxlblUnvan2.Caption := '';

  cdsEktralar.CreateDataSet;
  cdsEktralar.Open;

  cdsHedefKur.CreateDataSet;
  cdsHedefKur.Open;

  cdsOnDegerler.CreateDataSet;
  cdsOnDegerler.Open;
end;

procedure TfrmTeklifDetay.dsMalKalemleriDataChange(Sender: TObject; Field: TField);
begin


end;

{$ENDREGION}

{$REGION 'Künye Bilgisi'}

function TfrmTeklifDetay.GetYetkiliUnvan(FirmaYetkiliId : Integer): string;
var
  qryTemp : TADOQuery;
  Sonuc   : string;
begin

  Sonuc := '';
  qryTemp:= DMATP.CreateQuery();
  qryTemp.Close;
  qryTemp.SQL.Text := 'SELECT UnvanAdi FROM  FirmaYetkili FY '
                    + 'INNER JOIN Unvan U ON FY.UnvanId = U.UnvanId '
                    + 'WHERE FY.FirmaYetkiliId = ' + IntToStr(FirmaYetkiliId);
  qryTemp.Open;

  if qryTemp.RecordCount > 0 then
  begin
    Sonuc := qryTemp.FieldByName('UnvanAdi').AsString;
  end;
  Result := Sonuc;
end;

procedure TfrmTeklifDetay.lkpFirmaPropertiesEditValueChanged(Sender: TObject);
begin

  if lkpTeklifFirma.EditValue <> null then
  begin
    qryFirmaYetkili.Close;
    qryFirmaYetkili.SQL.Text := 'SELECT FY.FirmaYetkiliId, Y.YetkiliAdi + '' '' + Y.YetkiliSoyadi as Yetkili, '
                               +'U.UnvanAdi FROM FirmaYetkili FY '
                               +'INNER JOIN Yetkili Y ON FY.YetkiliId = Y.YetkiliId  '
                               +'INNER JOIN Unvan U ON FY.UnvanId = U.UnvanId  '
                               +'WHERE FY.FirmaId = ' + IntToStr(lkpTeklifFirma.EditValue);
    qryFirmaYetkili.Open;
  end;


end;

procedure TfrmTeklifDetay.lkpYetkili1PropertiesEditValueChanged( Sender: TObject);
begin

  if (Sender as TcxLookupComboBox).Name = lkpYetkili1.Name then
  begin
    if lkpYetkili1.Text <> '' then
      cxlblUnvan1.Caption := GetYetkiliUnvan(lkpYetkili1.EditValue)
    else
      cxlblUnvan1.Caption := '';
  end
  else
  begin
    if lkpYetkili2.Text <> '' then
      cxlblUnvan2.Caption := GetYetkiliUnvan(lkpYetkili2.EditValue)
    else
      cxlblUnvan2.Caption := '';
  end;

end;

{$ENDREGION}

{$REGION 'Mal Kalemleri'}
procedure TfrmTeklifDetay.btnMalKalemiEkleClick(Sender: TObject);
begin
  qryTempTeklifMalKalem.Append;
  qryTempTeklifMalKalem.FieldByName('DoKurId').AsInteger    := 1;
  qryTempTeklifMalKalem.FieldByName('DoKurTutar').AsInteger := 1;
  qryTempTeklifMalKalem.FieldByName('ToKurId').AsInteger    := 1;
  qryTempTeklifMalKalem.FieldByName('ToKurTutar').AsInteger := 1;

  qryTempTeklifMalKalem.FieldByName('KarOrani').AsFloat     := 20;
  qryTempTeklifMalKalem.FieldByName('ExtraDurum').AsBoolean := True;
  qryTempTeklifMalKalem.Post;
end;

procedure TfrmTeklifDetay.btnMalKalemiSilClick(Sender: TObject);
begin
//  if cdsMalKalemAna.RecordCount > 0 then
//  begin
//      if Dialogs.MessageDlg('Mal Kalemini Silmek Ýstediðinize Emin misiz?',
//        mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
//      begin
//        cdsMalKalemAna.Delete;
//      end;
//  end
//  else
//   ShowMessage('Listede Silmek için Kayýt Bulunamadý');

end;

procedure TfrmTeklifDetay.btnOnDegerlereDonClick(Sender: TObject);
var
  qryTemp : TADOQuery;
begin
  cdsOnDegerler.EmptyDataSet;
  qryTemp := DMATP.CreateQuery;

  //** On Degerler
  qryTemp.Close;
  qryTemp.SQL.Text := 'select * from Sabitler Where SabitTuru = ' + QuotedStr('OnDegerler');
  qryTemp.Open;

  cdsOnDegerler.Open;
  qryTemp.First;
  while not (qryTemp.Eof) do
  begin
    cdsOnDegerler.Append;
    cdsOnDegerlerDegerAdi.AsString  := qryTemp.FieldByName('SabitAdi').AsString;
    cdsOnDegerlerDegerOran.AsFloat  := qryTemp.FieldByName('SabitDeger').AsFloat;
    cdsOnDegerler.Post;

    qryTemp.Next;
  end;

  qryTemp.Destroy;
end;

{$REGION 'Detay'}
procedure TfrmTeklifDetay.btnMalDetayEkleClick(Sender: TObject);
begin

//  if cdsMalKalemleri.RecordCount > 0 then
//  begin
//    cdsMalKalemDetay.Append;
//    cdsMalKalemDetayKalemId.AsInteger := cdsMalKalemleriKalemId.AsInteger;
//  end
//  else
//    ShowMessage('Önce Mal Kalemi Eklmelisiniz');

end;

procedure TfrmTeklifDetay.btnMalDetaySilClick(Sender: TObject);
begin

//  if cdsMalKalemDetay.RecordCount > 0 then
//  begin
//      if Dialogs.MessageDlg('Mal Kalem Detayýný Silmek Ýstediðinize Emin misiz?',
//        mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
//      begin
//        cdsMalKalemDetay.Delete;
//      end;
//  end
//  else
//   ShowMessage('Listede Silmek için Kayýt Bulunamadý');

end;

{$ENDREGION}


{$ENDREGION}

{$REGION 'Maliyet Hesap'}
procedure TfrmTeklifDetay.pageTeklifDetayChange(Sender: TObject);
begin
  if pageTeklifDetay.ActivePage = tsMaliyetTablosu then
  begin
     MaliyetHesap();
  end;
end;

procedure TfrmTeklifDetay.pageTeklifDetayPageChanging(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
begin

  if NewPage = tsMaliyetTablosu then
  begin
      // if cdsMalKalem.RecordCount = 0 then
      // begin
      //   ShowMessage('Lütfen Öncelikle Mal Kalemlerini Giriniz');
      //   AllowChange := False;
      // end
      // else if txtKarOrani.Text = '' then
      // begin
      //   ShowMessage('Lütfen Öncelikle Kar Oranýný Giriniz');
      //   AllowChange := False;
      // end;
      // pageTeklifDetay.SetFocus;
  end;

end;

procedure TfrmTeklifDetay.qryTempTeklifMalKalemAfterPost(DataSet: TDataSet);
begin
 try
   qryTempTeklifMalKalem.Refresh;
 except
 end;

end;

procedure TfrmTeklifDetay.MaliyetHesap();
var
 MaliyetToplami : double;
 ExtraToplami   : double;
 KalemExtra     : double;
 //BrutKarOran    : double;
begin
//
//   if cdsEktralar.State in [dsInsert, dsEdit] then
//     cdsEktralar.Post;
//
//   if cdsOnDegerler.State in [dsInsert, dsEdit] then
//     cdsOnDegerler.Post;
//
//   //**Maliyet Toplam Agýrlýk Bulunuyor
//   MaliyetToplami := 0;
//   cdsMalKalem.First;
//   while not cdsMalKalem.Eof do
//   begin
//     if cdsMalKalemExtraDahil.AsInteger = 1 then
//     begin
//        MaliyetToplami := MaliyetToplami + cdsMalKalemToplamMaliyet.AsFloat;
//     end;
//     cdsMalKalem.Next;
//   end;
//
//   //**Ektra Alýnýyor
//   ExtraToplami      := grdEktralarTV.DataController.Summary.FooterSummaryValues[0];
//
//
//   cdsMalKalem.First;
//   while not cdsMalKalem.Eof do
//   begin
//     KalemExtra := 0;
//     if cdsMalKalemExtraDahil.AsInteger = 1 then
//     begin
//        KalemExtra := (cdsMalKalemToplamMaliyet.AsFloat / MaliyetToplami) * ExtraToplami;
//     end;
//
//     cdsMalKalem.Edit;
//     cdsMalKalemExtraPayi.AsFloat := KalemExtra;
//     cdsMalKalemKarOrani.AsFloat  := txtKarOrani.EditValue;
//
//     //Zaten Post Edilmiþ(Kontrol)
//     if cdsMalKalem.State in [dsEdit, dsInsert] then
//       cdsMalKalem.Post;
//
//     cdsMalKalem.Next;
//   end;
end;

function  TfrmTeklifDetay.KurHesabiYap(MevcutKurId : Integer; HedefKurId : Integer; Tutar : Double):Double;
begin
  cdsHedefKur.Filter   := 'KurId=' + IntToStr(MevcutKurId);
  cdsHedefKur.Filtered := True;
  Tutar := (Tutar / cdsHedefKurHedefKur.AsFloat);

  cdsHedefKur.Filter   := 'KurId=' + IntToStr(HedefKurId);
  cdsHedefKur.Filtered := True;
  Tutar := (Tutar * cdsHedefKurHedefKur.AsFloat);

  cdsHedefKur.Filtered := False;
  Result := Tutar;
end;

procedure TfrmTeklifDetay.cdsMalKalemKarOraniChange(Sender: TField);
begin


end;

{$ENDREGION}



{$REGION 'Alt Kalem'}
procedure TfrmTeklifDetay.btnAltKalemClick(Sender: TObject);
begin

  if pnlAltKalem.Visible = true then
  begin
    pnlAltKalem.Visible     := False;
    cxSplitter1.Visible     := False;
    btnAltKalem.Caption     := 'Alt Kalem Göster';
  end
  else
  begin
    pnlAltKalem.Visible     := True;
    cxSplitter1.Visible     := True;
    btnAltKalem.Caption     := 'Alt Kalem Gizle';
  end;




end;

{$ENDREGION}



{$REGION 'DataBase Islemleri'}
procedure TfrmTeklifDetay.btn1Click(Sender: TObject);
begin
   frmKurumDetay := TfrmKurumDetay.Create(nil);
   frmKurumDetay.KurumGetir(lkpKurumAdi.EditValue);
   frmKurumDetay.ShowModal;

end;

procedure TfrmTeklifDetay.btnKaydetClick(Sender: TObject);
var
  qryTemp      : TADOQuery;
  qryTempDetay : TADOQuery;
  KalemId      : Integer;
begin

  qryTemp      := DMATP.CreateQuery;
  qryTempDetay := DMATP.CreateQuery;


  //** Teklif Ana Bilgiler
  qryTemp.Close;
  qryTemp.SQL.Text := 'select * from Teklif Where TeklifId = ' + IntToStr(AktifTeklifId);
  qryTemp.Open;

  if qryTemp.RecordCount > 0 then
  begin
    qryTemp.Edit;
    TeklifDetaySil(AktifTeklifId);
  end
  else
    qryTemp.Append;

  qryTemp.FieldByName('IsinAdi').AsString             := txtIsinAdi.Text;
  qryTemp.FieldByName('KurumAdi').AsString            := lkpKurumAdi.Text;
  qryTemp.FieldByName('KurumId').AsString             := lkpKurumAdi.EditValue;
  qryTemp.FieldByName('IhaleUsuluId').AsInteger       := cbimgIhaleUsulu.EditValue;
  qryTemp.FieldByName('TeklifMektubuId').AsInteger    := cbimgTeklifMektubu.EditValue;
  qryTemp.FieldByName('IhaleTarihi').AsDateTime       := dteIhaleTarihi.Date;
  qryTemp.FieldByName('IhaleKayitNo').AsString        := txtIhaleKayitNo.Text;
  qryTemp.FieldByName('OpsiyonSuresi').AsInteger      := StrToInt(txtOpsiyonSuresi.Text);
  qryTemp.FieldByName('TeslimSuresi').AsInteger       := StrToInt(txtTeslimSuresi.Text);
  qryTemp.FieldByName('SevkiyatEmriNo').AsString      := txtSevkiyatEmirNo.Text;
  qryTemp.FieldByName('ProformaNo').AsString          := txtProformaNo.Text;
  qryTemp.FieldByName('TeklifVerenFirmaId').AsInteger := lkpTeklifFirma.EditValue;
  qryTemp.FieldByName('IhaleYetkilisiId').AsInteger   := lkpYetkili1.EditValue;
  qryTemp.FieldByName('IhaleYetkilisi2').AsInteger    := lkpYetkili2.EditValue;
  qryTemp.FieldByName('TeklifKurId').AsInteger        := lkpIhaleKur.EditValue;
  qryTemp.FieldByName('BrutKarOrani').AsFloat         := txtKarOrani.EditValue;
  qryTemp.Post;
  AktifTeklifId := qryTemp.FieldByName('TeklifId').AsInteger;


  //** Extralar
  qryTemp.Close;
  qryTemp.SQL.Text := 'select * from TeklifExtra Where 2 = 1';
  qryTemp.Open;

  cdsEktralar.First;
  while not cdsEktralar.Eof do
  begin
    qryTemp.Append;
    qryTemp.FieldByName('TeklifId').AsInteger  := AktifTeklifId;
    qryTemp.FieldByName('ExtraAdi').AsString   := cdsEktralarExtraAdi.AsString;
    qryTemp.FieldByName('ExtraTutar').AsFloat  := cdsEktralarExtraTutar.AsFloat;
    qryTemp.FieldByName('KurId').AsInteger     := cdsEktralarKurId.AsInteger;
    qryTemp.Post;

    cdsEktralar.Next;
  end;


  //**Teklif Kur
  qryTemp.Close;
  qryTemp.SQL.Text := 'select * from TeklifKur Where 2 = 1';
  qryTemp.Open;

  cdsHedefKur.First;
  while not cdsHedefKur.Eof do
  begin
    qryTemp.Append;
    qryTemp.FieldByName('TeklifId').AsInteger := AktifTeklifId;
    qryTemp.FieldByName('KurId').AsInteger    := cdsHedefKurKurId.AsInteger;
    qryTemp.FieldByName('GuncelKur').AsFloat  := cdsHedefKurGuncelKur.AsFloat;
    qryTemp.FieldByName('HedefKur').AsFloat   := cdsHedefKurHedefKur.AsFloat;
    qryTemp.Post;

    cdsHedefKur.Next;
  end;


  //**On Degerler
  qryTemp.Close;
  qryTemp.SQL.Text := 'select * from TeklifOnDeger Where 2 = 1';
  qryTemp.Open;

  cdsOnDegerler.First;
  while not cdsOnDegerler.Eof do
  begin
    qryTemp.Append;
    qryTemp.FieldByName('TeklifId').AsInteger    := AktifTeklifId;
    qryTemp.FieldByName('OnDegerAdi').AsString   := cdsOnDegerlerDegerAdi.AsString;
    qryTemp.FieldByName('OnDegerOran').AsFloat   := cdsOnDegerlerDegerOran.AsFloat;
    qryTemp.Post;

    cdsOnDegerler.Next;
  end;




  //**Mal Kalemleri

//  qryTemp.Close;
//  qryTemp.SQL.Text := 'select * from TeklifMalKalem Where 2 = 1';
//  qryTemp.Open;
//
//  cdsMalKalem.First;
//  while not (cdsMalKalem.Eof) do
//  begin
//    qryTemp.Append;
//    qryTemp.FieldByName('TeklifId').AsInteger   := AktifTeklifId;
//    qryTemp.FieldByName('KalemAdi').AsString    :=  cdsMalKalemKalemAdi.AsString;
//    qryTemp.FieldByName('Birimi').AsString      := cdsMalKalemBirimi.AsString;
//    qryTemp.FieldByName('Miktar').AsFloat       :=  cdsMalKalemMiktar.AsFloat;
//    qryTemp.FieldByName('ListeFiyati').AsFloat  := cdsMalKalemListeFiyati.AsFloat;
//    qryTemp.FieldByName('IndirimOrani').AsFloat :=cdsMalKalemIndirimOrani.AsFloat;
//    qryTemp.FieldByName('ExtraDahil').AsInteger := cdsMalKalemExtraDahil.AsInteger;
//    qryTemp.FieldByName('BirimMaliyet').AsFloat := cdsMalKalemBirimMaliyet.AsFloat;
//    qryTemp.FieldByName('ToplamMaliyet').AsFloat := cdsMalKalemToplamMaliyet.AsFloat;
//    qryTemp.FieldByName('ExtraPayi').AsFloat    := cdsMalKalemExtraPayi.AsFloat;
//    qryTemp.FieldByName('DovizId').AsInteger    := cdsMalKalemDovizId.AsInteger;
//    qryTemp.FieldByName('BirimMaliyetGorunen').AsFloat  := cdsMalKalemBirimMaliyetGorunen.AsFloat;
//    qryTemp.FieldByName('ToplamMaliyetGorunen').AsFloat := cdsMalKalemToplamMaliyetGorunen.AsFloat;
//    qryTemp.FieldByName('BirimMaliyetKur').AsFloat      := cdsMalKalemBirimMaliyetKur.AsFloat;
//    qryTemp.FieldByName('ToplamMaliyetKur').AsFloat     := cdsMalKalemToplamMaliyetKur.AsFloat;
//    qryTemp.FieldByName('KarOrani').AsFloat             := cdsMalKalemKarOrani.AsFloat;
//    qryTemp.FieldByName('BirimSatisFiyat').AsFloat      := cdsMalKalemBirimSatisFiyat.AsFloat;
//    qryTemp.FieldByName('ToplamSatisFiyat').AsFloat     := cdsMalKalemToplamSatisFiyat.AsFloat;
//    qryTemp.Post;
//
//    cdsMalKalem.Next;
//  end;




  ShowMessage('Kayýt Baþarýyla Yapýldý');
end;

procedure TfrmTeklifDetay.YeniTeklifOlustur();
var
  qryTemp : TADOQuery;
begin

  qryTemp := DMATP.CreateQuery;

  //**Ýhale Kur
  lkpIhaleKur.EditValue := 0;

  //**Extra Bilgisi
  qryTemp.Close;
  qryTemp.SQL.Text := 'select * from Sabitler Where SabitTuru = ' + QuotedStr('Extralar');
  qryTemp.Open;

  cdsEktralar.Open;
  qryTemp.First;
  while not (qryTemp.Eof) do
  begin
    cdsEktralar.Append;
    cdsEktralarExtraAdi.AsString   := qryTemp.FieldByName('SabitAdi').AsString;
    cdsEktralarExtraTutar.AsFloat  := qryTemp.FieldByName('SabitDeger').AsFloat;
    cdsEktralarKurId.AsInteger     := 0;
    cdsEktralar.Post;

    qryTemp.Next;
  end;


  //**Kur Bilgisi
  qryTemp.Close;
  qryTemp.SQL.Text := 'SELECT DovizId, ForexBuying FROM DovizKurlari WHERE Aktif = 1';
  qryTemp.Open;

  cdsHedefKur.Open;
  qryTemp.First;
  while not (qryTemp.Eof) do
  begin
    cdsHedefKur.Append;
    cdsHedefKurKurId.AsInteger     := qryTemp.FieldByName('DovizId').AsInteger;
    cdsHedefKurGuncelKur.AsFloat   := qryTemp.FieldByName('ForexBuying').AsFloat;
    cdsHedefKurHedefKur.AsFloat    := qryTemp.FieldByName('ForexBuying').AsFloat;
    cdsHedefKur.Post;

    qryTemp.Next;
  end;

  //** On Degerler
  qryTemp.Close;
  qryTemp.SQL.Text := 'select * from Sabitler Where SabitTuru = ' + QuotedStr('OnDegerler');
  qryTemp.Open;

  cdsOnDegerler.Open;
  qryTemp.First;
  while not (qryTemp.Eof) do
  begin
    cdsOnDegerler.Append;
    cdsOnDegerlerDegerAdi.AsString  := qryTemp.FieldByName('SabitAdi').AsString;
    cdsOnDegerlerDegerOran.AsFloat  := qryTemp.FieldByName('SabitDeger').AsFloat;
    cdsOnDegerler.Post;

    qryTemp.Next;
  end;

  qryTemp.Destroy;

end;

procedure TfrmTeklifDetay.TeklifDetaySil(TeklifId : Integer);
var
  qryTemp : TADOQuery;
begin

  qryTemp := DMATP.CreateQuery;

  //**Extra Bilgisi
  qryTemp.Close;
  qryTemp.SQL.Text := 'DELETE FROM TeklifExtra Where TeklifId = ' + IntToStr(TeklifId);
  qryTemp.ExecSQL;

  //**Teklif Kur
  qryTemp.Close;
  qryTemp.SQL.Text := 'DELETE FROM TeklifKur Where TeklifId = ' + IntToStr(TeklifId);
  qryTemp.ExecSQL;

  //**On Degerler
  qryTemp.Close;
  qryTemp.SQL.Text := 'DELETE FROM TeklifOnDeger Where TeklifId = ' + IntToStr(TeklifId);
  qryTemp.ExecSQL;

  //**Mal Kalemleri
  qryTemp.Close;
  qryTemp.SQL.Text := 'DELETE FROM TeklifMalKalem Where TeklifId = ' + IntToStr(TeklifId);
  qryTemp.ExecSQL;

  //** Mal Kalemleri Detay
  qryTemp.Close;
  qryTemp.SQL.Text := 'DELETE FROM TeklifMalKalemDetay Where TeklifId = ' + IntToStr(TeklifId);
  qryTemp.ExecSQL;


  qryTemp.Destroy;
end;

procedure TfrmTeklifDetay.txtKarOraniPropertiesEditValueChanged(Sender: TObject);
begin

//   if cdsMalKalem.RecordCount > 0 then
//   begin
//     MaliyetHesap();
//   end;
end;

procedure TfrmTeklifDetay.GetTeklifBilgileri(TeklifId : Integer);
var
  qryTemp : TADOQuery;
begin

  AktifTeklifId := TeklifId;
  qryTemp := DMATP.CreateQuery;

  qryTemp.Close;
  qryTemp.SQL.Text := 'SELECT * FROM Teklif Where TeklifId = ' + IntToStr(TeklifId);
  qryTemp.Open;

  //** Üst Bilgi
  txtIsinAdi.Text              := qryTemp.FieldByName('IsinAdi').AsString;
  lkpKurumAdi.EditValue        := qryTemp.FieldByName('KurumId').AsString;
  cbimgIhaleUsulu.EditValue    := qryTemp.FieldByName('IhaleUsuluId').AsInteger;
  cbimgTeklifMektubu.EditValue := qryTemp.FieldByName('TeklifMektubuId').AsInteger;
  dteIhaleTarihi.Date          := qryTemp.FieldByName('IhaleTarihi').AsDateTime;
  txtIhaleKayitNo.Text         := qryTemp.FieldByName('IhaleKayitNo').AsString;
  txtOpsiyonSuresi.Text        := IntToStr(qryTemp.FieldByName('OpsiyonSuresi').AsInteger);
  txtTeslimSuresi.Text         := IntToStr(qryTemp.FieldByName('TeslimSuresi').AsInteger);
  txtSevkiyatEmirNo.Text       := qryTemp.FieldByName('SevkiyatEmriNo').AsString;
  txtProformaNo.Text           := qryTemp.FieldByName('ProformaNo').AsString ;
  lkpTeklifFirma.EditValue     := qryTemp.FieldByName('TeklifVerenFirmaId').AsInteger;
  lkpYetkili1.EditValue        := qryTemp.FieldByName('IhaleYetkilisiId').AsInteger;
  lkpYetkili2.EditValue        := qryTemp.FieldByName('IhaleYetkilisi2').AsInteger;
  lkpIhaleKur.EditValue        := qryTemp.FieldByName('TeklifKurId').AsInteger;
  txtKarOrani.EditValue        := qryTemp.FieldByName('BrutKarOrani').AsFloat;


  //**Extra Bilgisi
  qryTemp.Close;
  qryTemp.SQL.Text := 'SELECT * FROM TeklifExtra Where TeklifId = ' + IntToStr(TeklifId);
  qryTemp.Open;

  cdsEktralar.Open;
  qryTemp.First;
  while not (qryTemp.Eof) do
  begin
    cdsEktralar.Append;
    cdsEktralarExtraAdi.AsString   := qryTemp.FieldByName('ExtraAdi').AsString;
    cdsEktralarExtraTutar.AsFloat  := qryTemp.FieldByName('ExtraTutar').AsFloat;
    cdsEktralarKurId.AsInteger     := qryTemp.FieldByName('KurId').AsInteger;
    cdsEktralar.Post;

    qryTemp.Next;
  end;


  //**Teklif Kur
  qryTemp.Close;
  qryTemp.SQL.Text := 'SELECT * FROM TeklifKur Where TeklifId = ' + IntToStr(TeklifId);
  qryTemp.Open;

  cdsHedefKur.Open;
  qryTemp.First;
  while not (qryTemp.Eof) do
  begin
    cdsHedefKur.Append;
    cdsHedefKurKurId.AsInteger   := qryTemp.FieldByName('KurId').AsInteger;
    cdsHedefKurGuncelKur.AsFloat := qryTemp.FieldByName('GuncelKur').AsFloat;
    cdsHedefKurHedefKur.AsFloat  := qryTemp.FieldByName('HedefKur').AsFloat;
    cdsHedefKur.Post;

    qryTemp.Next;
  end;


  //**On Degerler
  qryTemp.Close;
  qryTemp.SQL.Text := 'SELECT * FROM TeklifOnDeger Where TeklifId = ' + IntToStr(TeklifId);
  qryTemp.Open;

  cdsOnDegerler.Open;
  qryTemp.First;
  while not (qryTemp.Eof) do
  begin
    cdsOnDegerler.Append;
    cdsOnDegerlerDegerAdi.AsString := qryTemp.FieldByName('OnDegerAdi').AsString;
    cdsOnDegerlerDegerOran.AsFloat := qryTemp.FieldByName('OnDegerOran').AsFloat;
    cdsOnDegerler.Post;

    qryTemp.Next;
  end;


  //**Mal Kalemleri
//  qryTemp.Close;
//  qryTemp.SQL.Text := 'SELECT * FROM TeklifMalKalem Where TeklifId = ' + IntToStr(TeklifId);
//  qryTemp.Open;
//
//  qryTemp.First;
//  while not (qryTemp.Eof) do
//  begin
//    cdsMalKalem.Append;
//    cdsMalKalemKalemAdi.AsString     := qryTemp.FieldByName('KalemAdi').AsString;
//    cdsMalKalemBirimi.AsString       := qryTemp.FieldByName('Birimi').AsString;
//    cdsMalKalemMiktar.AsFloat        := qryTemp.FieldByName('Miktar').AsFloat;
//    cdsMalKalemListeFiyati.AsFloat   := qryTemp.FieldByName('ListeFiyati').AsFloat;
//    cdsMalKalemIndirimOrani.AsFloat  := qryTemp.FieldByName('IndirimOrani').AsFloat;
//    cdsMalKalemExtraDahil.AsInteger  := qryTemp.FieldByName('ExtraDahil').AsInteger;
//    cdsMalKalemBirimMaliyet.AsFloat  := qryTemp.FieldByName('BirimMaliyet').AsFloat;
//    cdsMalKalemToplamMaliyet.AsFloat := qryTemp.FieldByName('ToplamMaliyet').AsFloat;
//    cdsMalKalemExtraPayi.AsFloat     := qryTemp.FieldByName('ExtraPayi').AsFloat;
//    cdsMalKalemDovizId.AsInteger     := qryTemp.FieldByName('DovizId').AsInteger;
//
//    if not (cdsMalKalem.State in [dsInsert , dsEdit]) then
//       cdsMalKalem.Edit;
//
//    cdsMalKalemBirimMaliyetGorunen.AsFloat  := qryTemp.FieldByName('BirimMaliyetGorunen').AsFloat;
//    cdsMalKalemToplamMaliyetGorunen.AsFloat := qryTemp.FieldByName('ToplamMaliyetGorunen').AsFloat;
//    cdsMalKalemBirimMaliyetKur.AsFloat      := qryTemp.FieldByName('BirimMaliyetKur').AsFloat;
//    cdsMalKalemToplamMaliyetKur.AsFloat     := qryTemp.FieldByName('ToplamMaliyetKur').AsFloat;
//    cdsMalKalemKarOrani.AsFloat             := qryTemp.FieldByName('KarOrani').AsFloat;
//
//    if not (cdsMalKalem.State in [dsInsert , dsEdit]) then
//       cdsMalKalem.Edit;
//
//    cdsMalKalemBirimSatisFiyat.AsFloat      := qryTemp.FieldByName('BirimSatisFiyat').AsFloat;
//    cdsMalKalemToplamSatisFiyat.AsFloat     := qryTemp.FieldByName('ToplamSatisFiyat').AsFloat;
//    cdsMalKalem.Post;
//
//    qryTemp.Next;
//  end;



  qryTemp.Destroy;
end;

{$ENDREGION}

end.
