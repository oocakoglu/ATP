unit untKurumDetay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, DB, ADODB, cxMemo, cxDBEdit, cxTextEdit, cxLabel, Menus,
  StdCtrls, cxButtons, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, ExtCtrls, SUIForm, Grids, DBGrids;

type
  TfrmKurumDetay = class(TForm)
    qryKurum: TADOQuery;
    dsKurum: TDataSource;
    qryIlceKodu: TADOQuery;
    dsIlceKodu: TDataSource;
    suiForm1: TsuiForm;
    cxlbl1: TcxLabel;
    cxlbl2: TcxLabel;
    cxlbl3: TcxLabel;
    cxlbl4: TcxLabel;
    cxlbl6: TcxLabel;
    cxlbl7: TcxLabel;
    lkpIlAdi: TcxDBLookupComboBox;
    lkpIlce: TcxDBLookupComboBox;
    txtAdres: TcxDBMemo;
    txtFirmaAdi: TcxDBTextEdit;
    txtFirmaKodu: TcxDBTextEdit;
    txtFirmaYetkili: TcxDBTextEdit;
    pnl1: TPanel;
    btnEkle: TcxButton;
    btnKaydet: TcxButton;
    btnSil: TcxButton;
    btnVazgeç: TcxButton;
    cxDBMaskEdit2: TcxDBMaskEdit;
    cxlbl5: TcxLabel;
    procedure dsKurumStateChange(Sender: TObject);
    procedure btnEkleClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnVazgeçClick(Sender: TObject);
    procedure lkpIlAdiPropertiesEditValueChanged(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure KurumGetir(KurumId : Integer);
  end;

var
  frmKurumDetay: TfrmKurumDetay;

implementation

uses DM;

{$R *.dfm}

procedure TfrmKurumDetay.btnEkleClick(Sender: TObject);
begin
  qryKurum.Append;
end;

procedure TfrmKurumDetay.btnKaydetClick(Sender: TObject);
begin
  qryKurum.Post;
end;

procedure TfrmKurumDetay.btnSilClick(Sender: TObject);
begin
  qryKurum.Delete;
end;

procedure TfrmKurumDetay.btnVazgeçClick(Sender: TObject);
begin
  qryKurum.Cancel;
end;

procedure TfrmKurumDetay.dsKurumStateChange(Sender: TObject);
begin

   if qryKurum.State in [dsInsert, dsEdit] then
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

procedure TfrmKurumDetay.KurumGetir(KurumId : Integer);
begin

 qryKurum.Close;
 qryKurum.SQL.Text := 'Select * From Kurum Where KurumId = '  + IntToStr(KurumId);
 qryKurum.Open;

 if KurumId = 0 then
   qryKurum.Append;

end;

procedure TfrmKurumDetay.lkpIlAdiPropertiesEditValueChanged(Sender: TObject);
begin

  if lkpIlAdi.EditValue > 0 then
  begin
    qryIlceKodu.Close;
    qryIlceKodu.SQL.Text := 'Select * From Ilce Where IlKodu = ' + IntToStr(lkpIlAdi.EditValue);
    qryIlceKodu.Open;
  end;

end;

end.
