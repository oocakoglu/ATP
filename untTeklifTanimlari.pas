unit untTeklifTanimlari;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxPC,
  ExtCtrls, SUIForm, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, Menus, StdCtrls, cxButtons, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, ADODB, cxGridLevel, cxClasses,
  cxGridCustomView, cxGrid, cxCurrencyEdit;

type
  TfrmTeklifTanimlari = class(TForm)
    suifrmTeklifTanimlari: TsuiForm;
    pageTeklifTanimlari: TcxPageControl;
    tsOnDegerler: TcxTabSheet;
    tsExtralar: TcxTabSheet;
    Panel1: TPanel;
    grdOnDegerlerTV: TcxGridDBTableView;
    grdOnDegerlerLV: TcxGridLevel;
    grdOnDegerler: TcxGrid;
    qryOnDegerler: TADOQuery;
    dsOnDegerler: TDataSource;
    grdOnDegerlerTVSabitId: TcxGridDBColumn;
    grdOnDegerlerTVSabitTuru: TcxGridDBColumn;
    grdOnDegerlerTVSabitAdi: TcxGridDBColumn;
    grdOnDegerlerTVSabitDeger: TcxGridDBColumn;
    btnOnDegerEkle: TcxButton;
    btnOnDegerKaydet: TcxButton;
    btnOnDegerSil: TcxButton;
    btnOnDegerVazgec: TcxButton;
    Panel2: TPanel;
    btnExtraEkle: TcxButton;
    btnExtraKaydet: TcxButton;
    btnExtraSil: TcxButton;
    btnExtraVazgec: TcxButton;
    grdExtralar: TcxGrid;
    grdExtralarTV: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    grdExtralarLV: TcxGridLevel;
    qryExtralar: TADOQuery;
    dsExtralar: TDataSource;
    procedure btnOnDegerEkleClick(Sender: TObject);
    procedure btnOnDegerSilClick(Sender: TObject);
    procedure btnOnDegerKaydetClick(Sender: TObject);
    procedure btnOnDegerVazgecClick(Sender: TObject);
    procedure dsOnDegerlerStateChange(Sender: TObject);
    procedure qryOnDegerlerBeforePost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExtraEkleClick(Sender: TObject);
    procedure btnExtraSilClick(Sender: TObject);
    procedure btnExtraKaydetClick(Sender: TObject);
    procedure btnExtraVazgecClick(Sender: TObject);
    procedure dsExtralarStateChange(Sender: TObject);
    procedure qryExtralarBeforePost(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTeklifTanimlari: TfrmTeklifTanimlari;

implementation

uses DM;

{$R *.dfm}


{$REGION 'Form Events'}
procedure TfrmTeklifTanimlari.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmTeklifTanimlari.FormShow(Sender: TObject);
begin
  qryOnDegerler.Close;
  qryOnDegerler.Open;

  qryExtralar.Close;
  qryExtralar.Open;
end;

{$ENDREGION}


{$REGION 'On Deger Butonlar'}
procedure TfrmTeklifTanimlari.btnOnDegerEkleClick(Sender: TObject);
begin
 qryOnDegerler.Append;
end;

procedure TfrmTeklifTanimlari.btnOnDegerKaydetClick(Sender: TObject);
begin
 qryOnDegerler.Post;
end;

procedure TfrmTeklifTanimlari.btnOnDegerSilClick(Sender: TObject);
begin
 qryOnDegerler.Delete;
end;

procedure TfrmTeklifTanimlari.btnOnDegerVazgecClick(Sender: TObject);
begin
 qryOnDegerler.Cancel;
end;

procedure TfrmTeklifTanimlari.dsOnDegerlerStateChange(Sender: TObject);
begin
   if qryOnDegerler.State in [dsInsert, dsEdit] then
   begin
     btnOnDegerEkle.Enabled   := False;
     btnOnDegerSil.Enabled    := False;
     btnOnDegerKaydet.Enabled := True;
     btnOnDegerVazgec.Enabled := True;
   end
   else
   begin
     btnOnDegerEkle.Enabled   := True;
     btnOnDegerSil.Enabled    := True;
     btnOnDegerKaydet.Enabled := False;
     btnOnDegerVazgec.Enabled := False;
   end;
end;

procedure TfrmTeklifTanimlari.qryOnDegerlerBeforePost(DataSet: TDataSet);
begin
  if qryOnDegerler.FieldByName('SabitAdi').AsString = '' then
  begin
    ShowMessage('Ön deger adý girilmesi zorunludur');
    Abort;
  end;
  qryOnDegerler.FieldByName('SabitTuru').AsString := 'OnDegerler';
end;

{$ENDREGION}

{$REGION 'Extralar'}
procedure TfrmTeklifTanimlari.btnExtraEkleClick(Sender: TObject);
begin
  qryExtralar.Append;
end;

procedure TfrmTeklifTanimlari.btnExtraKaydetClick(Sender: TObject);
begin
  qryExtralar.Post;
end;

procedure TfrmTeklifTanimlari.btnExtraSilClick(Sender: TObject);
begin
  qryExtralar.Delete;
end;

procedure TfrmTeklifTanimlari.btnExtraVazgecClick(Sender: TObject);
begin
  qryExtralar.Cancel;
end;

procedure TfrmTeklifTanimlari.dsExtralarStateChange(Sender: TObject);
begin
   if qryExtralar.State in [dsInsert, dsEdit] then
   begin
     btnExtraEkle.Enabled   := False;
     btnExtraSil.Enabled    := False;
     btnExtraKaydet.Enabled := True;
     btnExtraVazgec.Enabled := True;
   end
   else
   begin
     btnExtraEkle.Enabled   := True;
     btnExtraSil.Enabled    := True;
     btnExtraKaydet.Enabled := False;
     btnExtraVazgec.Enabled := False;
   end;
end;

procedure TfrmTeklifTanimlari.qryExtralarBeforePost(DataSet: TDataSet);
begin
  if qryExtralar.FieldByName('SabitAdi').AsString = '' then
  begin
    ShowMessage('Extra adý girilmesi zorunludur');
    Abort;
  end;
  qryExtralar.FieldByName('SabitTuru').AsString := 'Extralar';
end;

{$ENDREGION}

end.
