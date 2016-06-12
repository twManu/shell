$myID = 'TREE'
$myPW = '123456'
$myLink = "dinbendon.net"

require 'watir-webdriver'

#give options default value
$options = {'debug' => 0}


#
# output message if message level is no less than current setting
#
def dbg(msg, msgLevel = 1)
	if $options['debug'] >= msgLevel then
		puts "#{msg}"
	end
end


def fire(link)
	bw = Watir::Browser.new :chrome
	bw.goto link
	
	bw.body.div(:id => 'main').table.table(:class => 'lists').tbody.wait_until_present
	tbody1 = bw.body.div(:id => 'main').table.table(:class => 'lists').tbody
	if NIL == tbody1 then
		puts "No tbody found"
		return
	end
	tbody1.text_field(:name => 'username').set $myID
	tbody1.text_field(:name => 'password').set $myPW
	#puts "#{tbody1.trs[2].inspect}, #{tbody1.trs[2].text}"
	#puts "#{tbody1.trs[2].text}".match('\d+')
	add1 = "#{tbody1.trs[2].text}".match(/(\d+)([^\d]*)(\d+)/)[1]
	add2 = "#{tbody1.trs[2].text}".match(/(\d+)([^\d]*)(\d+)/)[3]
	rlt = add1.to_i + add2.to_i
	dbg "#{add1} + #{add2} = #{rlt}"
	input = tbody1.text_field(:name => 'result')
	input.hover
	input.set rlt
	dbg "#{tbody1.trs[4].inspect}"
	dbg "#{tbody1.trs[4].td.inspect}"
	dbg "#{tbody1.trs[4].tds[1].input.inspect}"
	#this fails tbody1.trs[4].text_field(:name => 'submit').click
	tbody1.trs[4].tds[1].input.click
end


###
# main

fire $myLink
