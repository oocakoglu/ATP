unit untYetkilendirme;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  ADODB, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, ExtCtrls, cxImageComboBox,
  cxCheckBox, cxSplitter, Menus, StdCtrls, cxButtons, SUIForm;

type
  TfrmYetkilendirme = class(TForm)
    grdKullanicilarTV: TcxGridDBTableView;
    grdKullanicilarLV: TcxGridLevel;
    grdKullanicilar: TcxGrid;
    qryKullanicilar: TADOQuery;
    dsKullanicilar: TDataSource;
    grdKullanicilarTVKullaniciId: TcxGridDBColumn;
    grdKullanicilarTVKullaniciAdi: TcxGridDBColumn;
    grdKullanicilarTVKullaniciSoyadi: TcxGridDBColumn;
    grdKullanicilarTVUsername: TcxGridDBColumn;
    grdKullanicilarTVPassword: TcxGridDBColumn;
    pnlYetkilendirme: TPanel;
    qryKullaniciYetki: TADOQuery;
    dsKullaniciYetki: TDataSource;
    pnlSag: TPanel;
    cxSplitter1: TcxSplitter;
    grdKullaniciYetki: TcxGrid;
    grdKullaniciYetkiTV: TcxGridDBTableView;
    grdKullaniciYetkiTVYetkiId: TcxGridDBColumn;
    grdKullaniciYetkiTVKullaniciId: TcxGridDBColumn;
    grdKullaniciYetkiTVFormGrupId: TcxGridDBColumn;
    grdKullaniciYetkiTVFormAdi: TcxGridDBColumn;
    grdKullaniciYetkiTVProgramFormAdi: TcxGridDBColumn;
    grdKullaniciYetkiTVEkleme: TcxGridDBColumn;
    grdKullaniciYetkiTVSilme: TcxGridDBColumn;
    grdKullaniciYetkiTVDegistirme: TcxGridDBColumn;
    grdKullaniciYetkiTVGorme: TcxGridDBColumn;
    grdKullaniciYetkiLV: TcxGridLevel;
    Panel1: TPanel;
    Panel3: TPanel;
    btnKaydet: TcxButton;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    suifrm1: TsuiForm;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dsKullanicilarDataChange(Sender: TObject; Field: TField);
    procedure btnKaydetClick(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure YetkilendirmeKontrol;
  public
    { Public declarations }
  end;

var
  frmYetkilendirme: TfrmYetkilendirme;

implementation

uses DM, untKullaniciDetay, untMainATP;

{$R *.dfm}

procedure TfrmYetkilendirme.btnKaydetClick(Sender: TObject);
begin
   if qryKullaniciYetki.State in [dsInsert, dsEdit] then
      qryKullaniciYetki.Post;
   Self.Close;
end;

procedure TfrmYetkilendirme.cxButton1Click(Sender: TObject);
begin
   Application.CreateForm(TfrmKullaniciDetay,frmKullaniciDetay);
   frmKullaniciDetay.KullaniciGetir(qryKullanicilar.FieldByName('KullaniciId').AsInteger);
   frmKullaniciDetay.ShowModal;
   qryKullanicilar.Close;
   qryKullanicilar.Open;
end;

procedure TfrmYetkilendirme.cxButton2Click(Sender: TObject);
begin
   Application.CreateForm(TfrmKullaniciDetay,frmKullaniciDetay);
   frmKullaniciDetay.KullaniciGetir(0);
   frmKullaniciDetay.ShowModal;
   qryKullanicilar.Close;
   qryKullanicilar.Open;
end;

procedure TfrmYetkilendirme.dsKullanicilarDataChange(Sender: TObject;
  Field: TField);
begin
  YetkilendirmeKontrol;

  qryKullaniciYetki.Close;
  qryKullaniciYetki.SQL.Text := 'SELECT * FROM Yetkilendirme WHERE KullaniciId = ' + qryKullanicilar.Fieldbyname('KullaniciId').AsString + ' ORDER BY FormGrupId';
  qryKullaniciYetki.Open;

  grdKullaniciYetkiTV.ViewData.Expand(True);
end;

procedure TfrmYetkilendirme.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmMainATP.YetkilendirmeKontrol(UserId);
  action:=caFree;
end;

procedure TfrmYetkilendirme.FormShow(Sender: TObject);
begin
  qryKullanicilar.Open;

end;

procedure TfrmYetkilendirme.YetkilendirmeKontrol;
begin


  //**Teklifler
  DMATP.GetUserYetki(qryKullanicilar.FieldByName('KullaniciId').AsInteger ,tpgrpTeklifler ,'Yeni Teklif', 'frmYeniTeklif', tpGorme);
  DMATP.GetUserYetki(qryKullanicilar.FieldByName('KullaniciId').AsInteger ,tpgrpTeklifler ,'Teklif Listesi', 'frmTeklifListesi', tpGorme);

  //** Raporlar
  DMATP.GetUserYetki(qryKullanicilar.FieldByName('KullaniciId').AsInteger ,tpgrpRaporlar ,'Alýþ Ýstatistiði', 'frmAlisIstatistigi', tpGorme);


  //** Tanýmlar
  DMATP.GetUserYetki(qryKullanicilar.FieldByName('KullaniciId').AsInteger ,tpgrpTanimKartlari ,'Program Tanýmlarý', 'frmProgramTanimlari', tpGorme);
  DMATP.GetUserYetki(qryKullanicilar.FieldByName('KullaniciId').AsInteger ,tpgrpTanimKartlari ,'Teklif Tanýmlarý', 'frmTeklifTanimlari', tpGorme);
  DMATP.GetUserYetki(qryKullanicilar.FieldByName('KullaniciId').AsInteger ,tpgrpTanimKartlari ,'Firma Tanýmlarý', 'frmFirmaTanimlari', tpGorme);
  DMATP.GetUserYetki(qryKullanicilar.FieldByName('KullaniciId').AsInteger ,tpgrpTanimKartlari ,'Ýhale Yetkilisi Tanýmlarý', 'frmIhaleYetkilisiTanimlari', tpGorme);
  DMATP.GetUserYetki(qryKullanicilar.FieldByName('KullaniciId').AsInteger ,tpgrpTanimKartlari ,'Ünvan Tanýmlarý', 'frmUnvanTanimlari', tpGorme);
  DMATP.GetUserYetki(qryKullanicilar.FieldByName('KullaniciId').AsInteger ,tpgrpTanimKartlari ,'Kurum Tanýmlarý', 'frmKurumTanimlari', tpGorme);

  //**Sistem Yonetimi
  DMATP.GetUserYetki(qryKullanicilar.FieldByName('KullaniciId').AsInteger ,tpgrpSistemYonetimi ,'Yetkilendirme Ekraný', 'frmYetkilendirme', tpkontrol);
  DMATP.GetUserYetki(qryKullanicilar.FieldByName('KullaniciId').AsInteger ,tpgrpSistemYonetimi ,'Yedek Alma Ekraný', 'frmBackup', tpGorme);
  DMATP.GetUserYetki(qryKullanicilar.FieldByName('KullaniciId').AsInteger ,tpgrpSistemYonetimi ,'Geri Yükleme Ekraný', 'frmRestore', tpGorme);
end;


end.
