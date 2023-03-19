@Release15.0@Player_Archival@Player_Enrollment_Dup_Check@Desktop
Feature: OL_AR_Player_Enrollment

#***************************************************************************************************************
#**  Feature File                 : OL_AR_Offer.feature
#**  Feature Name                 : Loyalty Lite Player Enrollment Dup Check
#**  Defect/Bug Linked(if any)    :
#**  TFS TC ID Linked             : 479038
#**************************************************************************************************************/
#**  Created Date:         Author:                  #Comments
#**  13/06/2022            Vijay Pratap Singh       Initial Draft
#*************************************************************************************************************/
Scenario: 001 Verify that possible duplicate account should be displayed along with list of archive players while enrolling player from Loyalty Lite Application and entering already archived account First name in First name field (TC 479038)
	#Set Duplicate check criteria in configure enrollment
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password_3#>:<#Halo_domain#>" information
	Given User enters text "Configure Enrollment" in "lylMAIN_NAV_BOX.menu_Search_Box"
	Given User clicks on "lylCONFIG_ENROLLMENT.conf_enrollmnt_menu"
	Given User clicks on "lylCONFIG_ENROLLMENT.Duplicate_Tab"
	Then User "Checks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value     |
		| infoItem | FirstName |
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value    |
		| infoItem | LastName |
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value    |
		| infoItem | Birthday |
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value  |
		| infoItem | Gender |
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value |
		| infoItem | City  |
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value |
		| infoItem | State |
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value          |
		| infoItem | Identification |
	Then User "Checks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value                   |
		| infoItem | ucDuplicate_chkArchived |
	Given User clicks on "lylCONFIG_ENROLLMENT.DuplicateCheckSave_Button"
	When User waits "2" seconds
	Given User clicks on "lylCONFIG_ENROLLMENT.Other_Tab"
	Then User "checks" element "lylCONFIG_ENROLLMENT.Others_EnableDuplicateChecking_CheckBox"
	Given User clicks on "lylCONFIG_ENROLLMENT.Others_Save_Button"
	Then User verifies text - "Other type successfully updated" is present on page
	#Get data from DB for Archive Player
	When User runs query "select FirstName from UC_PL_Player where UniversalPlayerID = '<#ArchivePlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "FirstName"
	#User switches to Loyality Lite Application
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username_3#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password_3#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	#Selecting Enrollment Type and Property
	Given User clicks on "OLL_ENROLLPLAYER.lnk_EnrollPlayer"
	Given User selects option "<enrollType>" of element "OLL_ENROLLPLAYER.lst_EnrollmentType" by "value"
	#Entering details in Player Identity Section
	Given User selects option "<prefixType>" of element "OLL_ENROLLPLAYER.lbl_PrefixType" by "value"
	Given User types text "<$FirstName$>" in "OLL_ENROLLPLAYER.txt_FirstName"
	Given User clicks on "OLL_ENROLLPLAYER.txt_LastName"
	When User gets attribute "Name" value of "OLL_ENROLLPLAYER.lbl_DuplicateAccountPopup" element to save with key "NotificationText"
	When User performs string operation "stringEquals" of provided value "<DuplicateAccountPopuptext>" with "<$NotificationText$>"
	Given User clicks on "LLPlayerArchival.lbl_Ignore"
	Given User closes application

	Examples:
		| enrollType | prefixType | DuplicateAccountPopuptext                 |
		| Standard   | SIR        | NOTIFICATION - POSSIBLE DUPLICATE ACCOUNT |

Scenario: 002 Verify that possible duplicate account should be displayed along with list of archive players while enrolling player from Loyalty Lite Application and entering already archived account Last name in Last name field (TC 479038)
	#Set Duplicate check criteria in configure enrollment
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password_3#>:<#Halo_domain#>" information
	Given User enters text "Configure Enrollment" in "lylMAIN_NAV_BOX.menu_Search_Box"
	Given User clicks on "lylCONFIG_ENROLLMENT.conf_enrollmnt_menu"
	Given User clicks on "lylCONFIG_ENROLLMENT.Duplicate_Tab"
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value     |
		| infoItem | FirstName |
	Then User "Checks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value    |
		| infoItem | LastName |
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value    |
		| infoItem | Birthday |
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value  |
		| infoItem | Gender |
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value |
		| infoItem | City  |
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value |
		| infoItem | State |
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value          |
		| infoItem | Identification |
	Then User "Checks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value                   |
		| infoItem | ucDuplicate_chkArchived |
	Given User clicks on "lylCONFIG_ENROLLMENT.DuplicateCheckSave_Button"
	When User waits "2" seconds
	Given User clicks on "lylCONFIG_ENROLLMENT.Other_Tab"
	Then User "checks" element "lylCONFIG_ENROLLMENT.Others_EnableDuplicateChecking_CheckBox"
	Given User clicks on "lylCONFIG_ENROLLMENT.Others_Save_Button"
	Then User verifies text - "Other type successfully updated" is present on page
	#Get data from DB for Archive Player
	When User runs query "select FirstName from UC_PL_Player where UniversalPlayerID = '<#ArchivePlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "FirstName"
	When User runs query "select LastName from UC_PL_Player where UniversalPlayerID = '<#ArchivePlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "LastName"
	#User switches to Loyality Lite Application
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username_3#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password_3#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	#Selecting Enrollment Type and Property
	Given User clicks on "OLL_ENROLLPLAYER.lnk_EnrollPlayer"
	Given User selects option "<enrollType>" of element "OLL_ENROLLPLAYER.lst_EnrollmentType" by "value"
	#Entering details in Player Identity Section
	Given User selects option "<prefixType>" of element "OLL_ENROLLPLAYER.lbl_PrefixType" by "value"
	Given User types text "<$FirstName$>" in "OLL_ENROLLPLAYER.txt_FirstName"
	Given User types text "<$LastName$>" in "OLL_ENROLLPLAYER.txt_LastName"
	Given User selects option "<suffix>" of element "OLL_ENROLLPLAYER.lbl_PrefixType" by "value"
	When User gets attribute "Name" value of "OLL_ENROLLPLAYER.lbl_DuplicateAccountPopup" element to save with key "NotificationText"
	When User performs string operation "stringEquals" of provided value "<DuplicateAccountPopuptext>" with "<$NotificationText$>"
	Given User clicks on "LLPlayerArchival.lbl_Ignore"
	Given User closes application

	Examples:
		| enrollType | prefixType | suffix | DuplicateAccountPopuptext                 |
		| Standard   | SIR        | JR     | NOTIFICATION - POSSIBLE DUPLICATE ACCOUNT |

Scenario: 003 Verify that possible duplicate account should be displayed along with list of archive players while enrolling player from Loyalty Lite Application and entering already archived account DOB in DOB field (TC 479038)
	#Set Duplicate check criteria in configure enrollment
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password_3#>:<#Halo_domain#>" information
	Given User enters text "Configure Enrollment" in "lylMAIN_NAV_BOX.menu_Search_Box"
	Given User clicks on "lylCONFIG_ENROLLMENT.conf_enrollmnt_menu"
	Given User clicks on "lylCONFIG_ENROLLMENT.Duplicate_Tab"
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value     |
		| infoItem | FirstName |
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value    |
		| infoItem | LastName |
	Then User "Checks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value    |
		| infoItem | Birthday |
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value  |
		| infoItem | Gender |
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value |
		| infoItem | City  |
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value |
		| infoItem | State |
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value          |
		| infoItem | Identification |
	Then User "Checks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value                   |
		| infoItem | ucDuplicate_chkArchived |
	Given User clicks on "lylCONFIG_ENROLLMENT.DuplicateCheckSave_Button"
	When User waits "2" seconds
	Given User clicks on "lylCONFIG_ENROLLMENT.Other_Tab"
	Then User "checks" element "lylCONFIG_ENROLLMENT.Others_EnableDuplicateChecking_CheckBox"
	Given User clicks on "lylCONFIG_ENROLLMENT.Others_Save_Button"
	Then User verifies text - "Other type successfully updated" is present on page
	#Get data from DB for Archive Player
	When User runs query "select BirthDate from UC_PL_Player where UniversalPlayerID = '<#ArchivePlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "BirthDate"
	#User switches to Loyality Lite Application
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username_3#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password_3#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	#Selecting Enrollment Type and Property
	Given User clicks on "OLL_ENROLLPLAYER.lnk_EnrollPlayer"
	Given User selects option "<enrollType>" of element "OLL_ENROLLPLAYER.lst_EnrollmentType" by "value"
	#Entering details in Player Identity Section
	Given User selects option "<prefixType>" of element "OLL_ENROLLPLAYER.lbl_PrefixType" by "value"
	Given User types text "<$BirthDate$>" in "OLL_ENROLLPLAYER.txt_BirthDate"
	Given User clicks on "OLL_ENROLLPLAYER.lst_Gender"
	When User gets attribute "Name" value of "OLL_ENROLLPLAYER.lbl_DuplicateAccountPopup" element to save with key "NotificationText"
	When User performs string operation "stringEquals" of provided value "<DuplicateAccountPopuptext>" with "<$NotificationText$>"
	Given User clicks on "LLPlayerArchival.lbl_Ignore"
	Given User closes application

	Examples:
		| enrollType | prefixType | suffix | DuplicateAccountPopuptext                 |
		| Standard   | SIR        | JR     | NOTIFICATION - POSSIBLE DUPLICATE ACCOUNT |

Scenario: 004 Verify that possible duplicate account should be displayed along with list of archive players while enrolling player from Loyalty Lite Application and entering already archived account First name, Last Name and DOB (TC 479038)
	#Set Duplicate check criteria in configure enrollment
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password_3#>:<#Halo_domain#>" information
	Given User enters text "Configure Enrollment" in "lylMAIN_NAV_BOX.menu_Search_Box"
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
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value  |
		| infoItem | Gender |
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value |
		| infoItem | City  |
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value |
		| infoItem | State |
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value          |
		| infoItem | Identification |
	Then User "Checks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value                   |
		| infoItem | ucDuplicate_chkArchived |
	Given User clicks on "lylCONFIG_ENROLLMENT.DuplicateCheckSave_Button"
	When User waits "2" seconds
	Given User clicks on "lylCONFIG_ENROLLMENT.Other_Tab"
	Then User "checks" element "lylCONFIG_ENROLLMENT.Others_EnableDuplicateChecking_CheckBox"
	Given User clicks on "lylCONFIG_ENROLLMENT.Others_Save_Button"
	Then User verifies text - "Other type successfully updated" is present on page
	#Get data from DB for Archive Player
	When User runs query "select FirstName from UC_PL_Player where UniversalPlayerID = '<#ArchivePlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "FirstName"
	When User runs query "select LastName from UC_PL_Player where UniversalPlayerID = '<#ArchivePlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "LastName"
	When User runs query "select BirthDate from UC_PL_Player where UniversalPlayerID = '<#ArchivePlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "BirthDate"
	#User switches to Loyality Lite Application
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username_3#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password_3#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	#Selecting Enrollment Type and Property
	Given User clicks on "OLL_ENROLLPLAYER.lnk_EnrollPlayer"
	Given User selects option "<enrollType>" of element "OLL_ENROLLPLAYER.lst_EnrollmentType" by "value"
	#Entering details in Player Identity Section
	Given User selects option "<prefixType>" of element "OLL_ENROLLPLAYER.lbl_PrefixType" by "value"
	Given User types text "<$FirstName$>" in "OLL_ENROLLPLAYER.txt_FirstName"
	Given User types text "<$LastName$>" in "OLL_ENROLLPLAYER.txt_LastName"
	Given User selects option "<suffix>" of element "OLL_ENROLLPLAYER.lbl_PrefixType" by "value"
	Given User types text "<$BirthDate$>" in "OLL_ENROLLPLAYER.txt_BirthDate"
	Given User clicks on "OLL_ENROLLPLAYER.lst_Gender"
	When User gets attribute "Name" value of "OLL_ENROLLPLAYER.lbl_DuplicateAccountPopup" element to save with key "NotificationText"
	When User performs string operation "stringEquals" of provided value "<DuplicateAccountPopuptext>" with "<$NotificationText$>"
	Given User clicks on "LLPlayerArchival.lbl_Ignore"
	Given User closes application

	Examples:
		| enrollType | prefixType | suffix | DuplicateAccountPopuptext                 |
		| Standard   | SIR        | JR     | NOTIFICATION - POSSIBLE DUPLICATE ACCOUNT |

Scenario: 005 Verify that by default, archived accounts are not searchable while enrolling a player, by matching any duplicate criteria, when include archived accounts checkbox is unchecked. (TC 479038)
	#Set Duplicate check criteria in configure enrollment
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password_3#>:<#Halo_domain#>" information
	Given User enters text "Configure Enrollment" in "lylMAIN_NAV_BOX.menu_Search_Box"
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
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value  |
		| infoItem | Gender |
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value |
		| infoItem | City  |
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value |
		| infoItem | State |
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value          |
		| infoItem | Identification |
	Then User "UnChecks" element "lylCONFIG_ENROLLMENT.rdb_DuplicateCriteriaCheck" with parameters
		| Key      | Value                   |
		| infoItem | ucDuplicate_chkArchived |
	Given User clicks on "lylCONFIG_ENROLLMENT.DuplicateCheckSave_Button"
	When User waits "2" seconds
	Given User clicks on "lylCONFIG_ENROLLMENT.Other_Tab"
	Then User "checks" element "lylCONFIG_ENROLLMENT.Others_EnableDuplicateChecking_CheckBox"
	Given User clicks on "lylCONFIG_ENROLLMENT.Others_Save_Button"
	Then User verifies text - "Other type successfully updated" is present on page
	#Get data from DB for Archive Player
	When User runs query "select FirstName from UC_PL_Player where UniversalPlayerID = '<#ArchivePlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "FirstName"
	When User runs query "select LastName from UC_PL_Player where UniversalPlayerID = '<#ArchivePlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "LastName"
	When User runs query "select BirthDate from UC_PL_Player where UniversalPlayerID = '<#ArchivePlayer#>'" with connection "<#Halo_db_connectionstring#>" and save with key "BirthDate"
	#User switches to Loyality Lite Application
	Given User switch to "desktop" application
	Given User opens application "C:\Program Files\Aristocrat\OASIS LOYALTY\Loyalty Lite\Client\ATI.Loyalty.Lite.Client.exe"
	Given User types text "<#Halo_username_3#>" in "OLL_LOGIN.txt_UserName"
	Given User types text "<#Halo_password_3#>" in "OLL_LOGIN.txt_Password"
	Given User selects option "<#Halo_domain#>" of element "OLL_LOGIN.mic_DomainName" by "value"
	Given User clicks on "OLL_LOGIN.btn_Submit"
	#Selecting Enrollment Type and Property
	Given User clicks on "OLL_ENROLLPLAYER.lnk_EnrollPlayer"
	Given User selects option "<enrollType>" of element "OLL_ENROLLPLAYER.lst_EnrollmentType" by "value"
	#Entering details in Player Identity Section
	Given User selects option "<prefixType>" of element "OLL_ENROLLPLAYER.lbl_PrefixType" by "value"
	Given User types text "<$FirstName$>" in "OLL_ENROLLPLAYER.txt_FirstName"
	Given User types text "<$LastName$>" in "OLL_ENROLLPLAYER.txt_LastName"
	Given User selects option "<suffix>" of element "OLL_ENROLLPLAYER.lbl_PrefixType" by "value"
	Given User types text "<$BirthDate$>" in "OLL_ENROLLPLAYER.txt_BirthDate"
	Given User clicks on "OLL_ENROLLPLAYER.lst_Gender"
	Given User selects option "<gender>" of element "OLL_ENROLLPLAYER.lst_Gender" by "value"
	Given User clicks on "OLL_ENROLLPLAYER.lbl_Occupation"
	Given User closes application

	Examples:
		| enrollType | prefixType | suffix | gender |
		| Standard   | SIR        | JR     | Male   |

Scenario: 006-Close all Instance of Loyalty Lite desktop application.
	When User switch to window application "ATI.Loyalty.Lite.Client.exe"
	Given User closes application