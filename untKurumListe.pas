unit untKurumListe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, DB, cxDBData, ADODB, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  StdCtrls, cxButtons, cxLabel, cxTextEdit, ExtCtrls, frxClass, frxDBSet,
  SUIForm, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, cxSplitter;

type
  TfrmKurumListe = class(TForm)
    dsKurumListe: TDataSource;
    qryKurumListe: TADOQuery;
    suiForm1: TsuiForm;
    grdFirma: TcxGrid;
    grdFirmaDBTV: TcxGridDBTableView;
    grdclmFirmaDBTVKurumId: TcxGridDBColumn;
    grdclmFirmaDBTVKurumKodu: TcxGridDBColumn;
    grdclmFirmaDBTVKurumAdi: TcxGridDBColumn;
    grdclmFirmaDBTVKurumTelefon: TcxGridDBColumn;
    grdclmFirmaDBTVKurumIlKodu: TcxGridDBColumn;
    grdclmFirmaDBTVKurumIlceKodu: TcxGridDBColumn;
    grdclmFirmaDBTVKurumYetkilisi: TcxGridDBColumn;
    grdclmFirmaDBTVKurumAdres: TcxGridDBColumn;
    grdFirmaLV: TcxGridLevel;
    pnl1: TPanel;
    btnYenýFirma: TcxButton;
    btnFirmaDetay: TcxButton;
    txtKurumKodu: TcxTextEdit;
    cxlbl1: TcxLabel;
    cxlbl2: TcxLabel;
    txtKurumAdi: TcxTextEdit;
    cxlbl4: TcxLabel;
    txtKurumYetkili: TcxTextEdit;
    procedure txtFirmaKoduPropertiesChange(Sender: TObject);
    procedure btnYenýFirmaClick(Sender: TObject);
    procedure btnFirmaDetayClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdFirmaDBTVDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmKurumListe: TfrmKurumListe;

implementation

uses DM, untKurumDetay;

{$R *.dfm}

procedure TfrmKurumListe.btnFirmaDetayClick(Sender: TObject);
begin
   if qryKurumListe.RecordCount > 0 then
   begin
     frmKurumDetay := TfrmKurumDetay.Create(nil);
     frmKurumDetay.KurumGetir(qryKurumListe.FieldByName('KurumId').AsInteger);
     frmKurumDetay.ShowModal;
     qryKurumListe.Close;
     qryKurumListe.Open;


   end
   else
     ShowMessage('Listede Hasta Bulunmamaktadýr');
end;

procedure TfrmKurumListe.btnYenýFirmaClick(Sender: TObject);
begin

   Application.CreateForm(TfrmKurumDetay,frmKurumDetay);
   frmKurumDetay.KurumGetir(0);
   frmKurumDetay.ShowModal;
   qryKurumListe.Close;
   qryKurumListe.Open;
end;

procedure TfrmKurumListe.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TfrmKurumListe.FormShow(Sender: TObject);
begin
  txtFirmaKoduPropertiesChange(Sender);
end;

procedure TfrmKurumListe.grdFirmaDBTVDblClick(Sender: TObject);
begin

   if qryKurumListe.RecordCount > 0 then
   begin
     Application.CreateForm(TfrmKurumDetay,frmKurumDetay);
     frmKurumDetay.KurumGetir(qryKurumListe.FieldByName('KurumId').AsInteger);
     frmKurumDetay.ShowModal;
     qryKurumListe.Close;
     qryKurumListe.Open;
   end
   else
     ShowMessage('Listede Hasta Bulunmamaktadýr');

end;

procedure TfrmKurumListe.txtFirmaKoduPropertiesChange(Sender: TObject);
var
 sqlstring : String;
begin

  sqlstring := 'SELECT * FROM Kurum WHERE 1 = 1 ';


  if txtKurumKodu.Text <> '' then
    sqlstring := sqlstring + ' And KurumKodu like ' + QuotedStr(txtKurumKodu.Text +'%' );

  if txtKurumAdi.Text <> '' then
    sqlstring := sqlstring + ' And KurumAdi like ' + QuotedStr(txtKurumAdi.Text + '%');

  if txtKurumYetkili.Text <> '' then
    sqlstring := sqlstring + ' And KurumYetkili like ' + QuotedStr(txtKurumYetkili.Text + '%');

  qryKurumListe.Close;
  qryKurumListe.SQL.Text := sqlstring;
  qryKurumListe.Open;

end;

end.
