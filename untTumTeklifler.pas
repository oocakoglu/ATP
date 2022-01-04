unit untTumTeklifler;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, SUIForm, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxContainer, cxLabel, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, ADODB, cxGridLevel, cxClasses,
  cxGridCustomView, cxGrid;

type
  TfrmTumTeklifler = class(TForm)
    sufrmTumTeklifler: TsuiForm;
    Panel1: TPanel;
    grdTeklifListesiTV: TcxGridDBTableView;
    grdTeklifListesiLV: TcxGridLevel;
    grdTeklifListesi: TcxGrid;
    qryTeklif: TADOQuery;
    dsTeklif: TDataSource;
    grdTeklifListesiTVTeklifId: TcxGridDBColumn;
    grdTeklifListesiTVIsinAdi: TcxGridDBColumn;
    grdTeklifListesiTVKurumAdi: TcxGridDBColumn;
    grdTeklifListesiTVIhaleTarihi: TcxGridDBColumn;
    grdTeklifListesiTVIhaleKayitNo: TcxGridDBColumn;
    Panel2: TPanel;
    dteBasTar: TcxDateEdit;
    dteBitTar: TcxDateEdit;
    txtKurumAdi: TcxTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    btnYeniTeklif: TButton;
    btnTeklifDetay: TButton;
    btnSorgula: TButton;
    procedure Button1Click(Sender: TObject);
    procedure btnTeklifDetayClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSorgulaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTumTeklifler: TfrmTumTeklifler;

implementation

uses DM, untTeklifDetay;

{$R *.dfm}

procedure TfrmTumTeklifler.btnSorgulaClick(Sender: TObject);
var
 SqlText     : string;
 yil1,ay1,gun1 : word;
 yil2,ay2,gun2 : word;

begin

   SqlText := 'SELECT * FROM Teklif WHERE 1 = 1 ';

   //** Baþlangýç Tarihi
   if dteBasTar.Text <> '' then
   begin
     DecodeDate(dteBasTar.Date, yil1, ay1, gun1);
     SqlText := SqlText + ' AND IhaleTarihi >= CONVERT(DATETIME, '''+inttostr(yil1)+'-'+inttostr(ay1)+'-'+inttostr(gun1) +' 00:00:00'', 102) ';
   end;

    //** Bitiþ Tarihi
   if dteBitTar.Text <> '' then
   begin
      DecodeDate(dteBitTar.Date, yil2, ay2, gun2);
      SqlText := SqlText + ' AND IhaleTarihi <= CONVERT(DATETIME, '''+inttostr(yil2)+'-'+inttostr(ay2)+'-'+inttostr(gun2) +' 23:59:59'', 102) ';
   end;

   if txtKurumAdi.Text <> '' then
   begin
      SqlText := SqlText + ' AND KurumAdi like ' + QuotedStr('%' + txtKurumAdi.Text + '%');
   end;

   qryTeklif.Close;
   qryTeklif.SQL.Text := SqlText;
   qryTeklif.Open;

end;

procedure TfrmTumTeklifler.btnTeklifDetayClick(Sender: TObject);
begin
   Application.CreateForm(TfrmTeklifDetay,frmTeklifDetay);
   frmTeklifDetay.GetTeklifBilgileri(qryTeklif.FieldByName('TeklifId').AsInteger);
   frmTeklifDetay.show
end;

procedure TfrmTumTeklifler.Button1Click(Sender: TObject);
begin
   Application.CreateForm(TfrmTeklifDetay,frmTeklifDetay);
   frmTeklifDetay.show;
end;

procedure TfrmTumTeklifler.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmTumTeklifler.FormShow(Sender: TObject);
begin

  dteBasTar.Date := Date;
  dteBitTar.Date := Date + 30;

  qryTeklif.Close;
  qryTeklif.Open;

end;

end.
