﻿using System;
using System.Net;
using System.Text;
using System.IO;
using System.Xml;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;

namespace $safeprojectname$
{
    public partial class OOSPay : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string strMode = "PROD";
                string strApiVersion = "v0.01";
                string strTerminalProvUserID = "PROVOOS";
                string strType = "sales";
                string strAmount = "100"; //İşlem Tutarı 1.00 TL için 100 gönderilmeli.
                string strCurrencyCode = "949";
                string strInstallmentCount = ""; //Taksit Sayısı. Boş gönderilirse taksit yapılmaz
                string strTerminalUserID = "xxxxxxx";
                string strOrderID = "deneme123";
                string strCustomeripaddress = Request.UserHostAddress; //Kullanıcının IP adresini alır
                string strCustomeremailaddress = "eticaret@garanti.com.tr";
                string strTerminalID = "XXXXXXXX";
                string _strTerminalID = "0" + strTerminalID; //Başına 0 eklenerek 9 digite tamamlanmalıdır.
                string strTerminalMerchantID = "XXXXXXX"; //Üye İşyeri Numarası
                string strStoreKey = "XXXXXXX"; //3D Secure şifresi
                string strProvisionPassword = "XXXXXXX"; //TerminalProvUserID şifresi
                string strSuccessURL = "http://<sunucu_adresi>/OOSPayResults.aspx";
                string strErrorURL = "http://<sunucu_adresi>/OOSPayResults.aspx";
                string strCompanyName = "TradeSiS";
                string strlang = "tr";
                string strRefreshTime = "10";
                string strtimestamp = System.DateTime.Now.ToString(); //Random ve Unique bir değer olmalı
                string SecurityData = GetSHA1(strProvisionPassword + _strTerminalID).ToUpper();
                string HashData = GetSHA1(strTerminalID + strOrderID + strAmount + strSuccessURL + strErrorURL + strType + strInstallmentCount + strStoreKey + SecurityData).ToUpper();

                mode.Value = strMode;
                apiversion.Value = strApiVersion;
                terminalprovuserid.Value = strTerminalProvUserID;
                terminaluserid.Value = strTerminalUserID;
                terminalmerchantid.Value = strTerminalMerchantID;
                txntype.Value = strType;
                txnamount.Value = strAmount;
                txncurrencycode.Value = strCurrencyCode;
                txninstallmentcount.Value = strInstallmentCount;
                customeremailaddress.Value = strCustomeremailaddress;
                customeripaddress.Value = strCustomeripaddress;
                orderid.Value = strOrderID;
                terminalid.Value = strTerminalID;
                successurl.Value = strSuccessURL;
                errorurl.Value = strErrorURL;
                companyname.Value = strCompanyName;
                lang.Value = strlang;
                secure3dhash.Value = HashData;
                txntimestamp.Value = strtimestamp;
                refreshtime.Value = strRefreshTime;
            }
        }

        public string GetSHA1(string SHA1Data)
        {
            SHA1 sha = new SHA1CryptoServiceProvider();
            string HashedPassword = SHA1Data;
            byte[] hashbytes = Encoding.GetEncoding("ISO-8859-9").GetBytes(HashedPassword);
            byte[] inputbytes = sha.ComputeHash(hashbytes);
            return GetHexaDecimal(inputbytes);
        }

        public string GetHexaDecimal(byte[] bytes)
        {
            StringBuilder s = new StringBuilder();
            int length = bytes.Length;
            for (int n = 0; n <= length - 1; n++)
            {
                s.Append(String.Format("{0,2:x}", bytes[n]).Replace(" ", "0"));
            }
            return s.ToString();
        }
    }
}
