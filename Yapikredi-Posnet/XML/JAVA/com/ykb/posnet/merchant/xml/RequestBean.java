package com.ykb.posnet.merchant.xml;

import java.util.Vector;

/**
 * This class holds details of a posnet XML service
 * request. It is used by RequestMaker to prepare
 * xml string to be sent to posnet system.
 */
public class RequestBean implements java.io.Serializable {
    public final static String amountFiller = "000000000000";
    public final static int AMOUNT_LENGTH = 12;
	public final static int TRANTYPE_LENGTH = 1;
	
    private String posnetID = "";
    private String mid = "";
    private String tid = "";
    private String username = "";
    private String password = "";
    private String staticIP = "";
	
    private String tranType = "";
    private String tranTypeToReverse = "";

    private String ccno = "";
    private String cvc = "";
    private String expDate = "";

    private String tranSeqNo = "123";
    private String installment = "00";
    private String orderID = "";
    private String amount = "";
    private String wpAmount = "";
    private String currencyCode = "";
    private String multiplePoint = "00";
    private String extraPoint = "000000";

    private String hostlogkey = "";
    private String authCode = "000000";
	
	//For Hazýrkart
    private String kontor = "";
    private String gsmNo = "";
	
    private String vftCode;
    private String koiCode;
	
	//For OOS/TDS
    private String merchantData = "";
    private String bankData = "";
    private String sign = "";
	private String xid = "";
    private boolean OOSRequest = false;
    private String cardHolderName = "";
    private String encKey = "";
    private String OOSRequestType = "";
    
    //For Trio:
    protected boolean dueInfoBegan = false;

    protected String[] dueDate = new String[4];

    protected String[] dueAmount = new String[4];

    protected int dueDateIndex = 0;

    protected String termDayCount = "";

    protected String noWarranty = "";
    
    public RequestBean() {
        pgiIndexForAmount = 0;
        pgiIndexForTranType = 0;
        multiplePointForSale = "00";
    	extraPointForSale = "000000";
    	multiplePointForInstSale = "00";
    	extraPointForInstSale = "000000";
    
    }
    
	//For Point Gain Inquiry
	public static class AmountDataForWPInq {
        public String Amount = "";
        public String TranType = "";
        public String worldPoint = "";
    	public String worldPointAmount = "";
    	public AmountDataForWPInq() {
        }
        public AmountDataForWPInq(String newAmount, String newTranType) {
            Amount = newAmount;
            TranType = newTranType;
        }
    }
		
	public String multiplePointForSale = "00";
	public String extraPointForSale = "000000";
	public String multiplePointForInstSale = "00";
	public String extraPointForInstSale = "000000";
	private Vector amountDatasForWPInq = new Vector();
	private int pgiIndexForAmount = 0;
	private int pgiIndexForTranType = 0;

    public String getMid() {
        if(mid == null)
            return "";
        return mid;
    }

    public String getTid() {
        if(tid == null)
            return "";
        return tid;
    }

	public String getWorldPointAmount() {
        return wpAmount;
    }

    public String getKoiCode() {
        return koiCode;
    }

    public String getAmount() {
        return amount;
    }

    public String getAuthCode() {
        return authCode;
    }

    public String getBankData() {
        return bankData;
    }

    public String getCardHolderName() {
        return cardHolderName;
    }

    public String getCcNo() {
        return ccno;
    }

    public String getExpDate() {
        return expDate;
    }

    public String getCvc() {
        return cvc;
    }
    
    public String getCurrencyCode() {
        return currencyCode;
    }

    public String getEncKey() {
        return encKey;
    }
    
    public String getExtraPnt() {
        return extraPoint;
    }

    public String getGsmno() {
        return gsmNo;
    }

    public String getHostLogKey() {
        return hostlogkey;
    }

    public String getKontor() {
        return kontor;
    }

    public String getMerchantData() {
        return merchantData;
    }
    
    public String getMultiplePnt() {
        return multiplePoint;
    }

    public String getOOSRequestType() {
        return OOSRequestType;
    }

    public String getOrderID() {
        return orderID;
    }

    public String getPassword() {
        return password;
    }

    public String getPosnetID() {
        return posnetID;
    }

    public String getSign() {
        return sign;
    }

    public String getStaticIP() {
        return staticIP;
    }

    public String getInstalment() {
        return installment;
    }

    public String getTranSeqNo() {
        return tranSeqNo;
    }

    public String getTranType() {
        return tranType;
    }

    public String getTranTypeToReverse() {
        return tranTypeToReverse;
    }

    public String getUsername() {
        return this.username;
    }

    public String getVftCode() {
        return vftCode;
    }

    public String getXid() {
        return xid;
    }

    public boolean isOOSRequest() {
        return OOSRequest;
    }

    public void setKoiCode(String koiCode) {
        this.koiCode = koiCode;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public void setAuthCode(String authCode) {
        this.authCode = authCode;
    }

    public void setBankData(String newBankData) {
        bankData = newBankData;
    }

    protected void setCardHolderName(String newCardHolderName) {
        cardHolderName = newCardHolderName;
    }

    public void setCcNo(String ccNo) {
        ccno = ccNo;
    }

    public void setCurrencyCode(String newCurrencyCode) {
        currencyCode = newCurrencyCode;
    }

    public void setCvc(String cvc) {
        this.cvc = cvc;
    }

    public void setEncKey(String newEncKey) {
        encKey = newEncKey;
    }

    public void setExpDate(String expDate) {
        this.expDate = expDate;
    }

    public void setExtraPnt(String extraPnt) {
        if (extraPnt == null)
            this.extraPoint = "000000";
        else
            this.extraPoint = com.ykb.util.Util.dizgeTamamla(extraPnt, 6, '0', false);
    }

    public void setMultiplePnt(String multiplePnt) {
        if (multiplePnt == null)
            this.multiplePoint = "00";
        else
            this.multiplePoint = com.ykb.util.Util.dizgeTamamla(multiplePnt, 2, '0', false);
    }

    public void setGsmno(String gsmno) {
        gsmNo = gsmno;
    }

    public void setHostLogKey(String hostLogKey) {
        this.hostlogkey = hostLogKey;
    }

    public void setKontur(String kontor) {
        this.kontor = kontor;
    }

    public void setMerchantData(String newMerchantData) {
        this.merchantData = newMerchantData;
    }

    public void setMid(String mid) {
        this.mid = mid;
    }
    
    protected void setOOSRequest(boolean newOOSRequest) {
        OOSRequest = newOOSRequest;
    }

    public void setOOSRequestType(String newOOSRequestType) {
        setOOSRequest(true);
        OOSRequestType = newOOSRequestType;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setPosnetID(String newPosnetID) {
        posnetID = newPosnetID;
    }

    public void setSign(String newSign) {
        sign = newSign;
    }

    public void setStaticIP(String staticIP) {
        if (staticIP != null)
            staticIP = staticIP.trim();
        this.staticIP = staticIP;
    }

    public void setInstalment(String instalment) {
        installment = com.ykb.util.Util.dizgeTamamla(instalment, 2, '0', false);
    }

    public void setTid(String tid) {
        this.tid = tid;
    }

    public void setTranSeqNo(String tranSeqNo) {
        this.tranSeqNo = tranSeqNo;
    }

    public void setTranType(String newTranType) {
        tranType = newTranType;
    }

    public void setTranTypeToReverse(String newTranTypeToReverse) {
        tranTypeToReverse = newTranTypeToReverse;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setVftCode(String newVftCode) {
        vftCode = newVftCode;
    }

    public void setXid(String newXid) {
        xid = newXid;
    }

    public void setWorldPointAmount(String newWPAmount) {
        wpAmount = newWPAmount;
    }

    public String toString() {
        return "TranType : " + getTranType() + "\r\n" + "TranTypeReverse : " + getTranTypeToReverse() + "\r\n" + "OOS Resquest Type : " + getOOSRequestType() + "\r\n" + "Mid : " + getMid() + "\r\n"
                + "Tid : " + getTid() + "\r\n" + "Posnet ID :	" + getPosnetID() + "\r\n" + "Amount : " + getAmount() + "\r\n" + "AuthCode :	" + getAuthCode() + "\r\n" + "CcNo : " + getCcNo() + "\r\n"
                + "Cvc : " + getCvc() + "\r\n" + "ExpDate : " + getExpDate() + "\r\n" + "ExtraPnt : " + getExtraPnt() + "\r\n" + "Gsmno : " + getGsmno() + "\r\n" + "HostLogKey : " + getHostLogKey()
                + "\r\n" + "Kontur : " + getKontor() + "\r\n" + "MultiplePnt : " + getMultiplePnt() + "\r\n" + "OrderID : " + getOrderID() + "\r\n" + "XID : " + getXid() + "\r\n" + "Password : "
                + getPassword() + "\r\n" + "Instalment Number : " + getInstalment() + "\r\n" + "TranSeqNo : " + getTranSeqNo() + "\r\n" + "Username : " + getUsername() + "\r\n" + "Card Holder Name : "
                + getCardHolderName() + "\r\n";
    }

    public boolean isDueInfoBegan() {
        return dueInfoBegan;
    }

    /**
     * @param dueInfoBegan
     *            The dueInfoBegan to set.
     */
    public void setDueInfoBegan(boolean dueInfoBegan) {
        this.dueInfoBegan = dueInfoBegan;
    }

    public void appendDueDate(String s) {
        if (dueAmount[dueDateIndex] != null)
            //bu vade tarihi ve tutarý girilmiþ.
            //bir sonrakini hazýrla:
            //Bu kontrolün burada yapýlmasýnýn nedeni
            //tarihin tutardan önce gelmesi.
            dueDateIndex++;

        if (dueDate[dueDateIndex] == null)
            dueDate[dueDateIndex] = "";

        dueDate[dueDateIndex] = dueDate[dueDateIndex] + s;
    }

    /**
     * @return Returns the dueDate array. Trio iþlemleri bazen birden çok vade tarihine sahip olabiliyor. Bu metod bu nedenle String array dönüyor. Tek vade tarihi kullanýlacaksa dizinin 0. elemaný
     *         kullanýlmalý.
     */
    public String[] getDueDate() {
        if (dueDate[0] != null && dueDate[0].length() > 6) {
            //2005-01-31'i 050131'e çevir:
            //0123456789
            for (int i = 0; i < dueDate.length; i++) {
                if (dueDate[i] != null)
                    dueDate[i] = dueDate[i].substring(8) + dueDate[i].substring(5, 7) + dueDate[i].substring(2, 4);
            }
        }
        return dueDate;
    }

    /**
     * @return Returns given dueDate.
     * Bu metod eclipse'in bir hatasý nedeniyle çaðýrýlamýyor.
     * @param index Hangi vade tarihi isteniyor? 0-3 arasýnda olmalý.
     */
    public String getDueDate(short index) {
        //0123456789
        //2005-01-01
        return dueDate[index].substring(2, 4) + dueDate[index].substring(5, 7) + dueDate[index].substring(8, 10);
    }

    /**
     * @return Returns the termDayCount.
     */
    public String getTermDayCount() {
        return termDayCount;
    }

    /**
     * @param termDayCount The termDayCount to set.
     */
    public void appendTermDayCount(String termDayCount) {
        this.termDayCount = this.termDayCount + termDayCount;
    }

    /**
     * @return Returns the noWarranty.
     */
    public String getNoWarranty() {
        return (noWarranty.equalsIgnoreCase("true")) ? "1" : "0";
    }

    /**
     * @param noWarranty The noWarranty to set.
     */
    public void appendNoWarranty(String noWarranty) {
        this.noWarranty = this.noWarranty + noWarranty;
    }

    /**
     * @return Returns the dueAmount.
     */
    public String[] getDueAmount() {
        return dueAmount;
    }

    /**
     * @param dueAmount The dueAmount to set.
     */
    public void appendDueAmount(String dueAmount) {
        if (this.dueAmount[dueDateIndex] == null)
            this.dueAmount[dueDateIndex] = "";

        this.dueAmount[dueDateIndex] = this.dueAmount[dueDateIndex] + dueAmount;
    }
    
    public void addPgiAmount(String s) {
        setPgiAmount(s);
        pgiIndexForAmount++;
    }
    
    public void setPgiAmount(String s) {
        if(pgiIndexForAmount >= 10)
            return;
        
        AmountDataForWPInq tempAmountDataForWPInq;
        
        if(pgiIndexForTranType > pgiIndexForAmount || amountDatasForWPInq.size() > pgiIndexForAmount) {
            tempAmountDataForWPInq = (AmountDataForWPInq)amountDatasForWPInq.elementAt(pgiIndexForAmount);
            if(tempAmountDataForWPInq == null)
                return; 
            tempAmountDataForWPInq.Amount = s;
            amountDatasForWPInq.setElementAt(tempAmountDataForWPInq, pgiIndexForAmount);
        }
        else {
            tempAmountDataForWPInq = new AmountDataForWPInq();
            tempAmountDataForWPInq.Amount = s;
            amountDatasForWPInq.add(pgiIndexForAmount, tempAmountDataForWPInq);
        }
    }
    
    public void incPgiAmountIndex(String s) {
        pgiIndexForAmount++;
    }
    
    public String getPgiAmount(int index) {
        if(index < 0 && index >= 10)
            return "";
        
        AmountDataForWPInq tempAmountDataForWPInq;
        
        try {
            tempAmountDataForWPInq = (AmountDataForWPInq)amountDatasForWPInq.elementAt(index);
        }
        catch (ArrayIndexOutOfBoundsException ex) {
            return "";
        }
        if(tempAmountDataForWPInq == null)
            return "";
        
        return tempAmountDataForWPInq.Amount;
    }
    
    public void addPgiTranType(String s) {
        setPgiTranType(s);
        pgiIndexForTranType++;
    }
    
    public void setPgiTranType(String s) {
        if(pgiIndexForTranType >= 10)
            return;
        
        AmountDataForWPInq tempAmountDataForWPInq;
        
        if(pgiIndexForAmount > pgiIndexForTranType || amountDatasForWPInq.size() > pgiIndexForTranType) {
            tempAmountDataForWPInq = (AmountDataForWPInq)amountDatasForWPInq.elementAt(pgiIndexForTranType);
            if(tempAmountDataForWPInq == null)
                return; 
            tempAmountDataForWPInq.TranType = s;
            amountDatasForWPInq.setElementAt(tempAmountDataForWPInq, pgiIndexForTranType);
        }
        else {
            tempAmountDataForWPInq = new AmountDataForWPInq();
            tempAmountDataForWPInq.TranType = s;
            amountDatasForWPInq.add(pgiIndexForTranType, tempAmountDataForWPInq);
        }
    }
    
    public void incPgiTranTypeIndex(String s) {
        pgiIndexForTranType++;
    }
    
    public String getPgiTranType(int index) {
        if(index < 0 && index >= 10)
            return "";
        
        AmountDataForWPInq tempAmountDataForWPInq;
        
        try {
            tempAmountDataForWPInq = (AmountDataForWPInq)amountDatasForWPInq.elementAt(index);
        }
        catch (ArrayIndexOutOfBoundsException ex) {
            return "";
        }
        if(tempAmountDataForWPInq == null)
            return "";
        
        return tempAmountDataForWPInq.TranType;
    }
    
    public void addPgiAmountData(String amount, String tranDate) {
        addPgiAmount(amount);
        addPgiTranType(tranDate);
    }
    
    public int getLengthOfAmountDatasForWPInq() {
        return amountDatasForWPInq.size();
    }
}
