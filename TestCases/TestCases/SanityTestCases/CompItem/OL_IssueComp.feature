@Release15.0@Sequential@Comp_Issue@Sanity@Web
Feature: OL_IssueComp.

#******************************************************************************
#**  Feature File                 :  OL_IssueComp.feature
#**  Feature Name                 :  Issue Comp
#**  Defect/Bug Linked(if any)    :
#**  TFS TC ID Linked             : 592421
#********************************************************************************/
#**  Created Date:          Author:                  #Comments
#**  16/05/2022            Vijay Pratap Singh
#********************************************************************************/
Scenario: 001-Generating Test data.
	When User runs query "Select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User runs query "Select PropertyName from UC_X_Property Order By PropertyID ASC OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName2"
	When User runs query "Select OverrideTypeId from UC_X_OverrideType where OverrideType = 'Issue Comp'" with connection "<#Halo_db_connectionstring#>" and save with key "overridetypeid"
	When User runs query "select Top 1 OverrideReason from UC_X_OverrideReason where OverrideTypeId= '<$overridetypeid$>' Order by NEWID()" with connection "<#Halo_db_connectionstring#>" and save with key "Reason"
	When User runs query "Select top 1 OutletType from DBO.UC_X_OutletType where Active=1 order by NEWID()" with connection "<#Halo_db_connectionstring#>" and save with key "OutletType"
	When User runs query "Select top 1 FormName from DBO.UC_X_Form where activeFlag =1 order by newid()" with connection "<#Halo_db_connectionstring#>" and save with key "Form"
	When User runs query "Select Symbol from DBO.Currencies where CurrencyName='US Dollar'" with connection "<#Halo_db_connectionstring#>" and save with key "Symbol"
	When  User generates a "randomalphabetic" with "12" for key "Comment"
	When User generates a "getDate" with "M/d/yyyy" for key "currendate"

Scenario Outline: 002-Enroll Player using WebApp
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User generates a "RandomAlphabetic" with "5" for key "player_name"
	When Loyalty User Enroll Player via Webapp with "<$player_name$>" name and save key "PLAYER_ID" with data
		| Birthdate  | Gender | identificationtype |
		| 01/01/1985 | Male   | Driver's License   |

Scenario: 003-Verify Issue Comp functionality when user select Default Bucket view. (TC 592421)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#EB User Search Player.
	Given User clears "OLW_DASHBOARD.txt_playersearchbox"
	Given User enters text "<$PLAYER_ID$>" in "OLW_DASHBOARD.txt_playersearchbox"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.btnplayersearch"
	When User waits "2" seconds
	When EB User perform adjustment with function Authorization check "Y" with parameters
		| BucketView      | Property         | Amount | Reason     | Comment     |
		| <#Halo_Bucket#> | <$PropertyName$> | 1000   | <$Reason$> | <$Comment$> |
	When User waits "2" seconds
	#EB User Issue a Comp Item.
	Given EB user Issue Comp with Function Authorization "Y" with parameters
		| Comp Type           | Property         | Outlet          | BucketView      | Comp Item         | Comp Count | Issued Date    | Reason     | Comment     |
		| <#Halo_OutletType#> | <$PropertyName$> | <#Halo_Outlet#> | <#Halo_Bucket#> | <#Halo_CompItem#> | 1          | <$currendate$> | <$Reason$> | <$Comment$> |
	#EB User verify transaction at transaction Tab.
	When User waits "2" seconds
	Then EB User verify Player Transaction tab with Parameters
		| BucketView      | TransactionDTO | TransactionType | Status | Property         | Outlet          | User    | Comp Amount                             | Issue Date     | Outlet Type         | Comp Item         | Voided By | Comp Value                              | Redeem Date | Redeemed Amount | Redeemed By | Comp Remaining                          | Expiration date | Voided Date | Cost To Player                          | Reason     | Comment     |
		| <#Halo_Bucket#> | <$currendate$> | Comp Items      | Issue  | <$PropertyName$> | <#Halo_Outlet#> | oladmin | <$Symbol$><#Halo_CustomerCompValue#>.00 | <$currendate$> | <#Halo_OutletType#> | <#Halo_CompItem#> |           | <$Symbol$><#Halo_InternalCompValue#>.00 |             |                 |             | <$Symbol$><#Halo_CustomerCompValue#>.00 |                 |             | <$Symbol$><#Halo_CustomerCompValue#>.00 | <$Reason$> | <$Comment$> |

Scenario: 004-Verify Issue Comp functionality when user Issue chargeLess Comp.(TC 592421)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#EB User Search Player.
	Given User clears "OLW_DASHBOARD.txt_playersearchbox"
	Given User enters text "<$PLAYER_ID$>" in "OLW_DASHBOARD.txt_playersearchbox"
	When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.btnplayersearch"
	#EB User Issue a Comp Item.
	Given EB user Issue Comp with Function Authorization "Y" with parameters
		| Comp Type           | Property         | Outlet                    | BucketView      | Comp Item                   | Comp Count | Issued Date    | Reason     | Comment     |
		| <#Halo_OutletType#> | <$PropertyName$> | <#Halo_ChargelessOutlet#> | <#Halo_Bucket#> | <#Halo_ChargelessCompItem#> | 1          | <$currendate$> | <$Reason$> | <$Comment$> |
	#EB User verify transaction at transaction Tab.
	When User waits "2" seconds
	Then EB User verify Player Transaction tab with Parameters
		| BucketView      | TransactionDTO | Property         | Outlet                    | User    | TransactionType | Status | Comp Amount                                       | Issue Date     | Outlet Type         | Comp Item                   | Voided By | Comp Value                                        | Redeem Date | Redeemed Amount | Redeemed By | Comp Remaining                                    | Expiration date | Voided Date | Cost To Player                                    | Reason     | Comment     |
		| <#Halo_Bucket#> | <$currendate$> | <$PropertyName$> | <#Halo_ChargelessOutlet#> | oladmin | Comp Items      | Issue  | <$Symbol$><#Halo_ChargelessCustomerCompValue#>.00 | <$currendate$> | <#Halo_OutletType#> | <#Halo_ChargelessCompItem#> |           | <$Symbol$><#Halo_ChargelessInternalCompValue#>.00 |             |                 |             | <$Symbol$><#Halo_ChargelessCustomerCompValue#>.00 |                 |             | <$Symbol$><#Halo_ChargelessCustomerCompValue#>.00 | <$Reason$> | <$Comment$> |

Scenario: 005-Verify Issue Comp functionality when user Issue Auto Settle Comp.  (TC 592421)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#EB User Search Player.
	Given User clears "OLW_DASHBOARD.txt_playersearchbox"
	Given User enters text "<$PLAYER_ID$>" in "OLW_DASHBOARD.txt_playersearchbox"
	Given User clicks on "OLW_DASHBOARD.btnplayersearch"
	When User waits "2" seconds
	#EB User Issue a Comp Item & verify at bucket Balance Popup.
	Given EB user Issue Comp with Function Authorization "Y" with parameters
		| Comp Type           | Property         | Outlet                    | BucketView      | Comp Item                   | Comp Count | Issued Date    | Reason     | Comment     |
		| <#Halo_OutletType#> | <$PropertyName$> | <#Halo_AutoSettleOutlet#> | <#Halo_Bucket#> | <#Halo_AutoSettleCompItem#> | 1          | <$currendate$> | <$Reason$> | <$Comment$> |
	#EB User verify transaction at transaction Tab.
	When User waits "2" seconds
	Then EB User verify Player Transaction tab with Parameters
		| BucketView      | TransactionDTO | Property         | Outlet                    | User    | TransactionType | Status | Comp Amount                             | Issue Date     | Outlet Type         | Comp Item                   | Voided By | Comp Value                              | Redeem Date    | Redeemed Amount                         | Redeemed By | Comp Remaining | Expiration date | Voided Date | Cost To Player                          | Reason     | Comment     |
		| <#Halo_Bucket#> | <$currendate$> | <$PropertyName$> | <#Halo_AutoSettleOutlet#> | oladmin | Comp Items      | Redeem | <$Symbol$><#Halo_CustomerCompValue#>.00 | <$currendate$> | <#Halo_OutletType#> | <#Halo_AutoSettleCompItem#> |           | <$Symbol$><#Halo_InternalCompValue#>.00 | <$currendate$> | <$Symbol$><#Halo_CustomerCompValue#>.00 | oladmin     | 0              |                 |             | <$Symbol$><#Halo_CustomerCompValue#>.00 | <$Reason$> | <$Comment$> |

Scenario: 006-Verify the availability of secondary authorization if user tries to make transaction more than limit allowed.  (TC 592421)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#EB User Perform adjustment.
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<$PLAYER_ID$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "2" seconds
	Given User clicks on "PLAYER_SEARCH.PLAYER_SEARCH_BUTTON"
	When User waits "2" seconds
	When EB User perform adjustment with function Authorization check "Y" with parameters
		| BucketView      | Property         | Amount | Reason     | Comment     |
		| <#Halo_Bucket#> | <$PropertyName$> | 100    | <$Reason$> | <$Comment$> |
	When User waits "2" seconds
	#EB User Issue Comp Item
	Given User clicks on "PLAYER_INFO.ISSUE_COMP_BUTTON"
	Given User switches to frame "default"
	Given User switches to frame "ISSUE_COMP.ISSUE_COMP_FRAME"
	When User waits "2" seconds
	Given User selects option "<#Halo_OutletType#>" of element "ISSUE_COMP.COMP_TYPE_DROPDOWN" by "visibletext"
	When User waits "2" seconds
	Given User selects option "<$PropertyName$>" of element "ISSUE_COMP.COMP_PROPERTY_DROPDOWN" by "visibletext"
	When User waits "2" seconds
	Given User selects option "<#Halo_LimitCheckOutlet#>" of element "ISSUE_COMP.COMP_OUTLET_DROPDOWN" by "visibletext"
	When User waits "4" seconds
	Given User selects option "<#Halo_Bucket#>" of element "ISSUE_COMP.COMP_BUCKET_DROPDOWN" by "visibletext"
	When User waits "4" seconds
	Given User selects option "<#Halo_LimitCheckCompItem#>" of element "ISSUE_COMP.COMP_ITEM_DROPDOWN" by "visibletext"
	Given User clears "ISSUE_COMP.COMP_COUNT_TEXTBOX"
	When User waits "4" seconds
	Given User enters text "1" in "ISSUE_COMP.COMP_COUNT_TEXTBOX"
	Given User clicks on "ISSUE_COMP.COMP_ISSUEDATE_TEXTBOX"
	When User waits "2" seconds
	Given User clicks on "ISSUE_COMP.PASSWORD_TEXTBOX"
	Given User enters text "<#Halo_password#>" in "ISSUE_COMP.PASSWORD_TEXTBOX"
	Given User selects option "<$Reason$>" of element "ISSUE_COMP.ISSUE_COMP_REASON" by "visibletext"
	Given User enters text "<$Comment$>" in "ISSUE_COMP.COMMENT_TEXTBOX"
	Given User clicks on "ISSUE_COMP.ISSUE_COMP_BUTTON"
	When User waits "2" seconds
	Given User switches to frame "default"
	When User waits "2" seconds
	#Ev User validate the Error message on Secondary Authorization Popup.
	Then User verifies text - "The Limit has been reached. Secondary authorized user credentials are required to proceed." is present on page
	When User waits "2" seconds
	#Secondary Authorization.
	Given User enters text "<#Halo_username_3#>" in "AUTHORIZATION_POPUP.ISSUECOMP_USERID_SCNDAUTH"
	Given User enters text "<#Halo_password_3#>" in "AUTHORIZATION_POPUP.ISSUCOMP_PWD_SCNDAUTH"
	Given User selects option "<$Reason$>" of element "AUTHORIZATION_POPUP.AUTHORIZATION_POPUP_ISSUE_COMP_REASON" by "visibletext"
	Given User enters text "<$Comment$>" in "AUTHORIZATION_POPUP.ISSUCOMP_CMNT_SCNDAUTH"
	Given User clicks on "AUTHORIZATION_POPUP.ISSUCOMP_SUBMIT_SCNDAUTH"
	When User waits "2" seconds
	When User "refresh" the browser
	When User waits "2" seconds
	Then EB User verify Player Transaction tab with Parameters
		| BucketView      | TransactionDTO | Property         | Outlet                    | User                | TransactionType | Status | Comp Amount    | Issue Date     | Outlet Type         | Comp Item                   | Voided By | Comp Value                                   | Redeem Date | Redeemed Amount | Redeemed By | Comp Remaining | Expiration date | Voided Date | Cost To Player | Reason     | Comment     |
		| <#Halo_Bucket#> | <$currendate$> | <$PropertyName$> | <#Halo_LimitCheckOutlet#> | <#Halo_username_3#> | Comp Items      | Issue  | <$Symbol$>7.00 | <$currendate$> | <#Halo_OutletType#> | <#Halo_LimitCheckCompItem#> |           | <$Symbol$><#Halo_LimitInternalCompValue#>.00 |             |                 |             | <$Symbol$>7.00 |                 |             | <$Symbol$>7.00 | <$Reason$> | <$Comment$> |

Scenario: 007-Verify Issue Comp functionality when User select Consolidated Bucket view.(TC 592421)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	#EB User Perform adjustment.
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	Given User enters text "<$PLAYER_ID$>" in "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
	When User waits "2" seconds
	Given User clicks on "PLAYER_SEARCH.PLAYER_SEARCH_BUTTON"
	When User waits "2" seconds
	When EB User perform adjustment with function Authorization check "Y" with parameters
		| BucketView                  | Bucket                         | Property         | Amount | Reason     | Comment     |
		| <#Halo_ConsolidatedBucket#> | <#Halo_ConsolidatedSubBucket#> | <$PropertyName$> | 1000   | <$Reason$> | <$Comment$> |
	When User waits "2" seconds
	#EB User Issue a Comp Item.
	Given EB user Issue Comp with Function Authorization "Y" with parameters
		| Comp Type           | Property         | Outlet          | BucketView                  | Comp Item         | Comp Count | Issued Date    | Reason     | Comment     |
		| <#Halo_OutletType#> | <$PropertyName$> | <#Halo_Outlet#> | <#Halo_ConsolidatedBucket#> | <#Halo_CompItem#> | 1          | <$currendate$> | <$Reason$> | <$Comment$> |
	#EB User verify transaction at transaction Tab.
	When User waits "2" seconds
	Then EB User verify Player Transaction tab with Parameters
		| BucketView                  | TransactionDTO | Property         | Outlet          | User    | TransactionType | Status | Comp Amount                             | Issue Date     | Outlet Type         | Comp Item         | Voided By | Comp Value                              | Redeem Date | Redeemed Amount | Redeemed By | Comp Remaining                          | Expiration date | Voided Date | Cost To Player                          | Reason     | Comment     |
		| <#Halo_ConsolidatedBucket#> | <$currendate$> | <$PropertyName$> | <#Halo_Outlet#> | oladmin | Comp Items      | Issue  | <$Symbol$><#Halo_CustomerCompValue#>.00 | <$currendate$> | <#Halo_OutletType#> | <#Halo_CompItem#> |           | <$Symbol$><#Halo_InternalCompValue#>.00 |             |                 |             | <$Symbol$><#Halo_CustomerCompValue#>.00 |                 |             | <$Symbol$><#Halo_CustomerCompValue#>.00 | <$Reason$> | <$Comment$> |