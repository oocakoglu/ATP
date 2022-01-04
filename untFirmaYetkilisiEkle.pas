unit untFirmaYetkilisiEkle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus, cxControls,
  cxContainer, cxEdit, DB, ADODB, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxLabel, StdCtrls,
  cxButtons, ExtCtrls;

type
  TfrmFirmaYetkiliEkle = class(TForm)
    pnl1: TPanel;
    btnKBKaydet: TcxButton;
    btnKBVazgec: TcxButton;
    cxlbl1: TcxLabel;
    cxlbl2: TcxLabel;
    lkpFirma: TcxLookupComboBox;
    lkpUnvan: TcxLookupComboBox;
    cxlbl3: TcxLabel;
    lkpYetkili: TcxLookupComboBox;
    procedure btnKBKaydetClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnKBVazgecClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetYetkiliId(YetkiliId : Integer);
  end;

var
  frmFirmaYetkiliEkle: TfrmFirmaYetkiliEkle;

implementation

uses DM;

{$R *.dfm}

procedure TfrmFirmaYetkiliEkle.SetYetkiliId(YetkiliId : Integer);
begin
  lkpYetkili.EditValue := YetkiliId;
  lkpYetkili.Enabled   := False;
end;

procedure TfrmFirmaYetkiliEkle.btnKBKaydetClick(Sender: TObject);
var
   qryTemp : TADOQuery;
begin

  if lkpFirma.EditValue = Null then
  begin
    ShowMessage('Lütfen Firmayý Giriniz');
    Abort;
  end;

  if lkpYetkili.EditValue = Null then
  begin
    ShowMessage('Lütfen Yetkiliyi Giriniz');
    Abort;
  end;

  if lkpUnvan.EditValue = Null then
  begin
    ShowMessage('Lütfen Ünvaný Giriniz');
    Abort;
  end;



   qryTemp := DMATP.CreateQuery();

   qryTemp.Close;
   qryTemp.SQL.Text := 'SELECT * FROM FirmaYetkili '
                      +'WHERE FirmaId = ' + IntToStr(lkpFirma.EditValue) + ' '
                      +'And YetkiliId = ' + IntToStr(lkpYetkili.EditValue) + ' '
                      +'And UnvanId = ' + IntToStr(lkpUnvan.EditValue) + ' ';
   qryTemp.Open;

   if qryTemp.RecordCount = 0 then
   begin

      qryTemp.Append;
      qryTemp.FieldByName('FirmaId').AsInteger   := lkpFirma.EditValue;
      qryTemp.FieldByName('YetkiliId').AsInteger := lkpYetkili.EditValue;
      qryTemp.FieldByName('UnvanId').AsInteger   := lkpUnvan.EditValue;
      qryTemp.Post;
      Close;
   end
   else
   begin
     ShowMessage('Kaydetmeye Çalýþtýðýnýz Firma Yetkilisi Zaten Vardýr');
   end;
   qryTemp.Destroy;

end;

procedure TfrmFirmaYetkiliEkle.btnKBVazgecClick(Sender: TObject);
begin
 Close;
end;

procedure TfrmFirmaYetkiliEkle.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
