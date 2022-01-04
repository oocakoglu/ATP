unit untDataBaseBackup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, cxProgressBar, StdCtrls, cxButtons, cxLabel,
  cxTextEdit, cxMaskEdit, cxButtonEdit, DB, ADODB, ExtCtrls, SUIForm;

type
  TfrmDataBaseBackup = class(TForm)
    beyedeklemeYeri: TcxButtonEdit;
    cxLabel2: TcxLabel;
    btndatabaseYedekle: TcxButton;
    ProgressBaryedekle: TcxProgressBar;
    sd1: TSaveDialog;
    suifrm1: TsuiForm;
    procedure btndatabaseYedekleClick(Sender: TObject);
    procedure beyedeklemeYeriPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDataBaseBackup: TfrmDataBaseBackup;

implementation

uses DM;

{$R *.dfm}

procedure TfrmDataBaseBackup.beyedeklemeYeriPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  sd1.Filter:='Veri Tabaný Dosyalarý (*.BAK)|*.BAK';
  sd1.Title :='Yedeklemenin alýnacaðý dosya adý ve yeri';
  sd1.DefaultExt:='BAK';

  if sd1.Execute Then //Kaydet Göster ve iþlem iptal edilmezse
  Begin
    beyedeklemeYeri.Text := sd1.FileName;
  End;
end;

procedure TfrmDataBaseBackup.btndatabaseYedekleClick(Sender: TObject);
var
  Conn          : TADOConnection;
  Query_backup  : TADOQuery;
begin

  if length(trim(beyedeklemeYeri.Text)) = 0 then
  begin
    MessageDlg('Yedekleme yapýlacak yeri seçiniz!', mtWarning, [mbOk, mbCancel],0 );
    beyedeklemeYeri.SetFocus;
    exit;
  end;

  ProgressBaryedekle.Position := 15;
  btndatabaseYedekle.Enabled := False;

  Conn := TADOConnection.Create(nil);
  Conn.LoginPrompt := False ;
  Conn.ConnectionString := DMATP.ADOConnection.ConnectionString;

  Query_backup := TADOQuery.Create(nil);
  Query_backup.Connection := Conn;
  Query_backup.CommandTimeout := 400;


  if not(Conn.Connected) then
    Conn.Open;

  ProgressBaryedekle.Position := 40;
  if not DirectoryExists(ExtractFilePath(Application.ExeName) + 'Backup') then
    CreateDir(ExtractFilePath(Application.ExeName) + 'Backup');


  Query_backup.SQL.Text := 'BACKUP DATABASE ATP TO DISK = ' + QuotedStr (beyedeklemeYeri.Text);
  ProgressBaryedekle.Position := 80;

 // Application.ProcessMessages;
  Query_backup.ExecSQL;
  //Query_backup.Close;

  Query_backup.Destroy;
  Conn.Destroy;
  ProgressBaryedekle.Position := 100;
 // Application.ProcessMessages;

  ShowMessage('Yedek Alma Ýþlemi Gerçekleþti');

  btndatabaseYedekle.Enabled  := True;
  ProgressBaryedekle.Position := 0;
  beyedeklemeYeri.Text        := '';

end;

end.
