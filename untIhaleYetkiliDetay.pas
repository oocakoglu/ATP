unit untIhaleYetkiliDetay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  StdCtrls, DB, ADODB, cxPC, cxContainer, cxEdit, Menus, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxButtons, ExtCtrls, cxMemo, cxDBEdit, cxMaskEdit, cxTextEdit, cxLabel,
  SUIForm;

type
  TfrmIhaleYetkiliDetay = class(TForm)
    qryYetkili: TADOQuery;
    dsYetkili: TDataSource;
    qryFirmaYetkili: TADOQuery;
    dsFirmaYetkili: TDataSource;
    suiForm1: TsuiForm;
    pageIhaleYetkilisi: TcxPageControl;
    tsKisiselBilgiler: TcxTabSheet;
    cxlbl1: TcxLabel;
    txtYetkiliAdi: TcxDBTextEdit;
    cxlbl2: TcxLabel;
    txtYetkiliSoyadi: TcxDBTextEdit;
    cxlbl3: TcxLabel;
    cxDBMaskEdit1: TcxDBMaskEdit;
    cxlbl4: TcxLabel;
    cxDBMaskEdit2: TcxDBMaskEdit;
    cxlbl5: TcxLabel;
    cxDBTextEdit1: TcxDBTextEdit;
    cxlbl6: TcxLabel;
    cxDBMemo1: TcxDBMemo;
    pnl1: TPanel;
    btnKBKaydet: TcxButton;
    btnKBVazgec: TcxButton;
    tsFirmaBilgileri: TcxTabSheet;
    grdFirmaYetkili: TcxGrid;
    grdTVFirmaYetkiliTV: TcxGridDBTableView;
    grdclmTVFirmaYetkiliTVFirmaYetkiliId: TcxGridDBColumn;
    grdclmTVFirmaYetkiliTVFirmaId: TcxGridDBColumn;
    grdclmTVFirmaYetkiliTVYetkiliId: TcxGridDBColumn;
    grdclmTVFirmaYetkiliTVUnvanId: TcxGridDBColumn;
    grdFirmaYetkiliLV: TcxGridLevel;
    pnl2: TPanel;
    btnFirmaYetkiliEkle: TcxButton;
    btn2: TcxButton;
    procedure dsYetkiliStateChange(Sender: TObject);
    procedure btnKBKaydetClick(Sender: TObject);
    procedure btnKBVazgecClick(Sender: TObject);
    procedure btnFirmaYetkiliEkleClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
    AktifYetkiliId : Integer;
  public
    { Public declarations }
    procedure YetkiliBilgileriGetir(YetkiliId : Integer);
  end;

var
  frmIhaleYetkiliDetay: TfrmIhaleYetkiliDetay;

implementation

uses DM, untFirmaYetkilisiEkle;

{$R *.dfm}


procedure TfrmIhaleYetkiliDetay.btnKBKaydetClick(Sender: TObject);
begin
  qryYetkili.Post;
  AktifYetkiliId := qryYetkili.FieldByName('YetkiliId').AsInteger;
end;

procedure TfrmIhaleYetkiliDetay.btnKBVazgecClick(Sender: TObject);
begin
  qryYetkili.Cancel;
end;

procedure TfrmIhaleYetkiliDetay.dsYetkiliStateChange(Sender: TObject);
begin
   if qryYetkili.State in [dsInsert, dsEdit] then
   begin
     btnKBKaydet.Enabled := True;
     btnKBVazgec.Enabled := True;
   end
   else
   begin
     btnKBKaydet.Enabled := False;
     btnKBVazgec.Enabled := False;
   end;
end;

procedure TfrmIhaleYetkiliDetay.FormShow(Sender: TObject);
begin
  DMATP.qryFirma.Close;
  DMATP.qryFirma.Open;

  DMATP.qryYetkili.Close;
  DMATP.qryYetkili.Open;

  DMATP.qryUnvanlar.Close;
  DMATP.qryUnvanlar.Open;
end;

procedure TfrmIhaleYetkiliDetay.YetkiliBilgileriGetir(YetkiliId : Integer);
begin
   AktifYetkiliId := YetkiliId;

   qryYetkili.Close;
   qryYetkili.SQL.Text := 'SELECT * FROM Yetkili Where YetkiliId = '  + IntToStr(AktifYetkiliId);
   qryYetkili.Open;

   qryFirmaYetkili.Close;
   qryFirmaYetkili.SQL.Text := 'SELECT * FROM FirmaYetkili WHERE YetkiliId = '  + IntToStr(AktifYetkiliId);
   qryFirmaYetkili.Open;

   if AktifYetkiliId = 0 then
      qryYetkili.Append;

end;

procedure TfrmIhaleYetkiliDetay.btn2Click(Sender: TObject);
begin
  //** Birtakým Kontroller
  qryFirmaYetkili.Delete;
end;

procedure TfrmIhaleYetkiliDetay.btnFirmaYetkiliEkleClick(Sender: TObject);
begin

  if AktifYetkiliId = 0 then
  begin
    ShowMessage('Önce Yetkilinin Kiþisel Bilgilerini Kaydetmelisiniz');
    Abort;
  end;

   Application.CreateForm(TfrmFirmaYetkiliEkle, frmFirmaYetkiliEkle);
   frmFirmaYetkiliEkle.SetYetkiliId(AktifYetkiliId);
   frmFirmaYetkiliEkle.ShowModal;

   qryFirmaYetkili.Close;
   qryFirmaYetkili.SQL.Text := 'SELECT * FROM FirmaYetkili WHERE YetkiliId = '  + IntToStr(AktifYetkiliId);
   qryFirmaYetkili.Open;
end;
end.
