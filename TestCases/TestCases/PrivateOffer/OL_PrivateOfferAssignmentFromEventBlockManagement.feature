@Release_15.0@Group_PrivateOffer@Web
Feature: OL_PrivateOfferAssignmentFromEventBlockManagement
#******************************************************************************
#**  Feature File                 : OL_PrivateOfferAssignmentFromEventBlockManagement.feature
#**  Feature Name                 : Private Offer availability at Event Block Management.
#**  Defect/Bug Linked(if any)    : NA
#**  TFS TC ID Linked             : 590017,590037
#**
#
#**  Date:            Author:                  Comments
#**  --------        --------------            --------------
#**  07/11/2022     Jogendra Singh            Initial Draft
#********************************************************************************/
#
#/*************************************************************************

Scenario: 001-To provide ManagePrivateOffer Permission to User goup.(TC 590017)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "ManagePrivateOffer" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#assign VIEWASSIGNPRIVATEAWARD permission from UC_TechServices user group.
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value              |
	| permissionname | MANAGEPRIVATEOFFER |
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies text - "Permissions Saved" is present on page

Scenario: 002-To verify the availability of Private offer at Master Event when user group have the Permission.(TC 590017)
	When User runs query "Select  p.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User runs query "Select id  from Ofr.UC_X_OfferMaster where OfferName like '%UniversalPrivateOffer%'" with connection "<#Halo_db_connectionstring#>" and save with key "OfferID"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Event Block Management" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "OLW_MAIN_NAV_BOX.lnk_eventblockmanagement"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_add"
	When User generates a "UniqueString" with "Master_Event_:4" for key "MasterEventName"
	Given User enters text "<$MasterEventName$>" in "OLW_EBM_MASTEREVENT.txt_master_event_name"
	When User runs query "select format (getdate(),'MM/dd/yyyy')" with connection "<#Halo_db_connectionstring#>" and save with key "DBcurrenttime"
	And User performs action "adddays" of "7" on dateTime "<$DBcurrenttime$>" with format "MM/dd/yyyy" to save the result for key "EndDate"
	Given User enters text "<$DBcurrenttime$>" in "OLW_EBM_MASTEREVENT.txt_master_event_startdate"
	Given User enters text "<$EndDate$>" in "OLW_EBM_MASTEREVENT.txt_master_event_enddate"
	Then User "checks" element "OLW_EBM_MASTEREVENT.rdb_master_event"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_addoffer"
	Given User enters text "<#OfferName#>" in "OLW_EBM_MASTEREVENT.txt_EventOfferSearch_OfferName"
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_EventOfferSearch_OfferSearch"
	#Validate Private Offer availability.
	Then User verifies that element "OLW_EBM_MASTEREVENT.mic_offergrid" is present "true" on UI with parameters
    | Key       | Value             |
    | Campaign  | <#CampaignName#>  |
    | OfferName | <#OfferName#>     |
    | OfferID   | <$OfferID$>       |
    | StartDate | <#ValidFromDate#> |
    | EndDate   | <#ValidToDate#>   |
    | Property  | <$PropertyName$>  |
	Given User clicks on "OLW_EBM_MASTEREVENT.mic_offergrid" with parameters
    | Key       | Value             |
    | Campaign  | <#CampaignName#>  |
    | OfferName | <#OfferName#>     |
    | OfferID   | <$OfferID$>       |
    | StartDate | <#ValidFromDate#> |
    | EndDate   | <#ValidToDate#>   |
    | Property  | <$PropertyName$>  |
	When User waits "2" seconds

Scenario: 003-To verify the availability of Private offer at Schedule when user group have the Permission.(TC 590017)
	When User runs query "Select  p.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User runs query "Select id  from Ofr.UC_X_OfferMaster where OfferName like '%UniversalPrivateOffer%'" with connection "<#Halo_db_connectionstring#>" and save with key "OfferID"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Event Block Management" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "OLW_MAIN_NAV_BOX.lnk_eventblockmanagement"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_add"
	When User generates a "UniqueString" with "Master_Event_:4" for key "MasterEventName1"
	Given User enters text "<$MasterEventName1$>" in "OLW_EBM_MASTEREVENT.txt_master_event_name"
	When User runs query "select format (getdate(),'MM/dd/yyyy')" with connection "<#Halo_db_connectionstring#>" and save with key "DBcurrenttime"
	And User performs action "adddays" of "7" on dateTime "<$DBcurrenttime$>" with format "MM/dd/yyyy" to save the result for key "EndDate"
	Given User enters text "<$DBcurrenttime$>" in "OLW_EBM_MASTEREVENT.txt_master_event_startdate"
	Given User enters text "<$EndDate$>" in "OLW_EBM_MASTEREVENT.txt_master_event_enddate"
	Then User "checks" element "OLW_EBM_MASTEREVENT.rdb_eventschedule"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_save"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_add_schedule"
	When User waits "4" seconds
	Given User clicks on "OLW_EBM_EVENTSCHEDUL.btn_addoffer"
	Given User enters text "<#OfferName#>" in "OLW_EBM_MASTEREVENT.txt_EventOfferSearch_OfferName"
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_EventOfferSearch_OfferSearch"
	#Verify availability of Privte Offer at segment.
	Then User verifies that element "OLW_EBM_MASTEREVENT.mic_offergrid" is present "true" on UI with parameters
    | Key       | Value             |
    | Campaign  | <#CampaignName#>  |
    | OfferName | <#OfferName#>     |
    | OfferID   | <$OfferID$>       |
    | StartDate | <#ValidFromDate#> |
    | EndDate   | <#ValidToDate#>   |
    | Property  | <$PropertyName$>  |
	Given User clicks on "OLW_EBM_MASTEREVENT.mic_offergrid" with parameters
    | Key       | Value             |
    | Campaign  | <#CampaignName#>  |
    | OfferName | <#OfferName#>     |
    | OfferID   | <$OfferID$>       |
    | StartDate | <#ValidFromDate#> |
    | EndDate   | <#ValidToDate#>   |
    | Property  | <$PropertyName$>  |
	When User waits "2" seconds

Scenario: 004--To verify the availability of Private offer at Event Block when user group have the Permission.(TC 590017)
	When User runs query "Select  p.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User runs query "Select id  from Ofr.UC_X_OfferMaster where OfferName like '%UniversalPrivateOffer%'" with connection "<#Halo_db_connectionstring#>" and save with key "OfferID"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Event Block Management" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "OLW_MAIN_NAV_BOX.lnk_eventblockmanagement"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_name_filter"
	Given User clicks on "USER_TRANS_LOG.PLAYER_ID_FILTER_OPTIONS" with parameters
	| Key        | Value    |
	| OptionName | Contains |
	Given User enters text "<$MasterEventName1$>" in "USER_TRANS_LOG.TXT_PLAYER_ID_FILTER"
	When User pressed key "enter"
	When User waits "4" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.grid_mastereventname" with parameters
    | Key             | Value                |
    | MasterEventName | <$MasterEventName1$> |
    | Status          | New                  |
	When User waits "4" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_view"
	When User waits "2" seconds
	Then User "checks" element "OLW_EBM_MASTEREVENT.rdb_block"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_save"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_add_schedule"
	When User waits "4" seconds
	Given User enters text "Schedule Description" in "OLW_EBM_EVENTSCHEDUL.txt_description"
	When User generates a "UniqueString" with "Event_Schedule:4" for key "Eventname"
	Given User enters text "<$Eventname$>" in "OLW_EBM_EVENTSCHEDUL.txt_schedule_event_name"
	Given User selects option "<#EventType#>" of element "OLW_EBM_EVENTSCHEDUL.mic_eventtype" by "visibletext"
	Given User enters text "Choctow Casino" in "OLW_EBM_EVENTSCHEDUL.txt_host"
	Given User selects option "<$PropertyName$>" of element "OLW_EBM_EVENTSCHEDUL.mic_property" by "visibletext"
	When User runs query "select format (getdate(),'MM/dd/yyyy')" with connection "<#Halo_db_connectionstring#>" and save with key "DBcurrenttime"
	And User performs action "adddays" of "7" on dateTime "<$DBcurrenttime$>" with format "MM/dd/yyyy" to save the result for key "EndDate"
	Given User enters text "<$DBcurrenttime$>" in "OLW_EBM_EVENTSCHEDUL.txt_schedule_start_date"
	Given User enters text "12:00 AM" in "OLW_EBM_EVENTSCHEDUL.txt_schedule_start_time"
	Given User enters text "<$EndDate$>" in "OLW_EBM_EVENTSCHEDUL.txt_schedule_end_date"
	Given User enters text "06:30 PM" in "OLW_EBM_EVENTSCHEDUL.txt_schedule_end_time"
	Given User clicks on "OLW_EBM_EVENTSCHEDUL.btn_schedule_save"
	When User "refresh" the browser
	Given User clicks on "OLW_EBM_MASTEREVENT.tab_master_event"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_name_filter"
	Given User clicks on "USER_TRANS_LOG.PLAYER_ID_FILTER_OPTIONS" with parameters
	| Key        | Value    |
	| OptionName | Contains |
	Given User enters text "<$MasterEventName1$>" in "USER_TRANS_LOG.TXT_PLAYER_ID_FILTER"
	When User pressed key "enter"
	When User waits "4" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.grid_mastereventname" with parameters
    | Key             | Value                |
    | MasterEventName | <$MasterEventName1$> |
    | Status          | New                  |
	When User waits "4" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_view"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.lnk_event_schedule_grid" with parameters
    | Key         | Value         |
    | SchedueName | <$Eventname$> |
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_EVENTBLOCK.btn_add_event"
	When User waits "4" seconds
	Given User clicks on "OLW_EBM_EVENTBLOCK.btn_add_change_offer"
	Given User enters text "<#OfferName#>" in "OLW_EBM_MASTEREVENT.txt_EventOfferSearch_OfferName"
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_EventOfferSearch_OfferSearch"
	#Verify availability of private offer at Event Block. 
	Then User verifies that element "OLW_EBM_MASTEREVENT.mic_offergrid" is present "true" on UI with parameters
    | Key       | Value             |
    | Campaign  | <#CampaignName#>  |
    | OfferName | <#OfferName#>     |
    | OfferID   | <$OfferID$>       |
    | StartDate | <#ValidFromDate#> |
    | EndDate   | <#ValidToDate#>   |
    | Property  | <$PropertyName$>  |
	Given User clicks on "OLW_EBM_MASTEREVENT.mic_offergrid" with parameters
    | Key       | Value             |
    | Campaign  | <#CampaignName#>  |
    | OfferName | <#OfferName#>     |
    | OfferID   | <$OfferID$>       |
    | StartDate | <#ValidFromDate#> |
    | EndDate   | <#ValidToDate#>   |
    | Property  | <$PropertyName$>  |
	When User waits "2" seconds

Scenario: 005-Removing ManagePrivateOffer Permission to User goup.(TC 590017)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "ManagePrivateOffer" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#Removing VIEWASSIGNPRIVATEAWARD permission from UC_TechServices user group.
	Then User "unchecks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value              |
	| permissionname | MANAGEPRIVATEOFFER |
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies text - "Permissions Saved" is present on page

Scenario: 006-To verify the availability of Private offer at Master Event when user group don't have the Permission.(TC 590017)
	When User runs query "Select  p.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User runs query "Select id  from Ofr.UC_X_OfferMaster where OfferName like '%UniversalPrivateOffer%'" with connection "<#Halo_db_connectionstring#>" and save with key "OfferID"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Event Block Management" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "OLW_MAIN_NAV_BOX.lnk_eventblockmanagement"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_add"
	When User generates a "UniqueString" with "Master_Event_:4" for key "MasterEventName"
	Given User enters text "<$MasterEventName$>" in "OLW_EBM_MASTEREVENT.txt_master_event_name"
	When User runs query "select format (getdate(),'MM/dd/yyyy')" with connection "<#Halo_db_connectionstring#>" and save with key "DBcurrenttime"
	And User performs action "adddays" of "7" on dateTime "<$DBcurrenttime$>" with format "MM/dd/yyyy" to save the result for key "EndDate"
	Given User enters text "<$DBcurrenttime$>" in "OLW_EBM_MASTEREVENT.txt_master_event_startdate"
	Given User enters text "<$EndDate$>" in "OLW_EBM_MASTEREVENT.txt_master_event_enddate"
	Then User "checks" element "OLW_EBM_MASTEREVENT.rdb_master_event"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_addoffer"
	Given User enters text "<#OfferName#>" in "OLW_EBM_MASTEREVENT.txt_EventOfferSearch_OfferName"
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_EventOfferSearch_OfferSearch"
	# Verify Private Offer at Master event when user group does not have Permission.
	Then User verifies that element "OLW_EBM_MASTEREVENT.mic_offergrid" is present "false" on UI with parameters
    | Key       | Value             |
    | Campaign  | <#CampaignName#>  |
    | OfferName | <#OfferName#>     |
    | OfferID   | <$OfferID$>       |
    | StartDate | <#ValidFromDate#> |
    | EndDate   | <#ValidToDate#>   |
    | Property  | <$PropertyName$>  |


Scenario: 007-To verify the availability of Private offer at Schedule when user group don't have the Permission.(TC 590017)
	When User runs query "Select  p.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User runs query "Select id  from Ofr.UC_X_OfferMaster where OfferName like '%UniversalPrivateOffer%'" with connection "<#Halo_db_connectionstring#>" and save with key "OfferID"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Event Block Management" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "OLW_MAIN_NAV_BOX.lnk_eventblockmanagement"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_add"
	When User generates a "UniqueString" with "Master_Event_:4" for key "MasterEventName1"
	Given User enters text "<$MasterEventName1$>" in "OLW_EBM_MASTEREVENT.txt_master_event_name"
	When User runs query "select format (getdate(),'MM/dd/yyyy')" with connection "<#Halo_db_connectionstring#>" and save with key "DBcurrenttime"
	And User performs action "adddays" of "7" on dateTime "<$DBcurrenttime$>" with format "MM/dd/yyyy" to save the result for key "EndDate"
	Given User enters text "<$DBcurrenttime$>" in "OLW_EBM_MASTEREVENT.txt_master_event_startdate"
	Given User enters text "<$EndDate$>" in "OLW_EBM_MASTEREVENT.txt_master_event_enddate"
	Then User "checks" element "OLW_EBM_MASTEREVENT.rdb_eventschedule"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_save"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_add_schedule"
	When User waits "4" seconds
	Given User clicks on "OLW_EBM_EVENTSCHEDUL.btn_addoffer"
	Given User enters text "<#OfferName#>" in "OLW_EBM_MASTEREVENT.txt_EventOfferSearch_OfferName"
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_EventOfferSearch_OfferSearch"
	# Verify availability of Private Offer at Segment when User group does not have Permission.
	Then User verifies that element "OLW_EBM_MASTEREVENT.mic_offergrid" is present "false" on UI with parameters
    | Key       | Value             |
    | Campaign  | <#CampaignName#>  |
    | OfferName | <#OfferName#>     |
    | OfferID   | <$OfferID$>       |
    | StartDate | <#ValidFromDate#> |
    | EndDate   | <#ValidToDate#>   |
    | Property  | <$PropertyName$>  |

Scenario: 008-To verify the availability of Private offer at Event Block when user group don't have the Permission.(TC 590017)
	When User runs query "Select  p.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User runs query "Select id  from Ofr.UC_X_OfferMaster where OfferName like '%UniversalPrivateOffer%'" with connection "<#Halo_db_connectionstring#>" and save with key "OfferID"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Event Block Management" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "OLW_MAIN_NAV_BOX.lnk_eventblockmanagement"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_name_filter"
	Given User clicks on "USER_TRANS_LOG.PLAYER_ID_FILTER_OPTIONS" with parameters
	| Key        | Value    |
	| OptionName | Contains |
	Given User enters text "<$MasterEventName1$>" in "USER_TRANS_LOG.TXT_PLAYER_ID_FILTER"
	When User pressed key "enter"
	When User waits "4" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.grid_mastereventname" with parameters
    | Key             | Value                |
    | MasterEventName | <$MasterEventName1$> |
    | Status          | New                  |
	When User waits "4" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_view"
	When User waits "2" seconds
	Then User "checks" element "OLW_EBM_MASTEREVENT.rdb_block"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_save"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_add_schedule"
	When User waits "4" seconds
	Given User enters text "Schedule Description" in "OLW_EBM_EVENTSCHEDUL.txt_description"
	When User generates a "UniqueString" with "Event_Schedule:4" for key "Eventname"
	Given User enters text "<$Eventname$>" in "OLW_EBM_EVENTSCHEDUL.txt_schedule_event_name"
	Given User selects option "<#EventType#>" of element "OLW_EBM_EVENTSCHEDUL.mic_eventtype" by "visibletext"
	Given User enters text "Choctow Casino" in "OLW_EBM_EVENTSCHEDUL.txt_host"
	Given User selects option "<$PropertyName$>" of element "OLW_EBM_EVENTSCHEDUL.mic_property" by "visibletext"
	When User runs query "select format (getdate(),'MM/dd/yyyy')" with connection "<#Halo_db_connectionstring#>" and save with key "DBcurrenttime"
	And User performs action "adddays" of "7" on dateTime "<$DBcurrenttime$>" with format "MM/dd/yyyy" to save the result for key "EndDate"
	Given User enters text "<$DBcurrenttime$>" in "OLW_EBM_EVENTSCHEDUL.txt_schedule_start_date"
	Given User enters text "12:00 AM" in "OLW_EBM_EVENTSCHEDUL.txt_schedule_start_time"
	Given User enters text "<$EndDate$>" in "OLW_EBM_EVENTSCHEDUL.txt_schedule_end_date"
	Given User enters text "06:30 PM" in "OLW_EBM_EVENTSCHEDUL.txt_schedule_end_time"
	Given User clicks on "OLW_EBM_EVENTSCHEDUL.btn_schedule_save"
	When User "refresh" the browser
	Given User clicks on "OLW_EBM_MASTEREVENT.tab_master_event"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_name_filter"
	Given User clicks on "USER_TRANS_LOG.PLAYER_ID_FILTER_OPTIONS" with parameters
	| Key        | Value    |
	| OptionName | Contains |
	Given User enters text "<$MasterEventName1$>" in "USER_TRANS_LOG.TXT_PLAYER_ID_FILTER"
	When User pressed key "enter"
	When User waits "4" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.grid_mastereventname" with parameters
    | Key             | Value                |
    | MasterEventName | <$MasterEventName1$> |
    | Status          | New                  |
	When User waits "4" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_view"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.lnk_event_schedule_grid" with parameters
    | Key         | Value         |
    | SchedueName | <$Eventname$> |
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_EVENTBLOCK.btn_add_event"
	When User waits "4" seconds
	Given User clicks on "OLW_EBM_EVENTBLOCK.btn_add_change_offer"
	Given User enters text "<#OfferName#>" in "OLW_EBM_MASTEREVENT.txt_EventOfferSearch_OfferName"
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_EventOfferSearch_OfferSearch"
	#Verify availability of private offer at Event Block When user group does not have Permission.
	Then User verifies that element "OLW_EBM_MASTEREVENT.mic_offergrid" is present "false" on UI with parameters
    | Key       | Value             |
    | Campaign  | <#CampaignName#>  |
    | OfferName | <#OfferName#>     |
    | OfferID   | <$OfferID$>       |
    | StartDate | <#ValidFromDate#> |
    | EndDate   | <#ValidToDate#>   |
    | Property  | <$PropertyName$>  |

Scenario: 009-Provide MANAGEPRIVATEOFFER Permission to User group.
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "ManagePrivateOffer" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#assign VIEWASSIGNPRIVATEAWARD permission from UC_TechServices user group.
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value              |
	| permissionname | MANAGEPRIVATEOFFER |
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies text - "Permissions Saved" is present on page

Scenario Outline: 010-Enroll Player using WebApp.
	Given User switch to "Web" application
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	When User waits "2" seconds
	Given User enters text "Enroll Player" in "MAIN_NAV_BOX.EB_MenuSearch"
	Given User clicks on "MAIN_NAV_BOX.ENROLL_PLAYER"
	Given User selects option "<enrollType>" of element "ENROLL_PLAYER.ENROLL_TYPE_DROPDOWN" by "visibletext"	
	When User waits "2" seconds
	Given User selects option "<prefixType>" of element "ENROLL_PLAYER.ID_PREFIX_DROPDOWN" by "visibletext"
	When User waits "2" seconds
	When User generates a "RandomAlphabetic" with "5" for key "player_name"
	When User waits "2" seconds
	Given User enters text "<$player_name$>" in "ENROLL_PLAYER.ID_FIRST_NAME_TEXTBOX"
	Given User enters text "<middleName>" in "ENROLL_PLAYER.ID_MIDDLE_NAME_TEXTBOX"
	Given User enters text "<lastName>" in "ENROLL_PLAYER.ID_LAST_NAME_TEXTBOX"
	Given User selects option "<suffix>" of element "ENROLL_PLAYER.ID_SUFFIX_DROPDOWN" by "visibletext"
	Given User enters text "<bday>" in "ENROLL_PLAYER.ID_BDAY_TEXTBOX"
	Given User selects option "<gender>" of element "ENROLL_PLAYER.ID_PLAYER_GENDER_DROPDOWN" by "visibletext"
	Given User selects option "<idType>" of element "ENROLL_PLAYER.ID_TYPE_DROPDOWN" by "visibletext"
	When User waits "4" seconds
	Given User enters text "<id>" in "ENROLL_PLAYER.ID_TEXT_TEXTBOX"
	When User waits "4" seconds
	Given User enters text "<bday>" in "ENROLL_PLAYER.ID_DOB_TEXTBOX"
	When User waits "4" seconds
	Given User enters text "<expireDate>" in "ENROLL_PLAYER.ID_EXPIRY_DATE_TEXTBOX"
	Given User selects option "<country>" of element "ENROLL_PLAYER.ID_COUNTRY_DROPDOWN" by "visibletext"
	When User waits "4" seconds
	Given User selects option "<state>" of element "ENROLL_PLAYER.ID_STATE_DROPDOWN" by "visibletext"
	When User waits "2" seconds
	Given User selects option "<nationality>" of element "ENROLL_PLAYER.ID_NATIONALITY_DROPDOWN" by "visibletext"
	Given User selects option "<gender>" of element "ENROLL_PLAYER.ID_GENDER_DROPDOWN" by "visibletext"
	Given User clears "ENROLL_PLAYER.SSN_TEXTBOX"
	Given User enters text "<ssn>" in "ENROLL_PLAYER.SSN_TEXTBOX"
	#Address Information
	Then User "checks" element "ENROLL_PLAYER.ADDRESS_OPTIN_CHECKBOX"
	Given User selects option "<addressType>" of element "ENROLL_PLAYER.ADDRESS_TYPE_DROPDOWN" by "visibletext"
	When User waits "2" seconds
	Given User enters text "Test Address Line 1" in "ENROLL_PLAYER.ADDRESS_LINE1_TEXTBOX"
	Given User enters text "Test Address Line 2" in "ENROLL_PLAYER.ADDRESS_LINE2_TEXTBOX"
	Given User enters text "<city>" in "ENROLL_PLAYER.ADDRESS_CITY_TEXTBOX"
	Given User selects option "<country>" of element "ENROLL_PLAYER.ADDRESS_COUNTRY_DROPDOWN" by "visibletext"
	When User waits "2" seconds
	Given User selects option "<state>" of element "ENROLL_PLAYER.ADDRESS_STATE_DROPDOWN" by "visibletext"
	When User waits "2" seconds
	Given User enters text "<zip>" in "ENROLL_PLAYER.ADDRESS_ZIPCODE_TEXTBOX"
	Given User enters text "<zipFour>" in "ENROLL_PLAYER.ADDRESS_ZIP_PLUS_FOUR_TEXTBOX"
	#PIN Information
	Given User enters text "<pin>" in "ENROLL_PLAYER.PIN_TEXTBOX"
	Given User enters text "<pin>" in "ENROLL_PLAYER.PIN_AGAIN_TEXTBOX"
	When User scrolls till element "ENROLL_PLAYER.ENROLL_BUTTON"
	When User waits "2" seconds
	Given User clicks on "ENROLL_PLAYER.ENROLL_BUTTON"
	When User waits "4" seconds
	When User gets attribute "getText" value of "PLAYER_INFO.PLAYER_ID_SPAN" element to save with key "<PLAYER_ID_Key>"
	Examples:
		| BucketAmount | enrollType | prefixType | middleName | lastName  | suffix | bday       | gender | idType        | id          | expireDate | country | state   | country2 | state2  | nationality | addressType | addressLine          | city    | zip    | zipFour | fromDate   | toDate     | addressType2 | city2   | zip2   | zipFour2 | fromDate2  | toDate2    | teleType | teleNo     | teleStatus | emailType | email   | emailStatus | socialType | socialAccount  | smsType  | pin  | Permission | sms       | PLAYER_ID          | ssn       | PLAYER_ID_Key |
		| 1000         | Standard   | MR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID     |
		| 1000         | Standard   | MR        | Test1      | LastName1 | JR     | 01/01/1980 | Female | Consular Card | TUVXYZ54321 | 10/10/2030 | Canada  | Alberta | Canada   | Alberta | Australian  | Work        | Test Address Line 12 | Alberta | 110006 | 2346    | 08/08/2001 | 06/06/2016 | Work         | Alberta | 110006 | 2346     | 07/07/2017 | 08/08/2017 | Primary  | 9977553311 | blank      | Primary   | b@b.com | blank       | Gmail      | test@gmail.com | Personal | 1835 | checks     | 986108711 | PLAYER_ID_STANDARD | 198292902 | PLAYER_ID1     |


Scenario: 011-To Create Master campaign along with Private Offer, and add a player to Schedule event block.
	When User runs query "Select  p.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User runs query "Select id  from Ofr.UC_X_OfferMaster where OfferName like '%UniversalPrivateOffer%'" with connection "<#Halo_db_connectionstring#>" and save with key "OfferID"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Event Block Management" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "OLW_MAIN_NAV_BOX.lnk_eventblockmanagement"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_add"
	When User generates a "UniqueString" with "Master_Event_:4" for key "MasterEventName"
	Given User enters text "<$MasterEventName$>" in "OLW_EBM_MASTEREVENT.txt_master_event_name"
	When User runs query "select format (getdate(),'MM/dd/yyyy')" with connection "<#Halo_db_connectionstring#>" and save with key "DBcurrenttime"
	And User performs action "adddays" of "7" on dateTime "<$DBcurrenttime$>" with format "MM/dd/yyyy" to save the result for key "EndDate"
	Given User enters text "<$DBcurrenttime$>" in "OLW_EBM_MASTEREVENT.txt_master_event_startdate"
	Given User enters text "<$EndDate$>" in "OLW_EBM_MASTEREVENT.txt_master_event_enddate"
	Then User "checks" element "OLW_EBM_MASTEREVENT.rdb_master_event"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_addoffer"
	Given User enters text "<#OfferName#>" in "OLW_EBM_MASTEREVENT.txt_EventOfferSearch_OfferName"
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_EventOfferSearch_OfferSearch"
	Then User verifies that element "OLW_EBM_MASTEREVENT.mic_offergrid" is present "true" on UI with parameters
    | Key       | Value             |
    | Campaign  | <#CampaignName#>  |
    | OfferName | <#OfferName#>     |
    | OfferID   | <$OfferID$>       |
    | StartDate | <#ValidFromDate#> |
    | EndDate   | <#ValidToDate#>   |
    | Property  | <$PropertyName$>  |
	Given User clicks on "OLW_EBM_MASTEREVENT.mic_offergrid" with parameters
    | Key       | Value             |
    | Campaign  | <#CampaignName#>  |
    | OfferName | <#OfferName#>     |
    | OfferID   | <$OfferID$>       |
    | StartDate | <#ValidFromDate#> |
    | EndDate   | <#ValidToDate#>   |
    | Property  | <$PropertyName$>  |
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_offer_add"
	When User waits "4" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_save"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_add_schedule"
	When User waits "4" seconds
	Given User enters text "Schedule Description" in "OLW_EBM_EVENTSCHEDUL.txt_description"
	When User generates a "UniqueString" with "Event_Schedule:4" for key "Eventname"
	Given User enters text "<$Eventname$>" in "OLW_EBM_EVENTSCHEDUL.txt_schedule_event_name"
	Given User selects option "<#EventType#>" of element "OLW_EBM_EVENTSCHEDUL.mic_eventtype" by "visibletext"
	Given User enters text "Choctow Casino" in "OLW_EBM_EVENTSCHEDUL.txt_host"
	Given User selects option "<$PropertyName$>" of element "OLW_EBM_EVENTSCHEDUL.mic_property" by "visibletext"
	When User runs query "select format (getdate(),'MM/dd/yyyy')" with connection "<#Halo_db_connectionstring#>" and save with key "DBcurrenttime"
	And User performs action "adddays" of "7" on dateTime "<$DBcurrenttime$>" with format "MM/dd/yyyy" to save the result for key "EndDate"
	Given User enters text "<$DBcurrenttime$>" in "OLW_EBM_EVENTSCHEDUL.txt_schedule_start_date"
	Given User enters text "12:00 AM" in "OLW_EBM_EVENTSCHEDUL.txt_schedule_start_time"
	Given User enters text "<$EndDate$>" in "OLW_EBM_EVENTSCHEDUL.txt_schedule_end_date"
	Given User enters text "06:30 PM" in "OLW_EBM_EVENTSCHEDUL.txt_schedule_end_time"
	Given User clicks on "OLW_EBM_EVENTSCHEDUL.btn_schedule_save"
	When User "refresh" the browser
	When User waits "4" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.tab_master_event"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_name_filter"
	Given User clicks on "USER_TRANS_LOG.PLAYER_ID_FILTER_OPTIONS" with parameters
	| Key        | Value    |
	| OptionName | Contains |
	Given User enters text "<$MasterEventName$>" in "USER_TRANS_LOG.TXT_PLAYER_ID_FILTER"
	When User pressed key "enter"
	When User waits "4" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.grid_mastereventname" with parameters
    | Key             | Value               |
    | MasterEventName | <$MasterEventName$> |
    | Status          | New                 |
	When User waits "4" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_view"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.lnk_event_schedule_grid" with parameters
    | Key         | Value         |
    | SchedueName | <$Eventname$> |
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_EVENTBLOCK.btn_add_event"
	When User waits "4" seconds
	When User generates a "UniqueString" with "Concert:4" for key "BlockName"
	Given User enters text "<$BlockName$>" in "OLW_EBM_EVENTBLOCK.txt_block_name"
	Given User enters text "10" in "OLW_EBM_EVENTBLOCK.txt_block_count"
	Given User enters text "10" in "OLW_EBM_EVENTBLOCK.txt_max_allowed"
	Given User enters text "0" in "OLW_EBM_EVENTBLOCK.txt_cost_to_patron"
	Given User selects option "BaseComps" of element "OLW_EBM_EVENTBLOCK.mic_bucket_to_charge" by "visibletext"
	Given User clicks on "OLW_EBM_EVENTBLOCK.btn_eventblock_save"
	When User "refresh" the browser
	Given User clicks on "OLW_EBM_EVENTSCHEDUL.lnk_grid_blockname" with parameters
    | Key       | Value         |
    | BlockName | <$BlockName$> |
	When User waits "4" seconds
	Given User clicks on "OLW_EBM_EVENTBLOCK.btn_add_import"
	When User waits "2" seconds
	Given User enters text "<$PLAYER_ID$>" in "OLW_EBM_EVENTBLOCK.txt_addpatron_playerid"
	Given User clicks on "OLW_EBM_EVENTBLOCK.btn_addpatron_search"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_EVENTBLOCK.btn_addpatron_addplayer"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_EVENTBLOCK.btn_addpatron_cancel"
	When User "refresh" the browser
	Then User "checks" element "OLW_EBM_EVENTBLOCK.chk_patrongrid_updatechckbox"
	Given User clicks on "OLW_EBM_EVENTBLOCK.btn_updatestatus"
	When User waits "2" seconds
	Given User selects option "Picked Up" of element "OLW_EBM_EVENTBLOCK.mic_updatestatu_drpdown" by "visibletext"
	Given User clicks on "OLW_EBM_EVENTBLOCK.btn_updatestatussave"
	Given User enters text "<#Halo_password#>" in "OLW_EBM_EVENTBLOCK.txt_updatestatus_pwd"
	Given User selects option "Customer Request" of element "OLW_EBM_EVENTBLOCK.mic_updatestatus_reason" by "visibletext"
	Given User enters text "Update Offer Status" in "OLW_EBM_EVENTBLOCK.txt_updatestatus_txtauthcomment"
	Given User clicks on "OLW_EBM_EVENTBLOCK.btn_authsubmit"
	When User "refresh" the browser

Scenario: 012-To provide VIEWASSIGNPLAYERPRIVATEOFFER Permission to User goup.(TC 590017)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "VIEWASSIGNPLAYERPRIVATEOFFER" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#assign VIEWASSIGNPRIVATEAWARD permission from UC_TechServices user group.
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value                        |
	| permissionname | VIEWASSIGNPLAYERPRIVATEOFFER |
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies text - "Permissions Saved" is present on page

Scenario: 013-To verify the availability of Private offer at Offer screen when user group have the VIEWASSIGNPLAYERPRIVATEOFFER  Permission. (TC 590037)
	When User runs query "Select ID from OFR.UC_X_OfferMaster where OfferName like '%UniversalPrivateOffer%'" with connection "<#Halo_db_connectionstring#>" and save with key "Offerid"
	When User runs query "Select AvailableStartDate from OFR.UC_X_OfferMaster Where ID='<$Offerid$>'" with connection "<#Halo_db_connectionstring#>" and save with key "OfferStartDate"
	When User runs query "Select AvailableEndDate from OFR.UC_X_OfferMaster Where ID='<$Offerid$>'" with connection "<#Halo_db_connectionstring#>" and save with key "OfferEndDate"
	When User format date "<$OfferStartDate$>" from "MM-dd-yyyy 12:00:00 AM" to "MM/dd/yyyy" and save the result for key "startdate"
	When User format date "<$OfferEndDate$>" from "MM-dd-yyyy 12:00:00 AM" to "MM/dd/yyyy" and save the result for key "enddate"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
    Given User enters text "<$PLAYER_ID$>" in "OLW_DASHBOARD.txt_playersearchbox"
    When User waits "2" seconds
    Given User clicks on "OLW_DASHBOARD.btnplayersearch"
    When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.lnk_Offers"
	When User waits "4" seconds
	Then User verifies that element "OLW_OFFERS_TAB.grd_player_offer" is present "true" on UI with parameters
    | Key           | Value            |
    | OfferName     | <#OfferName#>    |
    | OfferType     | <#OfferType#>    |
    | RedeemPartial | Y                |
    | OfferStatus   | Active           |
    | FromDate      | <$startdate$>    |
    | ToDate        | <$enddate$>      |
    | Amount        | 10.00            |
    | Property      | <$PropertyName$> |
    | Kiosk         | N                |
    | PrivateStatus | Y                |

Scenario: 014-Remove VIEWASSIGNPLAYERPRIVATEOFFER Permission to User goup.(TC 590017)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "VIEWASSIGNPLAYERPRIVATEOFFER" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#assign VIEWASSIGNPRIVATEAWARD permission from UC_TechServices user group.
	Then User "unchecks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value                        |
	| permissionname | VIEWASSIGNPLAYERPRIVATEOFFER |
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies text - "Permissions Saved" is present on page

Scenario: 015-To Create Master campaign along with Private Offer, and add a player to Schedule event block. 
  When User runs query "Select  p.PropertyName from  UC_X_ADGroupPropXref AGP, UC_U_ADGroup AG, UC_X_Property P where AGP.ADGroupID = AG.ADGroupID and AGP.PropertyID = P.PropertyID and AGP.ActiveFlag = 1 and AGP.DefaultFlag = 1 and AG.ADGroupName = '<#Halo_ADGroup#>'" with connection "<#Halo_db_connectionstring#>" and save with key "PropertyName"
	When User runs query "Select id  from Ofr.UC_X_OfferMaster where OfferName like '%UniversalPrivateOffer%'" with connection "<#Halo_db_connectionstring#>" and save with key "OfferID"
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Event Block Management" in "MAIN_NAV_BOX.EB_MenuSearch"
	When User waits "2" seconds
	Given User clicks on "OLW_MAIN_NAV_BOX.lnk_eventblockmanagement"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_add"
	When User generates a "UniqueString" with "Master_Event_:4" for key "MasterEventName"
	Given User enters text "<$MasterEventName$>" in "OLW_EBM_MASTEREVENT.txt_master_event_name"
	When User runs query "select format (getdate(),'MM/dd/yyyy')" with connection "<#Halo_db_connectionstring#>" and save with key "DBcurrenttime"
	And User performs action "adddays" of "7" on dateTime "<$DBcurrenttime$>" with format "MM/dd/yyyy" to save the result for key "EndDate"
	Given User enters text "<$DBcurrenttime$>" in "OLW_EBM_MASTEREVENT.txt_master_event_startdate"
	Given User enters text "<$EndDate$>" in "OLW_EBM_MASTEREVENT.txt_master_event_enddate"
	Then User "checks" element "OLW_EBM_MASTEREVENT.rdb_master_event"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_addoffer"
	Given User enters text "<#OfferName#>" in "OLW_EBM_MASTEREVENT.txt_EventOfferSearch_OfferName"
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_EventOfferSearch_OfferSearch"
	Then User verifies that element "OLW_EBM_MASTEREVENT.mic_offergrid" is present "true" on UI with parameters
    | Key       | Value             |
    | Campaign  | <#CampaignName#>  |
    | OfferName | <#OfferName#>     |
    | OfferID   | <$OfferID$>       |
    | StartDate | <#ValidFromDate#> |
    | EndDate   | <#ValidToDate#>   |
    | Property  | <$PropertyName$>  |
	Given User clicks on "OLW_EBM_MASTEREVENT.mic_offergrid" with parameters
    | Key       | Value             |
    | Campaign  | <#CampaignName#>  |
    | OfferName | <#OfferName#>     |
    | OfferID   | <$OfferID$>       |
    | StartDate | <#ValidFromDate#> |
    | EndDate   | <#ValidToDate#>   |
    | Property  | <$PropertyName$>  |
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_offer_add"
	When User waits "4" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_save"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_add_schedule"
	When User waits "4" seconds
	Given User enters text "Schedule Description" in "OLW_EBM_EVENTSCHEDUL.txt_description"
	When User generates a "UniqueString" with "Event_Schedule:4" for key "Eventname"
	Given User enters text "<$Eventname$>" in "OLW_EBM_EVENTSCHEDUL.txt_schedule_event_name"
	Given User selects option "<#EventType#>" of element "OLW_EBM_EVENTSCHEDUL.mic_eventtype" by "visibletext"
	Given User enters text "Choctow Casino" in "OLW_EBM_EVENTSCHEDUL.txt_host"
	Given User selects option "<$PropertyName$>" of element "OLW_EBM_EVENTSCHEDUL.mic_property" by "visibletext"
	When User runs query "select format (getdate(),'MM/dd/yyyy')" with connection "<#Halo_db_connectionstring#>" and save with key "DBcurrenttime"
	And User performs action "adddays" of "7" on dateTime "<$DBcurrenttime$>" with format "MM/dd/yyyy" to save the result for key "EndDate"
	Given User enters text "<$DBcurrenttime$>" in "OLW_EBM_EVENTSCHEDUL.txt_schedule_start_date"
	Given User enters text "12:00 AM" in "OLW_EBM_EVENTSCHEDUL.txt_schedule_start_time"
	Given User enters text "<$EndDate$>" in "OLW_EBM_EVENTSCHEDUL.txt_schedule_end_date"
	Given User enters text "06:30 PM" in "OLW_EBM_EVENTSCHEDUL.txt_schedule_end_time"
	Given User clicks on "OLW_EBM_EVENTSCHEDUL.btn_schedule_save"
	When User "refresh" the browser
	Given User clicks on "OLW_EBM_MASTEREVENT.tab_master_event"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_name_filter"
	Given User clicks on "USER_TRANS_LOG.PLAYER_ID_FILTER_OPTIONS" with parameters
	| Key        | Value    |
	| OptionName | Contains |
	Given User enters text "<$MasterEventName$>" in "USER_TRANS_LOG.TXT_PLAYER_ID_FILTER"
	When User pressed key "enter"
	When User waits "4" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.grid_mastereventname" with parameters
    | Key             | Value               |
    | MasterEventName | <$MasterEventName$> |
    | Status          | New                 |
	When User waits "4" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.btn_view"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_MASTEREVENT.lnk_event_schedule_grid" with parameters
    | Key         | Value         |
    | SchedueName | <$Eventname$> |
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_EVENTBLOCK.btn_add_event"
	When User waits "4" seconds
	When User generates a "UniqueString" with "Concert:4" for key "BlockName"
	Given User enters text "<$BlockName$>" in "OLW_EBM_EVENTBLOCK.txt_block_name"
	Given User enters text "10" in "OLW_EBM_EVENTBLOCK.txt_block_count"
	Given User enters text "10" in "OLW_EBM_EVENTBLOCK.txt_max_allowed"
	Given User enters text "0" in "OLW_EBM_EVENTBLOCK.txt_cost_to_patron"
	Given User selects option "BaseComps" of element "OLW_EBM_EVENTBLOCK.mic_bucket_to_charge" by "visibletext"
	Given User clicks on "OLW_EBM_EVENTBLOCK.btn_eventblock_save"
	When User "refresh" the browser
	Given User clicks on "OLW_EBM_EVENTSCHEDUL.lnk_grid_blockname" with parameters
    | Key       | Value         |
    | BlockName | <$BlockName$> |
	When User waits "4" seconds
	Given User clicks on "OLW_EBM_EVENTBLOCK.btn_add_import"
	When User waits "2" seconds
	Given User enters text "<$PLAYER_ID1$>" in "OLW_EBM_EVENTBLOCK.txt_addpatron_playerid"
	Given User clicks on "OLW_EBM_EVENTBLOCK.btn_addpatron_search"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_EVENTBLOCK.btn_addpatron_addplayer"
	When User waits "2" seconds
	Given User clicks on "OLW_EBM_EVENTBLOCK.btn_addpatron_cancel"
	When User "refresh" the browser
	Then User "checks" element "OLW_EBM_EVENTBLOCK.chk_patrongrid_updatechckbox"
	Given User clicks on "OLW_EBM_EVENTBLOCK.btn_updatestatus"
	When User waits "2" seconds
	#Picked up Ticket 
	Given User selects option "Picked Up" of element "OLW_EBM_EVENTBLOCK.mic_updatestatu_drpdown" by "visibletext"
	Given User clicks on "OLW_EBM_EVENTBLOCK.btn_updatestatussave"
	Given User enters text "<#Halo_password#>" in "OLW_EBM_EVENTBLOCK.txt_updatestatus_pwd"
	Given User selects option "Customer Request" of element "OLW_EBM_EVENTBLOCK.mic_updatestatus_reason" by "visibletext"
	Given User enters text "Update Offer Status" in "OLW_EBM_EVENTBLOCK.txt_updatestatus_txtauthcomment"
	Given User clicks on "OLW_EBM_EVENTBLOCK.btn_authsubmit"
	When User "refresh" the browser

Scenario: 016-To verify the availability of Private offer at Offer screen when user group doesn't have the VIEWASSIGNPLAYERPRIVATEOFFER  Permission. (TC 590037)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username_3#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User clears "PLAYER_SEARCH.PLAYER_ID_TEXTBOX"
    Given User enters text "<$PLAYER_ID1$>" in "OLW_DASHBOARD.txt_playersearchbox"
    When User waits "2" seconds
    Given User clicks on "OLW_DASHBOARD.btnplayersearch"
    When User waits "2" seconds
	Given User clicks on "OLW_DASHBOARD.lnk_Offers"
	When User waits "4" seconds
	Then User verifies that element "OLW_OFFERS_TAB.grd_player_offer" is present "false" on UI with parameters
    | Key           | Value            |
    | OfferName     | <#OfferName#>    |
    | OfferType     | <#OfferType#>    |
    | RedeemPartial | Y                |
    | OfferStatus   | Active           |
    | FromDate      | <$startdate$>    |
    | ToDate        | <$enddate$>      |
    | Amount        | 10.00            |
    | Property      | <$PropertyName$> |
    | Kiosk         | N                |
    | PrivateStatus | Y                |

Scenario: 017-Proving VIEWASSIGNPLAYERPRIVATEOFFER Permission to User goup.(TC 590017)
	Given User login halo web app with "<#Halo_APPURL#>:<#Halo_username#>:<#Halo_password#>:<#Halo_domain#>" information
	Given User enters text "Group Permission" in "MAIN_NAV_BOX.MenuSearch"
	When User waits "1" seconds
	Given User clicks on "lylMAIN_NAV_BOX.lnkGroupPermission"
	When User waits "2" seconds
	Given User selects option "<#Halo_ADGroup_1#>" of element "OLW_USER_GROUP_PERMISSION.micUserGroup_Dropdown" by "visibletext"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.lnkEditPermission"
	Given User clears "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User enters text "VIEWASSIGNPLAYERPRIVATEOFFER" in "OLW_USER_GROUP_PERMISSION.txtSearchPermission"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSearch"
	When User waits "2" seconds
	#assign VIEWASSIGNPRIVATEAWARD permission from UC_TechServices user group.
	Then User "checks" element "OLW_USER_GROUP_PERMISSION.chkPermissionNameCheckbox" with parameters
	| Key            | Value                        |
	| permissionname | VIEWASSIGNPLAYERPRIVATEOFFER |
	When User scrolls till element "OLW_USER_GROUP_PERMISSION.btnSave"
	Given User clicks on "OLW_USER_GROUP_PERMISSION.btnSave"
	Then User verifies text - "Permissions Saved" is present on page
	