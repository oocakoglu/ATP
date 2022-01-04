unit untIhaleYetkiliListe;

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
  TfrmIhaleYetkiliListe = class(TForm)
    dsIhaleYetkiliListe: TDataSource;
    qryYetkiliListe: TADOQuery;
    qryFirmaYetkili: TADOQuery;
    dsFirmaYetkili: TDataSource;
    suiForm1: TsuiForm;
    grdFirma: TcxGrid;
    grdFirmaDBTV: TcxGridDBTableView;
    grdclmFirmaDBTVFirmaAdi: TcxGridDBColumn;
    grdclmFirmaDBTVFirmaSektor: TcxGridDBColumn;
    grdclmFirmaDBTVUnvanAdi: TcxGridDBColumn;
    grdFirmaLV: TcxGridLevel;
    grdYetkililer: TcxGrid;
    grdTVYetkililerTV: TcxGridDBTableView;
    grdclmTVYetkililerTVYetkiliId: TcxGridDBColumn;
    grdclmTVYetkililerTVYetkiliAdi: TcxGridDBColumn;
    grdclmTVYetkililerTVYetkiliSoyadi: TcxGridDBColumn;
    grdclmTVYetkililerTVCepTelefonu: TcxGridDBColumn;
    grdclmTVYetkililerTVEvTelefonu: TcxGridDBColumn;
    grdclmTVYetkililerTVEmail: TcxGridDBColumn;
    grdclmTVYetkililerTVAdres: TcxGridDBColumn;
    grdclmTVYetkililerTVTipi: TcxGridDBColumn;
    grdYetkililerLV: TcxGridLevel;
    pnl1: TPanel;
    btnYeniYetkili: TcxButton;
    btnYetkiliDetay: TcxButton;
    txtYetkiliAdi: TcxTextEdit;
    cxlbl1: TcxLabel;
    cxlbl2: TcxLabel;
    txtYetkiliSoyadi: TcxTextEdit;
    rptAdres: TfrxReport;
    rptdsFirmaListe: TfrxDBDataset;
    spltr1: TcxSplitter;
    procedure btnYeniYetkiliClick(Sender: TObject);
    procedure btnYetkiliDetayClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAdresBasClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtYetkiliAdiPropertiesChange(Sender: TObject);
    procedure dsIhaleYetkiliListeDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmIhaleYetkiliListe: TfrmIhaleYetkiliListe;

implementation

uses DM, untFirmaDetay, untIhaleYetkiliDetay;

{$R *.dfm}

procedure TfrmIhaleYetkiliListe.btnAdresBasClick(Sender: TObject);
begin
  rptAdres.ShowReport();
end;

procedure TfrmIhaleYetkiliListe.btnYetkiliDetayClick(Sender: TObject);
begin
   if qryYetkiliListe.RecordCount > 0 then
   begin
     Application.CreateForm(TfrmIhaleYetkiliDetay, frmIhaleYetkiliDetay);
     frmIhaleYetkiliDetay.YetkiliBilgileriGetir(qryYetkiliListe.FieldByName('YetkiliId').AsInteger);
     frmIhaleYetkiliDetay.ShowModal;
     qryYetkiliListe.Close;
     qryYetkiliListe.Open;
   end
   else
     ShowMessage('Listede Hasta Bulunmamaktadýr');
end;

procedure TfrmIhaleYetkiliListe.dsIhaleYetkiliListeDataChange(Sender: TObject;
  Field: TField);
begin

  if qryYetkiliListe.FieldByName('YetkiliId').AsInteger > 0 then
  begin
    qryFirmaYetkili.Close;
    qryFirmaYetkili.SQL.Text := 'SELECT F.FirmaAdi, F.FirmaSektor, U.UnvanAdi  FROM FirmaYetkili FY '
                              + 'LEFT JOIN Firma F ON FY.FirmaId = F.FirmaId '
                              + 'LEFT JOIN Unvan U ON FY.UnvanId = U.UnvanId '
                              + 'WHERE FY.YetkiliId = ' + IntToStr(qryYetkiliListe.FieldByName('YetkiliId').AsInteger);
    qryFirmaYetkili.Open;
  end;
end;

procedure TfrmIhaleYetkiliListe.btnYeniYetkiliClick(Sender: TObject);
begin

   Application.CreateForm(TfrmIhaleYetkiliDetay, frmIhaleYetkiliDetay);
   frmIhaleYetkiliDetay.YetkiliBilgileriGetir(0);
   frmIhaleYetkiliDetay.ShowModal;
   qryYetkiliListe.Close;
   qryYetkiliListe.Open;
end;

procedure TfrmIhaleYetkiliListe.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TfrmIhaleYetkiliListe.FormShow(Sender: TObject);
begin
  txtYetkiliAdiPropertiesChange(Sender);
end;

procedure TfrmIhaleYetkiliListe.txtYetkiliAdiPropertiesChange(Sender: TObject);
var
 sqlstring : String;
begin

  sqlstring := 'SELECT * FROM Yetkili WHERE 1 = 1 ';


  if txtYetkiliAdi.Text <> '' then
    sqlstring := sqlstring + ' And YetkiliAdi like ' + QuotedStr(txtYetkiliAdi.Text +'%' );

  if txtYetkiliSoyadi.Text <> '' then
    sqlstring := sqlstring + ' And YetkiliSoyadi like ' + QuotedStr(txtYetkiliSoyadi.Text + '%');

  qryYetkiliListe.Close;
  qryYetkiliListe.SQL.Text := sqlstring;
  qryYetkiliListe.Open;

end;

end.
