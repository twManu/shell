function basher() {
	if [[ $1 = 'run' ]]
	then
		shift
		/usr/bin/docker run -e \
		HIST_FILE=/root/.bash_history \
		-v $HOME/.bash_history:/root/.bash_history \
		"$@"
	else
		/usr/bin/docker "$@"
	fi
}
alias docker=basher