unit untDataBaseRestore;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, cxProgressBar, StdCtrls, cxButtons, cxTextEdit,
  cxMaskEdit, cxButtonEdit, cxLabel, DB, ADODB, StrUtils, ExtCtrls, SUIForm;

type
  TfrmDataBaseRestore = class(TForm)
    cxLabel1: TcxLabel;
    begeriyukleYeri: TcxButtonEdit;
    btndatabaseAc: TcxButton;
    ProgressBargeriYukle: TcxProgressBar;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    od1: TOpenDialog;
    suifrm1: TsuiForm;
    procedure btndatabaseAcClick(Sender: TObject);
    procedure begeriyukleYeriPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDataBaseRestore: TfrmDataBaseRestore;

implementation

uses DM;

{$R *.dfm}

procedure TfrmDataBaseRestore.begeriyukleYeriPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  od1.Filter := 'Veri Taban� Dosyalar� (*.BAK)|*.BAK';
  od1.Title := 'A�ilacak Olan Veritaban� Yedegini Se�iniz';
  od1.DefaultExt := 'BAK';
  od1.Execute;
  begeriyukleYeri.Text := od1.FileName;

end;

procedure TfrmDataBaseRestore.btndatabaseAcClick(Sender: TObject);
var
  qryRestore               : TADOQuery;
  qryBagliKullanicilar     : TADOQuery;
  Conn                     : TADOConnection;
  ConString                : String;
begin

  if MessageDlg('Yede�i geri y�klemek isterseniz' + #13
               +'�u anki veritaban�n�zdaki t�m verileri kaybedersiniz.'+ #13
               +'Bu tip riskli i�lemleri yapmadan �nce yedek alman�z �nerilir' + #13
               +'Devam Etmek �stedi�inize Emin misiniz?', mtWarning, [mbYes, mbNo],0 )<> mrYes then
  begin
    Abort;
  end;

  if length(trim(begeriyukleYeri.Text)) = 0 then
  begin
    MessageDlg('Yedekten geri y�klenecek yeri se�iniz!', mtWarning, [mbOk, mbCancel],0 );
    begeriyukleYeri.SetFocus;
    exit;
  end;

  ProgressBargeriYukle.Position := 15;
  btndatabaseAc.Enabled := False;

  Conn := TADOConnection.Create(nil);
  Conn.LoginPrompt := False ;
  ConString := DMATP.ADOConnection.ConnectionString;
  ConString := AnsiReplaceStr(ConString,'ATP;','master;');
  Conn.ConnectionString := ConString;

  qryRestore := TADOQuery.Create(nil);
  qryRestore.Connection := Conn;
  qryRestore.CommandTimeout := 400;

  qryBagliKullanicilar := TADOQuery.Create(nil);
  qryBagliKullanicilar.Connection := Conn;

  qryBagliKullanicilar.Close;
  qryBagliKullanicilar.SQL.Text := 'select spid from master..sysprocesses where dbid = db_id(''ATP'')';
  qryBagliKullanicilar.Open;

  ProgressBargeriYukle.Position := 40;
  while not (qryBagliKullanicilar.Eof) do
  begin
    qryRestore.SQL.Text := 'KILL ' + FloatToStr(qryBagliKullanicilar.FieldValues['spid']);
    qryRestore.ExecSQL;
    qryBagliKullanicilar.Next;
  end;

  ProgressBargeriYukle.Position := 80;
  qryRestore.close;
  qryRestore.SQL.Text := 'RESTORE DATABASE ATP FROM DISK  = ' + QuotedStr (begeriyukleYeri.Text);
  qryRestore.ExecSQL;
  qryRestore.Close;


  qryRestore.Destroy;
  Conn.Destroy;
  ProgressBargeriYukle.Position := 100;


  ShowMessage('Yedek A�me ��lemi Ger�ekle�ti. L�tfen Program� Tekrar Ba�lat�n�z');

  Halt;
  {btndatabaseAc.Enabled         := True;
  ProgressBargeriYukle.Position := 0;
  begeriyukleYeri.Text          := '';  }

end;


end.
