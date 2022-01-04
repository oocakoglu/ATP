unit GET;

interface

uses
  Windows, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxLookAndFeelPainters,
  cxGridTableView, DBClient, ExtCtrls, StdCtrls, cxButtons, cxGridLevel,
  cxGridCustomTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, cxContainer, cxProgressBar, jpeg, Controls,
  Classes, Forms, SysUtils,Messages, Dialogs, IdHTTP, TlHelp32,
  cxLookAndFeels, Menus, Nb30, SUIForm;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    cdLIST: TClientDataSet;
    cdLISTKontrol: TBooleanField;
    cdLISTAciklama: TStringField;
    sLIST: TDataSource;
    cxStyleRepository1: TcxStyleRepository;
    GridTableViewStyleSheetWindowsClassic: TcxGridTableViewStyleSheet;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    cxStyle5: TcxStyle;
    cxStyle6: TcxStyle;
    cxStyle7: TcxStyle;
    cxStyle8: TcxStyle;
    cxStyle9: TcxStyle;
    cxStyle10: TcxStyle;
    cxStyle11: TcxStyle;
    cdLISTDosyaAdi: TStringField;
    cdLISTVersiyon: TIntegerField;
    cdLISTBoyut: TIntegerField;
    cdsinfo: TClientDataSet;
    cdsinfoDosyaAdi: TStringField;
    cdsinfoVersiyon: TIntegerField;
    suifrm1: TsuiForm;
    pnl1: TPanel;
    img1: TImage;
    grpPBAR: TGroupBox;
    PBAR: TcxProgressBar;
    grd1: TcxGrid;
    grdTVGrid1DBTableView1: TcxGridDBTableView;
    grdclmTVGrid1DBTableView1ch: TcxGridDBColumn;
    grdclmTVGrid1DBTableView1FileName: TcxGridDBColumn;
    grdclmTVGrid1DBTableView1Info: TcxGridDBColumn;
    grdclmTVGrid1DBTableView1DBColumn1: TcxGridDBColumn;
    grdclmTVGrid1DBTableView1DBColumn2: TcxGridDBColumn;
    grd1Level1: TcxGridLevel;
    btnTAMAM: TcxButton;
    procedure FormShow(Sender: TObject);
    //procedure GetFile(Source:string;Target:string);
    function YeniGetFile(url,name:String):Boolean;
    procedure StartProcess;
    procedure Timer1Timer(Sender: TObject);
    procedure StartLastProcess;
    procedure btnTAMAMClick(Sender: TObject);
    function  GetFileVersion_(const FileName : String) : String;
    function  IndirilecekDosyalariCdsyeYaz() : Boolean;
    function  KontrolDosyalariniCdsyeYaz() : Boolean;
    function  IndirilecekMi(dosyaAdi:String; versiyon:integer) : Boolean;
    function  InfoDosyasiniBitisteDiskeYaz() : Boolean;
    function  InfoDosyasiniBaslangictaDiskeYaz() : Boolean;
    Procedure ProcessKill(DosyaAdi: String);
  private
    { Private declarations }
     FileName:string;
     function getMACadress():string;
     function getAdapterInfo(Lana:AnsiChar): String;
//     procedure URL_OnDownloadProgress(Sender: TDownLoadURL; Progress, ProgressMax: Cardinal;
//         StatusCode: TURLDownloadStatus; StatusText: String; var Cancel: Boolean) ;

  public
    { Public declarations }
  end;

var
  Form1: TForm1;
//  URL : TDownloadURL;
  ProgramPath :string;// C:\source\TEPE\install\program files\TEB\TeBEoS
  URL_ADRES   :string;


implementation

uses ATPService, StrUtils;

{$R *.dfm}

procedure TForm1.Timer1Timer(Sender: TObject);
var
  MacAdres        : string;
  ProgramVersiyon : string;
  KaymakamlikAdi  : string;

  Sonuc : ProgramDurum;

begin
  Timer1.Enabled := False;
  try
    cdLIST.CreateDataSet;
    cdLIST.Open;
    cdsinfo.CreateDataSet;
    cdsinfo.Open;
    //FileName := GetInstallInfo11Soap.GetInstallFileName('');
   ProgramVersiyon := GetFileVersion_(Application.ExeName);
   MacAdres        := getMACadress;
   KaymakamlikAdi  := '';//SabitGetirString('KaymakamlikAdi');

    Sonuc    := GetATPServiceSoap().VersiyonKontrol(MacAdres);
    FileName := Sonuc.IndirmeDosyasi;

    if FileName = EmptyStr then
    begin
      Application.Terminate;
      processKill('GETURL1.exe');
    end;

    StartProcess;
    StartLastProcess;
  except on e:exception do
    begin
      MessageDlg('Güncelleme yapýlamadý...!'+#13+'Lütfen ATP Maliyet Programýný tekrar baþlatýnýz!'+#13+e.Message, mtError, [mbOK], 0);
      //MessageDlg('Güncelleme yapýlamadý...!' +#13+ e.message, mtError, [mbOK], 0);
      processKill('GETURL1.exe');
    end;
  end;

end;

function  TForm1.InfoDosyasiniBaslangictaDiskeYaz() : Boolean;
var
  M:TStringList;
begin

  Result := False;
  cdLIST.First;

  M := TStringList.Create;
  if FileExists(ProgramPath+'INFO.txt') then
    M.LoadFromFile(ProgramPath+'INFO.txt');

  M.Add('INDIRILEN_DOSYA ' + FileName);

  M.SaveToFile(ProgramPath + 'INFO.txt');
  M.Free;
  Result := True;
end;


function  TForm1.InfoDosyasiniBitisteDiskeYaz() : Boolean;
var
  M:TStringList;
  InfoYaz: Boolean;
begin

  Result := False;
  InfoYaz := True;

  if cdLIST.RecordCount = 0 then
    InfoYaz := False;

  cdLIST.First;
  while not cdLIST.Eof do
  begin
    if cdLISTKontrol.AsBoolean = False then
      InfoYaz := False;
    cdLIST.Next;
  end;

  if InfoYaz then
  begin
    M := TStringList.Create;
    cdLIST.First;
    while not cdLIST.Eof do
    begin
      m.Add(cdLISTDosyaAdi.AsString +' '+ cdLISTVersiyon.AsString);
      cdLIST.Next;
    end;

    M.Add('INDIRILEN_DOSYA ' + FileName);
    M.SaveToFile(ProgramPath + 'INFO.txt');
    M.Free;
    Result := True;
  end;
end;

function  TForm1.IndirilecekMi(dosyaAdi:String; versiyon:integer) : Boolean;
begin
  //if copy(dosyaAdi,1,15) = 'TUKETICIISTAKIP' then  //'TUKETICIISTAKIP1006.EXE'
  if copy(dosyaAdi,1,10) = 'ATPMALIYET' then  //'TUKETICIISTAKIP1006.EXE'
    Result := True
  else
  begin
    if cdsinfo.Locate('DosyaAdi', dosyaAdi, []) then
    begin
      if cdsinfoVersiyon.AsInteger = versiyon then
        Result := False
      else
        Result := True;
    end
    else
      Result := True;
  end;
end;

function  TForm1.IndirilecekDosyalariCdsyeYaz() : Boolean;
var
  M     : TStringList;
  str   : String;
  Index : Integer;
  i     : integer;
  DsYa  : String;
begin
  Result := False;

  Application.ProcessMessages;
  //GetFile(URL_ADRES+FileName, ProgramPath+'Download\'+FileName);
  DsYa := URL_ADRES+FileName;
  YeniGetFile(DsYa, ProgramPath+'Download\'+FileName);
  M := TStringList.Create;
  M.LoadFromFile(ProgramPath+'Download\'+FileName);
//    M.LoadFromFile('c:\'+FileName);

  cdLIST.EmptyDataSet;
  for i := 0 to M.Count-1 do
  begin
    if Trim(M.Strings[i]) = '' then
      Continue;

    cdLIST.Append;
    cdLISTKontrol.AsBoolean := False;

    str := UpperCase(M.Strings[i]);
    Index := Pos(' ', str);
    cdLISTDosyaAdi.AsString := Trim(Copy(str, 0 ,Index-1));

    str := Copy(str, Index+1, Length(str));
    Index := Pos(' ', str);
    cdLISTboyut.AsInteger := strtoint(Trim(Copy(str, 0 ,Index-1)));

    str := Copy(str, Index+1, Length(str));
    cdLISTversiyon.AsInteger := strtoint(Trim(Copy(str, 0 ,Length(str))));

    cdLISTAciklama.AsString := EmptyStr;
    cdLIST.Post;
  end;
  M.Free;
  
  //Result := True;
end;

function  TForm1.KontrolDosyalariniCdsyeYaz() : Boolean;
var
  M    :TStringList;
  str  :String;
  Index: Integer;
  i    :integer;
begin
  Result := False;

  Application.ProcessMessages;

  M := TStringList.Create;
  if FileExists(ProgramPath+'INFO.txt') then
    M.LoadFromFile(ProgramPath+'INFO.txt');

  cdsinfo.EmptyDataSet;
  for i := 0 to M.Count-1 do
  begin
    str := UpperCase(M.Strings[i]);
    // sadece INDIRILEN_DOSYA satýrý yoksa iþleme al
    if Pos('INDIRILEN_DOSYA', str) = 0 then
    begin
      cdsinfo.Append;
      Index := Pos(' ', str);
      cdsinfoDosyaAdi.AsString := Trim(Copy(str, 0 ,Index-1));

      str := Copy(str, Index+1, Length(str));
      cdsinfoversiyon.AsInteger := strtoint(Trim(Copy(str, 0 ,Length(str))));
      cdsinfo.Post;
    end;
  end;
  M.Free;
  
  Result := True;
end;

//procedure TForm1.URL_OnDownloadProgress;
//begin
//  PBAR.Properties.Max:= ProgressMax;
//  PBAR.Position:= Progress;
//
//  Application.ProcessMessages;
//end;

function TForm1.YeniGetFile(url,name:String):Boolean;
var
Stream:TMemoryStream;
http:TidHttp;
Adres, isim:string;
begin
Adres := url;
isim := name;
try
   Stream := TMemoryStream.Create;
   http:=TIdHTTP.Create(self);
   HTTP.HandleRedirects := True;
   HTTP.AllowCookies := True;

   //HTTP.Request.UserAgent := 'Mozilla/4.0';
   HTTP.Request.Connection := 'Keep-Alive';
   HTTP.Request.ProxyConnection := 'Keep-Alive';
   //HTTP.Request.Referer := 'http://www.google.com';
   HTTP.Request.CacheControl := 'no-cache';  //this force use no-cache
   HTTP.Get(Url,Stream);

   Stream.SaveToFile(Name);
finally
   Stream.Free;
   http.Free;
end;
end;

//procedure TForm1.GetFile(Source:string;Target:string);
//begin
//  if (FileExists(Target)) then
//  begin
//    if not DeleteFile(Target) then
//      exit;
//  end;
//
//  URL := TDownloadURL.Create(Self);
//  URL.URL := Source;
//  URL.Filename := Target; //'c:\b.rar';
//
//  url.OnDownloadProgress := URL_OnDownloadProgress;
//
//  URL.ExecuteTarget(nil);
//end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ProgramPATH := ExtractFilePath(Application.ExeName);

  URL_ADRES   := 'http://gaziuzaktanegitim.net/Dokuman/';
  btnTamam.Visible := False;
  Timer1.Enabled := True;
end;

procedure TForm1.StartProcess;
var
  i, denemeSayisi :integer;
  dosya :File of byte;
  dsya : string;
begin
  ForceDirectories(ProgramPath+'Download');

  IndirilecekDosyalariCdsyeYaz();
  KontrolDosyalariniCdsyeYaz();
  InfoDosyasiniBaslangictaDiskeYaz();

  PBAR.Properties.Max:= cdLIST.RecordCount;
  PBAR.Position:= 0;

  denemeSayisi := 0;
  cdLIST.First;
  Application.ProcessMessages;
  while not cdLIST.Eof do
  begin

    if denemeSayisi > 1 then
    begin
      denemeSayisi := 0;
      PBAR.Position := PBAR.Position + 1;
      cdLIST.Next;
    end;
    
    cdLIST.Edit;
    cdLISTAciklama.AsString := 'Güncelleniyor...!';
    cdLIST.Post;
    if IndirilecekMi(cdLISTDosyaAdi.AsString, cdLISTVersiyon.AsInteger) then
    begin
      dsya := URL_ADRES + cdLISTDosyaAdi.AsString;
      YeniGetFile(dsya, ProgramPath+'Download\'+cdLISTDosyaAdi.AsString)
    end
    else
    begin
      denemeSayisi := 0;
      cdLIST.Edit;
      cdLISTKontrol.AsBoolean := True;
      cdLISTAciklama.AsString := 'Ýndirildi!';
      cdLIST.Post;
      PBAR.Position := PBAR.Position + 1;
      Application.ProcessMessages;
      cdLIST.Next;
    end;

    if FileExists(ProgramPath+'Download\'+cdLISTDosyaAdi.AsString) then
    begin
      AssignFile(dosya, ProgramPath+'Download\'+cdLISTDosyaAdi.AsString);
      FileMode := 0;
      Reset(dosya);

      //ShowMessage(inttostr(FileSize(dosya)));
      if cdLISTBoyut.AsInteger = FileSize(dosya) then
      begin
        denemeSayisi := 0;
        cdLIST.Edit;
        cdLISTKontrol.AsBoolean := True;
        cdLISTAciklama.AsString := 'Ýndirildi!';
        cdLIST.Post;
        CloseFile(dosya);
        PBAR.Position := PBAR.Position + 1;
        Application.ProcessMessages;
        cdLIST.Next;
      end
      else
      begin
        denemeSayisi := denemeSayisi + 1;
        CloseFile(dosya);
        DeleteFile(ProgramPath+'Download\'+cdLISTDosyaAdi.AsString);
      end;
    end;
  end;

  grpPBAR.Visible := False;
  btnTamam.Visible := True;
end;

procedure TForm1.StartLastProcess;
var
  Source,Target:string;

  sart1 : Boolean;
  sart2 : Boolean;
  sart3 : Boolean;
begin
  processKill('ATP.exe');

  cdLIST.First;
  while not cdLIST.Eof do
  begin
    //inen dosya exe ise (ATP ve geturl deðilse) çalýþýyorsa kapatýlmalý
    source := copy(cdLISTDosyaAdi.AsString,1,10);

    sart1 := False;
    sart2 := False;


    if Pos('.RAR', cdLISTDosyaAdi.AsString) <> 0 then
      sart1 := True;

    if copy(cdLISTDosyaAdi.AsString,1,10) <> 'ATPMALIYET' then
      sart2 := True;


    //if (Pos('.RAR', cdLISTDosyaAdi.AsString) <> 0) AND (copy(cdLISTDosyaAdi.AsString,1,10) <> 'ATPMALIYET') AND (copy(cdLISTDosyaAdi.AsString,1,15) <> 'GETURL') then
    if ((sart1) and (sart2)) then
        processKill(cdLISTDosyaAdi.AsString);

    Application.ProcessMessages;
    if copy(cdLISTDosyaAdi.AsString,1, 10) = 'ATPMALIYET' then
    begin
      processKill('ATP.exe');
      Source := pchar(ProgramPath+'Download\'+ trim(cdLISTDosyaAdi.AsString));

      Target := ProgramPath+'ATP.EXE';
      //programý sil

      if FileExists(Source) then // inen dosya indirilemediyse silmeyelim.
        if FileExists(Target) then
          DeleteFile(Target);

      if CopyFile(pchar(Source), pchar(Target), False) then
        DeleteFile(Source);
    end;
    cdLIST.Next;
  end;
  InfoDosyasiniBitisteDiskeYaz();
end;

Procedure TForm1.ProcessKill(DosyaAdi: String);
Var
  DonguDevam: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
Begin

  try
    FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
    DonguDevam := Process32First(FSnapshotHandle, FProcessEntry32);

    While Integer(DonguDevam)<>0 Do
      Begin
        If ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile))=UpperCase(DosyaAdi)) Or (UpperCase(FProcessEntry32.szExeFile)=UpperCase(DosyaAdi))) Then
        begin
          TerminateProcess(OpenProcess(PROCESS_TERMINATE,BOOL(0),FProcessEntry32.th32ProcessID), 0)
        end;

        DonguDevam:=Process32Next(FSnapshotHandle, FProcessEntry32);
      End;
    CloseHandle(FSnapshotHandle);
  except
  end;

End;

function TForm1.GetFileVersion_(const FileName : String) : String;
var
   VersionInfoSize,
   VersionInfoValueSize,
   Zero             : DWord;
   VersionInfo,
   VersionInfoValue : Pointer;
begin
   Result := EmptyStr;
   { Obtain size of version info structure }
   VersionInfoSize := GetFileVersionInfoSize(PChar(FileName), Zero);
   if VersionInfoSize = 0 then exit;
   { Allocate memory for the version info structure }
   { This could raise an EOutOfMemory exception }
   GetMem(VersionInfo, VersionInfoSize);
   try
      if GetFileVersionInfo(PChar(FileName), 0, VersionInfoSize, VersionInfo) and
         VerQueryValue(VersionInfo, '\' { root block }, VersionInfoValue, VersionInfoValueSize) and
         (0 <> LongInt(VersionInfoValueSize)) then begin
         with TVSFixedFileInfo(VersionInfoValue^) do begin
            Result :=                IntToStr(HiWord(dwFileVersionMS));
            Result := Result + '.' + IntToStr(LoWord(dwFileVersionMS));
            Result := Result + '.' + IntToStr(HiWord(dwFileVersionLS));
            Result := Result + '.' + IntToStr(LoWord(dwFileVersionLS));
         end; { with }
      end; { then }
   finally
      FreeMem(VersionInfo);
   end; { try }
end; { GetFileVersion }

procedure TForm1.btnTAMAMClick(Sender: TObject);
begin
  WinExec('ATP.EXE',SW_SHOWNORMAL);
  Close;
end;

function TForm1.getMACadress():string;
var
   AdapterList: TLanaEnum;
   NCB: TNCB;
begin
   FillChar(NCB, SizeOf(NCB), 0);
   NCB.ncb_command := Char(NCBENUM);
   NCB.ncb_buffer := @AdapterList;
   NCB.ncb_length := SizeOf(AdapterList);
   Netbios(@NCB);
   if Byte(AdapterList.length) > 0 then
     Result := GetAdapterInfo(AdapterList.lana[0])
   else
     Result := EmptyStr;
end;

function TForm1.getAdapterInfo(Lana:AnsiChar): String;
var
 Adapter: TAdapterStatus;
 NCB: TNCB;
begin
   FillChar(NCB, SizeOf(NCB), 0);
   NCB.ncb_command := Char(NCBRESET);
   NCB.ncb_lana_num := Lana;
   if Netbios(@NCB) <> Char(NRC_GOODRET) then
   begin
     Result := 'mac not found';
     Exit;
   end;

   FillChar(NCB, SizeOf(NCB), 0);
   NCB.ncb_command := Char(NCBASTAT);
   NCB.ncb_lana_num := Lana;
   NCB.ncb_callname := '*';

   FillChar(Adapter, SizeOf(Adapter), 0);
   NCB.ncb_buffer := @Adapter;
   NCB.ncb_length := SizeOf(Adapter);
   if Netbios(@NCB) <> Char(NRC_GOODRET) then
   begin
     Result := 'mac not found';
     Exit;
   end;
   Result :=
     IntToHex(Byte(Adapter.adapter_address[0]), 2) + '-' +
     IntToHex(Byte(Adapter.adapter_address[1]), 2) + '-' +
     IntToHex(Byte(Adapter.adapter_address[2]), 2) + '-' +
     IntToHex(Byte(Adapter.adapter_address[3]), 2) + '-' +
     IntToHex(Byte(Adapter.adapter_address[4]), 2) + '-' +
     IntToHex(Byte(Adapter.adapter_address[5]), 2);
end;


end.
