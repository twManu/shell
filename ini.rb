#usage: ini.rb INI_FILE

#give options default value
$options = {'ini_dbg' => 0, 'print' => false}

#
# output message if message level is no less than current setting
#
def iniDbg(msg, msgLevel = 1)
	if $options['ini_dbg'] >= msgLevel then
		puts "#{msg}"
	end
end


# Get array with given INI file
# In  : filaName
# Ret : hash, name after session, of hash
def iniGet(fileName)
	hashOfHash = {}                                    #SESSION => hashOfSession
	curHash = {}                                       #KEY => value
	curSess = 'Null'

	File.foreach(fileName) do |line|
		line = line.chomp.strip                    #remove leading and trailing spaces and newline
		next if line =~ /^;/                       #skip comment line
		next if line.length == 0                   #skip empty line
		if line =~ /^\[(.+)\]/ then                #session found
			tmpHash = curHash.clone            #copy hash to insert in hash since curHash will be modified
			if !curHash.empty? then
				cmd = "hashOfHash[\'" + "#{curSess}'\] = tmpHash"
				iniDbg("#{cmd}", 2)
				eval(cmd)
			elsif curSess != 'Null' then
				cmd = "hashOfHash[\'" + "#{curSess}'\] = tmpHash"
				iniDbg("#{cmd}", 2)
				eval(cmd)
			end

			curHash.clear
			iniDbg("found session #{curSess}")
			next if curSess = $1               #this must be a true assignment
		end
		token = line.split('=', 2)                 #cut to two pieces at most
		iniDbg("  \(key, value\) = \(#{token[0]}, #{token[1]}\)")
		cmd = "curHash\['" + "#{token[0]}'\] = " + "'#{token[1]}'"
		iniDbg("#{cmd}", 2)
		eval(cmd)
	end
	#the last session
	cmd = "hashOfHash[\'" + "#{curSess}'\] = curHash"
	iniDbg("#{cmd}", 2)
	eval(cmd)
	
	return hashOfHash
end


###
# main
if $0 == 'ini.rb' then
	require 'optparse'
	OptionParser.new do |opts|
		opts.banner = "Usage: ruby ini.rb [-f INI_FILE] [-d LEVEL] [-p]
		LEVEL defaults to 0, which means debug off
		INI_FILE ini file for parsing
		-p to print session and content, defaults to off"
	
		opts.on('-d', '--debug level', 'debug level') { |level|
			$options['ini_dbg'] = level.to_i
		}
		opts.on('-f', '--file INI_file', 'INI file for parsing') { |file|
			$options['file'] = file
		}
		opts.on('-p', '--print', 'print sessions and content') {
			$options['print'] = true
		}
		opts.on('-h', '--help', 'Display usage') {
			puts "#{opts.banner}"
			exit
		}
	end.parse(ARGV)
	
	if !$options.has_key?('file') then
		puts "No INI file provided"
		exit
	else
		iniDbg("Processing #{$options['file']} ...")
	end

	hh = iniGet($options['file'])
	if $options['print'] then
		hh.each_pair do |session, hash|
			puts "----- session \"#{session}\" -----"
			hash.each_pair do |key, value|
				puts "    #{key} = #{value}"
			end
		end
	end
end
