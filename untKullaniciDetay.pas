unit untKullaniciDetay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  cxControls, cxContainer, cxEdit, cxLabel, cxTextEdit, cxDBEdit, StdCtrls,
  cxButtons, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, ExtCtrls, SUIForm;

type
  TfrmKullaniciDetay = class(TForm)
    qryKullaniciDetay: TADOQuery;
    dsKullaniciDetay: TDataSource;
    btnEkle: TcxButton;
    btnSil: TcxButton;
    btnKaydet: TcxButton;
    btnVazgeç: TcxButton;
    edtAdi: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    edtSoyadi: TcxDBTextEdit;
    edtKullaniciAdi: TcxDBTextEdit;
    edtSifre: TcxDBTextEdit;
    edtSifreTekrar: TcxTextEdit;
    suifrm1: TsuiForm;
    procedure dsKullaniciDetayDataChange(Sender: TObject; Field: TField);
    procedure btnEkleClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure qryKullaniciDetayBeforePost(DataSet: TDataSet);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnVazgeçClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure KullaniciGetir(KullaniciId : Integer);
  end;

var
  frmKullaniciDetay: TfrmKullaniciDetay;

implementation

uses DM;

{$R *.dfm}

procedure TfrmKullaniciDetay.btnEkleClick(Sender: TObject);
begin
  qryKullaniciDetay.Append;
end;

procedure TfrmKullaniciDetay.btnKaydetClick(Sender: TObject);
begin
  qryKullaniciDetay.Post;
end;

procedure TfrmKullaniciDetay.btnSilClick(Sender: TObject);
begin

   if MessageDlg('Kullanýcýyý Silmek Ýstediðinize Emin misiniz?', mtConfirmation, [mbYes,mbNo], 0) <> mrYes then
      Abort;

   qryKullaniciDetay.delete;
end;

procedure TfrmKullaniciDetay.btnVazgeçClick(Sender: TObject);
begin
  qryKullaniciDetay.Cancel;
end;

procedure TfrmKullaniciDetay.dsKullaniciDetayDataChange(Sender: TObject;
  Field: TField);
begin

    if qryKullaniciDetay.State in [dsInsert, dsEdit] then
   begin
     btnEkle.Enabled := False;
     btnSil.Enabled  := False;
     btnKaydet.Enabled := True;
     btnVazgeç.Enabled := True;
   end
   else
   begin
     btnEkle.Enabled := True;
     btnSil.Enabled  := True;
     btnKaydet.Enabled := False;
     btnVazgeç.Enabled := False;
   end;

end;

procedure TfrmKullaniciDetay.KullaniciGetir(KullaniciId : Integer);
begin

 qryKullaniciDetay.Close;
 qryKullaniciDetay.SQL.Text := 'Select * From Kullanicilar Where KullaniciId = '  + IntToStr(KullaniciId);
 qryKullaniciDetay.Open;

 if KullaniciId = 0 then
 begin
   qryKullaniciDetay.Append;
 end
 else
 begin
   edtSifreTekrar.Text := qryKullaniciDetay.FieldByName('Password').AsString;
 end;

end;

procedure TfrmKullaniciDetay.qryKullaniciDetayBeforePost(DataSet: TDataSet);
begin

   if edtSifre.Text <> edtSifreTekrar.Text then
   begin
       MessageDlg('Þifre ve Þifre Tekrar Farklýdýr', mtConfirmation, [mbOK], 0);
       Abort;
   end;

end;

end.
