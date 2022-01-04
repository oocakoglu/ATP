unit untFirmaDetay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, DB, ADODB, cxMemo, cxDBEdit, cxTextEdit, cxLabel, Menus,
  StdCtrls, cxButtons, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, ExtCtrls, SUIForm, Grids, DBGrids;

type
  TfrmFirmaDetay = class(TForm)
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    txtFirmaKodu: TcxDBTextEdit;
    txtFirmaAdi: TcxDBTextEdit;
    txtFirmaYetkili: TcxDBTextEdit;
    txtAdres: TcxDBMemo;
    qryFirma: TADOQuery;
    dsFirma: TDataSource;
    btnEkle: TcxButton;
    btnSil: TcxButton;
    btnKaydet: TcxButton;
    btnVazgeç: TcxButton;
    cxLabel5: TcxLabel;
    txtFirmaSektor: TcxDBTextEdit;
    cxLabel6: TcxLabel;
    lkpIlAdi: TcxDBLookupComboBox;
    cxLabel7: TcxLabel;
    lkpIlce: TcxDBLookupComboBox;
    qryIlceKodu: TADOQuery;
    dsIlceKodu: TDataSource;
    suifrm1: TsuiForm;
    procedure dsFirmaStateChange(Sender: TObject);
    procedure btnEkleClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnVazgeçClick(Sender: TObject);
    procedure lkpIlAdiPropertiesEditValueChanged(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure FirmaGetir(FirmaId : Integer);
  end;

var
  frmFirmaDetay: TfrmFirmaDetay;

implementation

uses DM;

{$R *.dfm}

procedure TfrmFirmaDetay.btnEkleClick(Sender: TObject);
begin
  qryFirma.Append;
end;

procedure TfrmFirmaDetay.btnKaydetClick(Sender: TObject);
begin
  qryfirma.Post;
end;

procedure TfrmFirmaDetay.btnSilClick(Sender: TObject);
begin
  qryFirma.Delete;
end;

procedure TfrmFirmaDetay.btnVazgeçClick(Sender: TObject);
begin
  qryfirma.Cancel;
end;

procedure TfrmFirmaDetay.dsFirmaStateChange(Sender: TObject);
begin

   if qryFirma.State in [dsInsert, dsEdit] then
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

procedure TfrmFirmaDetay.FirmaGetir(FirmaId : Integer);
begin

 qryFirma.Close;
 qryFirma.SQL.Text := 'Select * From Firma Where FirmaId = '  + IntToStr(FirmaId);
 qryFirma.Open;

 if FirmaId = 0 then
   qryFirma.Append;

end;

procedure TfrmFirmaDetay.lkpIlAdiPropertiesEditValueChanged(Sender: TObject);
begin

  if lkpIlAdi.EditValue > 0 then
  begin
    qryIlceKodu.Close;
    qryIlceKodu.SQL.Text := 'Select * From Ilce Where IlKodu = ' + IntToStr(lkpIlAdi.EditValue);
    qryIlceKodu.Open;
  end;

end;

end.
