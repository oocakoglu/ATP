unit untAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Menus, StdCtrls, cxButtons,
  cxLabel, ShellAPI, SUIForm ;

type
  TfrmAbout = class(TForm)
    Shape1: TShape;
    cxLabel1: TcxLabel;
    cxlblVersiyonNo: TcxLabel;
    cxLabel3: TcxLabel;
    btnBilirkisiEkle: TcxButton;
    cxlblLisansAciklama: TcxLabel;
    suifrm1: TsuiForm;
    img1: TImage;
    cxlblMacNo: TcxLabel;
    procedure btnBilirkisiEkleClick(Sender: TObject);
    procedure cxLabel3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

uses DM;
{$R *.dfm}

procedure TfrmAbout.btnBilirkisiEkleClick(Sender: TObject);
begin
  close;
end;

procedure TfrmAbout.cxLabel3Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', PChar('http://www.ATPYazilim.com' ), nil, nil, SW_SHOWNORMAL)
end;

procedure TfrmAbout.FormShow(Sender: TObject);
begin
  cxlblVersiyonNo.Caption     := 'Version '+DMATP.AktifVersiyon+' - 2013';
  cxlblLisansAciklama.Caption := DMATP.LisansMesaj ;
  cxlblMacNo.Caption          := DMATP.AktifMacAdres;

end;

end.
