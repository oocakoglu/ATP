unit untIletisimSikayet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, StdCtrls, cxButtons, cxMemo, cxTextEdit, cxLabel,
  ExtCtrls, SUIForm, ATPService;

type
  TfrmIletisimSikayet = class(TForm)
    suifrm1: TsuiForm;
    cxlbl1: TcxLabel;
    cxlbl2: TcxLabel;
    cxlbl3: TcxLabel;
    cxlbl4: TcxLabel;
    txtAdiSoyadi: TcxTextEdit;
    txtEPosta: TcxTextEdit;
    txtKonu: TcxTextEdit;
    pnl1: TPanel;
    btnKaydet: TcxButton;
    btnSil: TcxButton;
    cxmAciklama: TcxMemo;
    cxlbl6: TcxLabel;
    txtTelefon: TcxTextEdit;
    procedure btnSilClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnKaydetClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmIletisimSikayet: TfrmIletisimSikayet;

implementation

uses DM;

{$R *.dfm}

procedure TfrmIletisimSikayet.btnKaydetClick(Sender: TObject);
begin
   try
      GetATPServiceSoap().Iletisim(DMATP.AktifMacAdres, txtAdiSoyadi.Text, txtEPosta.Text, txtTelefon.Text, txtKonu.Text, cxmAciklama.Text);
      btnSilClick(Sender);
      ShowMessage('Gerekli Bilgiler Baþarýyla Gönderilmiþtir.');
   except
      ShowMessage('Gerekli Bilgilerin Gönderimi Sýrasýnda Hata Oluþtu');
   end;
end;

procedure TfrmIletisimSikayet.btnSilClick(Sender: TObject);
begin
  txtAdiSoyadi.Text := '';
  txtEPosta.Text    := '';
  txtTelefon.Text   := '';
  txtKonu.Text      := '';
  cxmAciklama.Text  := '';
end;

procedure TfrmIletisimSikayet.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
