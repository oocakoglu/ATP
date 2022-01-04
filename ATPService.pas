// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://gaziuzaktanegitim.net/ATPService.asmx?wsdl
//  >Import : http://gaziuzaktanegitim.net/ATPService.asmx?wsdl>0
// Encoding : utf-8
// Version  : 1.0
// (24.08.2014 13:01:34 - - $Rev: 25127 $)
// ************************************************************************ //

unit ATPService;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:dateTime        - "http://www.w3.org/2001/XMLSchema"[Gbl]

  ProgramDurum         = class;                 { "http://tempuri.org/"[GblCplx] }
  ProgramBilgisi       = class;                 { "http://tempuri.org/"[GblCplx] }
  ProgramDurum2        = class;                 { "http://tempuri.org/"[GblElm] }
  ProgramBilgisi2      = class;                 { "http://tempuri.org/"[GblElm] }



  // ************************************************************************ //
  // XML       : ProgramDurum, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  ProgramDurum = class(TRemotable)
  private
    FVersiyonNo: string;
    FVersiyonNo_Specified: boolean;
    FDurumu: Integer;
    FAcilisMesaj: string;
    FAcilisMesaj_Specified: boolean;
    FLisansMesaj: string;
    FLisansMesaj_Specified: boolean;
    FIndirmeDosyasi: string;
    FIndirmeDosyasi_Specified: boolean;
    FLisansTarihi: TXSDateTime;
    procedure SetVersiyonNo(Index: Integer; const Astring: string);
    function  VersiyonNo_Specified(Index: Integer): boolean;
    procedure SetAcilisMesaj(Index: Integer; const Astring: string);
    function  AcilisMesaj_Specified(Index: Integer): boolean;
    procedure SetLisansMesaj(Index: Integer; const Astring: string);
    function  LisansMesaj_Specified(Index: Integer): boolean;
    procedure SetIndirmeDosyasi(Index: Integer; const Astring: string);
    function  IndirmeDosyasi_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property VersiyonNo:     string       Index (IS_OPTN) read FVersiyonNo write SetVersiyonNo stored VersiyonNo_Specified;
    property Durumu:         Integer      read FDurumu write FDurumu;
    property AcilisMesaj:    string       Index (IS_OPTN) read FAcilisMesaj write SetAcilisMesaj stored AcilisMesaj_Specified;
    property LisansMesaj:    string       Index (IS_OPTN) read FLisansMesaj write SetLisansMesaj stored LisansMesaj_Specified;
    property IndirmeDosyasi: string       Index (IS_OPTN) read FIndirmeDosyasi write SetIndirmeDosyasi stored IndirmeDosyasi_Specified;
    property LisansTarihi:   TXSDateTime  read FLisansTarihi write FLisansTarihi;
  end;



  // ************************************************************************ //
  // XML       : ProgramBilgisi, global, <complexType>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  ProgramBilgisi = class(TRemotable)
  private
    FVersiyonNo: string;
    FVersiyonNo_Specified: boolean;
    FDurumu: Integer;
    FBilgilendirmeUrl: string;
    FBilgilendirmeUrl_Specified: boolean;
    FAcilisMesaj: string;
    FAcilisMesaj_Specified: boolean;
    FLisansMesaj: string;
    FLisansMesaj_Specified: boolean;
    FIndirmeDosyasi: string;
    FIndirmeDosyasi_Specified: boolean;
    FLisansTarihi: TXSDateTime;
    procedure SetVersiyonNo(Index: Integer; const Astring: string);
    function  VersiyonNo_Specified(Index: Integer): boolean;
    procedure SetBilgilendirmeUrl(Index: Integer; const Astring: string);
    function  BilgilendirmeUrl_Specified(Index: Integer): boolean;
    procedure SetAcilisMesaj(Index: Integer; const Astring: string);
    function  AcilisMesaj_Specified(Index: Integer): boolean;
    procedure SetLisansMesaj(Index: Integer; const Astring: string);
    function  LisansMesaj_Specified(Index: Integer): boolean;
    procedure SetIndirmeDosyasi(Index: Integer; const Astring: string);
    function  IndirmeDosyasi_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property VersiyonNo:       string       Index (IS_OPTN) read FVersiyonNo write SetVersiyonNo stored VersiyonNo_Specified;
    property Durumu:           Integer      read FDurumu write FDurumu;
    property BilgilendirmeUrl: string       Index (IS_OPTN) read FBilgilendirmeUrl write SetBilgilendirmeUrl stored BilgilendirmeUrl_Specified;
    property AcilisMesaj:      string       Index (IS_OPTN) read FAcilisMesaj write SetAcilisMesaj stored AcilisMesaj_Specified;
    property LisansMesaj:      string       Index (IS_OPTN) read FLisansMesaj write SetLisansMesaj stored LisansMesaj_Specified;
    property IndirmeDosyasi:   string       Index (IS_OPTN) read FIndirmeDosyasi write SetIndirmeDosyasi stored IndirmeDosyasi_Specified;
    property LisansTarihi:     TXSDateTime  read FLisansTarihi write FLisansTarihi;
  end;

  string_         =  type string;      { "http://tempuri.org/"[GblElm] }


  // ************************************************************************ //
  // XML       : ProgramDurum, global, <element>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  ProgramDurum2 = class(ProgramDurum)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ProgramBilgisi, global, <element>
  // Namespace : http://tempuri.org/
  // ************************************************************************ //
  ProgramBilgisi2 = class(ProgramBilgisi)
  private
  published
  end;


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : ATPServiceSoap12
  // service   : ATPService
  // port      : ATPServiceSoap12
  // URL       : http://gaziuzaktanegitim.net/ATPService.asmx
  // ************************************************************************ //
  ATPServiceSoap = interface(IInvokable)
  ['{A68D4615-D019-3081-5344-70E683ACF260}']
    function  HelloWorld: string; stdcall;
    procedure Iletisim(const MacNo: string; const AdiSoyadi: string; const Eposta: string; const Telefon: string; const Konu: string; const Aciklama: string
                       ); stdcall;
    function  VersiyonKontrol(const MacAdres: string): ProgramDurum; stdcall;
    function  VersiyonKontrol2(const MacAdres: string): ProgramBilgisi; stdcall;
    procedure VersiyonTakip(const MacAdres: string; const Versiyon: string); stdcall;
    procedure BilgilendirmeGosterme(const MacAdres: string); stdcall;
  end;


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // binding   : ATPServiceHttpGet
  // service   : ATPService
  // port      : ATPServiceHttpGet
  // ************************************************************************ //
  ATPServiceHttpGet = interface(IInvokable)
  ['{36791CBE-A73A-47B4-E4D7-EB5BC31206A4}']
    function  HelloWorld: string_; stdcall;
    procedure Iletisim(const MacNo: string; const AdiSoyadi: string; const Eposta: string; const Telefon: string; const Konu: string; const Aciklama: string
                       ); stdcall;
    function  VersiyonKontrol(const MacAdres: string): ProgramDurum2; stdcall;
    function  VersiyonKontrol2(const MacAdres: string): ProgramBilgisi2; stdcall;
    procedure VersiyonTakip(const MacAdres: string; const Versiyon: string); stdcall;
    procedure BilgilendirmeGosterme(const MacAdres: string); stdcall;
  end;


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // binding   : ATPServiceHttpPost
  // service   : ATPService
  // port      : ATPServiceHttpPost
  // ************************************************************************ //
  ATPServiceHttpPost = interface(IInvokable)
  ['{1355AEFD-3730-519F-706D-1301D0132964}']
    function  HelloWorld: string_; stdcall;
    procedure Iletisim(const MacNo: string; const AdiSoyadi: string; const Eposta: string; const Telefon: string; const Konu: string; const Aciklama: string
                       ); stdcall;
    function  VersiyonKontrol(const MacAdres: string): ProgramDurum2; stdcall;
    function  VersiyonKontrol2(const MacAdres: string): ProgramBilgisi2; stdcall;
    procedure VersiyonTakip(const MacAdres: string; const Versiyon: string); stdcall;
    procedure BilgilendirmeGosterme(const MacAdres: string); stdcall;
  end;

function GetATPServiceSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ATPServiceSoap;
function GetATPServiceHttpGet(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ATPServiceHttpGet;
function GetATPServiceHttpPost(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ATPServiceHttpPost;


implementation
  uses SysUtils;

function GetATPServiceSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): ATPServiceSoap;
const
  defWSDL = 'http://gaziuzaktanegitim.net/ATPService.asmx?wsdl';
  defURL  = 'http://gaziuzaktanegitim.net/ATPService.asmx';
  defSvc  = 'ATPService';
  defPrt  = 'ATPServiceSoap12';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as ATPServiceSoap);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


function GetATPServiceHttpGet(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): ATPServiceHttpGet;
const
  defWSDL = 'http://gaziuzaktanegitim.net/ATPService.asmx?wsdl';
  defURL  = '';
  defSvc  = 'ATPService';
  defPrt  = 'ATPServiceHttpGet';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as ATPServiceHttpGet);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


function GetATPServiceHttpPost(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): ATPServiceHttpPost;
const
  defWSDL = 'http://gaziuzaktanegitim.net/ATPService.asmx?wsdl';
  defURL  = '';
  defSvc  = 'ATPService';
  defPrt  = 'ATPServiceHttpPost';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as ATPServiceHttpPost);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


destructor ProgramDurum.Destroy;
begin
  SysUtils.FreeAndNil(FLisansTarihi);
  inherited Destroy;
end;

procedure ProgramDurum.SetVersiyonNo(Index: Integer; const Astring: string);
begin
  FVersiyonNo := Astring;
  FVersiyonNo_Specified := True;
end;

function ProgramDurum.VersiyonNo_Specified(Index: Integer): boolean;
begin
  Result := FVersiyonNo_Specified;
end;

procedure ProgramDurum.SetAcilisMesaj(Index: Integer; const Astring: string);
begin
  FAcilisMesaj := Astring;
  FAcilisMesaj_Specified := True;
end;

function ProgramDurum.AcilisMesaj_Specified(Index: Integer): boolean;
begin
  Result := FAcilisMesaj_Specified;
end;

procedure ProgramDurum.SetLisansMesaj(Index: Integer; const Astring: string);
begin
  FLisansMesaj := Astring;
  FLisansMesaj_Specified := True;
end;

function ProgramDurum.LisansMesaj_Specified(Index: Integer): boolean;
begin
  Result := FLisansMesaj_Specified;
end;

procedure ProgramDurum.SetIndirmeDosyasi(Index: Integer; const Astring: string);
begin
  FIndirmeDosyasi := Astring;
  FIndirmeDosyasi_Specified := True;
end;

function ProgramDurum.IndirmeDosyasi_Specified(Index: Integer): boolean;
begin
  Result := FIndirmeDosyasi_Specified;
end;

destructor ProgramBilgisi.Destroy;
begin
  SysUtils.FreeAndNil(FLisansTarihi);
  inherited Destroy;
end;

procedure ProgramBilgisi.SetVersiyonNo(Index: Integer; const Astring: string);
begin
  FVersiyonNo := Astring;
  FVersiyonNo_Specified := True;
end;

function ProgramBilgisi.VersiyonNo_Specified(Index: Integer): boolean;
begin
  Result := FVersiyonNo_Specified;
end;

procedure ProgramBilgisi.SetBilgilendirmeUrl(Index: Integer; const Astring: string);
begin
  FBilgilendirmeUrl := Astring;
  FBilgilendirmeUrl_Specified := True;
end;

function ProgramBilgisi.BilgilendirmeUrl_Specified(Index: Integer): boolean;
begin
  Result := FBilgilendirmeUrl_Specified;
end;

procedure ProgramBilgisi.SetAcilisMesaj(Index: Integer; const Astring: string);
begin
  FAcilisMesaj := Astring;
  FAcilisMesaj_Specified := True;
end;

function ProgramBilgisi.AcilisMesaj_Specified(Index: Integer): boolean;
begin
  Result := FAcilisMesaj_Specified;
end;

procedure ProgramBilgisi.SetLisansMesaj(Index: Integer; const Astring: string);
begin
  FLisansMesaj := Astring;
  FLisansMesaj_Specified := True;
end;

function ProgramBilgisi.LisansMesaj_Specified(Index: Integer): boolean;
begin
  Result := FLisansMesaj_Specified;
end;

procedure ProgramBilgisi.SetIndirmeDosyasi(Index: Integer; const Astring: string);
begin
  FIndirmeDosyasi := Astring;
  FIndirmeDosyasi_Specified := True;
end;

function ProgramBilgisi.IndirmeDosyasi_Specified(Index: Integer): boolean;
begin
  Result := FIndirmeDosyasi_Specified;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(ATPServiceSoap), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ATPServiceSoap), 'http://tempuri.org/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(ATPServiceSoap), ioDocument);
  InvRegistry.RegisterInvokeOptions(TypeInfo(ATPServiceSoap), ioSOAP12);
  InvRegistry.RegisterInterface(TypeInfo(ATPServiceHttpGet), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ATPServiceHttpGet), '');
  InvRegistry.RegisterInterface(TypeInfo(ATPServiceHttpPost), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ATPServiceHttpPost), '');
  RemClassRegistry.RegisterXSClass(ProgramDurum, 'http://tempuri.org/', 'ProgramDurum');
  RemClassRegistry.RegisterXSClass(ProgramBilgisi, 'http://tempuri.org/', 'ProgramBilgisi');
  RemClassRegistry.RegisterXSInfo(TypeInfo(string_), 'http://tempuri.org/', 'string_', 'string');
  RemClassRegistry.RegisterXSClass(ProgramDurum2, 'http://tempuri.org/', 'ProgramDurum2', 'ProgramDurum');
  RemClassRegistry.RegisterXSClass(ProgramBilgisi2, 'http://tempuri.org/', 'ProgramBilgisi2', 'ProgramBilgisi');

end.