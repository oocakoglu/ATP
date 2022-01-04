program ATP;

uses
  Forms,
  Controls,
  untMainATP in 'untMainATP.pas' {frmMainATP},
  untlogin in 'untlogin.pas' {frmlogin},
  DM in 'DM.pas' {DMATP: TDataModule},
  untBekleEkrani in 'untBekleEkrani.pas' {frmBekleEkrani},
  untAttachDatabase in 'untAttachDatabase.pas' {frmAttachDatabase},
  untAnaMakinaSecim in 'untAnaMakinaSecim.pas' {frmAnaMakinaSecim},
  untNETInfo in 'untNETInfo.pas',
  ATPService in 'ATPService.pas',
  untAbout in 'untAbout.pas' {frmAbout},
  untIletisimSikayet in 'untIletisimSikayet.pas' {frmIletisimSikayet},
  untKullaniciDetay in 'untKullaniciDetay.pas' {frmKullaniciDetay},
  untYetkilendirme in 'untYetkilendirme.pas' {frmYetkilendirme},
  untDataBaseBackup in 'untDataBaseBackup.pas' {frmDataBaseBackup},
  untDataBaseRestore in 'untDataBaseRestore.pas' {frmDataBaseRestore},
  untFirmaListe in 'untFirmaListe.pas' {frmFirmaListe},
  untFirmaDetay in 'untFirmaDetay.pas' {frmFirmaDetay},
  untTeklifDetay in 'untTeklifDetay.pas' {frmTeklifDetay},
  untIhaleYetkiliListe in 'untIhaleYetkiliListe.pas' {frmIhaleYetkiliListe},
  untIhaleYetkiliDetay in 'untIhaleYetkiliDetay.pas' {frmIhaleYetkiliDetay},
  untFirmaYetkilisiEkle in 'untFirmaYetkilisiEkle.pas' {frmFirmaYetkiliEkle},
  untKurumListe in 'untKurumListe.pas' {frmKurumListe},
  untKurumDetay in 'untKurumDetay.pas' {frmKurumDetay},
  untDovizKurlari in 'untDovizKurlari.pas' {frmDovizKurlari},
  untTumTeklifler in 'untTumTeklifler.pas' {frmTumTeklifler},
  untTeklifTanimlari in 'untTeklifTanimlari.pas' {frmTeklifTanimlari};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDMATP, DMATP);
  frmlogin := Tfrmlogin.Create(nil);
  frmlogin.ModalResult := mrCancel;
  frmlogin.ShowModal;
  if frmlogin.ModalResult <>mrOk then
     Application.Terminate;

  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMainATP, frmMainATP);

  Application.Run;
end.
