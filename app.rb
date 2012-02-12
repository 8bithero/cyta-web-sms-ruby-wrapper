require 'rubygems'
require 'mechanize'

user = 'username'
password = 'password'
recipient = '99123456'
message = "Insert message here!"

agent = Mechanize.new

# Make sure we are using English
# Get page
#page = agent.get('http://www.cytamobile-vodafone.com/')

# Click English link
#page = agent.page.links_with(:text => 'English')[0].click

# Login Page
login_page = agent.get('https://www.cytamobile-vodafone.com/miPortal/HeaderLoginBar.aspx')

# Get login form
login_form = login_page.form('frmHeaderLogin')

# Set Username
login_form.field_with(:name => "HeaderLogin1$CybeeUserName1$txtUserName").value = user

# Set Password
login_form.field_with(:name => "HeaderLogin1$CybeePassword1$txtPassword").value = password

# Submit form
page = login_form.click_button

# Get web SMS page
web_sms_page = agent.get('http://www.cytamobile-vodafone.com/misms/sendsms.aspx')

# Get SMS Form
sms_form = web_sms_page.form('smsform')

# Enter recipient
sms_form.field_with(:name => "txtPhonebook").value = recipient

# Enter message
sms_form.field_with(:name => "txtSMSText").value = message

# Add field for form Target
sms_form.add_field!('__EVENTTARGET', 'lbtnSendSmsPreview')

# Submit SMS and go to preview page
web_sms_page2 = agent.submit(sms_form)

# Get form again from 'preview' page
sms_form2 = web_sms_page2.form('smsform')

# Add field for new form Target
sms_form2.add_field!('__EVENTTARGET', 'lbtnSendSMS')

# Submit SMS
gooo = agent.submit(sms_form2)
