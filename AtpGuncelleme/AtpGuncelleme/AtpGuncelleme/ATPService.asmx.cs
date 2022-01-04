using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using System.Data;

namespace AtpGuncelleme
{
    /// <summary>
    /// Summary description for ATPService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class ATPService : System.Web.Services.WebService
    {


        //** Farma
        public static SqlConnection CreateATPSqlConnection()
        {
            //SqlConnection bag = new SqlConnection("Data Source=200.0.0.169;Initial Catalog=TcFarma;Persist Security Info=True;User ID=sa;Password=123456Aa");
            SqlConnection bag = new SqlConnection("Data Source=mssql03.turhost.com;Initial Catalog=gaziuzak_egitim;Persist Security Info=True;User ID=gaziu_sa;Password=BAKU2005!");
            bag.Open();
            return bag;
        }

        public static DataTable CreateATPDateTable(string sql)
        {
            SqlConnection bag = CreateATPSqlConnection();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(sql, bag);
            da.Fill(dt);
            bag.Close();
            return dt;
        }

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }
        
        [WebMethod]
        public void Iletisim(string MacNo, string AdiSoyadi, string Eposta, string Telefon, string Konu, string Aciklama)
        {
            //** Yeni Kayıt Ekleme
            SqlConnection bag = CreateATPSqlConnection();
            SqlDataAdapter daIletisim = new SqlDataAdapter("SELECT * FROM ATPIletisim WHERE 2 = 1", bag);
            SqlCommandBuilder cbIletisim = new SqlCommandBuilder(daIletisim);
            DataTable dtIletisim = new DataTable();
            DataRow rwIletisim = dtIletisim.NewRow();

            daIletisim.Fill(dtIletisim);

            rwIletisim["MacNo"] = MacNo;
            rwIletisim["AdiSoyadi"] = AdiSoyadi;
            rwIletisim["EPosta"] = Eposta;
            rwIletisim["Telefon"] = Telefon;
            rwIletisim["Konu"] = Konu;
            rwIletisim["Aciklama"] = Aciklama;
            rwIletisim["KayitTarihi"] = DateTime.Now;

            dtIletisim.Rows.Add(rwIletisim);
            daIletisim.Update(dtIletisim);
            bag.Close();
            return ;
        }
        
        [WebMethod]
        public ProgramDurum VersiyonKontrol(string MacAdres)
        {
            ProgramDurum Sonuc = new ProgramDurum();
            DataTable dt = CreateATPDateTable("SELECT * FROM ATPVersiyonKontrol Where MacNo = '" + MacAdres + "'");
           
            if (dt.Rows.Count > 0)
            {
                Sonuc.VersiyonNo = dt.Rows[0]["VersiyonNo"].ToString();
                Sonuc.Durumu = Convert.ToInt32(dt.Rows[0]["Durumu"].ToString());                
                Sonuc.AcilisMesaj = dt.Rows[0]["AcilisMesaj"].ToString();
                Sonuc.LisansMesaj = dt.Rows[0]["LisansMesaj"].ToString();
                Sonuc.IndirmeDosyasi = dt.Rows[0]["IndirmeDosyasi"].ToString();
                Sonuc.LisansTarihi = Convert.ToDateTime(dt.Rows[0]["LisansTarihi"].ToString());
            }
            else
            {
                //** Yeni Kayıt Ekleme
                SqlConnection bag = CreateATPSqlConnection();
                SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM ATPVersiyonKontrol WHERE 2 = 1", bag);
                SqlCommandBuilder builder = new SqlCommandBuilder(adapter);

                // Create a dataset object
                DataSet ds = new DataSet("ATPVersiyonKontrolSet");
                adapter.Fill(ds, "ATPVersiyonKontrol");

                DataTable VersionTable = ds.Tables["ATPVersiyonKontrol"];
                DataRow row = VersionTable.NewRow();
                row["MacNo"] = MacAdres;
                row["VersiyonNo"] = "";
                row["Durumu"] = 5;
                row["AcilisMesaj"] = "";
                row["LisansMesaj"] = DateTime.Now.AddDays(15).ToString() + " Tarihine Kadar Süreli Demo Kullanım";
                row["IndirmeDosyasi"] = "";
                row["LisansTarihi"] = DateTime.Now.AddDays(15);
                row["KayitTarihi"] = DateTime.Now;

                VersionTable.Rows.Add(row);                
                adapter.Update(ds, "ATPVersiyonKontrol");


                //** Sonuc Gönderiliyor
                Sonuc.VersiyonNo = "";
                Sonuc.Durumu = 5;
                Sonuc.AcilisMesaj = "";
                Sonuc.LisansMesaj = DateTime.Now.AddDays(15).ToString() + " Tarihine Kadar Süreli Demo Kullanım";
                Sonuc.IndirmeDosyasi = "";
                Sonuc.LisansTarihi = DateTime.Now.AddDays(15);
            }
            return Sonuc;
        }

        [WebMethod]
        public ProgramBilgisi VersiyonKontrol2(string MacAdres)
        {
            ProgramBilgisi Sonuc = new ProgramBilgisi();
            DataTable dt = CreateATPDateTable("SELECT * FROM ATPVersiyonKontrol Where MacNo = '" + MacAdres + "'");

            if (dt.Rows.Count > 0)
            {
                Sonuc.VersiyonNo = dt.Rows[0]["VersiyonNo"].ToString();
                Sonuc.Durumu = Convert.ToInt32(dt.Rows[0]["Durumu"].ToString());
                Sonuc.BilgilendirmeUrl = dt.Rows[0]["BilgilendirmeUrl"].ToString();
                Sonuc.AcilisMesaj = dt.Rows[0]["AcilisMesaj"].ToString();
                Sonuc.LisansMesaj = dt.Rows[0]["LisansMesaj"].ToString();
                Sonuc.IndirmeDosyasi = dt.Rows[0]["IndirmeDosyasi"].ToString();
                Sonuc.LisansTarihi = Convert.ToDateTime(dt.Rows[0]["LisansTarihi"].ToString());
            }
            else
            {
                //** Yeni Kayıt Ekleme
                SqlConnection bag = CreateATPSqlConnection();
                SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM ATPVersiyonKontrol WHERE 2 = 1", bag);
                SqlCommandBuilder builder = new SqlCommandBuilder(adapter);

                // Create a dataset object
                DataSet ds = new DataSet("ATPVersiyonKontrolSet");
                adapter.Fill(ds, "ATPVersiyonKontrol");

                DataTable VersionTable = ds.Tables["ATPVersiyonKontrol"];
                DataRow row = VersionTable.NewRow();
                row["MacNo"] = MacAdres;
                row["VersiyonNo"] = "";
                row["Durumu"] = 5;
                row["BilgilendirmeUrl"] = "";
                row["AcilisMesaj"] = "";
                row["LisansMesaj"] = DateTime.Now.AddDays(15).ToString() + " Tarihine Kadar Süreli Demo Kullanım";
                row["IndirmeDosyasi"] = "";
                row["LisansTarihi"] = DateTime.Now.AddDays(15);
                row["KayitTarihi"] = DateTime.Now;

                VersionTable.Rows.Add(row);
                adapter.Update(ds, "ATPVersiyonKontrol");


                //** Sonuc Gönderiliyor
                Sonuc.VersiyonNo = "";
                Sonuc.Durumu = 5;
                Sonuc.BilgilendirmeUrl = "";
                Sonuc.AcilisMesaj = "";
                Sonuc.LisansMesaj = DateTime.Now.AddDays(15).ToString() + " Tarihine Kadar Süreli Demo Kullanım";
                Sonuc.IndirmeDosyasi = "";
                Sonuc.LisansTarihi = DateTime.Now.AddDays(15);
            }
            return Sonuc;
        }

        [WebMethod]
        public void VersiyonTakip(string MacAdres, string Versiyon)
        {
            SqlConnection bag = CreateATPSqlConnection();
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM ATPIslemler WHERE 2 = 1", bag);
            SqlCommandBuilder builder = new SqlCommandBuilder(adapter);

            // Create a dataset object
            DataSet ds = new DataSet("ATPIslemlerSet");
            adapter.Fill(ds, "ATPIslemler");

            DataTable VersionTable = ds.Tables["ATPIslemler"];
            DataRow row = VersionTable.NewRow();
            row["MacNo"] = MacAdres;
            row["VersiyonNo"] = Versiyon;
            row["KayitTarihi"] = DateTime.Now;

            VersionTable.Rows.Add(row);
            adapter.Update(ds, "ATPIslemler");
            bag.Close();
        }

        [WebMethod]
        public void BilgilendirmeGosterme(string MacAdres)
        {

            SqlConnection bag = CreateATPSqlConnection();
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = "UPDATE ATPVersiyonKontrol SET BilgilendirmeUrl = '' WHERE MacNo = '" + MacAdres + "'";
            cmd.CommandType = CommandType.Text;
            cmd.Connection = bag;
            cmd.ExecuteReader();
            bag.Close();
        }

    }

    public class ProgramDurum
    {
        public string VersiyonNo { get; set; }
        public int Durumu { get; set; }
        public string AcilisMesaj { get; set; }
        public string LisansMesaj { get; set; }
        public string IndirmeDosyasi { get; set; }
        public DateTime LisansTarihi { get; set; }
    }

    public class ProgramBilgisi
    {
        public string VersiyonNo { get; set; }
        public int Durumu { get; set; }
        public string BilgilendirmeUrl { get; set; }
        public string AcilisMesaj { get; set; }
        public string LisansMesaj { get; set; }
        public string IndirmeDosyasi { get; set; }
        public DateTime LisansTarihi { get; set; }
    }



}
