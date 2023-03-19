@sequential@Release_15.0 @Player_Enrollment@desktop
Feature: OLL_EP_PlayerEnrollment-Verifying end to end Player Enrollment Flow and Validating in Contact Information Tab in LoyaltyLite application

#******************************************************************************************************
#** Feature File                    : OL_EP_PlayerEnrollment
#** Feature Name                    : Verifing Player enrollment while entering data in all fields and validating in Contact Information Tab
#** Defect/Bug Linked(if any)       : NA
#** TFS TC ID Linked                : 597683
#****************************************************************************************************/
#**  Created Date:        Author:                  # Comments
#**  06/23/2022           Aayushi Nayak			Initial Draft
#**  07/04/2022			  Aayushi Nayak			Contact info & Dashboard data validation
#**  08/16/2022			  Aayushi Nayak			Contact Info data validation after bug fix
#**************************************************************************************************/


Scenario Outline:001- Enroll Player while entering data in all Fields (TC 597683)
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User runs query "select P.PropertyID from  UC_X_Property P where PropertyName = '<$PropertyName$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyID"
	When User runs query "SELECT TOP 1 AT.Name FROM dbo.UC_X_AccountType AT,UC_X_AccountTypeMaster ATM,AccountTypePropertyMappings APM where AT.AccountTypeMasterID = ATM.ID and APM.AccountTypeID = AT.ID and AT.AccountTypeMasterID = 3 and APM.PropertyID = '<$PropertyID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "EnrollmentName"
	When User generates a "UniqueString" with "FirstName:3" for key "FIRST_NAME"
	When User generates a "UniqueString" with "MiddleName:3" for key "MIDDLE_NAME"
	When User generates a "UniqueString" with "LastName:3" for key "LAST_NAME"
	#Search for Enroll Player Menu
	When User waits "4" seconds
	Given User clicks on "LLSideNavigation.mnu_EnrollPlayer"
	When User waits "2" seconds
	#Selecting Enrollment Type and Property
	Given User clicks on "OLL_ENROLLPLAYER.lst_EnrollmentType"
	When User waits "3" seconds
	Given User selects option "<$EnrollmentName$>" of element "OLL_ENROLLPLAYER.lst_EnrollmentType" by "value"
	Given User clicks on "OLL_ENROLLPLAYER.lst_enrollproperty"
	Given User selects option "<$PropertyName$>" of element "OLL_ENROLLPLAYER.lst_enrollproperty" by "value"
	Given User clicks on "OLL_ENROLLPLAYER.lst_Prefix"
	Given User selects option "<Prefix>" of element "OLL_ENROLLPLAYER.lst_Prefix" by "value"
	Given User types text "<$FIRST_NAME$>" in "OLL_ENROLLPLAYER.txt_FirstName"
	Given User types text "<$MIDDLE_NAME$>" in "OLL_ENROLLPLAYER.txt_middlename"
	Given User types text "<$LAST_NAME$>" in "OLL_ENROLLPLAYER.txt_LastName"
	Given User clicks on "OLL_ENROLLPLAYER.lst_SuffixType"
	Given User selects option "<Suffix>" of element "OLL_ENROLLPLAYER.lst_SuffixType" by "value"
	Given User types text "<DOB>" in "OLL_ENROLLPLAYER.txt_BirthDate"
	Given User clicks on "OLL_ENROLLPLAYER.lst_Gender"
	Given User selects option "<Gender>" of element "OLL_ENROLLPLAYER.lst_Gender" by "value"
	Given User types text "<Occupation>" in "OLL_ENROLLPLAYER.txt_occupation"
	#Entering details in Identification Section
	When User switch to window object "OLL_ENROLLPLAYER.frm_Identification_Frame"
	Given User clicks on "OLL_ENROLLPLAYER.lst_identificationtype"
	Given User selects option "<IdentificationType>" of element "OLL_ENROLLPLAYER.lst_identificationtype" by "value"
	When User waits "2" seconds
	Given User types text "<IdentificationID>" in "OLL_ENROLLPLAYER.txt_identificationnumb"
	When User waits "3" seconds
	Given User types text "<IdentificationDOB>" in "OLL_ENROLLPLAYER.txt_ident_dob"
	Given User clicks on "OLL_ENROLLPLAYER.txt_ident_expirydate"
	Given User types text "<IdentificationExpiryDate>" in "OLL_ENROLLPLAYER.txt_ident_expirydate"
	Given User clicks on "OLL_ENROLLPLAYER.lst_ident_country"
	Given User selects option "<IDCountry>" of element "OLL_ENROLLPLAYER.lst_ident_country" by "value"
	When User waits "2" seconds
	Given User clicks on "OLL_ENROLLPLAYER.lst_ident_state"
	Given User selects option "<IDState>" of element "OLL_ENROLLPLAYER.lst_ident_state" by "value"
    Given User clicks on "OLL_ENROLLPLAYER.lst_nationality"
	Given User selects option "<IDNationality>" of element "OLL_ENROLLPLAYER.lst_nationality" by "value"
	When User waits "2" seconds
    Given User clicks on "OLL_ENROLLPLAYER.lst_ident_gender"
	Given User selects option "<IDGender>" of element "OLL_ENROLLPLAYER.lst_ident_gender" by "value"
	When User waits "3" seconds
	When User switch to window object "default"
	Given User clicks on "LLSideNavigation.btn_pagedown"
	When User waits "3" seconds
	Given User enters text "<SSN>" in "OLL_ENROLLPLAYER.txt_socialsecurity"

	#Entering details in Address Section
	When User switch to window object "OLL_ENROLLPLAYER.frm_Address"
	Given User clicks on "OLL_ENROLLPLAYER.lst_AddressType"
	Given User selects option "<AddressType>" of element "OLL_ENROLLPLAYER.lst_AddressType" by "value"
	When User waits "3" seconds
	Given User types text "<AddressLine1>" in "OLL_ENROLLPLAYER.txt_AddressLine1"
	Given User types text "<AddressLine2>" in "OLL_ENROLLPLAYER.txt_AddressLine2"
	Given User types text "<AddressCity>" in "OLL_ENROLLPLAYER.txt_AddressCity"
	Given User clicks on "OLL_ENROLLPLAYER.lst_AddressCountryList"
	Given User selects option "<Country>" of element "OLL_ENROLLPLAYER.lst_AddressCountryList" by "value"
	When User runs query "select C.CountryCode from  UC_X_CountryCodeMaster C where CountryName = '<Country>'" with connection "<#Halo_db_connectionstring#>" and save with key "CountryCode"
    When User waits "3" seconds
	Given User clicks on "OLL_ENROLLPLAYER.lst_Address_State_List"
	When User waits "3" seconds
	Given User selects option "<State>" of element "OLL_ENROLLPLAYER.lst_Address_State_List" by "value"
	When User runs query "select S.StateCode from  UC_X_StateCode S where StateCodeDesc = '<State>'" with connection "<#Halo_db_connectionstring#>" and save with key "StateCode"
	Given User types text "<ZipCode>" in "OLL_ENROLLPLAYER.txt_Address_Zip"
	When User switch to window object "default"

	#Entering details in Telephone Section
	When User switch to window object "OLL_ENROLLPLAYER.frm_Telephone_frame"
	Given User clicks on "OLL_ENROLLPLAYER.lst_Telephone_type"
	Given User selects option "<PhoneType>" of element "OLL_ENROLLPLAYER.lst_Telephone_type" by "value"
	Given User types text "<TelephoneNumber>" in "OLL_ENROLLPLAYER.txt_Telephone_number"
	When User switch to window object "default"
	Given User clicks on "LLSideNavigation.btn_pagedown"
	When User waits "3" seconds

	#Entering details in Email Section
	When User switch to window object "OLL_ENROLLPLAYER.frm_Email_Frame"
	Given User clicks on "OLL_ENROLLPLAYER.lst_Email_Type"
	Given User selects option "<EmailType>" of element "OLL_ENROLLPLAYER.lst_Email_Type" by "value"
	Given User types text "<EmailAddress>" in "OLL_ENROLLPLAYER.txt_EmailAddress"
	When User switch to window object "default"
	
	#Entering details in Social Network Section
	When User switch to window object "OLL_ENROLLPLAYER.frm_SocailNetwork"
	Given User clicks on "OLL_ENROLLPLAYER.lst_SocialNetwork_Type"
	Given User selects option "<SocialType>" of element "OLL_ENROLLPLAYER.lst_SocialNetwork_Type" by "value"
	Given User types text "<SoicalAccount>" in "OLL_ENROLLPLAYER.txt_SocialNetwrk_Acct_text"
	Given User clicks on "OLL_ENROLLPLAYER.lst_SocialNetwork_Acct_Status"
	Given User selects option "<StatusSocial>" of element "OLL_ENROLLPLAYER.lst_SocialNetwork_Acct_Status" by "value"
	When User switch to window object "default"

	#Entering details in SMS Section
	When User switch to window object "OLL_ENROLLPLAYER.frm_SMS_Frame"
	Given User clicks on "OLL_ENROLLPLAYER.lst_SMS_Type"
	Given User selects option "<SMSType>" of element "OLL_ENROLLPLAYER.lst_SMS_Type" by "value"
	Given User types text "<SMSAccount>" in "OLL_ENROLLPLAYER.txt_SMS_Account_Text"
	Given User clicks on "OLL_ENROLLPLAYER.lst_SMS_Status"
	Given User selects option "<StatusSMS>" of element "OLL_ENROLLPLAYER.lst_SMS_Status" by "value"
	When User switch to window object "default"
	When User waits "3" seconds

	#Entering details in PIN Section
	Given User types text "<EnterPIN>" in "OLL_ENROLLPLAYER.txt_EnterPIN_Text"
	Given User types text "<EnterPINAgain>" in "OLL_ENROLLPLAYER.txt_ReEnterPin_Text"
	Given User clicks on "LLSideNavigation.btn_pagedown"
	When User waits "3" seconds
	
	
	#Entering details in Global Contact Preference Section
	When User switch to window object "OLL_ENROLLPLAYER.frm_GlobalPreferences"
	Given User clicks on "OLL_ENROLLPLAYER.chk_GlobalContactPreference_Address_Chec"
	When User waits "3" seconds
	When User switch to window object "default"
	When User waits "3" seconds
	Given User clicks on "LLSideNavigation.btn_pagedown"
	Given User clicks on "LLSideNavigation.btn_pagedown"
	Given User clicks on "LLSideNavigation.btn_pagedown"
	Given User clicks on "LLSideNavigation.btn_pagedown"
	When User waits "3" seconds
	#User click on Enroll Button
	Given User clicks on "OLL_ENROLLPLAYER.btn_enrollonly"
	When User waits "4" seconds
	#Get the UniversalPlayerID for validation
	When User gets attribute "Name" value of "OLL_ENROLLPLAYER.lbl_PlayerID" element to save with key "UniversalPlayerID"
	When User waits "4" seconds
	Given User closes application

	Examples:
	| DOB      | Suffix | Occupation     | IdentificationID | IdentificationDOB | IdentificationExpiryDate | SSN         | AddressLine1 | AddressLine2    | AddressCity | ZipCode | TelephoneNumber | EmailAddress   | SoicalAccount     | SMSAccount | EnterPIN | EnterPINAgain | State  | Country       | EmailType | StatusEmail | PhoneType | StatusPhone | SocialType | StatusSocial | SMSType  | StatusSMS | TelephoneNumberFormat | SMSAccountFormat | PlayerFirstName | PlayerMiddleName | PlayerLastName | PlayerName                        | AccountType        | EnrolledAt       | Prefix | Gender | IdentificationType | IDCountry     | IDState | IDNationality | IDGender | AddressType |
	| 1/1/1987 | Sr     | OccupationTest | 1234568          | 1/1/1987          | 1/1/2099                 | 656-57-5676 | Hno345,Road2 | Street1,Sector4 | NewCity     | 12345   | 9818821710      | Test@gmail.com | Test@facebook.com | 9818821710 | 2022     | 2022          | Nevada | United States | Primary   | Yes         | Primary   | Yes         | Facebook   | Yes          | Personal | Yes       | (981)882-1710         | (981) 882-1710   | <$FIRST_NAME$>  | <$MIDDLE_NAME$>  | <$LAST_NAME$>  | <$FIRST_NAME$> M <$LAST_NAME$> Sr | <$EnrollmentName$> | <$PropertyName$> | MR     | Male   | Alien Registration | United States | Nevada  | Indian        | Male     | Work        |

	
	Scenario Outline:002- Verify PIN & Player Details on Player Dashboard Section after enrolling Player in LL(TC 597683)
	
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	When User waits "3" seconds
	Given User types text "<$UniversalPlayerID$>" in "OLL_PLAYERDASHBOARD.txt_PlayerID_Search"
	When User waits "2" seconds
	Given User clicks on "OLL_PLAYERDASHBOARD.btn_PlayerSearch"
	Given User clicks on "LLSideNavigation.lblPlayerAction"
	Given User clicks on "LLSideNavigation.btn_pagedown"
	When User waits "2" seconds
	Then User verifies that element "OLL_RESETPIN.lnk_ResetPin" is present "true" on UI

	#Verify PIN saved while enrolling player
	Given User clicks on "OLL_RESETPIN.lnk_ResetPin"
	Given User enters text "<EnterPIN>" in "OLL_RESETPIN.txt_oldPin"
	Given User enters text "<EnterPIN>" in "OLL_RESETPIN.txt_NewPin"
	Given User enters text "<EnterPIN>" in "OLL_RESETPIN.txt_VerifyPin"
	Given User clicks on "OLL_RESETPIN.btn_OK"
	Then User verifies that element "OLL_RESETPIN.lbl_OldandNewPinErrorMsg" is present "true" on UI 
	When User waits "3" seconds
	Given User clicks on "OLL_RESETPIN.btn_Cancel"
	Given User clicks on "OLL_RESETPIN.btn_CloseBtn"
	Given User clicks on "OLL_PLAYERDASHBOARD.lnk_PlayerDashboard"
	When User gets attribute "Name" value of "OLL_PLAYERDASHBOARD.lbl_DOB" element to save with key "DOB"
	When User performs string operation "stringEquals" of provided value "<$DOB$>" with "<DOB>"
	When User waits "3" seconds
	When User gets attribute "Name" value of "OLL_PLAYERDASHBOARD.lbl_Occupation" element to save with key "Occupation"
	When User waits "3" seconds
	When User performs string operation "stringEquals" of provided value "<$Occupation$>" with "<Occupation>"
	When User gets attribute "Name" value of "OLL_PLAYERDASHBOARD.lbl_EnrollmentProperty" element to save with key "EnrolledAt"
	When User performs string operation "stringEquals" of provided value "<$EnrolledAt$>" with "<EnrolledAt>"
	

	Examples:
	| DOB             |  Occupation                | EnterPIN |   PlayerName                        | AccountType                       | EnrolledAt                     | 
	| DOB: 01/01/1987 | Occupation: OccupationTest | 2022     |  <$FIRST_NAME$> M <$LAST_NAME$> Sr  | Account Type: <$EnrollmentName$>  | Enrolled At: <$PropertyName$>  | 
	
	Scenario Outline:003- Verify Contact Information Status after enrolling Player (TC 597683 and Bug 599382)

	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	When User waits "3" seconds
	Given User types text "<$UniversalPlayerID$>" in "OLL_PLAYERDASHBOARD.txt_PlayerID_Search"
	When User waits "2" seconds
	Given User clicks on "OLL_PLAYERDASHBOARD.btn_PlayerSearch"

	#User click on Contact Information tab
	Given User clicks on "LLSideNavigation.lblPlayerAction"
	Given User clicks on "LLSideNavigation.mnu_ContactInfo"

	#Verify Contact Information "Physical Address" saved while enrolling player in Contact Information Tab
	When User gets attribute "Name" value of "OLL_MANAGECONTATCINFORMATION.tbl_PreferredPhysicalAddress" element to save with key "PrefferedPhysicalAddress"
	When User performs string operation "stringEquals" of provided value "<$PrefferedPhysicalAddress$>" with "<AddressLine1>"
	Given User clicks on "OLL_MANAGECONTATCINFORMATION.lnk_PhysicalAddress"
	When User gets attribute "Value" value of "OLL_MANAGECONTATCINFORMATION.tbl_AddressLine1" element to save with key "Addressline1"
	When User performs string operation "stringEquals" of provided value "<$Addressline1$>" with "<AddressLine1>"
	When User gets attribute "Value" value of "OLL_MANAGECONTATCINFORMATION.tbl_AddressLine2" element to save with key "Addressline2"
	When User performs string operation "stringEquals" of provided value "<$Addressline2$>" with "<AddressLine2>"
	When User gets attribute "Value" value of "OLL_MANAGECONTATCINFORMATION.tbl_AddressCity" element to save with key "AddressCity"
	When User performs string operation "stringEquals" of provided value "<$AddressCity$>" with "<AddressCity>"
	When User gets attribute "Value" value of "OLL_MANAGECONTATCINFORMATION.tbl_AddressState" element to save with key "AddressState"
	When User performs string operation "stringEquals" of provided value "<$AddressState$>" with "<AddressState>"
	When User gets attribute "Value" value of "OLL_MANAGECONTATCINFORMATION.tbl_ZipCode" element to save with key "ZipCode"
	When User performs string operation "stringEquals" of provided value "<$ZipCode$>" with "<ZipCode>"
	When User gets attribute "Value" value of "OLL_MANAGECONTATCINFORMATION.tbl_Country" element to save with key "Country"
	When User performs string operation "stringEquals" of provided value "<$Country$>" with "<Country>"	

	#Verify Contact Information "Email Address" saved while enrolling player in Contact Information Tab
	When User gets attribute "Name" value of "OLL_MANAGECONTATCINFORMATION.lbl_PerferredEmail" element to save with key "PrefferedEmail"
	When User performs string operation "stringEquals" of provided value "<$PrefferedEmail$>" with "<EmailAddress>"
	Given User clicks on "OLL_MANAGECONTATCINFORMATION.btn_EmailAddress"
	When User switch to window object "OLL_MANAGECONTATCINFORMATION.frm_Email"
	When User gets attribute "Value" value of "OLL_MANAGECONTATCINFORMATION.tbl_EmailType" element to save with key "EmailType"
	When User performs string operation "stringEquals" of provided value "<$EmailType$>" with "<EmailType>"
	When User gets attribute "Value" value of "OLL_MANAGECONTATCINFORMATION.tbl_EmailAddress" element to save with key "EmailAddress"
	When User performs string operation "stringEquals" of provided value "<$EmailAddress$>" with "<EmailAddress>"
	When User switch to window object "default"

	#Verify Contact Information "Phone" saved while enrolling player in Contact Information Tab
	When User gets attribute "Name" value of "OLL_MANAGECONTATCINFORMATION.lbl_PreferredPhone" element to save with key "PrefferedPhone"
	When User performs string operation "stringEquals" of provided value "<$PrefferedPhone$>" with "<TelephoneNumberFormat>"
	Given User clicks on "OLL_MANAGECONTATCINFORMATION.lnk_Phone"
	When User switch to window object "OLL_MANAGECONTATCINFORMATION.frm_Phone"
	When User gets attribute "Value" value of "OLL_MANAGECONTATCINFORMATION.tbl_PhoneType" element to save with key "PhoneType"
	When User performs string operation "stringEquals" of provided value "<$PhoneType$>" with "<PhoneType>"
	When User gets attribute "Value" value of "OLL_MANAGECONTATCINFORMATION.tbl_PhoneNumber" element to save with key "PhoneNumber"
	When User performs string operation "stringEquals" of provided value "<$PhoneNumber$>" with "<TelephoneNumberFormat>"
	When User switch to window object "default"

	#Verify Contact Information "SocialNetwork" saved while enrolling player in Contact Information Tab
	When User gets attribute "Name" value of "OLL_MANAGECONTATCINFORMATION.lnk_PreferredSocialNetwork" element to save with key "PrefferedSocialNetwork"
	When User performs string operation "stringEquals" of provided value "<$PrefferedSocialNetwork$>" with "<SoicalAccount>"
	Given User clicks on "OLL_MANAGECONTATCINFORMATION.lnk_SocialNetwork"
	When User switch to window object "OLL_MANAGECONTATCINFORMATION.frm_Social"
	When User gets attribute "Value" value of "OLL_MANAGECONTATCINFORMATION.tbl_SocialActType" element to save with key "SocialActType"
	When User performs string operation "stringEquals" of provided value "<$SocialActType$>" with "<SocialType>"
	When User gets attribute "Value" value of "OLL_MANAGECONTATCINFORMATION.tbl_SocialNetwrkAct" element to save with key "SocialNetworkAcct"
	When User performs string operation "stringEquals" of provided value "<$SocialNetworkAcct$>" with "<SoicalAccount>"
	When User switch to window object "default"

	#Verify Contact Information "SMS" saved while enrolling player in Contact Information Tab
	When User gets attribute "Name" value of "OLL_MANAGECONTATCINFORMATION.lbl_PreferredSMS" element to save with key "PrefferedSMS"
	When User performs string operation "stringEquals" of provided value "<$PrefferedSMS$>" with "<SMSAccountFormat>"
	Given User clicks on "OLL_MANAGECONTATCINFORMATION.lnk_SMS"
	When User switch to window object "OLL_MANAGECONTATCINFORMATION.frm_SMS"
	When User gets attribute "Value" value of "OLL_MANAGECONTATCINFORMATION.tbl_SmsType" element to save with key "SMSType"
	When User performs string operation "stringEquals" of provided value "<$SMSType$>" with "<SMSType>"
	When User gets attribute "Value" value of "OLL_MANAGECONTATCINFORMATION.tbl_SMSAccount" element to save with key "SMSAccount"
	When User performs string operation "stringEquals" of provided value "<$SMSAccount$>" with "<SMSAccountFormat>"
	When User switch to window object "default"



		Examples:
	| DOB      | Suffix | Occupation     | IdentificationID | IdentificationDOB | IdentificationExpiryDate | SSN         | AddressLine1 | AddressLine2    | AddressCity | AddressState | ZipCode | TelephoneNumber | EmailAddress | SoicalAccount | SMSAccount      |  Country | EmailType | StatusEmail | PhoneType | StatusPhone | SocialType | StatusSocial | SMSType | StatusSMS | TelephoneNumberFormat | SMSAccountFormat | PlayerFirstName | PlayerMiddleName | PlayerLastName | PlayerName | AccountType | EnrolledAt | Prefix | Gender | IdentificationType | IDCountry | IDState | IDNationality | IDGender | AddressType |
	| 1/1/1987 | Sr     | OccupationTest | 1234568          | 1/1/1987          | 1/1/2099                 | 656-57-5676 | Hno345,Road2 | Street1,Sector4 | NewCity     | NV           |12345   | 9818821710      | Test@gmail.com | Test@facebook.com | 9818821710 |   USA    | Primary   | Yes         | Primary   | Yes         | Facebook   | Yes          | Personal | Yes       | (981)882-1710         | (981) 8821710   | <$FIRST_NAME$>  | <$MIDDLE_NAME$>  | <$LAST_NAME$>  | <$FIRST_NAME$> M <$LAST_NAME$> Sr | <$EnrollmentName$> | <$PropertyName$> | MR     | Male   | Alien Registration | United States | Nevada  | Indian        | Male     | Work        |

	
	#Close the Loyalty Lite application 
	Scenario: 004-Close all instance of Loyalty Lite Desktop application. (TC 597683)
	When User switch to window application "ATI.Loyalty.Lite.Client.exe"
	Given User closes application