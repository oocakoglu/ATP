unit untAttachDatabase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus, StdCtrls,
  cxButtons, DB, ADODB, IdHTTP, IniFiles, ExtCtrls, SUIForm;

type
  TfrmAttachDatabase = class(TForm)
    btnDatabaseYeniKurulum: TcxButton;
    btnDatabaseYedekAc: TcxButton;
    btnTerminalKullan: TcxButton;
    OpenDialog1: TOpenDialog;
    suifrm1: TsuiForm;
    procedure btnDatabaseYeniKurulumClick(Sender: TObject);
    procedure btnDatabaseYedekAcClick(Sender: TObject);
  private
    { Private declarations }
    procedure DizinKontrol();
    procedure DataBaseKurulum(YeniKurulum : Boolean);
    function  YeniGetFile(url, name: String): Boolean;

  public
    { Public declarations }
  end;

var
  frmAttachDatabase: TfrmAttachDatabase;

implementation

uses DM, untBekleEkrani;

{$R *.dfm}

procedure TfrmAttachDatabase.DizinKontrol();
var
  ATCPath : string;
begin

  ATCPath := ExtractFilePath (Application.ExeName);

  //** Daha Önce Dizinde DAtabase Var Mý?
  if (FileExists(ATCPath + 'Data\ATP_Data.mdf')) or (FileExists(ATCPath + 'Data\ATP_log.LDF')) then
  begin
    if MessageDlg('Kurulum yapýlabilmesi için eski databasenize ait' +#13
               +'"' + ATCPath + 'Data"  dizininde dosyalar silinecektir.'+#13
               +'Bu dosyalarý silmek istediðinize emin misiniz?', mtConfirmation, [mbYes,mbNo], 0) <> mrYes then
    begin
      abort;
    end
    else
    begin
      DeleteFile(pchar(ATCPath+'Data\ATP_Data.mdf'));
      DeleteFile(pchar(ATCPath+'Data\ATP_log.LDF'));
    end;
  end;
end;

function  TfrmAttachDatabase.YeniGetFile(url, name: String): Boolean;
var
  Stream: TMemoryStream;
  http: TidHttp;
  Adres, isim: string;
begin
  Adres := url;
  isim := name;
  try
    Stream := TMemoryStream.Create;
    http := TIdHTTP.Create(self);
    http.HandleRedirects := True;
    http.AllowCookies := True;

    // HTTP.Request.UserAgent := 'Mozilla/4.0';
    http.Request.Connection := 'Keep-Alive';
    http.Request.ProxyConnection := 'Keep-Alive';
    // HTTP.Request.Referer := 'http://www.google.com';
    http.Request.CacheControl := 'no-cache'; // this force use no-cache
    http.Get(url, Stream);

    Stream.SaveToFile(Name);
  finally
    Stream.Free;
    http.Free;
  end;
end;

procedure TfrmAttachDatabase.btnDatabaseYedekAcClick(Sender: TObject);
begin
  DataBaseKurulum(False);
end;

procedure TfrmAttachDatabase.btnDatabaseYeniKurulumClick(Sender: TObject);
begin
  DataBaseKurulum(True);
end;

procedure TfrmAttachDatabase.DataBaseKurulum(YeniKurulum : Boolean);
var
  AdoConAttach   : TADOConnection;
  qryAttachDb    : TADOQuery;
  TebeosPath     : string;
  YedekPath      : string;

  IniDosya       : TiniFile;
begin

  try
    DizinKontrol();
    TebeosPath := ExtractFilePath (Application.ExeName);

    //** Connection Olusturulma
    AdoConAttach  := DMATP.CreateConAttach();
    qryAttachDb   := TADOQuery.Create(nil);
    qryAttachDb.Connection := AdoConAttach;
    qryAttachDb.CommandTimeout := 240;


    if YeniKurulum then
    begin
      YedekPath := ExtractFilePath (Application.ExeName) + 'Data\ATP_Backup.bak';
    end
    else
    begin
      OpenDialog1.Execute();
      YedekPath := OpenDialog1.FileName;
    end;


    OpenBekleForm('Veritabaný Oluþturuluyor. Lütfen Bekleyiniz...');
    Application.ProcessMessages;

//RESTORE FILELISTONLY FROM DISK = 'C:\Users\OMER\Desktop\cuneyt\Data\ATP_Backup.bak'
//
//RESTORE DATABASE ATP FROM DISK = 'C:\Users\OMER\Desktop\cuneyt\Data\ATP_Backup.bak'
//WITH
//MOVE 'ATP_Data' TO 'C:\Users\OMER\Desktop\cuneyt\Data\ATP_Data.mdf',
//MOVE 'ATP_log' TO 'C:\Users\OMER\Desktop\cuneyt\Data\ATP_log.LDF'


    if YedekPath <> '' then
    begin
        qryAttachDb.SQL.Text := 'RESTORE DATABASE ATP FROM DISK = '''
                          //+ YedekPath + 'TEBEOS_Backup.bak'' WITH MOVE ''TEBEOS_Data'' TO '''
                          + YedekPath + ''' WITH MOVE ''ATP_Data'' TO '''
                          + TebeosPath + 'Data\ATP_Data.mdf'',' + ' MOVE ''ATP_log'' TO '''
                          + TebeosPath + 'Data\ATP_log.LDF''';
        qryAttachDb.ExecSQL;
    end;
    CloseBekleForm;
    qryAttachDb.Destroy;
    AdoConAttach.Destroy;

    IniDosya := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'ACILIS.INI');
    IniDosya.WriteString('BAGLANTI_STRINGI', 'SERVER', '.');
    IniDosya.Free;

    Close;
  except on ex: exception do
    //GetDialog('Attach Hatasý Oluþtu! ' + ex.message, tdTipHata, [tdcevapTamam]);
    ShowMessage('Attach Hatasý Oluþtu!'+ ex.message);
  end;

end;


end.
