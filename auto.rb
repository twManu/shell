#!/usr/bin/ruby

$myID = 'lessmoney'
$myPW = 'lleopard2'
$jkLink = "www.jkforum.net/forum.php"
$unLink = "twunbbs.com/forum.php"
$enLink = "www.eyny.com"
$st85Link = "85st.com/forum.php"
$fishLink = "fishgeter.com"

$allSites = {
	'doJK' => "www.jkforum.net/forum.php"\
	, 'doUn' => "twunbbs.com/forum.php"\
	, 'doEyny' => "www.eyny.com"\
	, 'do85ST' => "85st.com/forum.php"\
}

require 'watir-webdriver'
require 'optparse'

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


#
# set all options['xxx'] to given value
def setAllOptions(value)
	$allSites.keys.each do |site|
		cmd = "\$options['" + "#{site}'] " + "= #{value}"
		eval(cmd)
	end
end


#
# In  : arg - argument list. i.e ARGV
#       $options - loaded w/ default value
# Out : $options - those to execute are set to true
#
def checkParam(arg)
	doAll = 1                                #assume all need to do
	index = 0
	
	setAllOptions(false)
	#process options
	OptionParser.new do |opts|
		opts.banner = "Usage: ruby auto.rb [-d LEVEL] [-j] [-f] [-e] [-u] [-s]
		LEVEL defaults to 0, which means debug off
		-j JK
		-f Fisher
		-e Eyny
		-u UN BBS
		-s 85 ST
	when none is provided, all sites visited"
		
	
		opts.on( '-d', '--debug level', 'debug level') { |level| $options['debug'] = level.to_i }
		opts.on( '-j', '--jk', 'JK forum') {$options['doJK'] = true}
		opts.on( '-f', '--fish', 'Fisher forum') {$options['doFish'] = true}
		opts.on( '-e', '--eyny', 'EYNY forum') {$options['doEyny'] = true}
		opts.on( '-u', '--un', 'UNBBS forum') {$options['doUn'] = true}
		opts.on( '-s', '--st', '85ST forum') {$options['do85ST'] = true}
		opts.on('-h', '--help', 'Display usage') {
			puts "#{opts.banner}"
			exit
		}
	end.parse arg

	$allSites.keys.each do |site|
		varName = "\$options['" +"#{site}']"
		index += 1
		dbg("  user #{varName}: #{eval(varName)}")
		if eval(varName) then doAll = 0 end       #once any is set, not all is requested
	end

	if doAll > 0 then
		dbg("No flag found and to modify enable all options !", 2)
		setAllOptions(true)
	end
end


#
# Do jobs on $options that is true
#
def jobDispatcher()
	$allSites.each do |site, link|
		optName = "\$options['" + "#{site}']"
		if eval(optName) then
			dbg("#{site} w/ #{link}", 3)
			cmd = "#{site}\(\"#{link}\")"
			eval(cmd)
		end
	end
end


def doEyny(link)
	bw = Watir::Browser.new :chrome
	bw.goto link

	div1 = bw.body.div(:id => 'wp').div(:class => 'y')
	if div1 == NIL then
		puts "No 'body.div.div.div' found"
		return
	end

	span = div1.span(:class => 'pipe')
	if span == NIL then
		puts "No 'body.div.div.div.span' found"
		return
	end
	span.hover
	
	span1 = span.element(:xpath => './following-sibling::*[3]')
	if span1 == NIL then
		puts "No 'body.div.div.div.span1' found"
		return
	end
	#puts "#{span1.inspect}, #{span1.text}"
	span1.click

	bw.div(:class => 'rfm').wait_until_present
	#user name in a div
	div = bw.div(:class => 'rfm')
	tr = div.table.tbody.tr
	span = tr.th.span
	hashid = span.a.attribute_value("id")
	hashid = hashid.sub("loginfield_","")
	hashid = hashid.sub("_ctrl","")
	nameid = "username_" << hashid
	#(loginfield_)(.*)(_ctrl)
	tr.text_field(:id => nameid).set $myID
	
	#passwd is sibling of user name
	div1 = div.element(:xpath => './following-sibling::*')
	nameid = "password3_" << hashid
	tr = div1.table.tbody.tr
	tr.text_field(:id => nameid).set $myPW
	bw.send_keys :enter
end


def doUn(link)
	bw = Watir::Browser.new :chrome
	bw.goto link

	bw.div(:class => 'mb_1 mb_11').a.click
	bw.div(:class => 'rfm').wait_until_present
	#user name in a div
	div = bw.div(:class => 'rfm')
	tr = div.table.tbody.tr
	label = tr.th.label
	hashid = label.attribute_value("for")
	#puts "#{label.inspect}, #{label.text} #{label.attribute_value("for")}"
	tr.text_field(:id => hashid).set $myID
	
	#passwd is sibling of user name
	div1 = div.element(:xpath => './following-sibling::*')
	tr = div1.table.tbody.tr
	label = tr.th.label
	hashid = label.attribute_value("for")
	tr.text_field(:id => hashid).set $myPW
	bw.send_keys :enter
end


def doCommon(link)
	bw = Watir::Browser.new :chrome
	bw.goto link

	bw.text_field(:id => 'ls_username').set $myID
	bw.text_field(:id => 'ls_password').set $myPW
	bw.send_keys :enter
	#bw.button(:class => 'pn vm').click
end


def doFish(link)
	bw = Watir::Browser.new :chrome
	bw.goto link

	bw.div(:id => 'umenu').as[1].click
	bw.text_field(:name => 'username').set $myID
	bw.text_field(:name => 'password').set $myPW
	bw.send_keys :enter
end


def doJK(link)
	doCommon(link)
end


def do85ST(link)
	bw = Watir::Browser.new :chrome
	bw.goto link

	bw.div(:class => 'logintx').as[0].click
	bw.text_field(:name => 'username').set $myID
	bw.text_field(:name => 'password').set $myPW
	bw.send_keys :enter
end


###
# main

checkParam(ARGV)
jobDispatcher

exit

doFish
doEyny
doUN
doJK($jkLink)
doJK($st85Link)
