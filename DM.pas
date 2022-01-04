unit DM;

interface

uses
  SysUtils, Classes, DB, ADODB, cxClasses, cxStyles, cxGridTableView, cxEdit,
  cxEditRepositoryItems, cxDBEditRepository, Forms, Dialogs, IniFiles, IdHTTP,
  Windows, Nb30, Controls, SUIMgr, Registry, frxClass, frxDBSet, xmldom,
  XMLIntf, msxmldom, XMLDoc, StrUtils;

type
  TYetkiTipi = (tpEkleme = 1, tpSilme = 2, tpDegistirme = 3, tpGorme = 4, tpkontrol = 5);
  TYetkiGrup = (tpgrpTeklifler = 1, tpgrpRaporlar= 2, tpgrpTanimKartlari = 3,  tpgrpSistemYonetimi = 5);

type
  TDMATP = class(TDataModule)
    ADOConnection: TADOConnection;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    cxStyle5: TcxStyle;
    StyleAdet1: TcxStyle;
    StyleAdet2: TcxStyle;
    styleTutar1: TcxStyle;
    styleTutar2: TcxStyle;
    GriTema: TcxGridTableViewStyleSheet;
    cxEditRepository1: TcxEditRepository;
    conADOCon_Attach: TADOConnection;
    sflthm1: TsuiFileTheme;
    qryIl: TADOQuery;
    dsIl: TDataSource;
    rpstyIller: TcxEditRepositoryLookupComboBoxItem;
    qryFirma: TADOQuery;
    dsFirma: TDataSource;
    rpstyFirmalar: TcxEditRepositoryLookupComboBoxItem;
    qryYetkili: TADOQuery;
    dsYetkili: TDataSource;
    rpstyYetkililer: TcxEditRepositoryLookupComboBoxItem;
    qryUnvanlar: TADOQuery;
    dsUnvanlar: TDataSource;
    rpstyUnvanlar: TcxEditRepositoryLookupComboBoxItem;
    qryKurum: TADOQuery;
    dsKurum: TDataSource;
    rpstyKurumlar: TcxEditRepositoryLookupComboBoxItem;
    XMLDocument1: TXMLDocument;
    qryKurlar: TADOQuery;
    dsKurlar: TDataSource;
    rpstyKurlar: TcxEditRepositoryLookupComboBoxItem;
    styleKurFiyat: TcxStyle;
    styleTLFiyat: TcxStyle;
    styleKarFiyat: TcxStyle;
    styleSatisFiyat: TcxStyle;
    DevExpressTema: TcxGridTableViewStyleSheet;
    cxStyle6: TcxStyle;
    cxStyle7: TcxStyle;
    cxStyle8: TcxStyle;
    cxStyle9: TcxStyle;
    cxStyle10: TcxStyle;
    cxStyle11: TcxStyle;
    cxStyle12: TcxStyle;
    cxStyle13: TcxStyle;
    cxStyle14: TcxStyle;
    cxStyle15: TcxStyle;
    cxStyle16: TcxStyle;
    cxStyle17: TcxStyle;
    cxStyle18: TcxStyle;
    cxStyle19: TcxStyle;
    procedure DataModuleCreate(Sender: TObject);

  private
    { Private declarations }
    procedure  AtachDatabase1;

    procedure  RegistryStringYaz(ParametreAdi: string; Deger : String);
    function   RegistryStringOku(ParametreAdi: string):string;

    procedure  RegistryIntYaz(ParametreAdi: string; Deger : Integer);
    function   RegistryIntOku(ParametreAdi: string):Integer;

    procedure  RegistryDateYaz(ParametreAdi: string; Deger : TDateTime);
    function   RegistryDateOku(ParametreAdi: string):TDateTime;


    function  SQLServerKur: Boolean;

    function   getAdapterInfo(Lana:AnsiChar): String;
    function   Xmlpost(url, postdata: string): String;
  public
    MesajKullaniciAdi : String;
    MesajSifre        : String;

    LisansMesaj       : String;
    AktifMacAdres     : String;
    AktifVersiyon     : String;
    BilgilendirmeUrl  : String;


    function  CreateQuery(): TADOQuery;
    function  SabitGetirHareket(SabitAdi : String):Integer;

    function  SabitGetirString(SabitAdi : String):String;
    function  SabitGetirInteger(SabitAdi : String):Integer;
    function  SabitGetirTarih(SabitAdi : String):TDate;

    function  GetUserYetki(KullaniciId : Integer ; FormGrupId : TYetkiGrup ; FormAdi : String ; ProgramFormAdi : String ; YetkiBirimId : TYetkiTipi): Boolean;
    function  ConnectionStringAl: string;
    function  MesajGonder(TelefonNumarasý : String; MesajBaslik: String; Mesaj : String): String;

    function  DatabaseBaglan(ServerName : String): Boolean;
    function  ServerDataBaseKontrol: Boolean;

    function  getMACadress():string;
    function  CreateConAttach(): TADOConnection;
    function  WinExecAndWait32(FileName: string; Visibility: Integer): Longword;

    function  GetFileVersion_(const FileName : String) : String;

    procedure DovizKurlariGuncelle();
    function  StrToFloatSeperatorAyarli(deger: string): Double;
    function  GetKurDeger(DovizId : Integer): Double;
    { Public declarations }
  end;

var
  DMATP: TDMATP;
  KullaniciAdi : String;
  UserId       : Integer;
  KullaniciAdiSoyadi : String;

implementation

uses ATPService, untBekleEkrani, untAttachDatabase, untAnaMakinaSecim;

{$R *.dfm}



function TDMATP.CreateQuery(): TADOQuery;
var
 qry : TADOQuery;
begin

  qry := TADOQuery.Create(nil);
  qry.Connection := ADOConnection;
  Result := qry;

end;

function TDMATP.SabitGetirString(SabitAdi : String):String;
var
  qryTemp : TADOQuery;
begin

  qryTemp := CreateQuery();

  qryTemp.Close;
  qryTemp.SQL.Text :='Select SabitAciklama From Sabitler Where SabitAdi = ' + QuotedStr(SabitAdi);
  qryTemp.Open;

  Result := qryTemp.FieldByName('SabitAciklama').AsString;
  qryTemp.Destroy;
end;

function TDMATP.SabitGetirInteger(SabitAdi : String):Integer;
var
  qryTemp : TADOQuery;
begin

  qryTemp := CreateQuery();

  qryTemp.Close;
  qryTemp.SQL.Text :='Select SabitSira From Sabitler Where SabitAdi = ' + QuotedStr(SabitAdi);
  qryTemp.Open;

  Result := qryTemp.FieldByName('SabitSira').AsInteger;
  qryTemp.Destroy;
end;

function TDMATP.SabitGetirTarih(SabitAdi : String):TDate;
var
  qryTemp : TADOQuery;
begin

  qryTemp := CreateQuery();

  qryTemp.Close;
  qryTemp.SQL.Text :='Select SabitTarih From Sabitler Where SabitAdi = ' + QuotedStr(SabitAdi);
  qryTemp.Open;

  Result := qryTemp.FieldByName('SabitTarih').AsDateTime;
  qryTemp.Destroy;
end;

procedure TDMATP.DataModuleCreate(Sender: TObject);
var
  M  :TStringList;
  DosyaYolu       : String;
  MacAdres        : string;
  ProgramVersiyon : string;
  KaymakamlikAdi  : string;
  programPath     : string;

  //Sonuc           : ProgramDurum;
  Sonuc           : ProgramBilgisi;
  Durum           : Integer;
  LisansTarihi    : TDateTime;

  ATPSoap    : ATPServiceSoap ;
begin

  programPath := ExtractFilePath(Application.ExeName);
  sflthm1.ThemeFile := programPath + 'THEME.ssk';

  AtachDatabase1;
  ProgramVersiyon := GetFileVersion_(Application.ExeName);
  MacAdres        := getMACadress;

  AktifMacAdres   := MacAdres;
  AktifVersiyon   := ProgramVersiyon;

  try

//     ATPSoap      := GetATPServiceSoap();
//     Sonuc        := ATPSoap.VersiyonKontrol2(MacAdres);
//
//
//     //** Gelen Deðerler Registty SET Ediliyor
//     RegistryStringYaz('VersiyonNo', Sonuc.VersiyonNo);
//     RegistryIntYaz('Durumu', Sonuc.Durumu);
//     //RegistryYaz('AcilisMesaj', Sonuc.AcilisMesaj);
//     RegistryStringYaz('LisansMesaj', Sonuc.LisansMesaj);
//     LisansTarihi := Sonuc.LisansTarihi.AsDateTime;
//     RegistryDateYaz('LisansTarihi', LisansTarihi);
//
//
//     LisansMesaj      := Sonuc.LisansMesaj;
//     BilgilendirmeUrl := Sonuc.BilgilendirmeUrl;
//
//     if Sonuc.Durumu = 1 then
//     begin
//         if Sonuc.VersiyonNo <> '' then
//         begin
//            if Sonuc.VersiyonNo <> ProgramVersiyon then
//            begin
//              if (Sonuc.IndirmeDosyasi <> '') and (Sonuc.VersiyonNo <> '')  then
//              begin
//                  //** guncelleme yap
//                  ShowMessage('Programýnýz Güncellenecektir.' + #13 +
//                              'Lütfen tamama basýp iþlem bitinceye kadar bekleyiniz' + #13 +
//                              'Bu iþlem bir kaç dakika sürebilir');
//                  WinExec(PAnsiChar(AnsiString(ExtractFilePath(Application.ExeName) + 'GETURL1.EXE')), SW_SHOW);
//                  //WinExec('GETURL1.EXE',SW_SHOWNORMAL);
//                  Halt;
//              end;
//            end;
//         end;
//     end
//     else
//     begin
//
//       if Sonuc.AcilisMesaj <> '' then
//       begin
//         ShowMessage(Sonuc.AcilisMesaj);
//       end;
//
//       //** Ýlk Kurulum
//
//       if Sonuc.Durumu = 5 then
//       begin
//         if Date >= LisansTarihi then
//         begin
//            ShowMessage('Programýnýz Lisansý Bitmiþtir');
//            RegistryIntYaz('Durumu', 9);
//            Halt;
//         end;
//
//         if Sonuc.VersiyonNo <> '' then
//         begin
//           if Sonuc.VersiyonNo <> ProgramVersiyon then
//           begin
//              if (Sonuc.IndirmeDosyasi <> '') and (Sonuc.VersiyonNo <> '')  then
//              begin
//                  //** guncelleme yap
//                  ShowMessage('Programýnýz Güncellenecektir.' + #13 +
//                              'Lütfen tamama basýp iþlem bitinceye kadar bekleyiniz' + #13 +
//                              'Bu iþlem bir kaç dakika sürebilir');
//                  WinExec(PAnsiChar(AnsiString(ExtractFilePath(Application.ExeName) + 'GETURL1.EXE')), SW_SHOW);
//                  //WinExec('GETURL1.EXE',SW_SHOWNORMAL);
//                  Halt;
//              end;
//           end;
//         end;
//
//       end
//       else if Sonuc.Durumu = 9 then
//       begin
//         ShowMessage('Programýnýz Lisansý Bitmiþtir');
//         Halt;
//       end;
//
//     end;
//
//     ATPSoap.VersiyonTakip(MacAdres, ProgramVersiyon);
//     DovizKurlariGuncelle;
  except
  begin
      Durum := RegistryIntOku('Durumu');

      if Durum = 9 then
      begin
        ShowMessage('Programýnýz Lisansý Bitmiþtir');
        Halt;
      end
      else if Durum = 5 then
      begin
         if Date >= LisansTarihi then
         begin
            ShowMessage('Programýnýz Lisansý Bitmiþtir');
            RegistryIntYaz('Durumu', 9);
            Halt;
         end;
      end
      else if Durum = 0 then
      begin
        ShowMessage('Program ilk kurulumda internete baðlanmasý zorunludur');
        Halt;
      end;

  end;
  end

end;

function  TDMATP.CreateConAttach(): TADOConnection;
var
  AdoConAttach : TADOConnection;
  InstanceName : string;
begin

  try
      AdoConAttach := TADOConnection.Create(nil);
      AdoConAttach.CommandTimeout    := 15;
      AdoConAttach.ConnectionTimeout := 15;
      AdoConAttach.LoginPrompt       := False;
      //AdoConAttach.Provider          := 'SQLNCLI.1';

      AdoConAttach.Connected := False;
      //AdoConAttach.ConnectionString := 'Provider=SQLNCLI.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=master;Data Source=.\ATP2014';
      //AdoConAttach.ConnectionString := 'Provider=SQLNCLI.1;Password=111222333;Persist Security Info=True;User ID=sa;Initial Catalog=master;Data Source=.\ATP2014';
      AdoConAttach.ConnectionString := 'Provider=SQLOLEDB.1;'
                                      +'Password=111222333;'
                                      +'Persist Security Info=True;'
                                      +'User ID=sa;'
                                      +'Initial Catalog=master;'
                                      +'Data Source=.\ATP2014';

      AdoConAttach.ConnectionString := 'Provider=SQLNCLI11.1;Integrated Security=SSPI;Persist Security Info=False;User ID="";Initial Catalog=ATP;Data Source=.;Initial File Name="";Server SPN=""';

      AdoConAttach.Connected := True;

      Result := AdoConAttach;
  except
  begin
     OpenBekleForm('SQL server Kurulacak. Lütfen Bekleyiniz');

     if SQLServerKur = True then
     begin
        CloseBekleForm;
        Result := CreateConAttach();
     end
     else
     begin
        CloseBekleForm;
        ShowMessage('Kurulum Sýrasýnda Hata Oluþtu');
        Halt;
     end;


  end;
  end;
end;

function TDMATP.SQLServerKur: Boolean;
begin
  try

    WinExecAndWait32((PCHAR(ExtractfilePath(Application.ExeName) + '\SQLServer\dotNetFx35setup.exe')),1);
    WinExecAndWait32((PCHAR(ExtractfilePath(Application.ExeName) + '\SQLServer\SQLEXPR.EXE /qb ADDLOCAL=ALL instancename=ATP2014 SQLAUTOSTART=1 DISABLENETWORKPROTOCOLS=2 SQLBROWSERAUTOSTART=1 SECURITYMODE=SQL SAPWD="111222333" SQLACCOUNT="NT AUTHORITY\SYSTEM" ')),1);
    Result := true;
  except
    Result := false;
  end;
end;

function TDMATP.WinExecAndWait32(FileName: string; Visibility: Integer): Longword;
var { by Pat Ritchey }
  zAppName: array[0..512] of Char;
  zCurDir: array[0..255] of Char;
  WorkDir: string;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  StrPCopy(zAppName, FileName);
  GetDir(0, WorkDir);
  StrPCopy(zCurDir, WorkDir);
  FillChar(StartupInfo, SizeOf(StartupInfo), #0);
  StartupInfo.cb          := SizeOf(StartupInfo);
  StartupInfo.dwFlags     := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := Visibility;
  if not CreateProcess(nil,
    zAppName, // pointer to command line string
    nil, // pointer to process security attributes
    nil, // pointer to thread security attributes
    False, // handle inheritance flag
    CREATE_NEW_CONSOLE or // creation flags
    NORMAL_PRIORITY_CLASS,
    nil, //pointer to new environment block
    nil, // pointer to current directory name
    StartupInfo, // pointer to STARTUPINFO
    ProcessInfo) // pointer to PROCESS_INF
    then Result := WAIT_FAILED
  else
  begin
    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
    GetExitCodeProcess(ProcessInfo.hProcess, Result);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end;
end; { WinExecAndWait32 }

function  TDMATP.ServerDataBaseKontrol: Boolean;
var
  AdoConAttach  : TADOConnection;
  qryCheckDb    : TADOQuery;
  DatabaseVar   : Boolean;
begin
     //** Connection Olusturulma
     AdoConAttach := CreateConAttach();
     qryCheckDb   := TADOQuery.Create(nil);
     qryCheckDb.Connection := AdoConAttach;
     qryCheckDb.CommandTimeout := 240;

     //** Silinmelerde 1. defa dosyanýn olmadýgýna dair guncelleme
     try
       qryCheckDb.Close;
       qryCheckDb.SQL.Text := 'EXEC sp_databases';
       qryCheckDb.Open;
       qryCheckDb.First;
     except
     begin
       qryCheckDb.Close;
       qryCheckDb.SQL.Text := 'EXEC sp_databases';
       qryCheckDb.Open;
       qryCheckDb.First;
     end;
     end;


    DatabaseVar := False;
    while not qryCheckDb.eof do
    begin
      if qryCheckDb.FieldByName('DATABASE_NAME').Value = 'ATP' then
      begin
        DatabaseVar := True;
        Result      := True;
        break;
      end;
      qryCheckDb.Next;
    end;
    Result := DatabaseVar;
end;

function  TDMATP.DatabaseBaglan(ServerName : String): Boolean;
var
 ConString    : string;
 InstanceName : string;
begin
   try
     InstanceName := 'ATP2014';

     //Provider=SQLNCLI.1;
     //Password=111222333;
     //Persist Security Info=True;
     //User ID=sa;
     //Initial Catalog=ATP;
     //Data Source=TÜKETICI\ATP2014


    ConString    := 'Provider=SQLOLEDB.1;'
                   +'Password=111222333;'
                   +'Persist Security Info=True;'
                   +'User ID=sa;'
                   +'Initial Catalog=ATP;'
                   +'Data Source='  + ServerName + '\' + InstanceName;
     ConString := 'Provider=SQLNCLI11.1;Integrated Security=SSPI;Persist Security Info=False;User ID="";Initial Catalog=ATP;Data Source=.;Initial File Name="";Server SPN=""';


     //ConString    :=  'Provider=SQLNCLI.1;Integrated Security=SSPI;Persist Security Info=False;User ID=sa;Initial Catalog=ATP;Data Source=.\ATP2014';
     ADOConnection.Close;
     ADOConnection.ConnectionString := ConString;
     ADOConnection.Open;
     Result := True;
   except
     Result := False;
   end;
end;

procedure TDMATP.AtachDatabase1;
var
  IniDosya       : TiniFile;
  ServerAdi      : string;
  KaymakamlikAdi : string;
  Sonuc          : Integer;
begin

   //** Ýni Dosyasý Var Yok Kontrolü
   if FileExists(ExtractFilePath(Application.ExeName) + 'ACILIS.INI') then
   begin
       // Ini Dosyadan Bilgiler Alnýyor
       IniDosya  := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'ACILIS.INI');
       ServerAdi := IniDosya.ReadString('BAGLANTI_STRINGI', 'SERVER','');

       if  ServerAdi = '.' then
       begin
           if ServerDataBaseKontrol then
           begin
             if DatabaseBaglan('.') then
             begin
               //** Bitti

             end
             else
             begin
               //** Kurulum Ekraný
               frmAttachDatabase := TfrmAttachDatabase.Create(nil);
               frmAttachDatabase.ShowModal;
               DatabaseBaglan('.');
             end;
           end
           else
           begin
             //**Kurulum Ekraný
             frmAttachDatabase := TfrmAttachDatabase.Create(nil);
             frmAttachDatabase.ShowModal;
             DatabaseBaglan('.');
           end;
       end
       else
       begin
          if DatabaseBaglan(ServerAdi) then
          begin
            //** Bitti

          end
          else
          begin
            //** Ana Makina Seçim Ekraný
            AtachDatabase1;
          end;
       end;
   end
   else
   begin

      Sonuc          := MessageDlg('Çalýþmýþ olduðunuz makina Server mý?', mtConfirmation, [mbYes,mbNo], 0);
      if Sonuc = mrYes then
      begin
         IniDosya := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'ACILIS.INI');
         IniDosya.WriteString('BAGLANTI_STRINGI', 'SERVER', '.');
         //IniDosya.WriteString('BAGLANTI_STRINGI', 'KAYMAKAMLIK', KaymakamlikAdi);
         IniDosya.Free;
         AtachDatabase1;
      end
      else if Sonuc = mrNo then
      begin
         //Config Olustur.
         //ShowMessage('Açýlýþ için Config Dosyasý Bulunamadý');
         frmAnaMakinaSecim := TfrmAnaMakinaSecim.Create(nil);
         frmAnaMakinaSecim.ShowModal;
         AtachDatabase1;
      end
      else
      begin
        halt;
      end;
   end;


end;

function TDMATP.ConnectionStringAl: string;
var

  CONNECT_INI     : TIniFile;
  constring,deger : String;
  ServerMac       : String;

  AnaMakinaAdi    : string;
  InstanceName    : string;
begin

  if FileExists(ExtractFilePath(Application.ExeName) + 'ACILIS.INI') then
  begin
    CONNECT_INI  := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'ACILIS.INI');
    AnaMakinaAdi := CONNECT_INI.ReadString('BAGLANTI_STRINGI', 'SERVER', '');

    InstanceName := 'ATP2014';
    ConString    := 'Provider=SQLOLEDB.1;'
                   +'Password=111222333;'
                   +'Persist Security Info=True;'
                   +'User ID=sa;'
                   +'Initial Catalog=ATP;'
                   +'Data Source=' + Trim(AnaMakinaAdi) + '\' + InstanceName;
     //conString := 'Provider=SQLNCLI11.1;Integrated Security=SSPI;Persist Security Info=False;User ID="";Initial Catalog=ATP;Data Source=.;Initial File Name="";Server SPN=""';';
     conString := 'Provider=SQLNCLI11.1;Integrated Security=SSPI;Persist Security Info=False;User ID="";Initial Catalog=ATP;Data Source=.;Initial File Name="";Server SPN=""';

     CONNECT_INI.Free;
    result := constring;
  end
  else
    begin
      ShowMessage('inifile bulunamadý');
      result := '';
    end;
end;

function  TDMATP.SabitGetirHareket(SabitAdi : String):Integer;
var
  qryTemp : TADOQuery;
  SabitId : Integer;
begin

  qryTemp := CreateQuery();

  qryTemp.Close;
  qryTemp.SQL.Text :='Select SabitSira From Sabitler Where SabitAdi = ' + QuotedStr(SabitAdi);
  qryTemp.Open;
  SabitId := qryTemp.FieldByName('SabitSira').AsInteger;

  qryTemp.Edit;
  qryTemp.FieldByName('SabitSira').AsInteger := SabitId + 1;
  qryTemp.Post;

  Result := qryTemp.FieldByName('SabitSira').AsInteger;
  qryTemp.Destroy;
end;

function  TDMATP.GetUserYetki(KullaniciId : Integer ; FormGrupId : TYetkiGrup ; FormAdi : String ; ProgramFormAdi : String ; YetkiBirimId : TYetkiTipi): Boolean;
var
  qrykullaniciYetki : TADOQuery;
begin

    qrykullaniciYetki := CreateQuery;

    qrykullaniciYetki.Close;
    qrykullaniciYetki.SQL.Text := 'Select * From Yetkilendirme Where KullaniciId = '+IntToStr(KullaniciId)+'  And ProgramFormAdi = '+QuotedStr(ProgramFormAdi);
    qrykullaniciYetki.Open;

    if  qrykullaniciYetki.RecordCount > 0 then
    begin
      case YetkiBirimId of
      tpEkleme:
      begin
          if qrykullaniciYetki.Fieldbyname('Ekleme').AsBoolean = False then
          begin
             MessageDlg(KullaniciAdi + ' kullanýcýsýnýn '
                                     + #13 +FormAdi+' formunda ekleme yetkisi yoktur'
                                     + #13 + 'Lütfen Admine müracat ediniz' , mtConfirmation, [mbOK], 0);
             Result := False;
             Abort;
          end ;
      end;
      tpSilme:
      begin
          if qrykullaniciYetki.Fieldbyname('Silme').AsBoolean = False then
          begin
             MessageDlg(KullaniciAdi + ' kullanýcýsýnýn '
                                     + #13 +FormAdi+' formunda silme yetkisi yoktur'
                                     + #13 + 'Lütfen Admine müracat ediniz' , mtConfirmation, [mbOK], 0);
             Result := False;
             Abort;
          end ;
      end;
      tpDegistirme:
      begin
          if qrykullaniciYetki.Fieldbyname('Degistirme').AsBoolean = False then
          begin
             MessageDlg(KullaniciAdi + ' kullanýcýsýnýn '
                                     + #13 +FormAdi+' formunda deðiþtirme yetkisi yoktur'
                                     + #13 + 'Lütfen Admine müracat ediniz' , mtConfirmation, [mbOK], 0);
             Result := False;
             Abort;
          end ;
      end;
      tpGorme:  Result := qrykullaniciYetki.Fieldbyname('Gorme').AsBoolean;
      end;
    end
    else
    begin
      qrykullaniciYetki.Insert;
      qrykullaniciYetki.Fieldbyname('KullaniciId').AsInteger   := KullaniciId;
      qrykullaniciYetki.Fieldbyname('FormGrupId').AsVariant   := FormGrupId;
      qrykullaniciYetki.Fieldbyname('FormAdi').AsString        := FormAdi;
      qrykullaniciYetki.Fieldbyname('ProgramFormAdi').AsString := ProgramFormAdi;
      qrykullaniciYetki.Fieldbyname('Ekleme').AsBoolean         := True;
      qrykullaniciYetki.Fieldbyname('Silme').AsBoolean          := True;
      qrykullaniciYetki.Fieldbyname('Degistirme').AsBoolean     := True;
      qrykullaniciYetki.Fieldbyname('Gorme').AsBoolean          := True;
      qrykullaniciYetki.Post;
      Result := True;
    end;
    qrykullaniciYetki.Destroy;

end;

function TDMATP.getAdapterInfo(Lana:AnsiChar): String;
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

function TDMATP.getMACadress():string;
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

function  TDMATP.MesajGonder(TelefonNumarasý : String; MesajBaslik: String; Mesaj : String): String;
var
xsml:String;
degisken:String;
begin

      xsml:='<mainbody>'+
        '<header>'+
	    	'<company>NETGSM</company>'+
        '<usercode>'+MesajKullaniciAdi+'</usercode>'+
        '<password>'+MesajSifre+'</password>'+
     		'<startdate></startdate>'+
		    '<stopdate></stopdate>'+
   	    '<type>1:n</type>'+
        '<msgheader>'+MesajBaslik+'</msgheader>'+
        '</header>'+
	     	'<body>'+
    		'<msg><![CDATA['+Mesaj+']]></msg>'+
	    	'<no>'+TelefonNumarasý+'</no>'+
	    	'</body>'+
       '</mainbody>';
        degisken:= Xmlpost('http://api.netgsm.com.tr/xmlbulkhttppost.asp',xsml);
        //showmessage(degisken);
        Result := degisken;
end;

function TDMATP.xmlpost(url, postdata: string): String;
//Dikkat!!! indy bu component 'i ssl desteði vermediði için url parametresi http:// ile baþlamalý
var IdHTTP1: TIdHTTP;
str1:TStringList;
begin
  try
    try
        IdHTTP1:=TIdHTTP.Create(nil);
        str1:=TStringList.Create;
        str1.Text:=postdata;
        result:=IdHTTP1.Post(url, str1);
    except
    end;
  finally
    FreeAndNil(str1);
    FreeAndNil(IdHTTP1);
  end;
end;

function TDMATP.GetFileVersion_(const FileName : String) : String;
var
   VersionInfoSize,
   VersionInfoValueSize,
   Zero             : DWord;
   VersionInfo,
   VersionInfoValue : Pointer;
begin
   Result := '';
   { Obtain size of version info structure }
   VersionInfoSize := GetFileVersionInfoSize(PChar(FileName), Zero);
   if VersionInfoSize = 0 then exit;
   { Allocate memory for the version info structure }
   { This could raise an EOutOfMemory exception }
   GetMem(VersionInfo, VersionInfoSize);
   try
      if GetFileVersionInfo(PChar(FileName), 0, VersionInfoSize, VersionInfo) and VerQueryValue(VersionInfo, '\' { root block }, VersionInfoValue, VersionInfoValueSize) and
         (0 <> LongInt(VersionInfoValueSize)) then
      begin
         with TVSFixedFileInfo(VersionInfoValue^) do
         begin
            Result :=                IntToStr(HiWord(dwFileVersionMS));
            Result := Result + '.' + IntToStr(LoWord(dwFileVersionMS));
            Result := Result + '.' + IntToStr(HiWord(dwFileVersionLS));
            Result := Result + '.' + IntToStr(LoWord(dwFileVersionLS));
         end; //with
      end; //if
   finally
      FreeMem(VersionInfo);
   end;//try
end;

procedure TDMATP.RegistryStringYaz(ParametreAdi: string; Deger : String);
var
  reg   : TRegistry;
begin

  reg := TRegistry.Create;
  reg.RootKey := HKEY_LOCAL_MACHINE;
  if reg.OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\App Management\ARPCache\ATP',False) = True then
  begin
    reg.WriteString(ParametreAdi, Deger);
  end
  else
  begin
      if reg.CreateKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\App Management\ARPCache\ATP') = True then
      begin
        if reg.OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\App Management\ARPCache\ATP',False) = True then
        begin
          reg.WriteString(ParametreAdi, Deger);
        end;
      end
  end;
  reg.Free;
end;

function TDMATP.RegistryStringOku(ParametreAdi: string):string;
var
  reg   : TRegistry;
  Sonuc : string;
begin

  reg := TRegistry.Create;
  reg.RootKey := HKEY_LOCAL_MACHINE;
  Sonuc := '';

  if reg.OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\App Management\ARPCache\ATP',False) = True then
  begin
    Sonuc := reg.ReadString(ParametreAdi);
  end;
  reg.Free;
  Result := Sonuc;
end;

procedure  TDMATP.RegistryIntYaz(ParametreAdi: string; Deger : Integer);
var
  reg   : TRegistry;
begin

  reg := TRegistry.Create;
  reg.RootKey := HKEY_LOCAL_MACHINE;
  if reg.OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\App Management\ARPCache\ATP',False) = True then
  begin
    reg.WriteInteger(ParametreAdi, Deger);
  end;
  reg.Free;
end;

function TDMATP.RegistryIntOku(ParametreAdi: string):Integer;
var
  reg   : TRegistry;
  Sonuc : Integer;
begin

  reg := TRegistry.Create;
  reg.RootKey := HKEY_LOCAL_MACHINE;
  Sonuc := 0;

  if reg.OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\App Management\ARPCache\ATP',False) = True then
  begin
    Sonuc := reg.ReadInteger(ParametreAdi);
  end;
  reg.Free;
  Result := Sonuc;
end;

procedure  TDMATP.RegistryDateYaz(ParametreAdi: string; Deger : TDateTime);
var
  reg   : TRegistry;
begin

  reg := TRegistry.Create;
  reg.RootKey := HKEY_LOCAL_MACHINE;
  if reg.OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\App Management\ARPCache\ATP',False) = True then
  begin
    reg.WriteDateTime(ParametreAdi, Deger);
  end;
  reg.Free;
end;

function TDMATP.RegistryDateOku(ParametreAdi: string):TDateTime;
var
  reg   : TRegistry;
  Sonuc : TDateTime;
begin

  reg := TRegistry.Create;
  reg.RootKey := HKEY_LOCAL_MACHINE;
  Sonuc := StrToDate('01.01.2000');

  if reg.OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\App Management\ARPCache\ATP',False) = True then
  begin
    Sonuc := reg.ReadDateTime(ParametreAdi);
  end;
  reg.Free;
  Result := Sonuc;
end;

procedure TDMATP.DovizKurlariGuncelle();
var
   qryTemp : TADOQuery;
   SonTrh  : TDateTime;
   i         : integer;
   baslangic : IXMLNode;
begin

  try
     qryTemp := DMATP.CreateQuery();

     qryTemp.Close;
     qryTemp.SQL.Text := 'Select * from IsletmeTanimi';
     qryTemp.Open;
     SonTrh := qryTemp.FieldByName('SonDovizGuncellemeTarih').AsDateTime;

     //** Guncel Deðilse
     if Date > SonTrh then
     begin
         XMLDocument1.Active:=false;
         XMLDocument1.FileName:='http://www.tcmb.gov.tr/kurlar/today.xml';
         XMLDocument1.Active:=true;

         i:=1;
         baslangic:=XMLDocument1.DocumentElement.ChildNodes.FindNode('Currency');
         repeat
            qryTemp.Close;
            qryTemp.SQL.Text := 'SELECT * FROM DovizKurlari WHERE DovizId = ' + IntToStr(i);
            qryTemp.Open;

            //** Yoksa Ekle Varsa Guncelle
            if qryTemp.RecordCount > 0 then
              qryTemp.Edit
            else
              qryTemp.Append;

            qryTemp.FieldByName('DovizId').AsInteger       := i;
            qryTemp.FieldByName('Isim').AsString           := baslangic.ChildNodes.Nodes['Isim'].Text;
            qryTemp.FieldByName('ForexBuying').AsFloat     := StrToFloatSeperatorAyarli(baslangic.ChildNodes.Nodes['ForexBuying'].Text);
            qryTemp.FieldByName('ForexSelling').AsFloat    := StrToFloatSeperatorAyarli(baslangic.ChildNodes.Nodes['ForexSelling'].Text);
            qryTemp.FieldByName('BanknoteBuying').AsFloat  := StrToFloatSeperatorAyarli(baslangic.ChildNodes.Nodes['BanknoteBuying'].Text);
            qryTemp.FieldByName('BanknoteSelling').AsFloat := StrToFloatSeperatorAyarli(baslangic.ChildNodes.Nodes['BanknoteSelling'].Text);
            qryTemp.Post;

            i:=i+1;
            baslangic:=baslangic.NextSibling;
         Until baslangic=nil;

         qryTemp.Close;
         qryTemp.SQL.Text := 'Select * from IsletmeTanimi';
         qryTemp.Open;

         qryTemp.Edit;
         qryTemp.FieldByName('SonDovizGuncellemeTarih').AsDateTime := Date;
         qryTemp.Post;
     end;

  except
  end;


end;

function TDMATP.StrToFloatSeperatorAyarli(deger: string): Double;
var
  value : string;
  sonuc : Double;
  i     : integer;
begin
  try
    if deger = '' then
    begin
      result := 0;
      Exit;
    end;

   if (Pos(',',deger) > 0) and (Pos('.',deger) > 0) then
    begin
      for i:=0 to Length(deger)-1 do
      begin
        if Copy(deger,i,1) = ',' then
        begin
          deger := AnsiReplaceStr(deger,',','');
          break;
        end;

        if Copy(deger,i,1) = '.' then
        begin
          deger := AnsiReplaceStr(deger,'.','');
          break;
        end;
      end;
    end;


    deger := AnsiReplaceStr(deger,'.',',');
    sonuc := 0;
    sonuc := StrToFloat(deger);
    value := deger;
  except
    if (Pos(',',deger) > 0) then
    begin
      value := AnsiReplaceStr(deger,',','.');
    end
    else
    begin
      value := AnsiReplaceStr(deger,'.',',');
    end;
  end;

  try
    sonuc := StrToFloat(value);
  except
    sonuc := 0;
  end;

  result := sonuc;
end;

function TDMATP.GetKurDeger(DovizId : Integer): Double;
var
 qryTemp : TADOQuery;
begin
   qryTemp := DMATP.CreateQuery();

   qryTemp.Close;
   qryTemp.SQL.Text := 'SELECT ForexBuying FROM DovizKurlari WHERE DovizId = ' + IntToStr(DovizId);
   qryTemp.Open;

   Result := qryTemp.FieldByName('ForexBuying').AsFloat;
end;

end.
