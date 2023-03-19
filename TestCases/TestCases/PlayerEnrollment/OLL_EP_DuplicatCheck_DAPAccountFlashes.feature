@sequential@Release_15.0 @Player_Enrollment@duplicatecheck@DAP@desktop
Feature: OLL_EP_DuplicatCheck_DAPAccountFlash-Verifing Duplicate Account Window Flashes DAP Accounts in Red

#******************************************************************************************************
#** Feature File                    : OL_EP_Duplicatecheck_DAPAccountFlash
#** Feature Name                    : Verifing Duplicate Account Window Flashes DAP Accounts in Red
#** Defect/Bug Linked(if any)       : NA
#** TFS TC ID Linked                : 581297
#****************************************************************************************************/
#**  Created Date:        Author:                  # Comments
#**  07/13/2022           Aayushi Nayak			Initial Draft
#**************************************************************************************************/


    Scenario: 001- Set Duplicate check criteria in configure enrollment under Others and Duplicate Tab (TC 581297)
    #Login to WebApp and enroll Player
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
    Given User enters text "Configure Enrollment" in "lylMAIN_NAV_BOX.menu_Search_Box"
	When User waits "2" seconds
	Given User clicks on "lylCONFIG_ENROLLMENT.conf_enrollmnt_menu"
	Given User clicks on "lylCONFIG_ENROLLMENT.Duplicate_Tab"
	Then User "Checks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value     |
		| infoItem | FirstName |
	Then User "Checks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value    |
		| infoItem | LastName |
	Then User "Checks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value    |
		| infoItem | Birthday |
	Then User "Checks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value    |
		| infoItem | ucDuplicate_chkArchived |
	Given User clicks on "lylCONFIG_ENROLLMENT.DuplicateCheckSave_Button"
	When User waits "2" seconds
	Given User clicks on "lylCONFIG_ENROLLMENT.Other_Tab"
    Then User "checks" element "lylCONFIG_ENROLLMENT.Others_EnableDuplicateChecking_CheckBox"
	Given User clicks on "lylCONFIG_ENROLLMENT.Others_Save_Button"
	Then User verifies text - "Other type successfully updated" is present on page

     Scenario Outline: 002- Duplicate Account Window Flashes DAP Accounts (TC 581297)
	 #Switch and Login to LoyaltyLite and enroll Player
	 Given User switch to "desktop" application
	 Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	 Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	 Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	 Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	 Given User clicks on "OLL_LOGIN.btn_Submit"
	 When User waits "3" seconds
	 When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	 When User runs query "select P.PropertyID from  UC_X_Property P where PropertyName = '<$PropertyName$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyID"
	 When User runs query "SELECT TOP 1 AT.Name FROM dbo.UC_X_AccountType AT,UC_X_AccountTypeMaster ATM,AccountTypePropertyMappings APM where AT.AccountTypeMasterID = ATM.ID and APM.AccountTypeID = AT.ID and AT.AccountTypeMasterID = 3 and APM.PropertyID = '<$PropertyID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "EnrollmentName"
	 When User runs query "select FirstName from UC_PL_Player where UniversalPlayerID = '<#ExcludedPlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "FIRST_NAME"
	 When User runs query "select LastName from UC_PL_Player where UniversalPlayerID = '<#ExcludedPlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "LAST_NAME"
	 When User runs query "select BirthDate from UC_PL_Player where UniversalPlayerID = '<#ExcludedPlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "DOB"
	 When User generates a "UniqueString" with "MiddleName:3" for key "MIDDLE_NAME"
	 When User waits "4" seconds
	 Given User clicks on "LLSideNavigation.mnu_EnrollPlayer"
	 When User waits "2" seconds
	#Selecting Enrollment Type and Property
	 Given User clicks on "OLL_ENROLLPLAYER.lst_EnrollmentType"
	 When User waits "3" seconds
	 Given User selects option "<$EnrollmentName$>" of element "OLL_ENROLLPLAYER.lst_EnrollmentType" by "value"
	 Given User clicks on "OLL_ENROLLPLAYER.lst_enrollproperty"
	 Given User selects option "<$PropertyName$>" of element "OLL_ENROLLPLAYER.lst_enrollproperty" by "value"
	 #Entering details in Player Identity Section
	 Given User clicks on "OLL_ENROLLPLAYER.lst_Prefix"
	 Given User selects option "<Prefix>" of element "OLL_ENROLLPLAYER.lst_Prefix" by "value"
	 Given User types text "<$FIRST_NAME$>" in "OLL_ENROLLPLAYER.txt_FirstName"
	 Given User types text "<$MIDDLE_NAME$>" in "OLL_ENROLLPLAYER.txt_middlename"
	 Given User types text "<$LAST_NAME$>" in "OLL_ENROLLPLAYER.txt_LastName"
	 Given User clicks on "OLL_ENROLLPLAYER.lst_SuffixType"
	 Given User selects option "<Suffix>" of element "OLL_ENROLLPLAYER.lst_SuffixType" by "value"
	 Given User types text "<$DOB$>" in "OLL_ENROLLPLAYER.txt_BirthDate"
	 When User pressed key "Tab"
	 When User waits "2" seconds
	 

	Examples:
	    | Suffix | Prefix | Gender | PossibleDuplicateActLabel                 |
	    | Sr     | MR     | Male   | NOTIFICATION - POSSIBLE DUPLICATE ACCOUNT | 


	Scenario Outline: 003- Duplicate Account Window Flashes Self Exclusion Accounts (TC 581297)
	 #Switch and Login to LoyaltyLite and enroll Player
	 Given User switch to "desktop" application
	 Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	 Given User types text "<#Halo_username#>" in "OLL_LOGIN.txt_UserName"
	 Given User types text "<#Halo_password#>" in "OLL_LOGIN.txt_Password"
	 Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	 Given User clicks on "OLL_LOGIN.btn_Submit"
	 When User waits "3" seconds
	 When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	 When User runs query "select P.PropertyID from  UC_X_Property P where PropertyName = '<$PropertyName$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyID"
	 When User runs query "SELECT TOP 1 AT.Name FROM dbo.UC_X_AccountType AT,UC_X_AccountTypeMaster ATM,AccountTypePropertyMappings APM where AT.AccountTypeMasterID = ATM.ID and APM.AccountTypeID = AT.ID and AT.AccountTypeMasterID = 3 and APM.PropertyID = '<$PropertyID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "EnrollmentName"
	 When User runs query "select FirstName from UC_PL_Player where UniversalPlayerID = '<#SelfExclusionPlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "FIRST_NAME"
	 When User runs query "select LastName from UC_PL_Player where UniversalPlayerID = '<#SelfExclusionPlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "LAST_NAME"
	 When User runs query "select BirthDate from UC_PL_Player where UniversalPlayerID = '<#SelfExclusionPlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "DOB"
	 When User generates a "UniqueString" with "MiddleName:3" for key "MIDDLE_NAME"
	 When User waits "4" seconds
	 Given User clicks on "LLSideNavigation.mnu_EnrollPlayer"
	 When User waits "2" seconds
	#Selecting Enrollment Type and Property
	 Given User clicks on "OLL_ENROLLPLAYER.lst_EnrollmentType"
	 When User waits "3" seconds
	 Given User selects option "<$EnrollmentName$>" of element "OLL_ENROLLPLAYER.lst_EnrollmentType" by "value"
	 Given User clicks on "OLL_ENROLLPLAYER.lst_enrollproperty"
	 Given User selects option "<$PropertyName$>" of element "OLL_ENROLLPLAYER.lst_enrollproperty" by "value"
	 #Entering details in Player Identity Section
	 Given User clicks on "OLL_ENROLLPLAYER.lst_Prefix"
	 Given User selects option "<Prefix>" of element "OLL_ENROLLPLAYER.lst_Prefix" by "value"
	 Given User types text "<$FIRST_NAME$>" in "OLL_ENROLLPLAYER.txt_FirstName"
	 Given User types text "<$MIDDLE_NAME$>" in "OLL_ENROLLPLAYER.txt_middlename"
	 Given User types text "<$LAST_NAME$>" in "OLL_ENROLLPLAYER.txt_LastName"
	 Given User clicks on "OLL_ENROLLPLAYER.lst_SuffixType"
	 Given User selects option "<Suffix>" of element "OLL_ENROLLPLAYER.lst_SuffixType" by "value"
	 Given User types text "<$DOB$>" in "OLL_ENROLLPLAYER.txt_BirthDate"
	 When User pressed key "Tab"
	 When User waits "2" seconds	


	Examples:
	    | Suffix | Prefix | Gender | PossibleDuplicateActLabel                 |
	    | Sr     | MR     | Male   | NOTIFICATION - POSSIBLE DUPLICATE ACCOUNT |
		
	#Close the Loyalty Lite application 
	Scenario: 004-Close all instance of Loyalty Lite Desktop application. (TC 597683)
	When User switch to window application "ATI.Loyalty.Lite.Client.exe"
	Given User closes application

	Scenario: 005- Removing Duplicate check criteria in configure enrollment under Others and Duplicate Tab (TC 581297)
    #Login to WebApp and enroll Player
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
    Given User enters text "Configure Enrollment" in "lylMAIN_NAV_BOX.menu_Search_Box"
	When User waits "2" seconds
	Given User clicks on "lylCONFIG_ENROLLMENT.conf_enrollmnt_menu"
	Given User clicks on "lylCONFIG_ENROLLMENT.Duplicate_Tab"
	Then User "unchecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value     |
		| infoItem | FirstName |
	Then User "unchecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value    |
		| infoItem | LastName |
	Then User "unchecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value    |
		| infoItem | Birthday |
	Given User clicks on "lylCONFIG_ENROLLMENT.DuplicateCheckSave_Button"
	When User waits "2" seconds
	Given User clicks on "lylCONFIG_ENROLLMENT.Other_Tab"
    Then User "unchecks" element "lylCONFIG_ENROLLMENT.Others_EnableDuplicateChecking_CheckBox"
	Given User clicks on "lylCONFIG_ENROLLMENT.Others_Save_Button"
	Then User verifies text - "Other type successfully updated" is present on page