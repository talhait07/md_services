ACCESS_TOKEN = /{"access_token":"\w{64}","token_type":"bearer","expires_in":7200,"refresh_token":"\w{64}","resource_owner_id":".+"}/

CARD_REGEX = /{"id":".+","brand":(".+"|null),"last4":("\d{4}"|null),"exp_month":(\d{1,2}|null),"exp_year":(\d{4}|null),"name":(".+"|null),"is_default":(true|false|null)}/

ORGANIZATION_REGEX = /{"id":".+","name":".+","npi_number":".+","positions":\d+,"address_1":".+","address_2":(".+"|null),"city":".+","state":".+","postal_code":".+","phone_number":".+","url":".+","sites_count":\d,"organization_users_count":\d}/

SITE_REGEX = /{"id":(".+"|null),"site_number":(".+"|null),"name":".+","address_1":".+","address_2":(".+"|null),"city":".+","state":".+","postal_code":".+","phone_number":".+","organization":(".+"|null)}/

ENCOUNTER_REGEX = /{"id":".+","first_name":".+","last_name":".+","birth_date":".+","phone_number":".+","balance":".+","site":#{SITE_REGEX},"created_at":".+"}/

USER_REGEX = /{"id":".+","first_name":".+","last_name":".+","email":".+","god":(true|false),"role":({"type":"organization","permissions":({(".+":(".+"|\d|null))?}|null)}|null)}/

PROFILE_REGEX = /{"id":".+","birth_date":".+","phone_number":".+"}/

PATIENT_REGEX = /{"id":".+","user":#{USER_REGEX},"profile":#{PROFILE_REGEX}}/

PAYMENT_REGEX = /{"id":".+","charge_id":(".+"|null),"status":".+","amount":".+","created_at":".+"}/
