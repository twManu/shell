
taiwan = [
	  'http://stockq.org/index/TWSE.php'\
	, '$TWII - SharpCharts Workbench - StockCharts.com'
]

shanghai = [
	  'http://stockq.org/index/SHCOMP.php'\
	, '$SSEC - SharpCharts Workbench - StockCharts.com'
]

japan = [
	  'http://stockq.org/index/NKY.php'\
	, '$NIKK - SharpCharts Workbench - StockCharts.com'
]

dutch = [
	  'http://stockq.org/index/DAX.php'\
	, '$DAX - SharpCharts Workbench - StockCharts.com'
]

dow = [
	  'http://stockq.org/index/INDU.php'\
	, '$INDU - SharpCharts Workbench - StockCharts.com'
]

nasdaq = [
	  'http://stockq.org/index/CCMP.php'\
	, '$COMPQ - SharpCharts Workbench - StockCharts.com'
]

markets = [ taiwan, shanghai, japan, dutch, dow, nasdaq ]
	
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


def fire(location)
	bw = Watir::Browser.new :chrome
	bw.goto location[0]
	
	b = bw.b(:text => '技術線圖')
	button = b.parent.elements[1]
	button.click
	bw.window(:title => location[1]).wait_until_present
	bw.window(:title => location[1]).use do
		bw.text_field(:id => 'overArgs_0').wait_until_present
		bw.text_field(:id => 'overArgs_0').set 5
		bw.text_field(:id => 'overArgs_1').set 22
		bw.text_field(:id => 'overArgs_2').set 66
		bw.input(:value => 'Update').click
	end
end


###
# main

markets.each { |place| fire place }

