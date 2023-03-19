Feature: Verifing Duplicate Account Window Flashes DAP Accounts in Red

#******************************************************************************************************
#** Feature File                    : OL_EP_Duplicatecheck_DAPAccountFlashesRed
#** Feature Name                    : Verifing Duplicate Account Window Flashes DAP Accounts in Red
#** Defect/Bug Linked(if any)       : NA
#** TFS TC ID Linked                : 581297
#****************************************************************************************************/
#**  Created Date:        Author:                  # Comments
#**  05/23/2022           Robbie Kalra				Initial Draft
#**************************************************************************************************/
@sequential@Release_15.0 @Player_Enrollment

    Scenario: 001- Set Duplicate check criteria in configure enrollment under Others and Duplicate Tab
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
	Given User clicks on "lylCONFIG_ENROLLMENT.DuplicateCheckSave_Button"
	When User waits "2" seconds
	Given User clicks on "lylCONFIG_ENROLLMENT.Other_Tab"
    Then User "checks" element "lylCONFIG_ENROLLMENT.Others_EnableDuplicateChecking_CheckBox"
	Given User clicks on "lylCONFIG_ENROLLMENT.Others_Save_Button"
	Then User verifies text - "Other type successfully updated" is present on page

	Scenario Outline: 002- Enroll new Player and Add DAP & Self Exclusion Plan (TC 581297)
	#Login to WebApp and enroll Player
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User generates a "UniqueString" with "FirstName:3" for key "FirstName"
    When User waits "2" seconds
    When Loyalty User Enroll Player via Webapp with "<$FirstName$>" name and save key "<PLAYER_ID>" with data
       | Birthdate  | Gender | identificationtype |
       | 01/01/1985 | Male   | Alien Registration |
	   | 01/01/1985 | Male   | Alien Registration |
	When User waits "2" seconds
	Given User clears "lylPlayer_Search.PlayerSearch_TextBox"
	Given User enters text "^$<PLAYER_ID>$^" in "lylPlayer_Search.PlayerSearch_TextBox"
	Given User clicks on "lylPlayer_Search.lnk_player_search"
	When User waits "2" seconds
	Given User enters text "Manage Player Exclusions" in "lylMAIN_NAV_BOX.menu_Search_Box"
	When User waits "2" seconds
	#Add Exclusion Plans
	Given User clicks on "lylPlayer_Function.Menu_ManagePlayerExclusions"
	Given User switches to frame "lylPlayer_Exclusion.frmAddExclusion"
	Given User clicks on "lylPlayer_Exclusion.AddConfigurableExclusionButton"
	Given User selects option "<ExclusionPlanType>" of element "lylPlayer_Exclusion.ExclusionPlanType_DropDown" by "visibletext"
	Given User clears "lylPlayer_Exclusion.StartDate"
	Given User enters text "<StartDate>" in "lylPlayer_Exclusion.StartDate"
	When User pressed key "Tab"
	Given User clears "lylPlayer_Exclusion.EndDate"
	Given User enters text "<EndDate>" in "lylPlayer_Exclusion.EndDate"
	When User pressed key "Tab"
	Given User clicks on "lylPlayer_Exclusion.SaveButton"
	Then User verifies that element "lylPlayer_Exclusion.ExclusionPlan_AddedMsg_Text" is present "true" on UI with parameters
		| Key                 | Value                                             |
		| AddExclusionPlantxt | Configurable Exclusion Plan assigned successfully |
    Given User switches to frame "default"
	Given User clicks on "lylPlayer_Exclusion.ClosePopupWindow"

    Examples:  
      | BirthDate  | Gender | IdentificationType | PLAYER_ID  | ExclusionPlanType | StartDate  | EndDate    |
      | 01/01/1985 | Male   | Driver's License   | PlayerID_1 | DAP Regulated     | 05/01/2022 | 05/01/2023 |
      | 01/01/1985 | Male   | Driver's License   | PlayerID_2 | Self-Exclusion    | 05/01/2022 | 05/01/2023 |

     Scenario Outline: 003- Duplicate Account Window Flashes DAP Accounts in Red (TC 581297)
	 #Login to WebApp and enroll Player
	 Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	 When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	 When User runs query "select P.PropertyID from  UC_X_Property P where PropertyName = '<$PropertyName$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyID"
	 When User runs query "SELECT TOP 1 AT.Name FROM dbo.UC_X_AccountType AT,UC_X_AccountTypeMaster ATM,AccountTypePropertyMappings APM where AT.AccountTypeMasterID = ATM.ID and APM.AccountTypeID = AT.ID and AT.AccountTypeMasterID = 3 and APM.PropertyID = '<$PropertyID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "EnrollmentName"
	 When User runs query "select FirstName from UC_PL_Player where UniversalPlayerID = '<$PlayerID_1$>'" with connection "<#Halo_db_connectionstring#>" and save with key "FirstName_PlayerID_1"
	 When User runs query "select LastName from UC_PL_Player where UniversalPlayerID = '<$PlayerID_1$>'" with connection "<#Halo_db_connectionstring#>" and save with key "LastName_PlayerID_1"
	 When User runs query "select BirthDate from UC_PL_Player where UniversalPlayerID = '<$PlayerID_1$>'" with connection "<#Halo_db_connectionstring#>" and save with key "BirthDate_PlayerID_1"
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
        | Key            | Value            |
        | PIPrefix       | <Prefix>         |  
	 Given User enters text "<$FirstName_PlayerID_1$>" in "lylENROLL_PLAYER.FirstName_Txtbox"
	 Given User enters text "<$MIDDLE_NAME$>" in "lylENROLL_PLAYER.MiddleName_TextBox"
	 Given User enters text "<$LastName_PlayerID_1$>" in "lylENROLL_PLAYER.LastName_TxtBox"
	 Given User clicks on "lylENROLL_PLAYER.Click_Suffix_DropDown"
	 Given User clicks without delay on "lylENROLL_PLAYER.Suffix_DropDown" with parameters
        | Key            | Value      |
        | PISuffix       | <Suffix>   |
	 Given User enters text "<$BirthDate_PlayerID_1$>" in "lylENROLL_PLAYER.DOB_TextBox"
	 When User pressed key "Tab"
	 When User waits "2" seconds
	 Then User verifies that element "lylENROLL_PLAYER.DuplicateAccount_Popup_Text" is present "true" on UI with parameters
		| Key              | Value                                     |
		| DuplicateAccount | NOTIFICATION - POSSIBLE DUPLICATE ACCOUNT |
	 When User waits "2" seconds
	 Then User verifies attribute "color" value "rgba(186, 2, 2, 1)" of element "lylENROLL_PLAYER.DAPPlayerColorSearch" with parameters
		| Key            | Value                                            |
		| firstlastlname | <$FirstName_PlayerID_1$> <$LastName_PlayerID_1$> |
	Then User verifies that element "lylContactInfo.OptIn_Check_AllContactType" is present "true" on UI

		Examples:
	    | Suffix | Prefix | Gender |
	    | Sr     | MR     | Male   |

	Scenario Outline: 004- Duplicate Account Window Flashes Self-Exclusion Accounts in Red (TC 581297)
	 #Login to WebApp and enroll Player
	 Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	 When User runs query "select P.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	 When User runs query "select P.PropertyID from  UC_X_Property P where PropertyName = '<$PropertyName$>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyID"
	 When User runs query "SELECT TOP 1 AT.Name FROM dbo.UC_X_AccountType AT,UC_X_AccountTypeMaster ATM,AccountTypePropertyMappings APM where AT.AccountTypeMasterID = ATM.ID and APM.AccountTypeID = AT.ID and AT.AccountTypeMasterID = 3 and APM.PropertyID = '<$PropertyID$>'" with connection "<#Halo_db_connectionstring#>" and save with key "EnrollmentName"
	 When User runs query "select FirstName from UC_PL_Player where UniversalPlayerID = '<$PlayerID_2$>'" with connection "<#Halo_db_connectionstring#>" and save with key "FirstName_PlayerID_2"
	 When User runs query "select LastName from UC_PL_Player where UniversalPlayerID = '<$PlayerID_2$>'" with connection "<#Halo_db_connectionstring#>" and save with key "LastName_PlayerID_2"
	 When User runs query "select BirthDate from UC_PL_Player where UniversalPlayerID = '<$PlayerID_2$>'" with connection "<#Halo_db_connectionstring#>" and save with key "BirthDate_PlayerID_2"
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
        | Key            | Value            |
        | PIPrefix       | <Prefix>         |  
	 Given User enters text "<$FirstName_PlayerID_2$>" in "lylENROLL_PLAYER.FirstName_Txtbox"
	 Given User enters text "<$MIDDLE_NAME$>" in "lylENROLL_PLAYER.MiddleName_TextBox"
	 Given User enters text "<$LastName_PlayerID_2$>" in "lylENROLL_PLAYER.LastName_TxtBox"
	 Given User clicks on "lylENROLL_PLAYER.Click_Suffix_DropDown"
	 Given User clicks without delay on "lylENROLL_PLAYER.Suffix_DropDown" with parameters
        | Key            | Value      |
        | PISuffix       | <Suffix>   |
	 Given User enters text "<$BirthDate_PlayerID_2$>" in "lylENROLL_PLAYER.DOB_TextBox"
	 When User pressed key "Tab"
	 When User waits "2" seconds
	 Then User verifies that element "lylENROLL_PLAYER.DuplicateAccount_Popup_Text" is present "true" on UI with parameters
		| Key              | Value                                     |
		| DuplicateAccount | NOTIFICATION - POSSIBLE DUPLICATE ACCOUNT |
	 When User waits "2" seconds
	 Then User verifies attribute "color" value "rgba(186, 2, 2, 1)" of element "lylENROLL_PLAYER.DAPPlayerColorSearch" with parameters
		| Key            | Value                                            |
		| firstlastlname | <$FirstName_PlayerID_2$> <$LastName_PlayerID_2$> |
	Then User verifies that element "lylContactInfo.OptIn_Check_AllContactType" is present "true" on UI

		Examples:
	    | Suffix | Prefix | Gender |
	    | Sr     | MR     | Male   |

	Scenario: 005- Removing Duplicate check criteria in configure enrollment under Others and Duplicate Tab
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