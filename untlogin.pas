unit untlogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, ActnList, DB, ADODB, StdCtrls, cxTextEdit, ExtCtrls, jpeg,
  cxRadioGroup, Inifiles, SUIForm, cxLabel, SUIButton;

type
  Tfrmlogin = class(TForm)
    edtkullaniciAdi: TcxTextEdit;
    edtSifre: TcxTextEdit;
    btngiris: TButton;
    btniptal: TButton;
    qrylogin: TADOQuery;
    dslogin: TDataSource;
    ActionList1: TActionList;
    ac_HizliGiris: TAction;
    rdAnaMakina: TcxRadioButton;
    rdTerminal: TcxRadioButton;
    suifrm1: TsuiForm;
    shp1: TShape;
    img1: TImage;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    lbl1: TLabel;
    procedure btngirisClick(Sender: TObject);
    procedure btniptalClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ac_HizliGirisExecute(Sender: TObject);
    procedure rdTerminalClick(Sender: TObject);
    procedure rdAnaMakinaClick(Sender: TObject);
  private
    { Private declarations }
    Acilis : Boolean;
    procedure RadioSec();

  public
    { Public declarations }
  end;

var
  frmlogin: Tfrmlogin;

implementation

uses DM, untAttachDatabase, untAnaMakinaSecim;


{$R *.dfm}

procedure Tfrmlogin.RadioSec();
var
  IniDosya      : TiniFile;
  ServerAdi     : string;
begin

   // Ini Dosyadan Bilgiler Alnýyor

     IniDosya := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'ACILIS.INI');
     ServerAdi := IniDosya.ReadString('BAGLANTI_STRINGI', 'SERVER','');
     IniDosya.Free;

     if ServerAdi = '.' then
       rdAnaMakina.Checked := True
     else
     begin
       rdTerminal.Checked := True;
       rdTerminal.Caption := 'Terminal (' + ServerAdi + ')';
     end;


end;

procedure Tfrmlogin.rdAnaMakinaClick(Sender: TObject);
var
  IniDosya      : TiniFile;
  ServerAdi     : string;
begin

   if Acilis = False then
   begin
       if DMATP.ServerDataBaseKontrol then
       begin
         if DMATP.DatabaseBaglan('.') then
         begin
           //** Bitti
           IniDosya := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'ACILIS.INI');
           ServerAdi := IniDosya.ReadString('BAGLANTI_STRINGI', 'SERVER','');
           IniDosya.Free;
           rdTerminal.Caption := 'Terminal';
         end
         else
         begin
           //** Kurulum Ekraný
           frmAttachDatabase := TfrmAttachDatabase.Create(nil);
           frmAttachDatabase.ShowModal;
           DMATP.DatabaseBaglan('.');
         end;
       end
       else
       begin
         //**Kurulum Ekraný
         frmAttachDatabase := TfrmAttachDatabase.Create(nil);
         frmAttachDatabase.ShowModal;
         DMATP.DatabaseBaglan('.');
       end;
   end;

end;

procedure Tfrmlogin.rdTerminalClick(Sender: TObject);
begin

   if Acilis = False then
   begin
     frmAnaMakinaSecim := TfrmAnaMakinaSecim.Create(nil);
     frmAnaMakinaSecim.ShowModal;
     RadioSec();
   end;

end;

procedure Tfrmlogin.ac_HizliGirisExecute(Sender: TObject);
var
   qrylogin : TADOQuery;
begin
    qrylogin := DMATP.CreateQuery;
    qrylogin.Close;
    qrylogin.SQL.Text := 'Select top(1) * From Kullanicilar';
    qrylogin.Open;

    KullaniciAdiSoyadi := qrylogin.FieldByName('KullaniciAdi').AsString+ ' ' + qrylogin.FieldByName('KullaniciSoyadi').AsString;
    KullaniciAdi := qrylogin.FieldByName('Username').AsString;
    UserId       := qrylogin.FieldByName('KullaniciId').AsInteger;
    ModalResult  := mrOk;
    qrylogin.Destroy;



end;

procedure Tfrmlogin.btngirisClick(Sender: TObject);
var
  qrylogin : TADOQuery;
begin

  if edtkullaniciAdi.Text= '' then
  begin
    MessageDlg('Kullanýcý Adýný Boþ Geçemezsiniz.', mtWarning, [mbOK], 0);
    Abort;
  end;

  if edtSifre.Text= '' then
  begin
    MessageDlg('Þifreyi Boþ Geçemezsiniz.', mtWarning, [mbOK], 0);
    Abort;
  end;

  try
    qrylogin := DMATP.CreateQuery;
    qrylogin.Close;
    qrylogin.SQL.Text := 'Select * From Kullanicilar Where Username   = ' + QuotedStr(edtkullaniciAdi.Text)
                                                      +' And Password = ' + QuotedStr(edtSifre.Text);
    qrylogin.Open;

    if qrylogin.RecordCount > 0 then
    begin
      KullaniciAdiSoyadi := qrylogin.FieldByName('KullaniciAdi').AsString+ ' ' + qrylogin.FieldByName('KullaniciSoyadi').AsString;
      KullaniciAdi := qrylogin.FieldByName('Username').AsString;
      UserId       := qrylogin.FieldByName('KullaniciId').AsInteger;
      ModalResult  := mrOk;
    end
    else
      MessageDlg('Kullanýcý Adý veya Þifre Hatalýdýr', mtWarning, [mbOK], 0);
  except;
    ModalResult :=mrCancel;
  end;
  qrylogin.Destroy;

end;

procedure Tfrmlogin.btniptalClick(Sender: TObject);
begin
   ModalResult :=mrCancel;
end;

procedure Tfrmlogin.FormShow(Sender: TObject);
begin
   Acilis := True;
   RadioSec();
   Acilis := False;

   btngiris.Default := True;
   edtkullaniciAdi.SetFocus;
end;

end.
