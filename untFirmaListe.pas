unit untFirmaListe;

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
  TfrmFirmaListe = class(TForm)
    dsFirmaListe: TDataSource;
    qryFirmaListe: TADOQuery;
    qryYetkiler: TADOQuery;
    dsYetkiler: TDataSource;
    suiForm1: TsuiForm;
    grdFirmaListe: TcxGrid;
    grdTVFirmaListeTV: TcxGridDBTableView;
    grdclmTVGrid1DBTableView1FirmaId: TcxGridDBColumn;
    grdclmTVGrid1DBTableView1FirmaKodu: TcxGridDBColumn;
    grdclmTVGrid1DBTableView1FirmaAdi: TcxGridDBColumn;
    grdclmTVGrid1DBTableView1FirmaSektor: TcxGridDBColumn;
    grdclmTVGrid1DBTableView1FirmaYetkili: TcxGridDBColumn;
    grdclmTVGrid1DBTableView1FirmaAdres: TcxGridDBColumn;
    grdclmTVGrid1DBTableView1IlAdi: TcxGridDBColumn;
    grdclmTVGrid1DBTableView1FirmaIlKodu: TcxGridDBColumn;
    grdclmTVGrid1DBTableView1FirmaIlceKodu: TcxGridDBColumn;
    grdFirmaListeLV: TcxGridLevel;
    grdYetkiler: TcxGrid;
    grdTVYetkilerTV: TcxGridDBTableView;
    grdclmTVYetkilerTVYetkili: TcxGridDBColumn;
    grdclmTVYetkilerTVUnvanAdi: TcxGridDBColumn;
    grdclmTVYetkilerTVCepTelefonu: TcxGridDBColumn;
    grdYetkilerLV: TcxGridLevel;
    pnl1: TPanel;
    btnFirmaDetay: TcxButton;
    txtFirmaKodu: TcxTextEdit;
    cxlbl1: TcxLabel;
    cxlbl2: TcxLabel;
    txtFirmaAdi: TcxTextEdit;
    txtFirmaSektor: TcxTextEdit;
    cxlbl3: TcxLabel;
    cxlbl4: TcxLabel;
    txtFirmaYetkili: TcxTextEdit;
    spltr1: TcxSplitter;
    procedure txtFirmaKoduPropertiesChange(Sender: TObject);
    procedure btnYenýFirmaClick(Sender: TObject);
    procedure btnFirmaDetayClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdFirmaDBTVDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dsFirmaListeDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFirmaListe: TfrmFirmaListe;

implementation

uses DM, untFirmaDetay;

{$R *.dfm}

procedure TfrmFirmaListe.btnFirmaDetayClick(Sender: TObject);
begin
   if qryFirmaListe.RecordCount > 0 then
   begin
     frmFirmaDetay := TfrmFirmaDetay.Create(nil);
     frmFirmaDetay.FirmaGetir(qryFirmaListe.FieldByName('FirmaId').AsInteger);
     frmFirmaDetay.ShowModal;
     qryFirmaListe.Close;
     qryFirmaListe.Open;


   end
   else
     ShowMessage('Listede Hasta Bulunmamaktadýr');
end;

procedure TfrmFirmaListe.btnYenýFirmaClick(Sender: TObject);
begin

   Application.CreateForm(TfrmFirmaDetay,frmFirmaDetay);
   frmFirmaDetay.FirmaGetir(0);
   frmFirmaDetay.ShowModal;
   qryFirmaListe.Close;
   qryFirmaListe.Open;
end;

procedure TfrmFirmaListe.dsFirmaListeDataChange(Sender: TObject; Field: TField);
begin

  if qryFirmaListe.FieldByName('FirmaId').AsInteger > 0 then
  begin
    qryYetkiler.Close;
    qryYetkiler.SQL.Text := 'SELECT Y.YetkiliAdi + '' '' + Y.YetkiliSoyadi as Yetkili, '
                           +'U.UnvanAdi, Y.CepTelefonu  FROM FirmaYetkili FY '
                           +'LEFT JOIN Yetkili Y ON FY.YetkiliId = Y.YetkiliId  '
                           +'LEFT JOIN Unvan U ON FY.UnvanId = U.UnvanId '
                           +'WHERE FY.FirmaId = ' + IntToStr(qryFirmaListe.FieldByName('FirmaId').AsInteger);
    qryYetkiler.Open;
  end;

end;

procedure TfrmFirmaListe.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

procedure TfrmFirmaListe.FormShow(Sender: TObject);
begin
  txtFirmaKoduPropertiesChange(Sender);
end;

procedure TfrmFirmaListe.grdFirmaDBTVDblClick(Sender: TObject);
begin

   if qryFirmaListe.RecordCount > 0 then
   begin
     Application.CreateForm(TfrmFirmaDetay,frmFirmaDetay);
     frmFirmaDetay.FirmaGetir(qryFirmaListe.FieldByName('FirmaId').AsInteger);
     frmFirmaDetay.ShowModal;
     qryFirmaListe.Close;
     qryFirmaListe.Open;
   end
   else
     ShowMessage('Listede Hasta Bulunmamaktadýr');

end;

procedure TfrmFirmaListe.txtFirmaKoduPropertiesChange(Sender: TObject);
var
 sqlstring : String;
begin

  sqlstring := 'SELECT F.*, I.IlAdi FROM Firma F '
              +'LEFT JOIN Il I ON F.FirmaIlKodu = I.IlKodu '
              +'WHERE 1 = 1 ';


  if txtFirmaKodu.Text <> '' then
    sqlstring := sqlstring + ' And F.FirmaKodu like ' + QuotedStr(txtFirmaKodu.Text +'%' );

  if txtFirmaAdi.Text <> '' then
    sqlstring := sqlstring + ' And F.FirmaAdi like ' + QuotedStr(txtFirmaAdi.Text + '%');

  if txtFirmaSektor.Text <> '' then
    sqlstring := sqlstring + ' And F.FirmaSektor like ' + QuotedStr(txtFirmaSektor.Text + '%');

  if txtFirmaYetkili.Text <> '' then
    sqlstring := sqlstring + ' And F.Telefon like ' + QuotedStr(txtFirmaYetkili.Text + '%');

  qryFirmaListe.Close;
  qryFirmaListe.SQL.Text := sqlstring;
  qryFirmaListe.Open;

end;

end.
