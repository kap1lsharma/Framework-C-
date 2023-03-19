Feature: Verifing Complete Player Enrollment Flow and Validating in Contact Information Tab

#******************************************************************************************************
#** Feature File                    : OL_EP_PlayerEnrollment
#** Feature Name                    : Verifing Player enrollment while entering data in all fields and validating in Contact Information Tab
#** Defect/Bug Linked(if any)       : NA
#** TFS TC ID Linked                : 591088
#****************************************************************************************************/
#**  Created Date:        Author:                  # Comments
#**  05/16/2022           Robbie Kalra				Initial Draft
#**************************************************************************************************/
@sequential@Release_15.0 @Player_Enrollment
Scenario: 001- Update Enrollment Type settings under Configure Enrollment page 
	#Login to WebApp and Pick property and enrollment type values
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User runs query "select P.PropertyID from  UC_X_Property P where PropertyName = '<$PropertyName$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyID"
	When User runs query "SELECT TOP 1 CONCAT( AT.Name, ' ( ' ,ATM.Name, ' )' ) FROM dbo.UC_X_AccountType AT,UC_X_AccountTypeMaster ATM,AccountTypePropertyMappings APM where AT.AccountTypeMasterID = ATM.ID and APM.AccountTypeID = AT.ID and AT.AccountTypeMasterID = 3 and APM.PropertyID = '<$PropertyID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "EnrollmentName"
	#Search for Conigure Enrollment page
	Given User enters text "Configure Enrollment" in "lylMAIN_NAV_BOX.menu_Search_Box"
	When User waits "2" seconds
	Given User clicks on "lylCONFIG_ENROLLMENT.conf_enrollmnt_menu"
	#Search for Conigure Enrollment Type
	Given User enters text "<$EnrollmentName$>" in "lylCONFIG_ENROLLMENT.Enrlment_type__seachbox"
	Given User clicks on "lylCONFIG_ENROLLMENT.Enrollmentype_searchlist" with parameters
        | Key            | Value              |
        | enrollmenttype | <$EnrollmentName$> |
	#Set values for Conigure Enrollment Type
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value           |
		| infoItem  | PlayerIdentity1 |
		| condition | Require         |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value           |
		| infoItem  | PlayerIdentity2 |
		| condition | Require         |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value    |
		| infoItem  | Gender   |
		| condition | Require  |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value      |
		| infoItem  | Occupation |
		| condition | Require    |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value          |
		| infoItem  | Identification |
		| condition | Require        |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value    |
		| infoItem  | Address  |
		| condition | Require  |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value     |
		| infoItem  | Telephone |
		| condition | Require  |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value    |
		| infoItem  | Email    |
		| condition | Require  |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value    |
		| infoItem  | Social   |
		| condition | Require  |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value    |
		| infoItem  | SMS      |
		| condition | Require  |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value    |
		| infoItem  | PIN      |
		| condition | Require  |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value    |
		| infoItem  | SSN      |
		| condition | Require  |
	Given User clicks without delay on "lylCONFIG_ENROLLMENT.rdb_EnrollmentTypeInfoItem" with parameters
		| Key       | Value      |
		| infoItem  | EnrollProp |
		| condition | Optional   |
	Given User clicks on "lylCONFIG_ENROLLMENT.SaveEnrollmentType_Button"
	#Verify enrollment type created successfully and visible in the left panel
	Then User verifies that element "lylCONFIG_ENROLLMENT.EnrollmentCreatedMsg_Text" is present "true" on UI with parameters
		| Key           | Value                                |
		| Enrollmenttxt | Enrollment type successfully updated |

Scenario Outline:002- Enroll Player while entering data in all Fields (TC 591088)
    #Login to WebApp and Pick property and enrollment type values
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User runs query "select P.PropertyID from  UC_X_Property P where PropertyName = '<$PropertyName$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyID"
	When User runs query "SELECT TOP 1 AT.Name FROM dbo.UC_X_AccountType AT,UC_X_AccountTypeMaster ATM,AccountTypePropertyMappings APM where AT.AccountTypeMasterID = ATM.ID and APM.AccountTypeID = AT.ID and AT.AccountTypeMasterID = 3 and APM.PropertyID = '<$PropertyID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "EnrollmentName"
	When User generates a "UniqueString" with "FirstName:3" for key "FIRST_NAME"
	When User generates a "UniqueString" with "MiddleName:3" for key "MIDDLE_NAME"
	When User generates a "UniqueString" with "LastName:3" for key "LAST_NAME"
	#Search for Enroll Player Menu
	Given User enters text "Enroll Player" in "lylMAIN_NAV_BOX.menu_Search_Box"
	When User waits "2" seconds
	#Selecting Enrollment Type and Property
	Given User clicks on "lylENROLL_PLAYER.EnrollPlayer_Menu"
	Given User clicks on "lylENROLL_PLAYER.Click_EnrollmentType_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.EnrollmentType_DropDown" with parameters
        | Key            | Value              |
        | EnrollmentType | <$EnrollmentName$> |
	Given User clicks on "lylENROLL_PLAYER.Click_PropertyDropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.PropertyDropDown" with parameters
        | Key            | Value              |
        | PropertyID     | <$PropertyName$>   |
	#Entering details in Player Identity Section
    Given User clicks on "lylENROLL_PLAYER.Click_Prefix_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Prefix_DropDown" with parameters
        | Key            | Value            |
        | PIPrefix       | <Prefix>         |  
	Given User enters text "<$FIRST_NAME$>" in "lylENROLL_PLAYER.FirstName_Txtbox"
	Given User enters text "<$MIDDLE_NAME$>" in "lylENROLL_PLAYER.MiddleName_TextBox"
	Given User enters text "<$LAST_NAME$>" in "lylENROLL_PLAYER.LastName_TxtBox"
	Given User clicks on "lylENROLL_PLAYER.Click_Suffix_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Suffix_DropDown" with parameters
        | Key            | Value      |
        | PISuffix       | <Suffix>   |
	Given User enters text "<DOB>" in "lylENROLL_PLAYER.DOB_TextBox"
	Given User clicks on "lylENROLL_PLAYER.Click_Gender_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Gender_DropDown" with parameters
        | Key            | Value        |
        | PIGender       | <Gender>     |
	Given User enters text "<Occupation>" in "lylENROLL_PLAYER.Occupation_TextBox"
	#Entering details in Identification Section
	Given User clicks on "lylENROLL_PLAYER.Click_ID_Type_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.ID_Type_DropDown" with parameters
        | Key                      | Value                |
        | IdentificationType       | <IdentificationType> |
	When User waits "2" seconds
	Given User enters text "<IdentificationID>" in "lylENROLL_PLAYER.ID#_TextBox"
	When User waits "3" seconds
	Given User clicks on "lylENROLL_PLAYER.ID_DOB_Text Box"
	When User waits "3" seconds
	Given User enters text "<IdentificationDOB>" in "lylENROLL_PLAYER.ID_DOB_Text Box"
	Given User clicks on "lylENROLL_PLAYER.ID_ExpireDate_TextBox"
	Given User enters text "<IdentificationExpiryDate>" in "lylENROLL_PLAYER.ID_ExpireDate_TextBox"
	Given User clicks on "lylENROLL_PLAYER.Click_ID_Country_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.ID_CountryDropDown" with parameters
        | Key                         | Value            |
        | IdentificationCountry       | <IDCountry>      |
	When User waits "2" seconds
	Given User clicks on "lylENROLL_PLAYER.Click_ID_State_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.ID_State_Drop Down" with parameters
        | Key                     | Value              |
        | IdentificationState     | <IDState>          |
    Given User clicks on "lylENROLL_PLAYER.Click_ID_Nationality_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.ID_Nationality" with parameters
        | Key                       | Value              |
        | IdentificationNationality | <IDNationality>    |
    Given User clicks on "lylENROLL_PLAYER.Click_ID_Gender_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.ID_Gender" with parameters
        | Key                       | Value              |
        | IdentificationGender      | <IDGender>         |
	Given User clears "lylENROLL_PLAYER.SocialSecurity#_TextBox"
	Given User enters text "<SSN>" in "lylENROLL_PLAYER.SocialSecurity#_TextBox"
	#Entering details in Address Section
	Given User clicks on "lylENROLL_PLAYER.Address_OptIn_RadioButton"
	Given User clicks on "lylENROLL_PLAYER.Address_Preferred_RadioButton"
	Given User clicks on "lylENROLL_PLAYER.Click_Address_Type_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Address_Type_Drop Down" with parameters
        | Key      | Value          |
        | AddType  | <AddressType>  |
	When User waits "3" seconds
	Given User enters text "<AddressLine1>" in "lylENROLL_PLAYER.AddressLine1_TextBox"
	Given User enters text "<AddressLine2>" in "lylENROLL_PLAYER.AddressLine2_TextBox"
	Given User enters text "<AddressCity>" in "lylENROLL_PLAYER.Address_City_Text Box"
	Given User clicks on "lylENROLL_PLAYER.Click_Address_Country_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Address_Country_DropDown" with parameters
        | Key             | Value        |
        | AddressCountry  | <Country>    |
	When User runs query "select C.CountryCode from  UC_X_CountryCodeMaster C where CountryName = '<Country>'" with connection "<#Halo_db_connectionstring#>" and save with key "CountryCode"
    When User waits "3" seconds
	Given User clicks on "lylENROLL_PLAYER.Click_Address_State_DropDown"
	When User waits "3" seconds
	Given User clicks on "lylENROLL_PLAYER.Address_State_DropDown" with parameters
        | Key             | Value     |
        | AddressState    | <State>   |
	When User runs query "select S.StateCode from  UC_X_StateCode S where StateCodeDesc = '<State>'" with connection "<#Halo_db_connectionstring#>" and save with key "StateCode"
	Given User enters text "<ZipCode>" in "lylENROLL_PLAYER.Address_ZipCode"
	#Entering details in Telephone Section
	Given User clicks on "lylENROLL_PLAYER.Telephone_OptIn_CheckBox"
	Given User clicks on "lylENROLL_PLAYER.Telephone_Preferred_CheckBox"
	Given User clicks on "lylENROLL_PLAYER.Click_Telephone_Type_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Telephone_Type_DropDown" with parameters
        | Key            | Value       |
        | TelephoneType  | <PhoneType> |
	Given User enters text "<TelephoneNumber>" in "lylENROLL_PLAYER.Telephone_TelephoneNumber_TextBox"
	Given User clicks on "lylENROLL_PLAYER.Click_Telephone_Status_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.Telephone_Status_DropDown" with parameters
        | Key              | Value         |
        | TelephoneStatus  | <StatusPhone> |
	#Entering details in Email Section
	Given User clicks on "lylENROLL_PLAYER.EmailAddress_OptIn_CheckBox"
	Given User clicks on "lylENROLL_PLAYER.EmailAddress_Preferred_CheckBox"
	Given User clicks on "lylENROLL_PLAYER.Click_Email_Type_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.EmailAddress_Type_DropDown" with parameters
        | Key               | Value       |
        | EmailAddressType  | <EmailType> |
	Given User enters text "<EmailAddress>" in "lylENROLL_PLAYER.EmailAddress_EmailAddress_Text_Box"
	Given User clicks on "lylENROLL_PLAYER.Click_EmailAdress_Status_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.EmailAddress_Status_DropDown" with parameters
        | Key          | Value             |
        | EmailStatus  | <StatusEmail>     |
	#Entering details in Social Network Section
	Given User clicks on "lylENROLL_PLAYER.SocialNetwok_OptIn_Checkbox"
	Given User clicks on "lylENROLL_PLAYER.Social_Checkbox_Preferred"
	Given User clicks on "lylENROLL_PLAYER.Click_SocialNetwork_Type_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.SocialNetwork_Type_DropDown" with parameters
        | Key                | Value           |
        | SoicalNetworkType  | <SocialType>    |
	Given User enters text "<SoicalAccount>" in "lylENROLL_PLAYER.SocialNetwrok_Account_TextBox"
	Given User clicks on "lylENROLL_PLAYER.Click_SocialNetwork_Status_DropDwon"
	Given User clicks without delay on "lylENROLL_PLAYER.SocialNetwork_Status_DropDown" with parameters
        | Key                  | Value           |
        | SoicalNetworkStatus  | <StatusSocial>  |
	#Entering details in SMS Section
	Given User clicks on "lylENROLL_PLAYER.SMS_OptIn_CheckBox"
	Given User clicks on "lylENROLL_PLAYER.SMS_Preferred_CheckBox"
	Given User clicks on "lylENROLL_PLAYER.Click_SMS_Type_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.SMS_Type_DropDown" with parameters
        | Key      | Value       |
        | TypeSMS  | <SMSType>   |
	Given User enters text "<SMSAccount>" in "lylENROLL_PLAYER.SMS_Account_TextBox"
	Given User clicks on "lylENROLL_PLAYER.Click_SMS_Status_DropDown"
	Given User clicks without delay on "lylENROLL_PLAYER.SMS_Status_DropDown" with parameters
        | Key        | Value       |
        | SMSStatus  | <StatusSMS> |
	#Entering details in PIN Section
	Given User enters text "<EnterPIN>" in "lylENROLL_PLAYER.PIN_EnterPIN_TextBox"
	Given User enters text "<EnterPINAgain>" in "lylENROLL_PLAYER.PIN_EnterPINAgain_TextBox"  
	#Entering details in Global Contact Preference Section
	Given User clicks on "lylENROLL_PLAYER.GlobalContactPreference_Address_CheckBox"
	#User click on Enroll Button
	Given User clicks on "lylENROLL_PLAYER.EnrollOnly_Button"
	When User waits "3" seconds
	When User gets attribute "getText" value of "lylPlayer_Info.PlayerID" element to save with key "UniversalPlayerID"

		Examples:
	| DOB      | Suffix | Occupation     | IdentificationID | IdentificationDOB | IdentificationExpiryDate | SSN         | AddressLine1 | AddressLine2    | AddressCity | ZipCode | TelephoneNumber | EmailAddress   | SoicalAccount     | SMSAccount | EnterPIN | EnterPINAgain | State  | Country       | EmailType | StatusEmail | PhoneType | StatusPhone | SocialType | StatusSocial | SMSType  | StatusSMS | TelephoneNumberFormat | SMSAccountFormat | PlayerFirstName | PlayerMiddleName | PlayerLastName | PlayerName                        | AccountType        | EnrolledAt       | Prefix | Gender | IdentificationType | IDCountry     | IDState | IDNationality | IDGender | AddressType |
	| 1/1/1987 | Sr     | OccupationTest | 1234568          | 1/1/1987          | 1/1/2099                 | 656-57-5676 | Hno345,Road2 | Street1,Sector4 | NewCity     | 12345   | 9818821710      | Test@gmail.com | Test@facebook.com | 9818821710 | 2022     | 2022          | Nevada | United States | Primary   | Yes         | Primary   | Yes         | Facebook   | Yes          | Personal | Yes       | (981)882-1710         | (981) 882-1710   | <$FIRST_NAME$>  | <$MIDDLE_NAME$>  | <$LAST_NAME$>  | <$FIRST_NAME$> M <$LAST_NAME$> Sr | <$EnrollmentName$> | <$PropertyName$> | MR     | Male   | Alien Registration | United States | Nevada  | Indian        | Male     | Work        |

Scenario Outline:003- Verify Contact Information Status after enrolling Player (TC 591088)

	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User clears "lylPlayer_Search.PlayerSearch_TextBox"
	Given User enters text "<$UniversalPlayerID$>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	Given User switches to frame "default"
	#User click on Contact Information tab
	Given User clicks on "lylContactInfo.ContactInformationTab"
	#Verify Contact Information "Physical Address" saved while enrolling player in Contact Information Tab
	Then User verifies attribute "text" value "<AddressLine1>" of element "lylContactInfo.GetAddress_PreferredValue"
	Then User verifies attribute "checked" value "true" of element "lylContactInfo.PrefferedaddressRadioButton"
	Given User clicks on "lylContactInfo.Click_PhysicalAddressPreferenceType"
	Then User verifies attribute "text" value "<AddressLine1>" of element "lylContactInfo.ColumnValue" with parameters
		| Key   | Value          |
		| Value | <AddressLine1> |
	Then User verifies attribute "text" value "<AddressLine2>" of element "lylContactInfo.ColumnValue" with parameters
	    | Key   | Value          |
		| Value | <AddressLine2> |
	Then User verifies attribute "text" value "<AddressCity>" of element "lylContactInfo.ColumnValue" with parameters
	    | Key   | Value         |
		| Value | <AddressCity> |
	Then User verifies attribute "text" value "<$CountryCode$>" of element "lylContactInfo.ColumnValue" with parameters
	    | Key   | Value            |
	    | Value | <$CountryCode$>  |
	Then User verifies attribute "text" value "<$StateCode$>" of element "lylContactInfo.ColumnValue" with parameters
	    | Key   | Value         |
	    | Value | <$StateCode$> |
	Then User verifies attribute "text" value "<ZipCode>" of element "lylContactInfo.ColumnValue_Numeric" with parameters
	    | Key   | Value     |
		| Value | <ZipCode> |
	Then User verifies attribute "checked" value "true" of element "lylContactInfo.OptIn_Check_AllContactType"
	Then User verifies attribute "checked" value "true" of element "lylContactInfo.Preferred_Check_AllContactType"
	#Verify Contact Information "Email Address" saved while enrolling player in Contact Information Tab
	Given User clicks on "lylContactInfo.ContactInformationTab"
	Then User verifies attribute "text" value "<EmailAddress>" of element "lylContactInfo.GetEmailAddress_PreferredValue"
	Then User verifies attribute "selected" value "false" of element "lylContactInfo.PrefferedEmailRadioButton"
	Given User clicks on "lylContactInfo.EmailAddressPreferenceTypeLink"
	Then User verifies attribute "text" value "<EmailType>" of element "lylContactInfo.ColumnValue" with parameters
		| Key   | Value       |
		| Value | <EmailType> |
	Then User verifies attribute "text" value "<EmailAddress>" of element "lylContactInfo.ColumnValue" with parameters
		| Key   | Value          |
		| Value | <EmailAddress> |
    Then User verifies attribute "checked" value "true" of element "lylContactInfo.OptIn_Check_AllContactType"
	Then User verifies attribute "checked" value "true" of element "lylContactInfo.Preferred_Check_AllContactType"
	Then User verifies attribute "text" value "<StatusEmail>" of element "lylContactInfo.ColumnValue" with parameters
		| Key   | Value         |
		| Value | <StatusEmail> |
    #Verify Contact Information "Phone" saved while enrolling player in Contact Information Tab
	Given User clicks on "lylContactInfo.ContactInformationTab"
	Then User verifies attribute "text" value "<TelephoneNumberFormat>" of element "lylContactInfo.GetPhone_PreferredValue"
	Then User verifies attribute "selected" value "false" of element "lylContactInfo.PrefferedPhoneRadioButton"
	Given User clicks on "lylContactInfo.PhonePreferenceTypeLink"
	Then User verifies attribute "text" value "<EmailType>" of element "lylContactInfo.ColumnValue" with parameters
		| Key   | Value       |
		| Value | <PhoneType> |
	Then User verifies attribute "text" value "<TelephoneNumberFormat>" of element "lylContactInfo.ColumnValue" with parameters
		| Key   | Value                   |
		| Value | <TelephoneNumberFormat> |
	Then User verifies attribute "checked" value "true" of element "lylContactInfo.OptIn_Check_AllContactType"
	Then User verifies attribute "checked" value "true" of element "lylContactInfo.Preferred_Check_AllContactType"
	Then User verifies attribute "text" value "<StatusPhone>" of element "lylContactInfo.ColumnValue" with parameters
		| Key   | Value         |
		| Value | <StatusPhone> |
	#Verify Contact Information "Social Network Account" saved while enrolling player in Contact Information Tab
	Given User clicks on "lylContactInfo.ContactInformationTab"
	Then User verifies attribute "text" value "<SoicalAccount>" of element "lylContactInfo.GetSocialNetwork_PreferredValue"
	Then User verifies attribute "selected" value "false" of element "lylContactInfo.PrefferedSocialRadioButton"
	Given User clicks on "lylContactInfo.SocialNetworkPreferenceTypeLink"
	Then User verifies attribute "text" value "<SocialType>" of element "lylContactInfo.ColumnValue" with parameters
		| Key   | Value        |
		| Value | <SocialType> |
	Then User verifies attribute "text" value "<SoicalAccount>" of element "lylContactInfo.ColumnValue" with parameters
		| Key   | Value           |
		| Value | <SoicalAccount> |
	Then User verifies attribute "checked" value "true" of element "lylContactInfo.OptIn_Check_AllContactType"
	Then User verifies attribute "checked" value "true" of element "lylContactInfo.Preferred_Check_AllContactType"
	Then User verifies attribute "text" value "<StatusSocial>" of element "lylContactInfo.ColumnValue" with parameters
		| Key   | Value          |
		| Value | <StatusSocial> |

	#Verify Contact Information "SMS" saved while enrolling player in Contact Information Tab
	Given User clicks on "lylContactInfo.ContactInformationTab"
	Then User verifies attribute "text" value "<SMSAccountFormat>" of element "lylContactInfo.GetSMS_PreferredValue"
	Then User verifies attribute "selected" value "false" of element "lylContactInfo.PrefferedSMSRadioButton"
	Given User clicks on "lylContactInfo.SMSPreferredPreferenceTypeLink"
	Then User verifies attribute "text" value "<SMSType>" of element "lylContactInfo.ColumnValue" with parameters
		| Key   | Value        |
		| Value | <SMSType>    |
	Then User verifies attribute "text" value "<SMSAccountFormat>" of element "lylContactInfo.ColumnValue" with parameters
		| Key   | Value              |
		| Value | <SMSAccountFormat> |
	Then User verifies attribute "checked" value "true" of element "lylContactInfo.OptIn_Check_AllContactType"
	Then User verifies attribute "checked" value "true" of element "lylContactInfo.Preferred_Check_AllContactType"
	Then User verifies attribute "text" value "<StatusSMS>" of element "lylContactInfo.ColumnValue" with parameters
		| Key   | Value       |
		| Value | <StatusSMS> |

		Examples:
	| DOB      | Suffix | Occupation     | IdentificationID | IdentificationDOB | IdentificationExpiryDate | SSN         | AddressLine1 | AddressLine2    | AddressCity | ZipCode | TelephoneNumber | EmailAddress   | SoicalAccount     | SMSAccount | EnterPIN | EnterPINAgain | State  | Country       | EmailType | StatusEmail | PhoneType | StatusPhone | SocialType | StatusSocial | SMSType  | StatusSMS | TelephoneNumberFormat | SMSAccountFormat | PlayerFirstName | PlayerMiddleName | PlayerLastName | PlayerName                        | AccountType        | EnrolledAt       | Prefix | Gender | IdentificationType | IDCountry     | IDState | IDNationality | IDGender | AddressType |
	| 1/1/1987 | Sr     | OccupationTest | 1234568          | 1/1/1987          | 1/1/2099                 | 656-57-5676 | Hno345,Road2 | Street1,Sector4 | NewCity     | 12345   | 9818821710      | Test@gmail.com | Test@facebook.com | 9818821710 | 2022     | 2022          | Nevada | United States | Primary   | Yes         | Primary   | Yes         | Facebook   | Yes          | Personal | Yes       | (981)882-1710         | (981) 882-1710   | <$FIRST_NAME$>  | <$MIDDLE_NAME$>  | <$LAST_NAME$>  | <$FIRST_NAME$> M <$LAST_NAME$> Sr | <$EnrollmentName$> | <$PropertyName$> | MR     | Male   | Alien Registration | United States | Nevada  | Indian        | Male     | Work        |

Scenario Outline:004- Verify PIN & Player Details on Player Info Section after enrolling Player (TC 591088)
	
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User clears "lylPlayer_Search.PlayerSearch_TextBox"
	Given User enters text "<$UniversalPlayerID$>" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	Given User clicks on "lylPlayer_Info.PlayerInfoTab"
	#Verify PIN saved while enrolling player
	Then User verifies that element "lylPlayer_Info.ResetPIN" is present "true" on UI
	Given User clicks on "lylPlayer_Info.ResetPIN"
	Given User switches to frame "lylPlayer_Info.frm_AddResetPinFrame"
	Given User enters text "<EnterPIN>" in "lylPlayer_Info.AddRestPIN_OldPIN"
	Given User enters text "<EnterPIN>" in "lylPlayer_Info.AddRestPIN_NewPIN"
	Given User enters text "<EnterPIN>" in "lylPlayer_Info.AddRestPIN_VerifyPIN"
	Given User clicks on "lylPlayer_Info.AddRestPIN_SubmitButton"
	Then User verifies that element "lylPlayer_Info.OldNewPINCannotSame_ErrorMessage" is present "true" on UI with parameters
		| Key        | Value                                        |
		| PINMessage | The PIN cannot be the same as previous PINs. |
	When User waits "3" seconds
	Given User clicks on "lylPlayer_Info.ResetPIN_CancelButton"
	Given User clicks on "lylPlayer_Info.PlayerInfoTab"
	Then User verifies attribute "text" value "<DOB>" of element "lylPlayer_Info.DOB"
	Then User verifies attribute "text" value "<Occupation>" of element "lylPlayer_Info.Occupation"
	Then User verifies attribute "text" value "<PlayerName>" of element "lylPlayer_Info.PlayerName"
	Then User verifies attribute "text" value "<AccountType>" of element "lylPlayer_Info.AccountType"
	Then User verifies attribute "text" value "<EnrolledAt>" of element "lylPlayer_Info.EnrolledAt"

		Examples:
	| DOB      | Suffix | Occupation     | IdentificationID | IdentificationDOB | IdentificationExpiryDate | SSN         | AddressLine1 | AddressLine2    | AddressCity | ZipCode | TelephoneNumber | EmailAddress   | SoicalAccount     | SMSAccount | EnterPIN | EnterPINAgain | State  | Country       | EmailType | StatusEmail | PhoneType | StatusPhone | SocialType | StatusSocial | SMSType  | StatusSMS | TelephoneNumberFormat | SMSAccountFormat | PlayerFirstName | PlayerMiddleName | PlayerLastName | PlayerName                        | AccountType        | EnrolledAt       | Prefix | Gender | IdentificationType | IDCountry     | IDState | IDNationality | IDGender | AddressType |
	| 1/1/1987 | Sr     | OccupationTest | 1234568          | 1/1/1987          | 1/1/2099                 | 656-57-5676 | Hno345,Road2 | Street1,Sector4 | NewCity     | 12345   | 9818821710      | Test@gmail.com | Test@facebook.com | 9818821710 | 2022     | 2022          | Nevada | United States | Primary   | Yes         | Primary   | Yes         | Facebook   | Yes          | Personal | Yes       | (981)882-1710         | (981) 882-1710   | <$FIRST_NAME$>  | <$MIDDLE_NAME$>  | <$LAST_NAME$>  | <$FIRST_NAME$> M <$LAST_NAME$> Sr | <$EnrollmentName$> | <$PropertyName$> | MR     | Male   | Alien Registration | United States | Nevada  | Indian        | Male     | Work        |