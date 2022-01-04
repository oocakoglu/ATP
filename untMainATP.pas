unit untMainATP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Menus, jpeg, ExtCtrls, SUIForm, SUIMainMenu;

type
  TfrmMainATP = class(TForm)
    statusBar1: TStatusBar;
    suiMDIForm1: TsuiMDIForm;
    img1: TImage;
    suiMainMenu1: TsuiMainMenu;
    eklifler2: TMenuItem;
    miYeniTeklif: TMenuItem;
    eklifListesi1: TMenuItem;
    Raporlar1: TMenuItem;
    anmlamalemleri2: TMenuItem;
    ProgramTanmlar1: TMenuItem;
    eklifTanmlar1: TMenuItem;
    FirmaTANIMLAMA1: TMenuItem;
    haleYetkilisiTanmlar1: TMenuItem;
    KurumTanmlar1: TMenuItem;
    DvizKurlar1: TMenuItem;
    SistemYnetimi1: TMenuItem;
    Hakknda2: TMenuItem;
    miYetkilendirme: TMenuItem;
    miYedekAl: TMenuItem;
    miGeriYukle: TMenuItem;
    miHakkindaLisans: TMenuItem;
    miUzaktanYardim: TMenuItem;
    miletiim: TMenuItem;
    procedure miHakkindaLisansClick(Sender: TObject);
    procedure miletiimClick(Sender: TObject);
    procedure miUzaktanYardimClick(Sender: TObject);
    procedure miYetkilendirmeClick(Sender: TObject);
    procedure miYedekAlClick(Sender: TObject);
    procedure miGeriYukleClick(Sender: TObject);
    procedure miFirmaTanimlariClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure miYeniTeklifClick(Sender: TObject);
    procedure miIhaleYetkilisiTanimlariClick(Sender: TObject);
    procedure miKurumTanimlariClick(Sender: TObject);
    procedure mniDovizKurlariClick(Sender: TObject);
    procedure eklifListesi1Click(Sender: TObject);
    procedure eklifTanmlar1Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
     procedure YetkilendirmeKontrol(UserId : Integer);
  end;

var
  frmMainATP: TfrmMainATP;

implementation

uses DM, untAbout, untIletisimSikayet, untYetkilendirme, untDataBaseBackup, untDataBaseRestore,
  untFirmaListe, untTeklifDetay, untIhaleYetkiliListe, untKurumListe,
  untDovizKurlari, untTumTeklifler, untTeklifTanimlari;

{$R *.dfm}

procedure TfrmMainATP.miHakkindaLisansClick(Sender: TObject);
begin
  Application.CreateForm(TfrmAbout, frmAbout);
  frmAbout.ShowModal;
end;

procedure TfrmMainATP.miIhaleYetkilisiTanimlariClick(Sender: TObject);
begin
  Application.CreateForm(TfrmIhaleYetkiliListe, frmIhaleYetkiliListe);
  frmIhaleYetkiliListe.Show;
end;

procedure TfrmMainATP.miKurumTanimlariClick(Sender: TObject);
begin
  Application.CreateForm(TfrmKurumListe, frmKurumListe);
  frmKurumListe.Show;
end;

procedure TfrmMainATP.miletiimClick(Sender: TObject);
begin
  Application.CreateForm(TfrmIletisimSikayet, frmIletisimSikayet);
  frmIletisimSikayet.Show;
end;

procedure TfrmMainATP.miUzaktanYardimClick(Sender: TObject);
var
  program_path:string;
begin
  program_path:= ExtractFilePath(Application.ExeName)+'TeamATPYardim.exe';
  if FileExists(program_path) <> true then
  begin
    //** �ifre 1111
    //InformMessage('UzaktanYardm1Click', 'TeamViewerQS.exe bulunamam��t�r...!');
    ShowMessage('TeamATPYardim.exe bulunamam��t�r...!');
    exit;
  end;
  WinExec(PansiChar(AnsiString(program_path)), SW_SHOW);
end;

procedure TfrmMainATP.miYedekAlClick(Sender: TObject);
begin
   Application.CreateForm(TfrmDataBaseBackup,frmDataBaseBackup);
   frmDataBaseBackup.ShowModal;
end;

procedure TfrmMainATP.miYeniTeklifClick(Sender: TObject);
begin
   Application.CreateForm(TfrmTeklifDetay,frmTeklifDetay);
   frmTeklifDetay.YeniTeklifOlustur();
   frmTeklifDetay.show
end;

procedure TfrmMainATP.miYetkilendirmeClick(Sender: TObject);
begin
   Application.CreateForm(TfrmYetkilendirme,frmYetkilendirme);
   frmYetkilendirme.show
end;

procedure TfrmMainATP.mniDovizKurlariClick(Sender: TObject);
begin
   Application.CreateForm(TfrmDovizKurlari,frmDovizKurlari);
   frmDovizKurlari.show
end;

procedure TfrmMainATP.eklifListesi1Click(Sender: TObject);
begin
   Application.CreateForm(TfrmTumTeklifler,frmTumTeklifler);
   frmTumTeklifler.show
end;

procedure TfrmMainATP.eklifTanmlar1Click(Sender: TObject);
begin
 Application.CreateForm(TfrmTeklifTanimlari, frmTeklifTanimlari);
 frmTeklifTanimlari.show;
end;

procedure TfrmMainATP.FormShow(Sender: TObject);
begin
  DMATP.qryIl.close;
  DMATP.qryIl.open;

  DMATP.qryKurlar.Close;
  DMATP.qryKurlar.Open;

  StatusBar1.Panels[0].Text := 'ATP Maliyet Hesaplama';
  StatusBar1.Panels[1].Text := 'Versiyon No: ' +  DMATP.AktifVersiyon;;
  StatusBar1.Panels[2].Text := 'Kullan�c�: ' +KullaniciAdi;

  YetkilendirmeKontrol(UserId);
end;

procedure TfrmMainATP.miFirmaTanimlariClick(Sender: TObject);
begin
   Application.CreateForm(TfrmFirmaListe,frmFirmaListe);
   frmFirmaListe.show
end;

procedure TfrmMainATP.miGeriYukleClick(Sender: TObject);
begin
   Application.CreateForm(TfrmDataBaseRestore,frmDataBaseRestore);
   frmDataBaseRestore.show
end;



procedure TfrmMainATP.YetkilendirmeKontrol(UserId : Integer);
begin

//  //**Teklifler
//  miYeniTeklif.Enabled    := DMATP.GetUserYetki(UserId ,tpgrpTeklifler ,'Yeni Teklif', 'frmYeniTeklif', tpGorme);
//  miTeklifListesi.Enabled := DMATP.GetUserYetki(UserId ,tpgrpTeklifler ,'Teklif Listesi', 'frmTeklifListesi', tpGorme);
//
//  //** Raporlar
//  miAlstatistigi.Enabled := DMATP.GetUserYetki(UserId ,tpgrpRaporlar ,'Al�� �statisti�i', 'frmAlisIstatistigi', tpGorme);
//
//
//  //** Tan�mlar
//  miProgramTanmlari.Enabled := DMATP.GetUserYetki(UserId ,tpgrpTanimKartlari ,'Program Tan�mlar�', 'frmProgramTanimlari', tpGorme);
//  miTeklifTanimlari.Enabled := DMATP.GetUserYetki(UserId ,tpgrpTanimKartlari ,'Teklif Tan�mlar�', 'frmTeklifTanimlari', tpGorme);
//  miFirmaTanimlari.Enabled  := DMATP.GetUserYetki(UserId ,tpgrpTanimKartlari ,'Firma Tan�mlar�', 'frmFirmaTanimlari', tpGorme);
//  miIhaleYetkilisiTanimlari.Enabled := DMATP.GetUserYetki(UserId ,tpgrpTanimKartlari ,'�hale Yetkilisi Tan�mlar�', 'frmIhaleYetkilisiTanimlari', tpGorme);
//  //miUnvanTanimlari.Enabled   := DMATP.GetUserYetki(UserId ,tpgrpTanimKartlari ,'�nvan Tan�mlar�', 'frmUnvanTanimlari', tpGorme);
//  miKurumTanimlari.Enabled   := DMATP.GetUserYetki(UserId ,tpgrpTanimKartlari ,'Kurum Tan�mlar�', 'frmKurumTanimlari', tpGorme);
//  mniDovizKurlari.Enabled    := DMATP.GetUserYetki(UserId ,tpgrpTanimKartlari ,'D�viz Kurlar�', 'frmDovizKurlari', tpGorme);
//
//
//  //**Sistem Yonetimi
//  miYetkilendirme.Enabled := DMATP.GetUserYetki(UserId ,tpgrpSistemYonetimi ,'Yetkilendirme Ekran�', 'frmYetkilendirme', tpGorme);
//  miYedekAl.Enabled       := DMATP.GetUserYetki(UserId ,tpgrpSistemYonetimi ,'Yedek Alma Ekran�', 'frmBackup', tpGorme);
//  miGeriYukle.Enabled     := DMATP.GetUserYetki(UserId ,tpgrpSistemYonetimi ,'Geri Y�kleme Ekran�', 'frmRestore', tpGorme);
//

end;


end.
