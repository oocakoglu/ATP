unit untNETInfo;

interface

uses
  SysUtils,Windows,Classes;

  function BilgisayarAdiGetir : string;
  function GetWorkgroupName : string;
  function GetDomainControllerName(const ADomainName : string) : string;
  procedure GetUsers(Users : TStringList; AServer : string);

implementation

Const
   NERR_Success = 0;

function NetApiBufferAllocate(ByteCount: DWORD; var Buffer: Pointer): DWORD;
                                           stdcall; external 'netapi32.dll';
function NetGetDCName(servername: LPCWSTR; domainname: LPCWSTR;
  bufptr: Pointer): DWORD; stdcall; external 'netapi32.dll';
function NetApiBufferFree (Buffer: Pointer): DWORD ; stdcall;
                                     external 'netapi32.dll';
Function NetWkstaGetInfo
        (ServerName : LPWSTR;
         Level      : DWORD;
         BufPtr     : Pointer) : Longint; Stdcall;
                external 'netapi32.dll' Name 'NetWkstaGetInfo';

function NetUserEnum(servername: LPCWSTR; level: DWORD; filter: DWORD;
  var bufptr: Pointer; prefmaxlen: DWORD; var entriesread: DWORD;
  var totalentries: DWORD; resume_handle: PDWORD): DWORD; stdcall;
                                          external 'netapi32.dll';

type  WKSTA_INFO_100   = Record
      wki100_platform_id  : DWORD;
      wki100_computername : LPWSTR;
      wki100_langroup     : LPWSTR;
      wki100_ver_major    : DWORD;
      wki100_ver_minor    : DWORD;
                            End;

   LPWKSTA_INFO_100 = ^WKSTA_INFO_100;

  _USER_INFO_0  = record
    usri0_name: LPWSTR;
  end;
  TUserInfo0 = _USER_INFO_0;

function GetNetParam(AParam : integer) : string;
Var
  PBuf  : LPWKSTA_INFO_100;
  Res   : LongInt;
begin
  result := '';
  Res := NetWkstaGetInfo (Nil, 100, @PBuf);
  If Res = NERR_Success Then
    begin
      case AParam of
       0:   Result := string(PBuf^.wki100_computername);
       1:   Result := string(PBuf^.wki100_langroup);
      end;
    end;
end;

function BilgisayarAdiGetir : string;
begin
  Result := GetNetParam(0);
end;

function GetWorkgroupName : string;
begin
  Result := GetNetParam(1);
end;

function GetDomainControllerName(const ADomainName : string) : string;
var
  wDomainName : WideString;
  Controller : PWideChar;
begin
  wDomainName := AdomainName;
  NetGetDCName (Nil, PWideChar (wDomainName), @Controller);
  Result := WideCharToString(controller);
  NetAPIBufferFree (Controller);
end;


procedure GetUsers(Users : TStringList; AServer : string);
type
  TUserInfoArr = array[0..(MaxInt - 4) div SizeOf(TUserInfo0)] of TUserInfo0;
var
  UserInfo: Pointer;
  EntriesRead, TotalEntries, ResumeHandle: DWORD;
  Res: DWORD;
  i: Integer;
  FServer : WideString;
begin
  FServer :=  AServer;
  ResumeHandle := 0;
  repeat
    Res := NetUserEnum(PWideChar(FServer), 0, 0, UserInfo,
                       64 * SizeOf(TUserInfo0),
                       EntriesRead, TotalEntries, @ResumeHandle);
    if (Res = NERR_SUCCESS) or (Res = ERROR_MORE_DATA) then
    begin
      for i := 0 to EntriesRead - 1 do
        Users.Add(TUserInfoArr(UserInfo^)[i].usri0_name);
      NetApiBufferFree(UserInfo);
    end;
  until Res <> ERROR_MORE_DATA;
end;

end.
