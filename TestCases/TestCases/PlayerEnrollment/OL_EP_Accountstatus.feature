@Release_15.0 @Player_Enrollment@Duplicate_check@AccountStatus@DAP@SelfExcluded@Deceased@Archival@Web

Feature: OL_EP_AccountStatus_Verifying the Account status field in the Duplicate pop-up Patron data pop-up
	Configure duplicate check and  Verifing the account status of DAP, Deceased,Inactive, Merge victim, self Exclusion and Configurable Exclusion

#******************************************************************************************************
#** Feature File                    : OL_EP_AccountStatus
#** Feature Name                    : Verifing the account status of DAP, Deceased,Inactive, Merge victim, self Exclusion and Configurable Exclusion
#** Defect/Bug Linked(if any)       : NA
#** TFS TC ID Linked                : 581609, 581607
#****************************************************************************************************/
#**  Created Date:        Author:                  # Comments
#**  06/06/2022           Aayushi Nayak				Initial Draft
#**  08/18/2022			  Aayushi Nayak				Account status column check in Dup check Pop-up
#**************************************************************************************************/


	Scenario: 001- Set Duplicate check criteria in configure enrollment under Others and Duplicate Tab (TC 581609, 581607)
    #Login to WebApp and enroll Player
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
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
	When User waits "4" seconds
	Then User verifies text - "Other type updated successfully" is present on page

	Scenario: 002- To Check Account status for DAP player on Dup Check Patron data Pop up and showing status as DAP (TC 581609, 581607)
	 #Login to WebApp and enroll Player
	 Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	 When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	 When User runs query "select P.PropertyID from  UC_X_Property P where PropertyName = '<$PropertyName$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyID"
	 When User runs query "SELECT TOP 1 AT.Name FROM dbo.UC_X_AccountType AT,UC_X_AccountTypeMaster ATM,AccountTypePropertyMappings APM where AT.AccountTypeMasterID = ATM.ID and APM.AccountTypeID = AT.ID and AT.AccountTypeMasterID = 3 and APM.PropertyID = '<$PropertyID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "EnrollmentName"
	 When User runs query "select FirstName from UC_PL_Player where UniversalPlayerID = '<#ExcludedPlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "FirstName_PlayerID_1"
	 When User runs query "select LastName from UC_PL_Player where UniversalPlayerID = '<#ExcludedPlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "LastName_PlayerID_1"
	 When User runs query "select BirthDate from UC_PL_Player where UniversalPlayerID = '<#ExcludedPlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "BirthDate_PlayerID_1"
	 When User generates a "UniqueString" with "MiddleName:3" for key "MIDDLE_NAME"
	 #Search for Enroll Player Menu
	 Given User enters text "Enroll Player" in "lylMAIN_NAV_BOX.menu_Search_Box"
	 When User waits "2" seconds
	 #Selecting Enrollment Type and Property
	 Given User clicks on "lylENROLL_PLAYER.EnrollPlayer_Menu"
	 Given User clicks on "lylENROLL_PLAYER.Click_EnrollmentType_DropDown"
	 When User waits "4" seconds
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
        | PIPrefix       | MR         |  
	 Given User enters text "<$FirstName_PlayerID_1$>" in "lylENROLL_PLAYER.FirstName_Txtbox"
	 Given User enters text "<$MIDDLE_NAME$>" in "lylENROLL_PLAYER.MiddleName_TextBox"
	 Given User enters text "<$LastName_PlayerID_1$>" in "lylENROLL_PLAYER.LastName_TxtBox"
	 Given User clicks on "lylENROLL_PLAYER.Click_Suffix_DropDown"
	 Given User clicks without delay on "lylENROLL_PLAYER.Suffix_DropDown" with parameters
        | Key            | Value      |
        | PISuffix       | Sr   |
	 Given User enters text "<$BirthDate_PlayerID_1$>" in "lylENROLL_PLAYER.DOB_TextBox"
	 When User pressed key "Tab"
	 When User waits "2" seconds
	 Then User verifies that element "lylENROLL_PLAYER.DuplicateAccount_Popup_Text" is present "true" on UI with parameters
		| Key              | Value                                     |
		| DuplicateAccount | NOTIFICATION - POSSIBLE DUPLICATE ACCOUNT |
	 When User waits "2" seconds
	 Then User verifies that element "lylENROLL_PLAYER.lbl_DupCheckPopupAccountStatus" is present "true" on UI with parameters
		| Key      | Value     |
		| infoitem | DAP       |
	 When User waits "3" seconds
	 Given User clicks without delay on "lylENROLL_PLAYER.dupcheck_existing_player" with parameters
		| Key               | Value               |
		| UniversalPlayerID | <#ExcludedPlayer#>  |
	#Click on Dup check pop up data and validate Account Status field
	Then User verifies that element "lylENROLL_PLAYER.dupcheck_patron_act" is present "true" on UI with parameters
		| Key      | Value     |
		| infoitem | <#ExcludedPlayer#>  |
	Then User verifies that element "lylENROLL_PLAYER.lbl_ActStatus" is present "true" on UI
	Then User verifies attribute "value" value "DAP" of element "lylENROLL_PLAYER.txt_Accountstatus" 
	Given User clicks on "lylENROLL_PLAYER.dupcheck_viewpatron_okbtn"


	Scenario: 003- To Check Account status for Self Excluded player on Dup Check Patron data Pop up and showing status as Self Excluded (TC 581609, 581607)
	 #Login to WebApp and enroll Player
	 Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	 When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	 When User runs query "select P.PropertyID from  UC_X_Property P where PropertyName = '<$PropertyName$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyID"
	 When User runs query "SELECT TOP 1 AT.Name FROM dbo.UC_X_AccountType AT,UC_X_AccountTypeMaster ATM,AccountTypePropertyMappings APM where AT.AccountTypeMasterID = ATM.ID and APM.AccountTypeID = AT.ID and AT.AccountTypeMasterID = 3 and APM.PropertyID = '<$PropertyID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "EnrollmentName"
	 When User runs query "select FirstName from UC_PL_Player where UniversalPlayerID = '<#SelfExclusionPlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "FirstName_PlayerID_1"
	 When User runs query "select LastName from UC_PL_Player where UniversalPlayerID = '<#SelfExclusionPlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "LastName_PlayerID_1"
	 When User runs query "select BirthDate from UC_PL_Player where UniversalPlayerID = '<#SelfExclusionPlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "BirthDate_PlayerID_1"
	 When User generates a "UniqueString" with "MiddleName:3" for key "MIDDLE_NAME"
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
        | Key      | Value |
        | PIPrefix | MR    | 
	 Given User enters text "<$FirstName_PlayerID_1$>" in "lylENROLL_PLAYER.FirstName_Txtbox"
	 Given User enters text "<$MIDDLE_NAME$>" in "lylENROLL_PLAYER.MiddleName_TextBox"
	 Given User enters text "<$LastName_PlayerID_1$>" in "lylENROLL_PLAYER.LastName_TxtBox"
	 Given User clicks on "lylENROLL_PLAYER.Click_Suffix_DropDown"
	 Given User clicks without delay on "lylENROLL_PLAYER.Suffix_DropDown" with parameters
        | Key      | Value |
        | PISuffix | Sr    |
	 Given User enters text "<$BirthDate_PlayerID_1$>" in "lylENROLL_PLAYER.DOB_TextBox"
	 When User pressed key "Tab"
	 When User waits "2" seconds
	 Then User verifies that element "lylENROLL_PLAYER.DuplicateAccount_Popup_Text" is present "true" on UI with parameters
		| Key              | Value                                     |
		| DuplicateAccount | NOTIFICATION - POSSIBLE DUPLICATE ACCOUNT |
	When User waits "2" seconds
	 Then User verifies that element "lylENROLL_PLAYER.lbl_DupCheckPopupAccountStatus" is present "true" on UI with parameters
		| Key      | Value               |
		| infoitem | Self Excluded       |
	 When User waits "3" seconds
	Given User clicks without delay on "lylENROLL_PLAYER.dupcheck_existing_player" with parameters
		| Key               | Value               |
		| UniversalPlayerID | <#SelfExclusionPlayer#> |
	#Click on Dup check pop up data and validate Account Status field
	Then User verifies that element "lylENROLL_PLAYER.dupcheck_patron_act" is present "true" on UI with parameters
		| Key      | Value     |
		| infoitem | <#SelfExclusionPlayer#>  |
	Then User verifies that element "lylENROLL_PLAYER.lbl_ActStatus" is present "true" on UI
	Then User verifies attribute "value" value "Self Excluded" of element "lylENROLL_PLAYER.txt_Accountstatus"      
	Given User clicks on "lylENROLL_PLAYER.dupcheck_viewpatron_okbtn"


	Scenario: 004- To Check Account status for Configurable Excluded player on Dup Check Patron data Pop up and showing status as Excluded (TC 581609, 581607)
	 #Login to WebApp and enroll Player
	 Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	 When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	 When User runs query "select P.PropertyID from  UC_X_Property P where PropertyName = '<$PropertyName$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyID"
	 When User runs query "SELECT TOP 1 AT.Name FROM dbo.UC_X_AccountType AT,UC_X_AccountTypeMaster ATM,AccountTypePropertyMappings APM where AT.AccountTypeMasterID = ATM.ID and APM.AccountTypeID = AT.ID and AT.AccountTypeMasterID = 3 and APM.PropertyID = '<$PropertyID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "EnrollmentName"
	 When User runs query "select FirstName from UC_PL_Player where UniversalPlayerID = '<#ConfigurableExcludedPlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "FirstName_PlayerID_1"
	 When User runs query "select LastName from UC_PL_Player where UniversalPlayerID = '<#ConfigurableExcludedPlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "LastName_PlayerID_1"
	 When User runs query "select BirthDate from UC_PL_Player where UniversalPlayerID = '<#ConfigurableExcludedPlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "BirthDate_PlayerID_1"
	 When User generates a "UniqueString" with "MiddleName:3" for key "MIDDLE_NAME"
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
        | Key      | Value |
        | PIPrefix | MR    |  
	 Given User enters text "<$FirstName_PlayerID_1$>" in "lylENROLL_PLAYER.FirstName_Txtbox"
	 Given User enters text "<$MIDDLE_NAME$>" in "lylENROLL_PLAYER.MiddleName_TextBox"
	 Given User enters text "<$LastName_PlayerID_1$>" in "lylENROLL_PLAYER.LastName_TxtBox"
	 Given User clicks on "lylENROLL_PLAYER.Click_Suffix_DropDown"
	 Given User clicks without delay on "lylENROLL_PLAYER.Suffix_DropDown" with parameters
        | Key      | Value |
        | PISuffix | Sr    | 
	 Given User enters text "<$BirthDate_PlayerID_1$>" in "lylENROLL_PLAYER.DOB_TextBox"
	 When User pressed key "Tab"
	 When User waits "2" seconds
	 Then User verifies that element "lylENROLL_PLAYER.DuplicateAccount_Popup_Text" is present "true" on UI with parameters
		| Key              | Value                                     |
		| DuplicateAccount | NOTIFICATION - POSSIBLE DUPLICATE ACCOUNT |
	 When User waits "2" seconds
	 Then User verifies that element "lylENROLL_PLAYER.lbl_DupCheckPopupAccountStatus" is present "true" on UI with parameters
		| Key      | Value          |
		| infoitem | Excluded       |
	 When User waits "2" seconds
	Given User clicks without delay on "lylENROLL_PLAYER.dupcheck_existing_player" with parameters
		| Key               | Value               |
		| UniversalPlayerID | <#ConfigurableExcludedPlayer#> |
	#Click on Dup check pop up data and validate Account Status field
	Then User verifies that element "lylENROLL_PLAYER.dupcheck_patron_act" is present "true" on UI with parameters
		| Key      | Value     |
		| infoitem | <#ConfigurableExcludedPlayer#>  |
	Then User verifies that element "lylENROLL_PLAYER.lbl_ActStatus" is present "true" on UI
	Then User verifies attribute "value" value "Excluded" of element "lylENROLL_PLAYER.txt_Accountstatus"      
	Given User clicks on "lylENROLL_PLAYER.dupcheck_viewpatron_okbtn"


	Scenario: 005- To Check Account status for Deceased player on Dup Check Patron data Pop up and showing status as Deceased (TC 581609, 581607)
	#Login to WebApp and enroll Player
	 Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	 When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	 When User runs query "select P.PropertyID from  UC_X_Property P where PropertyName = '<$PropertyName$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyID"
	 When User runs query "SELECT TOP 1 AT.Name FROM dbo.UC_X_AccountType AT,UC_X_AccountTypeMaster ATM,AccountTypePropertyMappings APM where AT.AccountTypeMasterID = ATM.ID and APM.AccountTypeID = AT.ID and AT.AccountTypeMasterID = 3 and APM.PropertyID = '<$PropertyID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "EnrollmentName"
	 When User runs query "select FirstName from UC_PL_Player where UniversalPlayerID = '<#DeceasedPlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "FirstName_PlayerID_1"
	 When User runs query "select LastName from UC_PL_Player where UniversalPlayerID = '<#DeceasedPlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "LastName_PlayerID_1"
	 When User runs query "select BirthDate from UC_PL_Player where UniversalPlayerID = '<#DeceasedPlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "BirthDate_PlayerID_1"
	 When User generates a "UniqueString" with "MiddleName:3" for key "MIDDLE_NAME"
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
        | Key      | Value |
        | PIPrefix | MR    |  
	 Given User enters text "<$FirstName_PlayerID_1$>" in "lylENROLL_PLAYER.FirstName_Txtbox"
	 Given User enters text "<$MIDDLE_NAME$>" in "lylENROLL_PLAYER.MiddleName_TextBox"
	 Given User enters text "<$LastName_PlayerID_1$>" in "lylENROLL_PLAYER.LastName_TxtBox"
	 Given User clicks on "lylENROLL_PLAYER.Click_Suffix_DropDown"
	 Given User clicks without delay on "lylENROLL_PLAYER.Suffix_DropDown" with parameters
        | Key      | Value |
        | PISuffix | Sr    |
	 Given User enters text "<$BirthDate_PlayerID_1$>" in "lylENROLL_PLAYER.DOB_TextBox"
	 When User pressed key "Tab"
	 When User waits "2" seconds
	 Then User verifies that element "lylENROLL_PLAYER.DuplicateAccount_Popup_Text" is present "true" on UI with parameters
		| Key              | Value                                     |
		| DuplicateAccount | NOTIFICATION - POSSIBLE DUPLICATE ACCOUNT |
	 When User waits "2" seconds
	 Then User verifies that element "lylENROLL_PLAYER.lbl_DupCheckPopupAccountStatus" is present "true" on UI with parameters
		| Key      | Value          |
		| infoitem | Deceased       |
	 When User waits "2" seconds
	Given User clicks without delay on "lylENROLL_PLAYER.dupcheck_existing_player" with parameters
		| Key               | Value               |
		| UniversalPlayerID | <#DeceasedPlayer#> |
	#Click on Dup check pop up data and validate Account Status field
	Then User verifies that element "lylENROLL_PLAYER.dupcheck_patron_act" is present "true" on UI with parameters
		| Key      | Value     |
		| infoitem | <#DeceasedPlayer#>  |
	Then User verifies that element "lylENROLL_PLAYER.lbl_ActStatus" is present "true" on UI
	Then User verifies attribute "value" value "Deceased" of element "lylENROLL_PLAYER.txt_Accountstatus"      
	Given User clicks on "lylENROLL_PLAYER.dupcheck_viewpatron_okbtn"


	Scenario: 006- To Check Account status for Merge Victim player on Dup Check Patron data Pop up and showing status as Merged Victim (TC 581609, 581607)
	 #Login to WebApp and enroll Player
	 Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	 When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	 When User runs query "select P.PropertyID from  UC_X_Property P where PropertyName = '<$PropertyName$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyID"
	 When User runs query "SELECT TOP 1 AT.Name FROM dbo.UC_X_AccountType AT,UC_X_AccountTypeMaster ATM,AccountTypePropertyMappings APM where AT.AccountTypeMasterID = ATM.ID and APM.AccountTypeID = AT.ID and AT.AccountTypeMasterID = 3 and APM.PropertyID = '<$PropertyID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "EnrollmentName"
	 When User runs query "select FirstName from UC_PL_Player where UniversalPlayerID = '<#MergePlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "FirstName_PlayerID_1"
	 When User runs query "select LastName from UC_PL_Player where UniversalPlayerID = '<#MergePlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "LastName_PlayerID_1"
	 When User runs query "select BirthDate from UC_PL_Player where UniversalPlayerID = '<#MergePlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "BirthDate_PlayerID_1"
	 When User generates a "UniqueString" with "MiddleName:3" for key "MIDDLE_NAME"
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
        | Key      | Value |
        | PIPrefix | MR    |  
	 Given User enters text "<$FirstName_PlayerID_1$>" in "lylENROLL_PLAYER.FirstName_Txtbox"
	 Given User enters text "<$MIDDLE_NAME$>" in "lylENROLL_PLAYER.MiddleName_TextBox"
	 Given User enters text "<$LastName_PlayerID_1$>" in "lylENROLL_PLAYER.LastName_TxtBox"
	 Given User clicks on "lylENROLL_PLAYER.Click_Suffix_DropDown"
	 Given User clicks without delay on "lylENROLL_PLAYER.Suffix_DropDown" with parameters
        | Key      | Value |
        | PISuffix | Sr    |
	 Given User enters text "<$BirthDate_PlayerID_1$>" in "lylENROLL_PLAYER.DOB_TextBox"
	 When User pressed key "Tab"
	 When User waits "2" seconds
	 Then User verifies that element "lylENROLL_PLAYER.DuplicateAccount_Popup_Text" is present "true" on UI with parameters
		| Key              | Value                                     |
		| DuplicateAccount | NOTIFICATION - POSSIBLE DUPLICATE ACCOUNT |
	 When User waits "2" seconds
	  Then User verifies that element "lylENROLL_PLAYER.lbl_DupCheckPopupAccountStatus" is present "true" on UI with parameters
		| Key      | Value               |
		| infoitem | Merged Victim       |
	 When User waits "2" seconds
	Given User clicks without delay on "lylENROLL_PLAYER.dupcheck_existing_player" with parameters
		| Key               | Value               |
		| UniversalPlayerID | <#MergePlayer#> |
	#Click on Dup check pop up data and validate Account Status field
	Then User verifies that element "lylENROLL_PLAYER.dupcheck_patron_act" is present "true" on UI with parameters
		| Key      | Value     |
		| infoitem | <#MergePlayer#>  |
	Then User verifies that element "lylENROLL_PLAYER.lbl_ActStatus" is present "true" on UI
	Then User verifies attribute "value" value "Merged Victim" of element "lylENROLL_PLAYER.txt_Accountstatus"      
	Given User clicks on "lylENROLL_PLAYER.dupcheck_viewpatron_okbtn"

	
	Scenario Outline: 007- Disable Duplicate check criteria in configure enrollment (TC 581367, 581607)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Configure Enrollment" in "lylMAIN_NAV_BOX.menu_Search_Box"
	Given User clicks on "lylCONFIG_ENROLLMENT.conf_enrollmnt_menu"
	Given User clicks on "lylCONFIG_ENROLLMENT.Duplicate_Tab"
	#Disable duplicate check configurations
	Then User "unchecks" element "lylCONFIG_ENROLLMENT.chkbox_duplicatecriteria" with parameters
		| Key      | Value     |
		| infoItem | FirstName |
	Then User "unchecks" element "lylCONFIG_ENROLLMENT.chkbox_duplicatecriteria" with parameters
		| Key      | Value    |
		| infoItem | LastName |
	Then User "unchecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value    |
		| infoItem | Birthday |
	Then User "unchecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value          |
		| infoItem | ucDuplicate_chkArchived |
	Given User clicks on "lylCONFIG_ENROLLMENT.DuplicateCheckSave_Button"
	Then User verifies text - "Duplicate criteria saved successfully." is present on page
	# enable duplicate chk from others tab
	Given User clicks on "lylCONFIG_ENROLLMENT.Other_Tab"
	Then User "unchecks" element "lylCONFIG_ENROLLMENT.Others_EnableDuplicateChecking_CheckBox"
	Given User clicks on "lylCONFIG_ENROLLMENT.Others_Save_Button"
	Then User verifies text - "Other type updated successfully" is present on page



	

	
