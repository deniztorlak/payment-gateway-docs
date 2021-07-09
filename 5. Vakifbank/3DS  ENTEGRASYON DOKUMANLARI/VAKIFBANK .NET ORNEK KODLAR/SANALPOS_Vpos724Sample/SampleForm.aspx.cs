using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace PayFlex.Vpos.Sample.Application
{
    public partial class SampleForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                return;
            }

            XmlDocument xmlDoc = new XmlDocument();

            XmlDeclaration xmlDeclaration = xmlDoc.CreateXmlDeclaration("1.0", "utf-8", null);
           
            XmlElement rootNode = xmlDoc.CreateElement("VposRequest");
            xmlDoc.InsertBefore(xmlDeclaration, xmlDoc.DocumentElement);
            xmlDoc.AppendChild(rootNode);

            //eklemek istedi�iniz di�er elementleride bu �ekilde ekleyebilirsiniz.
            XmlElement merchantNode = xmlDoc.CreateElement("MerchantId");
            XmlElement passwordNode = xmlDoc.CreateElement("Password");
            XmlElement terminalNode = xmlDoc.CreateElement("TerminalNo");
            XmlElement transactionTypeNode = xmlDoc.CreateElement("TransactionType");
            XmlElement transactionIdNode = xmlDoc.CreateElement("TransactionId");
            XmlElement currencyAmountNode = xmlDoc.CreateElement("CurrencyAmount"); //3D Secure i�lem ge�en i�yerlerimizin bu parametreyi kullanmas�na l�zum yoktur.
            XmlElement currencyCodeNode = xmlDoc.CreateElement("CurrencyCode"); //3D Secure i�lem ge�en i�yerlerimizin bu parametreyi kullanmas�na l�zum yoktur.
            XmlElement panNode = xmlDoc.CreateElement("Pan"); //3D Secure i�lem ge�en i�yerlerimizin bu parametreyi kullanmas�na l�zum yoktur.
            XmlElement cvvNode = xmlDoc.CreateElement("Cvv");
            XmlElement expiryNode = xmlDoc.CreateElement("Expiry"); //3D Secure i�lem ge�en i�yerlerimizin bu parametreyi kullanmas�na l�zum yoktur.
            XmlElement ClientIpNode = xmlDoc.CreateElement("ClientIp");
            XmlElement transactionDeviceSourceNode = xmlDoc.CreateElement("TransactionDeviceSource");

            //yukar�da ekledi�imiz node lar i�in de�erleri ekliyoruz.
            XmlText merchantText = xmlDoc.CreateTextNode("655500056");
            XmlText passwordtext = xmlDoc.CreateTextNode("123456");
            XmlText terminalNoText = xmlDoc.CreateTextNode("000123");
            XmlText transactionTypeText = xmlDoc.CreateTextNode("Sale");
            XmlText transactionIdText = xmlDoc.CreateTextNode(Guid.NewGuid().ToString("N")); //uniqe olacak �ekilde d�zenleyebilirsiniz.
            XmlText currencyAmountText = xmlDoc.CreateTextNode("90.50"); //tutar� nokta ile g�nderdi�inizden emin olunuz. ////3D Secure i�lem ge�en i�yerlerimizin bu parametreyi kullanmas�na l�zum yoktur.
            XmlText currencyCodeText = xmlDoc.CreateTextNode("949"); //3D Secure i�lem ge�en i�yerlerimizin bu parametreyi kullanmas�na l�zum yoktur.
            XmlText panText = xmlDoc.CreateTextNode("4543600299100712"); //3D Secure i�lem ge�en i�yerlerimizin bu parametreyi kullanmas�na l�zum yoktur.
            XmlText cvvText = xmlDoc.CreateTextNode("454");
            XmlText expiryText = xmlDoc.CreateTextNode("201611"); //3D Secure i�lem ge�en i�yerlerimizin bu parametreyi kullanmas�na l�zum yoktur.
            XmlText ClientIpText = xmlDoc.CreateTextNode("190.20.13.12");
            XmlText transactionDeviceSourceText = xmlDoc.CreateTextNode("0"); 

            //nodelar� root elementin alt�na ekliyoruz.
            rootNode.AppendChild(merchantNode);
            rootNode.AppendChild(passwordNode);
            rootNode.AppendChild(terminalNode);
            rootNode.AppendChild(transactionTypeNode);
            rootNode.AppendChild(transactionIdNode);
            rootNode.AppendChild(currencyAmountNode); //3D Secure i�yerlerimizin bu parametreyi kullanmas�na l�zum yoktur.
            rootNode.AppendChild(currencyCodeNode); //3D Secure i�lem ge�en i�yerlerimizin bu parametreyi kullanmas�na l�zum yoktur.
            rootNode.AppendChild(panNode);//3D Secure i�lem ge�en i�yerlerimizin bu parametreyi kullanmas�na l�zum yoktur.
            rootNode.AppendChild(cvvNode);
            rootNode.AppendChild(expiryNode); //3D Secure i�lem ge�en i�yerlerimizin bu parametreyi kullanmas�na l�zum yoktur.
            rootNode.AppendChild(ClientIpNode);
            rootNode.AppendChild(transactionDeviceSourceNode);

            //nodelar i�in olu�turdu�umuz textleri node lara ekliyoruz.
            merchantNode.AppendChild(merchantText);
            passwordNode.AppendChild(passwordtext);
            terminalNode.AppendChild(terminalNoText);
            transactionTypeNode.AppendChild(transactionTypeText);
            transactionIdNode.AppendChild(transactionIdText);
            currencyAmountNode.AppendChild(currencyAmountText); //3D Secure i�yerlerimizin bu parametreyi kullanmas�na l�zum yoktur.
            currencyCodeNode.AppendChild(currencyCodeText); //3D Secure i�lem ge�en i�yerlerimizin bu parametreyi kullanmas�na l�zum yoktur.
            panNode.AppendChild(panText); //3D Secure i�yerlerimizin bu parametreyi kullanmas�na l�zum yoktur.
            cvvNode.AppendChild(cvvText);
            expiryNode.AppendChild(expiryText); //3D Secure i�yerlerimizin bu parametreyi kullanmas�na l�zum yoktur.
            ClientIpNode.AppendChild(ClientIpText);
            transactionDeviceSourceNode.AppendChild(transactionDeviceSourceText);

            string xmlMessage = xmlDoc.OuterXml;

            //olu�turdu�umuz xml i vposa g�nderiyoruz.
            byte[] dataStream = Encoding.UTF8.GetBytes("prmstr="+xmlMessage);
            HttpWebRequest webRequest = (HttpWebRequest)HttpWebRequest.Create("http://localhost:4955/v3/vposreq.aspx");//Vpos adresi
            webRequest.Method = "POST";
            webRequest.ContentType = "application/x-www-form-urlencoded";
            webRequest.ContentLength = dataStream.Length;
            webRequest.KeepAlive = false;
            string responseFromServer = "";

            using (Stream newStream = webRequest.GetRequestStream())
            {
                newStream.Write(dataStream, 0, dataStream.Length);
                newStream.Close();
            }

            using (WebResponse webResponse = webRequest.GetResponse())
            {
                using (StreamReader reader = new StreamReader(webResponse.GetResponseStream()))
                {
                    responseFromServer = reader.ReadToEnd();
                    reader.Close();
                }

                webResponse.Close();
            }

            if (string.IsNullOrEmpty(responseFromServer))
            {
                return;
            }
            var xmlResponse = new XmlDocument();
            xmlResponse.LoadXml(responseFromServer);
            var resultCodeNode = xmlResponse.SelectSingleNode("VposResponse/ResultCode");
            var resultDescriptionNode = xmlResponse.SelectSingleNode("VposResponse/ResultDescription");
            string resultCode = "";
            string resultDescription = "";

            if(resultCodeNode != null)
            {
                resultCode = resultCodeNode.InnerText;
            }
            if (resultDescriptionNode != null)
            {
                resultDescription = resultDescriptionNode.InnerText;
            }

            lblResult.Text = "��lem Sonucu " + resultCode + " " + resultDescription;
        }
    }
}
