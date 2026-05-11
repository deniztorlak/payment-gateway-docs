package com.ykb.posnet.merchant.sample.xml;

/**
 * This class holds details of a posnet XML service
 * request. It is used by RequestMaker to prepare
 * xml string to be sent to posnet system.
 */
public class RequestBean {
	public java.lang.String mid;
	public java.lang.String tid;
	public java.lang.String username;
	public java.lang.String password;

	public java.lang.String tranType;
	public java.lang.String tranTypeToReverse;

	public java.lang.String ccno;
	public java.lang.String cvc;
	public java.lang.String expDate;

	public java.lang.String installment;
	public java.lang.String orderID;
	public java.lang.String amount;
	public java.lang.String currencyCode;
	public java.lang.String multiplePoint;
	public java.lang.String extraPoint;

	public java.lang.String hostlogkey;
	public java.lang.String authCode;
	
	public java.lang.String vftCode;
	public java.lang.String koiCode;
}
