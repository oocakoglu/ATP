unit untDovizKurlari;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  xmldom, XMLIntf, msxmldom, XMLDoc, StdCtrls, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, ExtCtrls, ADODB, StrUtils, cxCheckBox, cxCurrencyEdit;

type
  TfrmDovizKurlari = class(TForm)
    pnl1: TPanel;
    btnGuncelle: TButton;
    grdDovizKurlari: TcxGrid;
    grdTVDovizKurlariTV: TcxGridDBTableView;
    grdDovizKurlariLV: TcxGridLevel;
    qryDovizKurlari: TADOQuery;
    dsDovizKurlari: TDataSource;
    grdclmTVDovizKurlariTVDovizId: TcxGridDBColumn;
    grdclmTVDovizKurlariTVIsim: TcxGridDBColumn;
    grdclmTVDovizKurlariTVForexBuying: TcxGridDBColumn;
    grdclmTVDovizKurlariTVForexSelling: TcxGridDBColumn;
    grdclmTVDovizKurlariTVBanknoteBuying: TcxGridDBColumn;
    grdclmTVDovizKurlariTVBanknoteSelling: TcxGridDBColumn;
    grdclmTVDovizKurlariTVCrossRateEuro: TcxGridDBColumn;
    grdclmTVDovizKurlariTVAktif: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDovizKurlari: TfrmDovizKurlari;

implementation

uses DM;

{$R *.dfm}

procedure TfrmDovizKurlari.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmDovizKurlari.FormShow(Sender: TObject);
begin

  qryDovizKurlari.Close;
  qryDovizKurlari.Open;

end;

end.
