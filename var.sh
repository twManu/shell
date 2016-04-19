#!/bin/bash

#if parameter is not set, use default
parameter-default() {
	local var1=1
	local var2=2

	echo "var1=$var1, var2=$var2"
	echo "  var1 defined, \${var1-\$var2} outputs \$var1 (${var1-$var2})"
	echo "  var3 not defined, \${var3-\$var2} outputs \$var2 (${var3-$var2})"
	echo

	var1=
	echo "var1="
	echo "  var1 defined, \${var1-\$var2} outputs \$var1 (${var1-$var2})"
	echo "  var1 declared but set as null, \${var1:-\$var2} outputs \$var2 (${var1:-$var2})"
	echo
}


#if parameter is not set, set it to default
parameter-set-default() {
	echo "varA is not declared"
	echo "  \${varA=abc} sets var as (${varA=abc})"
	echo "${varA:=xyz}" >/dev/null
	echo "  this time \${varA=xyz} leaves varA remain (${varA})"
	echo

	local varB=
	echo "  varB declared but is set as null, \${varB=abc} leaves varB as (${varB=abc})"
	echo "  varB declared but is set as null, \${varB:=abc} sets varB as (${varB:=abc})"
	echo

}



parameter-default
parameter-set-default
