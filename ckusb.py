#!/usr/bin/python

import glob, os

SCU="/sys/class/udc/"
UDC="dwc3.1.auto/"

ITEMS={
	"a_alt_hnp_support": 1,
	"current_speed": 1,
	"is_a_peripheral": 1,
	"maximum_speed": 1,
	"srp": 0,
	"uevent": 1,
	"b_hnp_support": 1,
	"is_otg": 0,
	"power": 0,
	"state": 1,
	"b_hnp_enable": 1,
	"function": 1,
	"is_selfpowered": 0,
	"soft_connect": 0,
	"subsystem": 0
}

for ff in glob.glob(SCU+UDC+"*"):
	basename = os.path.basename(ff)
	if basename in ITEMS and ITEMS[basename]:
		if os.path.islink(ff): continue
		if os.path.isdir(ff): continue
		print "*** checking", basename
		os.system('cat '+ff)

