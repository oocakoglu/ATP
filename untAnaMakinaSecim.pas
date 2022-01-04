unit untAnaMakinaSecim;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, StdCtrls, cxButtons, cxTextEdit, cxListBox,
  cxLabel, ADODB, StrUtils, DB, Inifiles, ExtCtrls, SUIForm;

type
  TfrmAnaMakinaSecim = class(TForm)
    lblBilgisayarAdi: TcxLabel;
    lstServer: TcxListBox;
    txtSunucuAdi: TcxTextEdit;
    btnServerAra: TcxButton;
    btnTest: TcxButton;
    btnServerOnay: TcxButton;
    con1: TADOConnection;
    suifrm1: TsuiForm;
    procedure btnServerAraClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure btnServerOnayClick(Sender: TObject);
    procedure lstServerClick(Sender: TObject);
    procedure lstServerKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAnaMakinaSecim: TfrmAnaMakinaSecim;

implementation

{$R *.dfm}
uses ActiveX, ComObj, AdoInt, OleDB, untNETInfo, DM;

procedure ListAvailableSQLServers(Names : TStrings);
var
  RSCon: ADORecordsetConstruction;
  Rowset: IRowset;
  SourcesRowset: ISourcesRowset;
  SourcesRecordset: _Recordset;
  SourcesName, SourcesType: TField;

  MakinaAdi : string;
  SunucuAdi : string;

    function PtCreateADOObject(const ClassID: TGUID): IUnknown;
    var
      Status: HResult;
      FPUControlWord: Word;
    begin
      asm
        FNSTCW FPUControlWord
      end;
      Status := CoCreateInstance(
                  CLASS_Recordset,
                  nil,
                  CLSCTX_INPROC_SERVER or CLSCTX_LOCAL_SERVER,
                  IUnknown,
                  Result);
      asm
        FNCLEX
        FLDCW FPUControlWord
      end;
      OleCheck(Status);
    end;
begin

  MakinaAdi := BilgisayarAdiGetir();
  SourcesRecordset := PtCreateADOObject(CLASS_Recordset) as _Recordset;
  RSCon := SourcesRecordset as ADORecordsetConstruction;
  SourcesRowset := CreateComObject(ProgIDToClassID('SQLOLEDB Enumerator')) as ISourcesRowset;
  OleCheck(SourcesRowset.GetSourcesRowset(nil, IRowset, 0, nil, IUnknown(Rowset)));
  RSCon.Rowset := RowSet;
  with TADODataSet.Create(nil) do
  try
    Recordset := SourcesRecordset;
    SourcesName := FieldByName('SOURCES_NAME'); { do not localize }
    SourcesType := FieldByName('SOURCES_TYPE'); { do not localize }
    Names.BeginUpdate;
    try
      while not EOF do
      begin
        if (SourcesType.AsInteger = DBSOURCETYPE_DATASOURCE) and (SourcesName.AsString <> '') then
        begin

          if Pos('ATP', SourcesName.AsString) <> 0 then
          begin
            SunucuAdi := ReplaceStr(SourcesName.AsString, '\ATP2014', '');

            if SunucuAdi <> MakinaAdi then
                Names.Add( SunucuAdi );

            //if Pos('veya', Ayaktan) <> 0 then
          end;
        end;
        Next;
      end;
    finally
      Names.EndUpdate;
    end;
  finally
    Free;
  end;
end;


procedure TfrmAnaMakinaSecim.btnServerOnayClick(Sender: TObject);
var
  IniDosya      : TiniFile;
  SunucuAdi     : string;
begin

  SunucuAdi := txtSunucuAdi.Text;
  if SunucuAdi = '' then
  begin
     ShowMessage('Lütfen geçerli bir veritabaný baðlantýsý belirtin');
     exit;
  end;

  if DMATP.DatabaseBaglan(SunucuAdi) then
  begin
    ShowMessage(SunucuAdi + ' makinasý baþarýlý bir þekilde ana makina seçildi');
    IniDosya := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'ACILIS.INI');
    IniDosya.WriteString('BAGLANTI_STRINGI', 'SERVER', SunucuAdi);
    IniDosya.Free;

    close;
  end
  else
  begin
    ShowMessage(SunucuAdi + ' makinasýna baðlanýlamýyor');
  end;

end;

procedure TfrmAnaMakinaSecim.btnServerAraClick(Sender: TObject);
begin
  lstServer.Items.Clear;
  ListAvailableSQLServers(lstServer.Items);
end;

procedure TfrmAnaMakinaSecim.btnTestClick(Sender: TObject);
var
  InstanceName : string;
  ConString    : string;
begin

   try
     InstanceName := 'ATP2014';
     ConString    := 'Provider=SQLOLEDB.1;'
                     +'Password=111222333;'
                     +'Persist Security Info=True;'
                     +'User ID=sa;'
                     +'Initial Catalog=ATP;'
                     +'Data Source='+ Trim(txtSunucuAdi.Text) + '\' + InstanceName;

     con1.Close;
     con1.ConnectionString := ConString;
     con1.Open;
     ShowMessage(txtSunucuAdi.Text + ' makinasýna baþarýyla baðlandý');
   except
     ShowMessage(txtSunucuAdi.Text + ' makinasýna baðlanýlamýyor.');
   end;

end;


procedure TfrmAnaMakinaSecim.lstServerClick(Sender: TObject);
begin
  txtSunucuAdi.Text := lstServer.Items[lstServer.ItemIndex];
end;

procedure TfrmAnaMakinaSecim.lstServerKeyPress(Sender: TObject; var Key: Char);
begin
  txtSunucuAdi.Text := lstServer.Items[lstServer.ItemIndex];
end;

end.
